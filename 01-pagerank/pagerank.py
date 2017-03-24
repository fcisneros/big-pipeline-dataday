#!/usr/bin/python
# -*- coding: utf-8 -*-

from org.apache.pig.scripting import *

base_output_path="$OUTPATH"
links_input="$INPUT"
damping_factor=$DAMPING

if not damping_factor:
    damping_factor = 0.75

UPDATE = Pig.compile("""
--PR(A) = (1-d) + d (PR(T1)/C(T1) + ... + PR(Tn)/C(Tn))

previous_pagerank =
    LOAD '$docs_in'
    USING PigStorage('\t')
    AS ( url: chararray, pagerank: float, links:{ link: ( url: chararray ) } );

outbound_pagerank =
    FOREACH previous_pagerank
    GENERATE
        pagerank / COUNT ( links ) AS pagerank,
        FLATTEN ( links ) AS to_url;

new_pagerank =
    FOREACH
        ( COGROUP outbound_pagerank BY to_url, previous_pagerank BY url INNER )
    GENERATE
        group AS url,
        ( 1 - $d ) + $d * SUM ( outbound_pagerank.pagerank ) AS pagerank,
        FLATTEN ( previous_pagerank.links ) AS links;

STORE new_pagerank
    INTO '$docs_out'
    USING PigStorage('\t');
""")

params = { 'd': "$damping_factor", 'docs_in': "$links_input" }
out = ""
for i in range(10):
   out = "$base_output_path/iter_" + str(i + 1)
   params["docs_out"] = out
   Pig.fs("rmr " + out)
   stats = UPDATE.bind(params).runSingle()
   if not stats.isSuccessful():
      raise RuntimeError('Failed pagerank iter: ' + str(i + 1))
   params["docs_in"] = out

SORT = Pig.compile("""
pagerank =
    LOAD '$docs_in'
    USING PigStorage('\t')
    AS ( url: chararray, pr: float, links:{ link: ( url: chararray ) } );

reduced = FOREACH pagerank GENERATE url, pr;

sorted = ORDER reduced BY pr DESC;

STORE sorted INTO '$docs_out' USING PigStorage('\t');
""")

params = {'docs_in': out, 'docs_out': "$base_output_path/ranks"}
Pig.fs("rmr " + params['docs_out'])
stats = SORT.bind(params).runSingle()
if not stats.isSuccessful():
   raise RuntimeError('Failed pagerank sort')
