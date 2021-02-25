validate: map
	pyshacl -f human -s mapped-shapes.ttl bibtex.ttl

map:
	python map.py


