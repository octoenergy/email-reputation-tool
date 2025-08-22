# Copilot Instructions for Email Reputation Tool

## Project Overview
- **Purpose:** Utility to check the reputation of email addresses (validity, disposability, maliciousness) using the [emailrep](https://emailrep.io/) API.
- **Main Components:**
  - `src/email_reputation_tool/`: Core library code
    - `emailrep_client.py`: Example usage of the `emailrep` API
    - `__main__.py`: Entrypoint for CLI (calls `app()` from `cli` module)
    - `utils.py`: Utility functions (currently placeholder)
    - `__init__.py`: Package metadata
  - `tests/`: Pytest-based tests (minimal, template only)
  - `docs/`: Sphinx documentation

## Developer Workflows
- **Install:**
  - `make install` (creates venv, installs package and dev dependencies)
- **Run CLI:**
  - `emailrep <email_address>` (after install, exposes CLI)
- **Test:**
  - `make test` or `pytest` (all tests)
  - `make test-all` (tests on multiple Python versions with `uv`)
- **Lint/Format:**
  - `make lint` (uses `ruff` for linting, import sorting, formatting)
- **Docs:**
  - `make docs` (builds Sphinx docs)
- **Clean:**
  - `make clean` (removes build/test artifacts)

## Patterns & Conventions
- **API Key:** Reads `EMAILREP_API_KEY` from `.env` (not checked in)
- **CLI Entrypoint:**
  - `src/email_reputation_tool/__main__.py` imports and runs `app()` from `cli` (CLI code not present, add if missing)
  - `pyproject.toml` exposes CLI as `email_reputation_tool.cli:app`
- **Dependencies:**
  - Core: `emailrep`
  - Dev: `pytest`, `ruff`, `coverage`, `ty`, `ipdb`
- **Linting:**
  - `ruff` config in `pyproject.toml` (line length 120, strict linting)
- **Testing:**
  - Pytest fixtures and tests in `tests/` (currently template)
- **CI:**
  - GitHub Actions (`.github/workflows/test.yml`) runs tests and lint on push/PR to `main`/`master` for Python 3.12/3.13

## Integration Points
- **External:**
  - [emailrep](https://emailrep.io/) API (via `emailrep` Python package)
- **Environment:**
  - Python >=3.10
  - API key required for some operations (set in `.env`)

## Examples
- **Query an email:**
  ```python
  from emailrep import EmailRep
  emailrep = EmailRep(os.getenv("EMAILREP_API_KEY"))
  emailrep.query("bill@microsoft.com")
  ```
- **Report an email:**
  ```python
  emailrep.report("foo@bar.com", ["bec", "maldoc"], "Phishing email targeting CEO")
  ```

## Key Files
- `src/email_reputation_tool/emailrep_client.py`: API usage examples
- `Makefile`: Developer workflow commands
- `pyproject.toml`: Dependency, CLI, lint, and test config
- `.github/workflows/test.yml`: CI pipeline

---
**Feedback:** If any section is unclear or missing, please specify what needs improvement or additional detail.
