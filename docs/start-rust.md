# How To Get Started In Rust

Clean and simple instruction to start development in Rust on Windows with VSCode.

## Installation

Install Rust toolchain via scoop.

There's two options to install rust with MSVC toolchain.

1. Install rust with MSVC toolchain. No need to install additional dependencies.

  ```powershell
  scoop install rust-msvc
  ```
  
  However, this toolchain doesn't have some core component like clippy or rust_fmt.

2. Install rustup via scoop and install MSVC manually from microsoft. This is recommended.

  ```powershell
  scoop install rustup-msvc
  ```

  This command will install only Rust. You should install MSVC toolchain from [Microsoft C++ Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/)

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
