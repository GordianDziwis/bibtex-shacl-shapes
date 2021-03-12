#!/bin/sh

export $(cat .env | xargs)
TRANSLATION_SERVER=localhost:$TRANSLATION_SERVER_PORT

. ./scripts/bibtex-to-zotero.sh
. ./scripts/zotero-to-rdf.sh
. ./scripts/rdf-to-turtle.sh
. ./scripts/validate-turtle.sh
