; =============================================================================
; Topiary formatting queries for Siemens SCL
; =============================================================================

; -----------------------------------------------------------------------------
; Leaves — do not format inside these nodes
; -----------------------------------------------------------------------------

[
  (string)
  (comment)
  (region_name)
  (db_identifier)
] @leaf

; -----------------------------------------------------------------------------
; Allow blank lines before statements
; -----------------------------------------------------------------------------

[
  (assignment)
  (function_call)
  (if_statement)
  (for_loop)
  (while_loop)
  (case_statement)
  (var_block)
  (region)
  (comment)
] @allow_blank_line_before

; -----------------------------------------------------------------------------
; Newlines — each statement on its own line
; -----------------------------------------------------------------------------

(source_file (assignment) @prepend_hardline)
(source_file (function_call) @prepend_hardline)
(source_file (if_statement) @prepend_hardline)
(source_file (for_loop) @prepend_hardline)
(source_file (while_loop) @prepend_hardline)
(source_file (case_statement) @prepend_hardline)
(source_file (var_block) @prepend_hardline)
(source_file (region) @prepend_hardline)
(source_file (comment) @prepend_hardline)

(if_statement (assignment) @prepend_hardline)
(if_statement (function_call) @prepend_hardline)
(if_statement (if_statement) @prepend_hardline)
(if_statement (for_loop) @prepend_hardline)
(if_statement (while_loop) @prepend_hardline)
(if_statement (case_statement) @prepend_hardline)
(if_statement (comment) @prepend_hardline)

(elsif_clause (assignment) @prepend_hardline)
(elsif_clause (function_call) @prepend_hardline)
(elsif_clause (if_statement) @prepend_hardline)
(elsif_clause (for_loop) @prepend_hardline)
(elsif_clause (while_loop) @prepend_hardline)
(elsif_clause (case_statement) @prepend_hardline)
(elsif_clause (comment) @prepend_hardline)

(for_loop (assignment) @prepend_hardline)
(for_loop (function_call) @prepend_hardline)
(for_loop (if_statement) @prepend_hardline)
(for_loop (for_loop) @prepend_hardline)
(for_loop (while_loop) @prepend_hardline)
(for_loop (case_statement) @prepend_hardline)
(for_loop (comment) @prepend_hardline)

(while_loop (assignment) @prepend_hardline)
(while_loop (function_call) @prepend_hardline)
(while_loop (if_statement) @prepend_hardline)
(while_loop (for_loop) @prepend_hardline)
(while_loop (while_loop) @prepend_hardline)
(while_loop (case_statement) @prepend_hardline)
(while_loop (comment) @prepend_hardline)

(case_branch (assignment) @prepend_hardline)
(case_branch (function_call) @prepend_hardline)
(case_branch (if_statement) @prepend_hardline)
(case_branch (for_loop) @prepend_hardline)
(case_branch (while_loop) @prepend_hardline)
(case_branch (case_statement) @prepend_hardline)
(case_branch (comment) @prepend_hardline)

(region (assignment) @prepend_hardline)
(region (function_call) @prepend_hardline)
(region (if_statement) @prepend_hardline)
(region (for_loop) @prepend_hardline)
(region (while_loop) @prepend_hardline)
(region (case_statement) @prepend_hardline)
(region (var_block) @prepend_hardline)
(region (comment) @prepend_hardline)

(var_block (var_declaration) @prepend_hardline)

; -----------------------------------------------------------------------------
; Keywords — spacing and newlines
; -----------------------------------------------------------------------------

; Block closers on their own line
"END_IF"     @prepend_hardline
"END_FOR"    @prepend_hardline
"END_WHILE"  @prepend_hardline
"END_CASE"   @prepend_hardline
"END_REGION" @prepend_hardline
"END_VAR"    @prepend_hardline

; ELSIF and ELSE on their own line
"ELSIF" @prepend_hardline @append_space
"ELSE"  @prepend_hardline @append_indent_start @append_hardline

; Space after these keywords before condition/expression
"IF"    @append_space
"FOR"   @append_space
"WHILE" @append_space
"CASE"  @append_space

; Space before and after these keywords
"THEN" @prepend_space @append_hardline
"DO"   @prepend_space @append_hardline
"OF"   @prepend_space
"TO"   @prepend_space @append_space
"BY"   @prepend_space @append_space

; -----------------------------------------------------------------------------
; Indentation
; -----------------------------------------------------------------------------

(if_statement
  "THEN" @append_indent_start
  "END_IF" @prepend_indent_end)

(if_statement
  "ELSE" @prepend_indent_end)

(elsif_clause
  "ELSIF" @prepend_indent_end
  "THEN" @append_indent_start)

(for_loop
  "DO" @append_indent_start
  "END_FOR" @prepend_indent_end)

(while_loop
  "DO" @append_indent_start
  "END_WHILE" @prepend_indent_end)

(case_statement
  "OF" @append_indent_start
  "END_CASE" @prepend_indent_end)

(case_statement
  "ELSE" @prepend_indent_end)

(case_branch
  ":" @append_indent_start)

(case_branch (case_value) @prepend_hardline @prepend_indent_end)

(var_block
  "END_VAR" @prepend_indent_end)

(var_block
  ["VAR"
  "VAR_TEMP"
  "VAR_IN"
  "VAR_OUT"
  "VAR_IN_OUT"] @append_indent_start)

(region
  "REGION" @append_indent_start
  "END_REGION" @prepend_indent_end)

(region
  (region_name) @append_hardline)

; -----------------------------------------------------------------------------
; Assignment and operator spacing
; -----------------------------------------------------------------------------

(var_declaration
  ":" @prepend_space @append_space)

(assignment ":=" @prepend_space @append_space)
(argument ":=" @prepend_space @append_space)

";" @prepend_antispace

(binary_expression
  [
    "OR" "XOR" "AND"
    "=" "<>" "<" ">" "<=" ">="
    "+" "-" "*" "/" "MOD"
  ] @prepend_space @append_space)

(unary_expression "NOT" @append_space)

; -----------------------------------------------------------------------------
; Function calls
; -----------------------------------------------------------------------------

(function_call "(" @prepend_antispace)

(argument_list
  "," @prepend_antispace @append_spaced_softline)

(function_call
  "(" @append_indent_start @append_empty_softline
  ")" @prepend_empty_softline @prepend_indent_end)

(argument (plain_identifier) @append_space ":=" @append_space)

(function_call ")" @prepend_antispace .)

; -----------------------------------------------------------------------------
; Variable member access — no spaces around dots
; -----------------------------------------------------------------------------

(local_variable "." @prepend_antispace @append_antispace)
(global_variable "." @prepend_antispace @append_antispace)
(local_variable "#" @append_antispace)

; -----------------------------------------------------------------------------
; Case branch — no space before colon
; -----------------------------------------------------------------------------

(case_branch ":" @prepend_antispace)
