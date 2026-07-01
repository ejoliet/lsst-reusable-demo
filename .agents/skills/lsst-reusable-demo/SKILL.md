```markdown
# lsst-reusable-demo Development Patterns

> Auto-generated skill from repository analysis

## Overview
This skill teaches the core development patterns and conventions used in the `lsst-reusable-demo` Python repository. It covers file naming, import/export styles, commit message tendencies, and testing patterns. While no explicit frameworks or automated workflows were detected, this guide will help you contribute code that matches the project's established style.

## Coding Conventions

### File Naming
- Use **snake_case** for all file names.
  - Example: `data_loader.py`, `my_module.py`

### Import Style
- Use **relative imports** within the package.
  - Example:
    ```python
    from .utils import helper_function
    from . import constants
    ```

### Export Style
- Use **named exports** (explicitly define what is exported from a module).
  - Example:
    ```python
    __all__ = ['MyClass', 'my_function']
    ```

### Commit Messages
- Freeform style, no strict prefixes.
- Average commit message length: ~21 characters.
  - Example:  
    ```
    Add data processing script
    ```

## Workflows

_No automated workflows detected in this repository._

## Testing Patterns

- **Test Framework:** Unknown (no framework detected).
- **Test File Pattern:** Files named with the pattern `*.test.ts` (TypeScript test files).
  - Example: `example.test.ts`
- **Note:** While the codebase is Python, test files may be written in TypeScript or follow a TypeScript-style naming convention. Check with the team for the preferred testing approach.

## Commands

| Command | Purpose |
|---------|---------|
| /contribute | Guidelines for contributing code using the project's conventions |
| /test | Instructions for running or writing tests (if applicable) |
| /imports | Examples of correct import/export usage |
```