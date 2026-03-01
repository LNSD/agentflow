---
name: code-format
description: Format Rust code automatically. Use immediately after editing .rs files, when user mentions formatting, code style, or before commits/PRs. Ensures consistent code style following project conventions.
---

# Code Formatting Skill

This skill provides code formatting operations for the project codebase, which is a Rust workspace.

## When to Use This Skill

Use this skill when you need to:
- Format code after editing Rust files
- Check if code meets formatting standards
- Ensure code formatting compliance before commits

## Command Selection Rules

Choose the appropriate command based on the number of crates/files edited:

| Scenario | Command | Rationale |
|----------|---------|-----------|
| 1 crate, 1-2 files | `just fmt-file <file>` (per file) | Faster, targeted formatting |
| 1 crate, 3+ files | `just fmt` | More efficient than multiple per-file calls |
| 2+ crates | `just fmt` | Always use workspace-wide formatting |

**Decision process:**
1. Identify how many crates contain your edited files
2. If 2 or more crates: use `just fmt`
3. If exactly 1 crate with 1-2 files: use `just fmt-file` for each file
4. If exactly 1 crate with 3+ files: use `just fmt`

## Available Commands

### Format Rust Code
```bash
just fmt
```
Formats all Rust code using `cargo +nightly fmt --all`. This is the primary formatting command.

### Check Rust Formatting
```bash
just fmt-check
```
Checks Rust code formatting without making changes using `cargo +nightly fmt --all -- --check`.

### Format Specific File
```bash
just fmt-file <FILE>
```
Formats a specific Rust file.

Examples:
- `just fmt-file src/main.rs` - formats a Rust file

## Important Guidelines

### Format Before Checks/Commit
Format code when you finish a coherent chunk of work and before running checks or committing.

This is a critical requirement from the project's development workflow:
- Do not skip formatting before checks/commit
- Use the Command Selection Rules above to choose the right command
- Run formatting before any check or test commands

### Example Workflows

**Single file edit:**
1. Edit a Rust file: `src/common/utils.rs`
2. When ready to validate, run: `just fmt-file src/common/utils.rs`
3. Then run checks

**Multiple files edit (3+):**
1. Edit multiple Rust files across the codebase
2. When ready to validate, run: `just fmt`
3. Then run checks

## Common Mistakes to Avoid

### ❌ Anti-patterns
- **Never run `cargo fmt` directly** - Use `just fmt-file` or `just fmt`
- **Never run `rustfmt` directly** - The justfile includes proper flags
- **Never skip formatting before checks/commit** - Even "minor" edits need formatting
- **Never use `just fmt` for 1-2 files in a single crate** - Use `just fmt-file <file>` for efficiency
- **Never use `just fmt-file` for 2+ crates or 3+ files** - Use `just fmt` for efficiency

### ✅ Best Practices
- Format before running checks/tests or before committing
- Use `just fmt-file` for 1-2 files within a single crate (faster, targeted)
- Use `just fmt` for 2+ crates or 3+ files (more efficient)
- Run `just fmt-check` to verify formatting before commits

## Next Steps

After formatting your code:
1. **Check compilation** → See `.claude/skills/code-check/SKILL.md`
2. **Run clippy** → See `.claude/skills/code-check/SKILL.md`
3. **Run targeted tests when warranted** → See `.claude/skills/code-test/SKILL.md`
