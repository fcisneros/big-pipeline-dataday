-- Executes a wordcount using an input (url, text)

rmf $OUTPUT

-- load raw content from INPUT:
content = LOAD '$INPUT' USING PigStorage('\t') AS (url:chararray, text:chararray);

filtered = FILTER content BY url IS NOT NULL AND text IS NOT NULL;

tokens = FOREACH filtered generate FLATTEN(TOKENIZE(text)) as word;

word_count = FOREACH (GROUP tokens BY word) GENERATE
  group as word,
  COUNT(tokens) as wc;

sorted_count = ORDER word_count BY wc DESC;

STORE sorted_count INTO '$OUTPUT' USING PigStorage('\t');
