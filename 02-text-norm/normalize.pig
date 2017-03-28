REGISTER /usr/local/lib/textutils-pig-jar-with-dependencies.jar
REGISTER /usr/local/lib/warcutils-jar-with-dependencies.jar;

DEFINE normalize textutils.pig.udf.SimpleTextNormalizer();
DEFINE WarcLoader nl.surfsara.warcutils.pig.WarcFileLoader();

rmf $OUTPUT

-- load raw content from INPUT:
raw = LOAD '$INPUT' USING WarcLoader AS (url, type, content);
raw = FILTER raw BY url IS NOT NULL AND content IS NOT NULL;
STORE raw INTO '$OUTPUT/raw' USING PigStorage('\t');

normalized = FOREACH raw GENERATE url, normalize(content);
STORE normalized INTO '$OUTPUT/normalized' USING PigStorage('\t');
