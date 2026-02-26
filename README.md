# topiary-structured-control-language
topiary formatter for Siemens SCL

# Features
Format SCL code.
- Automatic indentation
- Adds spaces around assignment operator `:=`
- Breaks up multiargument function and function blocks calls to one argument per line.

# Usage
Use with [topiary](https://github.com/topiary/topiary) to format Siemens SCL code that has been parsed with [tree-sitter](https://github.com/tree-sitter/tree-sitter).

A compatible tree-sitter parser for SCL can be found [here](https://github.com/jensalmkvist/tree-sitter-structured-control-language).

Add the tree-sitter grammar.js to your topiary config languages.ncl like this:
```scm
    structured_control_language = {
      extensions | default = ["scl"],
      indent | default = "  ", # 2 spaces
      grammar.source | default = {
        git = {
          git = "https://github.com/jensalmkvist/tree-sitter-structured-control-language.git",
          rev = "main",
        },
      },
    },
```

Place the .scm file from this repo in either your workspace or topiary OS folder
╭───────────┬────────────────────────────────────────────────────────────────┬───────────────┬─────────╮
│ source    │ path                                                           │ languages.ncl │ queries │
├───────────┼────────────────────────────────────────────────────────────────┼───────────────┼─────────┤
│ workspace │ \\?\C:\Utilities\topiary-structured-control-language\.topiary  │ ✅            │ ✅      │
├───────────┼────────────────────────────────────────────────────────────────┼───────────────┼─────────┤
│ OS        │ \\?\C:\Users\JensThiemeAlmkvist\AppData\Roaming\topiary\config │ ✅            │ ✅      │
├───────────┼────────────────────────────────────────────────────────────────┼───────────────┼─────────┤
│ built-in  │ <built-in>                                                     │ ✅            │ ✅      │
╰───────────┴────────────────────────────────────────────────────────────────┴───────────────┴─────────╯

Check your current scheme paths with
```powershell
topiary config -show-sources
```

## Run the formatter on a file
To run the formatter on a file use `topiary format <FILE_PATH>`
