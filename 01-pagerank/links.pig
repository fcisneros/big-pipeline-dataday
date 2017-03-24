-- Extracts and formats links needed by the pagerank task

set pig.splitCombination false;

REGISTER /usr/local/lib/webarchive-commons-jar-with-dependencies.jar;
DEFINE resolve org.archive.hadoop.func.URLResolverFunc();

rmf $OUTPUT

-- load data from INPUT:
raw = LOAD '$INPUT' USING org.archive.hadoop.ArchiveJSONViewLoader(
  'Envelope.WARC-Header-Metadata.WARC-Target-URI',
  'Envelope.Payload-Metadata.HTTP-Response-Metadata.HTML-Metadata.Head.Base',
  'Envelope.Payload-Metadata.HTTP-Response-Metadata.HTML-Metadata.@Links.url')
AS (page_url,html_base,relative);

-- discard lines without links
links = FILTER raw BY relative != '' OR relative IS NOT NULL;

-- create new 1st column, which is the resolved to-URL, followed by the from-URL:
resolved_links = FOREACH links GENERATE FLATTEN(resolve(page_url,html_base,relative)) AS (resolved), page_url;

-- this will include all the fields, for debug:
--resolved_links = FOREACH links GENERATE FLATTEN(resolve(page_url,html_base,relative)) AS (resolved), page_url, html_base, relative;

-- Links from a page to itself, or multiple outbound links from one single page to another single page, are ignored
filtered_links = FILTER resolved_links BY resolved IS NOT NULL
  --AND STARTSWITH(resolved, 'http')
  AND NOT (resolved matches '([^\\s]+(\\.(?i)(jpg|png|gif|bmp|svg))$)')
  AND page_url != resolved;

uniques = DISTINCT filtered_links;

grouped_links = FOREACH (GROUP uniques BY page_url) GENERATE
  group as url,
  1 as pagerank,
  uniques.resolved as links;

STORE grouped_links INTO '$OUTPUT' USING PigStorage();
