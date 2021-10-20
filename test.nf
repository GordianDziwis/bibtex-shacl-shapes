#!/usr/bin/env nextflow
 

 
/*
 * split a fasta file in multiple files
 */
process bibtexToZotero {
 
    input:
    path 'bibtex' from params.in
 
    output:
    file "turtle.ttl" into output
 
    """
    curl --data-binary @bibtex -H 'Content-Type: text/plain' $TRANSLATION_SERVER/import > zotero.json
    curl -d @zotero.json -H 'Content-Type: application/json' $TRANSLATION_SERVER/export?format=rdf_bibliontology > triple.rdf
    """
}
 

 
/*
 * print the channel content
 */
output.subscribe { println it }
