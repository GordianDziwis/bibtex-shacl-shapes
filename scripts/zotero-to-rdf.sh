#!/bin/sh

cd workspace
curl -d @$INPUT.json -H 'Content-Type: application/json' $TRANSLATION_SERVER/export?format=rdf_bibliontology > $INPUT.rdf
cd ..
