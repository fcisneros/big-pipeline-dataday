-- Extracts and formats links needed by the pagerank task

REGISTER /usr/local/lib/warcutils-jar-with-dependencies.jar;
DEFINE WarcLoader nl.surfsara.warcutils.pig.WarcFileLoader();

rmf $OUTPUT

-- load content from INPUT:
raw = LOAD '$INPUT' USING WarcLoader AS (url, type, content);
raw = FILTER raw BY url IS NOT NULL AND content IS NOT NULL;

STORE raw INTO '$OUTPUT' USING PigStorage('\t');
