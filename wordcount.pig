-- load file content
lines = LOAD 'big.txt' as (line:chararray);

-- Split lines in to words.
words = FOREACH lines generate FLATTEN(TOKENIZE(line)) as word;

-- Groupping all words
grpwords = GROUP words BY word;

-- Count each word.
wordcount = FOREACH grpwords GENERATE group, COUNT(words);

--DUMP wordcount;

-- Order by number of words
ordbycount = ORDER wordcount by $1;

--DUMP ordbycount;

-- Store word coud result in file.
STORE ordbycount  INTO 'wordcount' USING PigStorage(',');