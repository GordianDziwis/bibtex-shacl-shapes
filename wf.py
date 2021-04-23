from urllib import parse

from prefect import Flow, task
from prefect.run_configs import DockerRun
from prefect.tasks.shell import ShellTask
import requests


@task
def import_translation(data: str, url: str) -> str:
    url = parse.urljoin(url, "import")
    headers = {"Content-Type": "text/plain"}
    response = requests.post(url, data=data.encode("utf-8"), headers=headers)
    return response.text


@task
def export_translation(data: str, url: str, format: str) -> str:
    params = parse.urlencode({"format": format})
    url = parse.urljoin(url, "export")
    headers = {"Content-Type": "application/json"}
    response = requests.post(
        url, data=data.encode("utf-8"), headers=headers, params=params
    )
    return response.text


@task
def load_file(filename: str) -> str:
    with open(filename, "r", encoding="utf-8") as file:
        return file.read()


@task
def printa(stuff):
    print(stuff)


task = ShellTask(return_all=True)
with Flow("shell") as f:
    translation_server_url = "http://localhost:1969"
    bibtex = load_file("./workspace/aksw-short.bib")
    zotero = import_translation(bibtex, translation_server_url)
    rdf = export_translation(zotero, translation_server_url, "rdf_bibliontology")
    turtle = task(command="rapper - -o turtle -I www.test.com > tests.ttl", stdin=rdf)
    printa(turtle)

f.run_config = DockerRun(
    image="prefecthq/prefect"
)
f.register(project_name="tutoriala")

# Configure extra environment variables for this flow,
# and set a custom image
# f.run()
