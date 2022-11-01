# How to setup Python development environment

## Installation

Install python, editor, and package manager via scoop.

```powershell
sudo scoop install python vscode poetry
```

## Configuration

### Poetry

Create virtual env under each project directory.

```powershell
poetry config virtualenvs.in-project true
```

### VSCode

Add this line to `settings.json`.

```setting.json
{
    "python.defaultInterpreterPath": ".venv\\Scripts\\python.exe",
}
```

## Extension

Finally, install Python extension from Marketplace.
