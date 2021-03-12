#!/bin/sh

cd workspace
pyshacl -f human -s shacl-shapes.ttl $INPUT.ttl
cd ..

