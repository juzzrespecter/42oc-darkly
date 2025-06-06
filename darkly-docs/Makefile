.PHONY: serve build

PYTHON:=python3
VENV:=.venv

${VENV}:
	${PYTHON} -m venv $@
	source ${VENV}/bin/activate
	pip install -r requirements.txt

serve: ${VENV}
	mkdocs serve

build: ${VENV}
	mkdocs build