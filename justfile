# Display available commands and their descriptions (default target)
default:
    @just --list


## Workspace management

alias clean := cargo-clean

# Clean cargo workspace (cargo clean)
[group: 'workspace']
cargo-clean:
    cargo clean


## Code formatting and linting

# Format Rust code (cargo fmt --all)
[group: 'format']
fmt:
    cargo +nightly fmt --all

# Check Rust code format (cargo fmt --check)
[group: 'format']
fmt-check:
    cargo +nightly fmt --all -- --check

# Format specific Rust file (cargo fmt <file>)
[group: 'format']
fmt-file FILE:
    cargo +nightly fmt -- {{FILE}}


## Check

# Check Rust code (cargo check --all-targets)
[group: 'check']
check *EXTRA_FLAGS:
    cargo check --all-targets {{EXTRA_FLAGS}}

# Check specific crate with tests (cargo check -p <crate> --all-targets)
[group: 'check']
check-crate CRATE *EXTRA_FLAGS:
    cargo check --package {{CRATE}} --all-targets {{EXTRA_FLAGS}}

# Lint Rust code (cargo clippy --all-targets)
[group: 'check']
clippy *EXTRA_FLAGS:
    cargo clippy --all-targets {{EXTRA_FLAGS}}

# Lint specific crate (cargo clippy -p <crate> --all-targets --no-deps)
[group: 'check']
clippy-crate CRATE *EXTRA_FLAGS:
    cargo clippy --package {{CRATE}} --all-targets --no-deps {{EXTRA_FLAGS}}

alias check-deps := check-unused-deps

# Check for unused Rust dependencies (cargo machete)
[group: 'check']
check-unused-deps:
    cargo machete


## Testing

# Run all tests (profile: default)
[group: 'test']
test *EXTRA_FLAGS:
    #!/usr/bin/env bash
    set -e # Exit on error

    if command -v "cargo-nextest" &> /dev/null; then
        cargo nextest run {{EXTRA_FLAGS}} --workspace --all-features
    else
        >&2 echo "================================================="
        >&2 echo "ERROR: This command requires 'cargo-nextest' ❌"
        >&2 echo ""
        >&2 echo "Please install cargo-nextest to use this command:"
        >&2 echo "  cargo install --locked cargo-nextest@^0.9"
        >&2 echo "================================================="
        exit 1
    fi

# Run unit tests (profile: unit)
[group: 'test']
test-unit *EXTRA_FLAGS:
    #!/usr/bin/env bash
    set -e # Exit on error

    if command -v "cargo-nextest" &> /dev/null; then
        cargo nextest run --profile unit {{EXTRA_FLAGS}} --workspace --all-features
    else
        >&2 echo "================================================="
        >&2 echo "ERROR: This command requires 'cargo-nextest' ❌"
        >&2 echo ""
        >&2 echo "Please install cargo-nextest to use this command:"
        >&2 echo "  cargo install --locked cargo-nextest@^0.9"
        >&2 echo "================================================="
        exit 1
    fi

# Run integration tests (profile: integration)
[group: 'test']
test-integration *EXTRA_FLAGS:
    #!/usr/bin/env bash
    set -e # Exit on error

    if command -v "cargo-nextest" &> /dev/null; then
        cargo nextest run --profile integration {{EXTRA_FLAGS}} --workspace --all-features
    else
        >&2 echo "================================================="
        >&2 echo "ERROR: This command requires 'cargo-nextest' ❌"
        >&2 echo ""
        >&2 echo "Please install cargo-nextest to use this command:"
        >&2 echo "  cargo install --locked cargo-nextest@^0.9"
        >&2 echo "================================================="
        exit 1
    fi

# Run e2e tests (profile: e2e)
[group: 'test']
test-e2e *EXTRA_FLAGS:
    #!/usr/bin/env bash
    set -e # Exit on error

    if command -v "cargo-nextest" &> /dev/null; then
        cargo nextest run --profile e2e {{EXTRA_FLAGS}} --workspace --all-features
    else
        >&2 echo "================================================="
        >&2 echo "ERROR: This command requires 'cargo-nextest' ❌"
        >&2 echo ""
        >&2 echo "Please install cargo-nextest to use this command:"
        >&2 echo "  cargo install --locked cargo-nextest@^0.9"
        >&2 echo "================================================="
        exit 1
    fi


## Misc

PRECOMMIT_CONFIG := ".github/pre-commit-config.yaml"
PRECOMMIT_DEFAULT_HOOKS := "pre-commit pre-push"

# Install Git hooks
[group: 'misc']
install-git-hooks HOOKS=PRECOMMIT_DEFAULT_HOOKS:
    #!/usr/bin/env bash
    set -e # Exit on error

    # Check if pre-commit is installed
    if ! command -v "pre-commit" &> /dev/null; then
        >&2 echo "=============================================================="
        >&2 echo "Required command 'pre-commit' not available ❌"
        >&2 echo ""
        >&2 echo "Please install pre-commit using your preferred package manager"
        >&2 echo "  pip install pre-commit"
        >&2 echo "  pacman -S pre-commit"
        >&2 echo "  apt-get install pre-commit"
        >&2 echo "  brew install pre-commit"
        >&2 echo "=============================================================="
        exit 1
    fi

    # Install all Git hooks (see PRECOMMIT_HOOKS for default hooks)
    pre-commit install --config {{PRECOMMIT_CONFIG}} {{replace_regex(HOOKS, "\\s*([a-z-]+)\\s*", "--hook-type $1 ")}}

# Remove Git hooks
[group: 'misc']
remove-git-hooks HOOKS=PRECOMMIT_DEFAULT_HOOKS:
    #!/usr/bin/env bash
    set -e # Exit on error

    # Check if pre-commit is installed
    if ! command -v "pre-commit" &> /dev/null; then
        >&2 echo "=============================================================="
        >&2 echo "Required command 'pre-commit' not available ❌"
        >&2 echo ""
        >&2 echo "Please install pre-commit using your preferred package manager"
        >&2 echo "  pip install pre-commit"
        >&2 echo "  pacman -S pre-commit"
        >&2 echo "  apt-get install pre-commit"
        >&2 echo "  brew install pre-commit"
        >&2 echo "=============================================================="
        exit 1
    fi

    # Remove all Git hooks (see PRECOMMIT_HOOKS for default hooks)
    pre-commit uninstall --config {{PRECOMMIT_CONFIG}} {{replace_regex(HOOKS, "\\s*([a-z-]+)\\s*", "--hook-type $1 ")}}

# Install cargo-nextest
[group: 'misc']
install-cargo-nextest:
    cargo install --locked cargo-nextest@^0.9

# Install cargo-machete (unused dependency checker)
[group: 'misc']
install-cargo-machete:
    cargo install --locked cargo-machete

