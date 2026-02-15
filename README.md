# Copier Template: Typer + UV CLI Starter

A modern [Copier](https://copier.readthedocs.io/) template for generating production-grade Python CLI applications.

## What You Get

Generated projects include:

- **[uv](https://github.com/astral-sh/uv)** - Fast package + environment management
- **[uv_build](https://docs.astral.sh/uv/guides/integration/build-backend/)** - Modern build backend
- **[typer](https://typer.tiangolo.com/)** - CLI framework with Rich integration
- **[rich](https://rich.readthedocs.io/)** - Beautiful terminal output
- **[textual](https://textual.textualize.io/)** - TUI framework
- **[httpx](https://www.python-httpx.org/)** - HTTP client
- **[pydantic](https://docs.pydantic.dev/)** - Data validation
- **[ruff](https://docs.astral.sh/ruff/)** - Fast linter + formatter
- **[pytest](https://docs.pytest.org/)** - Testing
- **[ty](https://github.com/astral-sh/ty)** - Type checker (Astral's new type checker)
- **[just](https://github.com/casey/just)** - Command runner

## Features

- **Command Autodiscovery** - Drop Python files in `cli/commands/` and they become CLI commands
- **Nested Command Groups** - Subdirectories become command groups
- **Console Helpers** - `ok()`, `warn()`, `err()`, `info()` for colored output
- **Structured Errors** - `AppError` with optional hints
- **HTTP Client Wrapper** - Sync client with error handling
- **Settings via Environment** - Pydantic Settings with `.env` support
- **Works with uvx** - One-command install from git

## Usage

### Generate a new project

```bash
# Install copier
uv pip install copier

# Generate from template
copier copy gh:frankwiles/typer-cli-template my-new-cli
```

### After generation

```bash
cd my-new-cli

# Install dependencies
uv sync

# Run your CLI
uv run my-new-cli --help

# Run tests
uv run pytest
```

## Template Development

This repository includes a Justfile for template development:

```bash
# List available commands
just --list

# Quick smoke test (generate + test)
just playground-smoke

# Generate with custom project name
just playground-init project_name=myapp package_name=myapp cli_name=myapp

# Run individual commands
just playground-sync      # Install deps
just playground-run --help # Run CLI
just playground-test      # Run tests
just playground-lint      # Lint code
just playground-typecheck # Type check

# Clean up
just playground-clean

# Full reset
just playground-fresh
```

## Generated Project Structure

```
src/{{package_name}}/
├── __init__.py           # Package init
├── __main__.py           # Module entry point
├── cli/
│   ├── app.py            # Main CLI with autodiscovery
│   ├── ui/
│   │   ├── console.py    # Output helpers
│   │   └── errors.py     # Error rendering
│   └── commands/         # Auto-discovered commands
│       ├── hello.py      # Sample command
│       └── api/
│           └── get.py    # Sample nested command
├── config/
│   └── settings.py       # Pydantic settings
├── domain/
│   └── errors.py         # AppError class
└── infrastructure/
    └── http_client.py    # HTTP client wrapper
```

## Author

Written by [Frank Wiles](https://www.frankwiles.com)
