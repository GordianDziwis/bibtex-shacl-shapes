#!/bin/bash

cd workspace
rapper $INPUT.rdf -o turtle > $INPUT.ttl
cd ..


