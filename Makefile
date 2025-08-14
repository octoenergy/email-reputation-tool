# Makefile for email-reputation-tool
# Reads EMAILREP_API_KEY from .env file (which should be in .gitignore)

.PHONY: install setup

install: venv 
	pip install .[dev]

setup:
	. .env; emailrep setup -k $$EMAILREP_API_KEY
# Create and activate virtual environment
venv:
	python3 -m venv venv

# Upgrade emailrep package
upgrade-emailrep:
	pip3 install emailrep --upgrade
	pip install .
.PHONY: clean clean-build clean-pyc clean-test coverage dist docs help install lint lint/flake8

.DEFAULT_GOAL := help

define BROWSER_PYSCRIPT
import os, webbrowser, sys

from urllib.request import pathname2url

webbrowser.open("file://" + pathname2url(os.path.abspath(sys.argv[1])))
endef
export BROWSER_PYSCRIPT

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

BROWSER := python -c "$$BROWSER_PYSCRIPT"

help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

clean: clean-build clean-pyc clean-test ## remove all build, test, coverage and Python artifacts

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test: ## remove test and coverage artifacts
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr .pytest_cache

lint: ## fix style, sort imports, check types
	ruff check . --fix
	ruff check --select I --fix .
	ruff format .

MAKECMDGOALS ?= .	

test:  ## Run all the tests, but allow for arguments to be passed
	@echo "Running with arg: $(filter-out $@,$(MAKECMDGOALS))"
	pytest $(filter-out $@,$(MAKECMDGOALS))

pdb:  ## Run all the tests, but on failure, drop into the debugger
	@echo "Running with arg: $(filter-out $@,$(MAKECMDGOALS))"
	pytest --pdb --maxfail=10 --pdbcls=IPython.terminal.debugger:TerminalPdb $(filter-out $@,$(MAKECMDGOALS))

test-all: ## run tests on every Python version with uv
	uv run --python=3.10 --extra test pytest
	uv run --python=3.11 --extra test pytest
	uv run --python=3.12 --extra test pytest
	uv run --python=3.13 --extra test pytest

coverage: ## check code coverage quickly with the default Python
	coverage run --source email_reputation_tool -m pytest
	coverage report -m
	coverage html
	$(BROWSER) htmlcov/index.html

docs: ## generate Sphinx HTML documentation, including API docs
	rm -f docs/email_reputation_tool.md
	rm -f docs/modules.md
	sphinx-apidoc -o docs/ email_reputation_tool
	$(MAKE) -C docs clean
	$(MAKE) -C docs html
	$(BROWSER) docs/_build/html/index.html

servedocs: docs ## compile the docs watching for changes
	watchmedo shell-command -p '*.md' -c '$(MAKE) -C docs html' -R -D .

release: dist ## package and upload a release
	uv release -t $(UV_PUBLISH_TOKEN)

build: clean ## builds source and wheel package
	rm -rf build dist
	uv build
	ls -l build dist
