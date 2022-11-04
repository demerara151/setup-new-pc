# How To Get Started In Python

Clean and simple instruction to start development in Python on Windows with VSCode.

## Installation

Install python, editor, and package manager via scoop.

```powershell
sudo scoop install python vscode poetry
```

## Configuration

### Poetry

Configure where to create venv folder.

I would like to create virtual env folder in every project directory, so run this command:

```powershell
poetry config virtualenvs.in-project true
```

## Create new project

Create new python project using poetry.

```powershell
poetry new my-python-project
```

This command creates project folder.

## Initialize virtual environment

Go into project folder and run install command.

```powershell
cd my-python-project
poetry install
```

This command will create `.venv` folder in the project.

## Workspace

Open VSCode and save this folder as workspace.

```powershell
code .
```

> MENU: File > Save Workspace As...

## Extension

Install Python extension from Marketplace. Search `ms-python.python` in Extensions menu.

## Settings

Open settings page (`Ctrl` + `,`), select the workspace tab and open settings file by clicking the gear icon on the top right corner.

Add this in the settings section in the workspace file.

```jsonc
	"settings": {
		"[python]": {
			"editor.defaultformatter": "ms-python.python",
			"editor.wordbasedsuggestions": false,
			"editor.wordwrap": "on",
			"editor.wordwrapcolumn": 79
		},
		"python.analysis.completefunctionparens": true,
		"python.analysis.inlayhints.functionreturntypes": true,
		"python.analysis.inlayhints.variabletypes": true,
		"python.analysis.loglevel": "warning",
		"python.analysis.typecheckingmode": "strict",
		"python.defaultinterpreterpath": ".venv\\scripts\\python.exe",
		"python.formatting.blackargs": ["--line-length=79"],
		"python.formatting.provider": "black",
		"python.languageserver": "pylance",
		"python.linting.enabled": true,
		"python.linting.flake8enabled": true,
		"python.linting.lintonsave": true,
		"python.terminal.activateenvironment": true,
		"python.testing.pytestargs": ["tests"],
		"python.testing.pytestenabled": true,
		"python.testing.unittestenabled": false,
    	}
```

## Add dependencies

> Menu: Terminal > New Terminal

Install dependencies with `add` command.

```powershell
# Example
poetry add pydantic typer[all] httpx[http2]
```

You can specify development dependencies with the `--group dev" option.

```powershell
# Example
poetry add --group dev pytest black flake8
```

🎉 Congrats! Now you can start coding! 🎉
