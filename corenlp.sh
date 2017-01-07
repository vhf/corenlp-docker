#!/usr/bin/env bash
cd /opt/corenlp/src
cp /models/* /opt/corenlp
exec java -mx8g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer
