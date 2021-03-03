include .env
export

validate: map $(INPUT).ttl
	pyshacl -f human -s mapped-shapes.ttl $(INPUT).ttl

map:
	python map.py

$(INPUT).ttl: $(INPUT).json
	curl -d @$(INPUT).json -H 'Content-Type: application/json' 'http://127.0.0.1:$(TRANSLATION_SERVER_PORT)/export?format=rdf_bibliontology' > $(INPUT).rdf
	rapper $(INPUT).rdf -o turtle > $(INPUT).ttl

$(INPUT).json: run-translation-server
	curl --data-binary @$(INPUT)-short.bib -H 'Content-Type: text/plain' http://127.0.0.1:$(TRANSLATION_SERVER_PORT)/import > aksw.json

run-translation-server:
	docker-compose up -d
	sleep 1

run-workflow: run-translation-server
	IFS="="; while read -r key value; do echo -n " -s _$$key=$$value"; done < .env | xargs -o popper run -f wf.yml

clean:
	docker-compose down
	rm -f $(INPUT).json
	rm -f $(INPUT).rdf
	rm -f $(INPUT).ttl

.PHONY: $(INPUT).json


