# Copier Template Development Tasks
# Use `just --list` to see available commands

# Default values for playground testing
project_name := "test-cli"
package_name := "test_cli"
cli_name := "test-cli"
description := "Test CLI app"
author := "Test Author"
use_commands := "true"

# Default recipe - show help
default:
    just --list

# Install copier for template development
setup:
    uv venv venv
    uv pip install copier

# Generate a test project to ./playground/
playground-init:
    rm -rf playground
    mkdir -p playground
    source venv/bin/activate && copier copy . playground/{{ project_name }} \
        --data project_name={{ project_name }} \
        --data package_name={{ package_name }} \
        --data cli_name={{ cli_name }} \
        --data description="{{ description }}" \
        --data author_name="{{ author }}" \
        --data use_commands_folder={{ use_commands }} \
        --defaults \
        --force

# Install dependencies in playground project (includes dev deps)
playground-sync:
    cd playground/{{ project_name }} && uv sync --all-extras

# Run the generated CLI with --help
playground-run *ARGS:
    cd playground/{{ project_name }} && uv run {{ cli_name }} {{ ARGS }}

# Run tests in playground
playground-test:
    cd playground/{{ project_name }} && uv run pytest -v

# Format code in playground
playground-fmt:
    cd playground/{{ project_name }} && uv run ruff format .

# Lint code in playground
playground-lint:
    cd playground/{{ project_name }} && uv run ruff check .

# Type check playground
playground-typecheck:
    cd playground/{{ project_name }} && uv run ty check

# Run all checks in playground
playground-check: playground-lint playground-typecheck playground-test

# Clean up playground directory
playground-clean:
    rm -rf playground

# Full reset: clean, init, sync (for a fresh test)
playground-fresh: playground-clean playground-init playground-sync

# Quick smoke test: fresh build + run help + run tests
playground-smoke: playground-fresh
    cd playground/{{ project_name }} && uv run {{ cli_name }} --help
    cd playground/{{ project_name }} && uv run {{ cli_name }} --version
    cd playground/{{ project_name }} && uv run pytest -v

# Generate with NO commands folder (simple CLI)
playground-simple:
    rm -rf playground
    mkdir -p playground
    source venv/bin/activate && copier copy . playground/{{ project_name }} \
        --data project_name={{ project_name }} \
        --data package_name={{ package_name }} \
        --data cli_name={{ cli_name }} \
        --data description="{{ description }}" \
        --data author_name="{{ author }}" \
        --data use_commands_folder=false \
        --defaults \
        --force
