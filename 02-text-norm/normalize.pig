REGISTER /usr/local/lib/textutils-pig-jar-with-dependencies.jar
DEFINE normalize textutils.pig.udf.SimpleTextNormalizer();

rmf $OUTPUT

-- load raw content from INPUT:
raw = LOAD '$INPUT' USING PigStorage('\t') AS (url:chararray, type:chararray, content:chararray);
normalized = FOREACH raw GENERATE url, normalize(content);

STORE normalized INTO '$OUTPUT' USING PigStorage('\t');
