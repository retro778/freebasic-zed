# FreeBASIC for Zed (MX Linux / Xfce)

FreeBASIC language support for the [Zed editor](https://zed.dev), plus build & run
tasks that use **xfce4-terminal** (MX Linux's default terminal).

## Features

- **Syntax highlighting** via
  [tree-sitter-freebasic-zed](https://github.com/Tefached95/tree-sitter-freebasic-zed)
  — case-insensitive keywords, UDTs, enums, unions, namespaces, pointers,
  preprocessor directives
- **File detection** for `.bas` and `.bi`
- **Comments**: line (`'`) and block (`/' ... '/`) toggling, bracket auto-close
- **Outline panel / breadcrumbs** for SUBs, FUNCTIONs, PROPERTYs, TYPEs, ENUMs,
  UNIONs and NAMESPACEs
- **Tasks** for `fbc -s console -exx -w all` and `fbc -s gui -exx -w all`,
  compile-only, run-only, and compile+run — the program opens in its own
  xfce4-terminal window *outside* Zed

## 1. Install the extension

```bash
mkdir -p ~/zed-extensions
# copy this freebasic-zed folder into ~/zed-extensions/ so it lives somewhere permanent
```

In Zed: `Ctrl-Shift-P` → **zed: extensions** → **Install Dev Extension** →
select `~/zed-extensions/freebasic-zed`.

> ⚠️ **The first install is heavy.** This grammar's generated parser is ~69 MB of C.
> Compiling it to WebAssembly needs roughly **5 GB of free memory** and takes
> **3–6 minutes**. Close memory-hungry apps first, and **do not close or restart
> Zed while it builds**. Watch progress with:
>
> ```bash
> tail -f ~/.local/share/zed/logs/Zed.log
> ```
>
> If memory is tight, add temporary swap first:
>
> ```bash
> sudo fallocate -l 8G /swapfile && sudo chmod 600 /swapfile \
>   && sudo mkswap /swapfile && sudo swapon /swapfile
> ```

When it finishes, open a `.bas` file — the status bar should read **FreeBASIC**.

## 2. Install the tasks and keybindings

Zed extensions can't bundle tasks, so copy these two files:

```bash
mkdir -p ~/.config/zed
cp tasks.json  ~/.config/zed/tasks.json
cp keymap.json ~/.config/zed/keymap.json
```

(If you already have either file, merge the entries into the existing array.)
They apply on save — no restart needed.

For a single project instead of globally, put `tasks.json` in
`<project>/.zed/tasks.json`.

## Tasks

| Task | What it does |
|------|--------------|
| FB: Build (console) | `fbc -s console -exx -w all <file>` |
| FB: Build (GUI) | `fbc -s gui -exx -w all <file>` |
| FB: Run in Xfce Terminal | runs the built executable in a new terminal window |
| FB: Build (console) + Run in Xfce Terminal | compile, then run on success |
| FB: Build (GUI) + Run in Xfce Terminal | compile, then run on success |

Run them from `Ctrl-Shift-P` → **task: spawn**, or with the keys below.
Compiler output appears in Zed's terminal panel; the program itself runs in its
own window that stays open (shows the exit code, waits for a key press).

## Keybindings

| Key | Action |
|-----|--------|
| **F5** | Build console + Run |
| **Shift-F5** | Build GUI + Run |
| **F7** | Build console (compile only) |
| **Shift-F7** | Build GUI (compile only) |
| **F8** | Run the built executable |

Tasks act on the file focused in the editor; the executable is expected at fbc's
default location (same directory, same name without the extension).

## Requirements

- [FreeBASIC](https://www.freebasic.net) — `fbc` on your PATH
  (`sudo apt install freebasic`, or install from freebasic.net)
- `xfce4-terminal` (default on MX Linux). Using a different terminal? Replace
  `xfce4-terminal ... -x` with your own in `tasks.json`:
  - `xterm -e` / `konsole -e` / `mate-terminal --` / `gnome-terminal --`

## Notes

- `grammars/` and `*.wasm` appear inside this folder after a dev install —
  they're Zed's build artifacts and are gitignored.
- The bundled `highlights.scm` is the upstream grammar's query with one fix: the
  `escape_sequence` rule is removed, because that node doesn't exist in the
  grammar's generated parser and its presence stops Zed loading the language
  entirely (`Query error ... Invalid node type "escape_sequence"`).

## License

MIT — see [LICENSE](LICENSE).
