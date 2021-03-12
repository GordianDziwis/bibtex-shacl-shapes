include .env

run-popper-workflow: run-translation-server
	IFS="="; while read -r key value; do echo -n " -s _$$key=$$value"; done < .env | xargs -o popper run -f wf.yml

run-local-workflow: run-translation-server
	./wf.sh

run-translation-server:
	docker-compose up -d
	sleep 1

clean:
	docker-compose down
	rm -f $(INPUT).rdf
	rm -f $(INPUT).ttl
	rm -f $(INPUT).json

.PHONY: run-popper-workflow run-local-workflow run-translation-server clean


