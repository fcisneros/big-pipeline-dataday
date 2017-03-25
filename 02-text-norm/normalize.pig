-- Extracts and formats links needed by the pagerank task

REGISTER /usr/local/lib/warcutils-jar-with-dependencies.jar;
DEFINE WarcLoader nl.surfsara.warcutils.pig.WarcFileLoader();

rmf $OUTPUT

-- load content from INPUT:
raw = LOAD '$INPUT' USING WarcLoader
  AS (url, type, content);

STORE raw INTO '$OUTPUT/raw' USING PigStorage('\t');
