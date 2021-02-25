from jproperties import Properties

MAPPING_FILE = "schema.map"
NAMESPACE = "XXX:"
INPUT_FILE = "shapes.ttl"
OUTPUT_FILE = "mapped-shapes.ttl"

mappings = Properties()
with open(MAPPING_FILE, "rb") as file:
    mappings.load(file, "utf-8")

with open(INPUT_FILE, "r") as reader, open(OUTPUT_FILE, "w") as writer:
    for line in reader.readlines():
        for k, v in mappings.properties.items():
            line = line.replace(NAMESPACE + k + ' ', v + ' ')
        writer.write(line)
# Assumptions:
# 1. Space a
