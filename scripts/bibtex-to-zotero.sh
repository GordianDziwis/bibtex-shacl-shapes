#!/bin/sh

cd workspace
curl --data-binary @$INPUT-short.bib -H 'Content-Type: text/plain' $TRANSLATION_SERVER/import > $INPUT.json
cd ..
