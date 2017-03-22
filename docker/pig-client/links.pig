-- Extracts and formats links needed by the pagerank task

set pig.splitCombination false;

REGISTER /app/lib/webarchive-commons-jar-with-dependencies.jar;
DEFINE resolve org.archive.hadoop.func.URLResolverFunc();

rmf $OUTPUT

-- load data from INPUT:
Orig = LOAD '$INPUT' USING org.archive.hadoop.ArchiveJSONViewLoader(
  'Envelope.WARC-Header-Metadata.WARC-Target-URI',
  'Envelope.Payload-Metadata.HTTP-Response-Metadata.HTML-Metadata.Head.Base',
  'Envelope.Payload-Metadata.HTTP-Response-Metadata.HTML-Metadata.@Links.url')
AS (page_url,html_base,relative);

-- discard lines without links
LinksOnly = FILTER Orig BY relative != '';

-- fabricate new 1st column, which is the resolved to-URL, followed by the from-URL:
--ResolvedLinks = FOREACH LinksOnly GENERATE FLATTEN(resolve(page_url,html_base,relative)) AS (resolved), page_url;

-- this will include all the fields, for debug:
ResolvedLinks = FOREACH LinksOnly GENERATE FLATTEN(resolve(page_url,html_base,relative)) AS (resolved), page_url, html_base, relative;

-- we want http* links only
FilteredLinks = FILTER ResolvedLinks BY resolved IS NOT NULL
  AND STARTSWITH(resolved, 'http')
  AND NOT (resolved matches '([^\\s]+(\\.(?i)(jpg|png|gif|bmp))$)');

GroupedLinks = FOREACH (GROUP FilteredLinks BY page_url) GENERATE
  group as url,
  1 as pagerank,
  FilteredLinks.resolved as links;

STORE GroupedLinks INTO '$OUTPUT' USING PigStorage();
