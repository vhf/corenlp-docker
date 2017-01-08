#!/usr/bin/env bash
cd /models;
for jar in *.jar; do
  ln -s /models/$jar /opt/corenlp/src/$jar;
done

cd /opt/corenlp/src
exec java -mx4g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer
