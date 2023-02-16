# How To Get Started In Rust

Clean and simple instruction to start development in Rust on Windows with VSCode.

## Installation

Install Rust toolchain called `rustup` via scoop.

Install `rustup` via scoop and install `MSVC toolchain` manually from microsoft.

```powershell
scoop install rustup
```

You have to install `Visual Studio Installer` to install `Visual Studio Build Tools` from [Microsoft C++ Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/)

Then install `MSVC Build tools` and `Windows SDK` in `C/C++ desktop development` section.

![build_tools](https://user-images.githubusercontent.com/54271767/219233838-0b5c43b0-97f6-4c4a-8c1c-b5e7edfb06f5.png)

## Create your first Rust project

Run `cargo new [Your-Project-Name]` in terminal. Then cd to it and open vscode.

```powershell
cargo new my_first_rust_project

cd my_first_rust_project
code .
```

## Extension

Install Rust extension from Marketplace. Search `rust-lang.rust-analyzer` in Extensions menu.

## Settings

Open settings page (`Ctrl + ,`), select the workspace tab and open settings file by clicking the gear icon on the top right corner.

Add this in the settings section in the workspace file.

```jsonc
"settings":
		"[rust]": {
			"editor.defaultFormatter": "rust-lang.rust-analyzer",
      },
```

## Start coding

Yes, there's no additional configuration needed.

🎉 Congrats! Now you can start coding! 🎉
