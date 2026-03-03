; =============================================================================
; Topiary formatting queries for Siemens SCL
; =============================================================================

; -----------------------------------------------------------------------------
; Leaves — do not reformat the internals of these nodes
; -----------------------------------------------------------------------------

[
  (string_literal)
  (wstring_literal)
  (comment)
  (region_name)
  (db_identifier)
  (typed_literal)
  (time_literal)
  (s5time_literal)
  (date_literal)
  (time_of_day_literal)
  (date_time_literal)
  (based_literal)
] @leaf

; Comments always followed by a newline
(comment) @append_hardline

; -----------------------------------------------------------------------------
; Allow blank lines before top-level declarations and statements
; -----------------------------------------------------------------------------

[
  (function_block_declaration)
  (function_declaration)
  (organization_block_declaration)
  (data_block_declaration)
  (type_declaration)
] @allow_blank_line_before

[
  (assignment_statement)
  (invocation_statement)
  (if_statement)
  (for_statement)
  (while_statement)
  (repeat_statement)
  (case_statement)
  (var_block)
  (region)
  (comment)
  (return_statement)
  (exit_statement)
  (continue_statement)
] @allow_blank_line_before

; -----------------------------------------------------------------------------
; Top-level block declarations — each on its own line
; -----------------------------------------------------------------------------

(source_file (function_block_declaration)     @prepend_hardline)
(source_file (function_declaration)           @prepend_hardline)
(source_file (organization_block_declaration) @prepend_hardline)
(source_file (data_block_declaration)         @prepend_hardline)
(source_file (type_declaration)               @prepend_hardline)

; TYPE / END_TYPE keywords — own line, space after TYPE before name
["TYPE" "type" "Type"] @prepend_hardline @append_space
["END_TYPE" "end_type" "End_type" "End_Type"] @prepend_hardline @append_hardline

; STRUCT / END_STRUCT — END_STRUCT always on its own line
; STRUCT does NOT get @prepend_hardline globally because it appears inline
; after ":" in var_declarations (e.g. "Header : Struct").
; Newlines before top-level STRUCT are handled by (struct_type (var_declaration))
; and the type_declaration indent scope.
["STRUCT" "struct" "Struct"] @append_hardline
["END_STRUCT" "end_struct" "End_struct" "End_Struct"] @prepend_hardline

; In a type_declaration: STRUCT and END_STRUCT are indented under TYPE.
; VERSION is NOT indented. Indent opens after the version_pragma line,
; or after the block name if there is no VERSION pragma.
(type_declaration
  (version_pragma) @append_indent_start
  ["END_TYPE" "end_type" "End_type" "End_Type"] @prepend_indent_end)
(type_declaration
  name: (identifier)    @append_indent_start
  (version_pragma)      @prepend_indent_end)
(type_declaration
  name: (db_identifier) @append_indent_start
  (version_pragma)      @prepend_indent_end)

; var_declaration inside struct_type — each on its own line
(struct_type (var_declaration) @prepend_hardline)

; -----------------------------------------------------------------------------
; Statements inside all container scopes — each on its own line
; -----------------------------------------------------------------------------

; Helper macro — applied to every parent that can contain statements
; We list each combination to satisfy Topiary's explicit matching requirement.

; function_block_declaration body
(function_block_declaration (assignment_statement)  @prepend_hardline)
(function_block_declaration (invocation_statement)  @prepend_hardline)
(function_block_declaration (if_statement)          @prepend_hardline)
(function_block_declaration (for_statement)         @prepend_hardline)
(function_block_declaration (while_statement)       @prepend_hardline)
(function_block_declaration (repeat_statement)      @prepend_hardline)
(function_block_declaration (case_statement)        @prepend_hardline)
(function_block_declaration (return_statement)      @prepend_hardline)
(function_block_declaration (exit_statement)        @prepend_hardline)
(function_block_declaration (continue_statement)    @prepend_hardline)
(function_block_declaration (region)                @prepend_hardline)
(function_block_declaration (comment)               @prepend_hardline)

; function_declaration body
(function_declaration (assignment_statement)  @prepend_hardline)
(function_declaration (invocation_statement)  @prepend_hardline)
(function_declaration (if_statement)          @prepend_hardline)
(function_declaration (for_statement)         @prepend_hardline)
(function_declaration (while_statement)       @prepend_hardline)
(function_declaration (repeat_statement)      @prepend_hardline)
(function_declaration (case_statement)        @prepend_hardline)
(function_declaration (return_statement)      @prepend_hardline)
(function_declaration (exit_statement)        @prepend_hardline)
(function_declaration (continue_statement)    @prepend_hardline)
(function_declaration (region)                @prepend_hardline)
(function_declaration (comment)               @prepend_hardline)

; organization_block_declaration body
(organization_block_declaration (assignment_statement)  @prepend_hardline)
(organization_block_declaration (invocation_statement)  @prepend_hardline)
(organization_block_declaration (if_statement)          @prepend_hardline)
(organization_block_declaration (for_statement)         @prepend_hardline)
(organization_block_declaration (while_statement)       @prepend_hardline)
(organization_block_declaration (repeat_statement)      @prepend_hardline)
(organization_block_declaration (case_statement)        @prepend_hardline)
(organization_block_declaration (return_statement)      @prepend_hardline)
(organization_block_declaration (exit_statement)        @prepend_hardline)
(organization_block_declaration (continue_statement)    @prepend_hardline)
(organization_block_declaration (region)                @prepend_hardline)
(organization_block_declaration (comment)               @prepend_hardline)

; statement_list (shared by if/for/while/repeat bodies via else_clause etc.)
(statement_list (assignment_statement)  @prepend_hardline)
(statement_list (invocation_statement)  @prepend_hardline)
(statement_list (if_statement)          @prepend_hardline)
(statement_list (for_statement)         @prepend_hardline)
(statement_list (while_statement)       @prepend_hardline)
(statement_list (repeat_statement)      @prepend_hardline)
(statement_list (case_statement)        @prepend_hardline)
(statement_list (return_statement)      @prepend_hardline)
(statement_list (exit_statement)        @prepend_hardline)
(statement_list (continue_statement)    @prepend_hardline)
(statement_list (region)                @prepend_hardline)
(statement_list (comment)               @prepend_hardline)

; case_element body
(case_element (assignment_statement)  @prepend_hardline)
(case_element (invocation_statement)  @prepend_hardline)
(case_element (if_statement)          @prepend_hardline)
(case_element (for_statement)         @prepend_hardline)
(case_element (while_statement)       @prepend_hardline)
(case_element (repeat_statement)      @prepend_hardline)
(case_element (case_statement)        @prepend_hardline)
(case_element (return_statement)      @prepend_hardline)
(case_element (exit_statement)        @prepend_hardline)
(case_element (continue_statement)    @prepend_hardline)
(case_element (region)                @prepend_hardline)
(case_element (comment)               @prepend_hardline)

; data_block_declaration body (BEGIN section assignments)
(data_block_declaration (assignment_statement) @prepend_hardline)
(data_block_declaration (comment)              @prepend_hardline)

; region body
(region (assignment_statement)  @prepend_hardline)
(region (invocation_statement)  @prepend_hardline)
(region (if_statement)          @prepend_hardline)
(region (for_statement)         @prepend_hardline)
(region (while_statement)       @prepend_hardline)
(region (repeat_statement)      @prepend_hardline)
(region (case_statement)        @prepend_hardline)
(region (return_statement)      @prepend_hardline)
(region (exit_statement)        @prepend_hardline)
(region (continue_statement)    @prepend_hardline)
(region (comment)               @prepend_hardline)

; -----------------------------------------------------------------------------
; Variable blocks — each declaration on its own line
; -----------------------------------------------------------------------------

(var_block (var_declaration) @prepend_hardline)

; -----------------------------------------------------------------------------
; Block-level keywords and their spacing/newlines
; (uppercase and lowercase variants)
; -----------------------------------------------------------------------------

; VERSION pragma  — own line, space around colon, hardline after value
(version_pragma) @prepend_hardline
(version_pragma ":" @prepend_space @append_space)
(version_pragma (float_literal) @append_hardline)

; Block-level RETAIN / NON_RETAIN — own line
(block_attr) @prepend_hardline @append_hardline

; BEGIN section — own line
["BEGIN" "begin" "Begin"] @prepend_hardline @append_hardline

; Block openers — on their own line, name follows on same line
["FUNCTION_BLOCK" "function_block" "Function_block" "Function_Block"] @prepend_hardline @append_space
["FUNCTION" "function" "Function"]                                    @prepend_hardline @append_space
["ORGANIZATION_BLOCK" "organization_block" "Organization_block" "Organization_Block"] @prepend_hardline @append_space
["DATA_BLOCK" "data_block" "Data_block" "Data_Block"]                  @prepend_hardline @append_space

; Block closers — on their own line
["END_FUNCTION_BLOCK" "end_function_block" "End_function_block" "End_Function_Block"] @prepend_hardline @append_hardline
["END_FUNCTION" "end_function" "End_function" "End_Function"]             @prepend_hardline @append_hardline
["END_ORGANIZATION_BLOCK" "end_organization_block" "End_organization_block" "End_Organization_Block"] @prepend_hardline @append_hardline
["END_DATA_BLOCK" "end_data_block" "End_data_block" "End_Data_Block"]     @prepend_hardline @append_hardline

; VAR block keywords
["VAR" "var" "Var"
 "VAR_INPUT" "var_input" "Var_input" "Var_Input"
 "VAR_OUTPUT" "var_output" "Var_output" "Var_Output"
 "VAR_IN_OUT" "var_in_out" "Var_in_out" "Var_In_Out"
 "VAR_TEMP" "var_temp" "Var_temp" "Var_Temp"
 "VAR_STAT" "var_stat" "Var_stat" "Var_Stat"
 "VAR_GLOBAL" "var_global" "Var_global" "Var_Global"] @prepend_hardline @append_space

["END_VAR" "end_var" "End_var" "End_Var"] @prepend_hardline @append_hardline

; RETAIN / NON_RETAIN / CONSTANT / PERSISTENT stay on same line as VAR keyword.
; var_declaration gets its own @prepend_hardline from (var_block (var_declaration)).
(var_attr) @append_hardline

; -----------------------------------------------------------------------------
; Control-flow keyword spacing
; -----------------------------------------------------------------------------

; IF / ELSIF — space after, condition follows inline
["IF" "if" "If"] @append_space
["ELSIF" "elsif" "Elsif"] @prepend_hardline @append_space

; THEN — space before, body on next line
["THEN" "then" "Then"] @prepend_space @append_hardline

; ELSE — own line, body on next line
["ELSE" "else" "Else"] @prepend_hardline @append_hardline

; END_IF — own line
["END_IF" "end_if" "End_if" "End_If"] @prepend_hardline

; FOR — space after
["FOR" "for" "For"] @append_space

; TO / BY — space on both sides
["TO" "to" "To"] @prepend_space @append_space
["BY" "by" "By"] @prepend_space @append_space

; DO — space before, body on next line
["DO" "do" "Do"] @prepend_space @append_hardline

["END_FOR" "end_for" "End_for" "End_For"] @prepend_hardline
["END_WHILE" "end_while" "End_while" "End_While"] @prepend_hardline

; WHILE — space after
["WHILE" "while" "While"] @append_space

; REPEAT — body on next line; UNTIL — own line, space after
["REPEAT" "repeat" "Repeat"] @append_hardline
["UNTIL" "until" "Until"] @prepend_hardline @append_space
["END_REPEAT" "end_repeat" "End_repeat" "End_Repeat"] @prepend_hardline

; CASE — space after; OF — space before, body on next line
["CASE" "case" "Case"] @append_space
(case_statement ["OF" "of" "Of"] @prepend_space @append_hardline)

["END_CASE" "end_case" "End_case" "End_Case"] @prepend_hardline

; RETURN / EXIT / CONTINUE — own line, semicolon immediately after
["RETURN" "return" "Return"] @prepend_hardline @append_antispace
["EXIT" "exit" "Exit"] @prepend_hardline @append_antispace
["CONTINUE" "continue" "Continue"] @prepend_hardline @append_antispace

; REGION
["REGION" "region" "Region"] @prepend_hardline @append_space
["END_REGION" "end_region" "End_region" "End_Region"] @prepend_hardline

(region (region_name) @append_hardline)

; -----------------------------------------------------------------------------
; Indentation
; -----------------------------------------------------------------------------

; Block body indentation — indent starts after BEGIN, ends at block closer.
; VAR blocks and pragmas sit outside BEGIN so they are NOT indented.
; Statements inside BEGIN ARE indented.
(function_block_declaration
  ["BEGIN" "begin" "Begin"] @append_indent_start
  ["END_FUNCTION_BLOCK" "end_function_block" "End_function_block" "End_Function_Block"] @prepend_indent_end)

(function_declaration
  ["BEGIN" "begin" "Begin"] @append_indent_start
  ["END_FUNCTION" "end_function" "End_function" "End_Function"] @prepend_indent_end)

(organization_block_declaration
  ["BEGIN" "begin" "Begin"] @append_indent_start
  ["END_ORGANIZATION_BLOCK" "end_organization_block" "End_organization_block" "End_Organization_Block"] @prepend_indent_end)

(data_block_declaration
  ["BEGIN" "begin" "Begin"] @append_indent_start
  ["END_DATA_BLOCK" "end_data_block" "End_data_block" "End_Data_Block"] @prepend_indent_end)

; VAR blocks
(var_block
  ["VAR" "var" "Var"
   "VAR_INPUT" "var_input" "Var_input" "Var_Input"
   "VAR_OUTPUT" "var_output" "Var_output" "Var_Output"
   "VAR_IN_OUT" "var_in_out" "Var_in_out" "Var_In_Out"
   "VAR_TEMP" "var_temp" "Var_temp" "Var_Temp"
   "VAR_STAT" "var_stat" "Var_stat" "Var_Stat"
   "VAR_GLOBAL" "var_global" "Var_global" "Var_Global"] @append_indent_start
  ["END_VAR" "end_var" "End_var" "End_Var"] @prepend_indent_end)

; IF / ELSIF / ELSE
(if_statement
  ["THEN" "then" "Then"] @append_indent_start
  ["END_IF" "end_if" "End_if" "End_If"] @prepend_indent_end)

(elsif_clause
  ["ELSIF" "elsif" "Elsif"] @prepend_indent_end
  ["THEN" "then" "Then"] @append_indent_start)

(else_clause
  ["ELSE" "else" "Else"] @prepend_indent_end @append_indent_start)

; FOR
(for_statement
  ["DO" "do" "Do"] @append_indent_start
  ["END_FOR" "end_for" "End_for" "End_For"] @prepend_indent_end)

; WHILE
(while_statement
  ["DO" "do" "Do"] @append_indent_start
  ["END_WHILE" "end_while" "End_while" "End_While"] @prepend_indent_end)

; REPEAT .. UNTIL
(repeat_statement
  ["REPEAT" "repeat" "Repeat"] @append_indent_start
  ["UNTIL" "until" "Until"] @prepend_indent_end)

; CASE
(case_statement
  ["OF" "of" "Of"] @append_indent_start
  ["END_CASE" "end_case" "End_case" "End_Case"] @prepend_indent_end)

; case_element — selector on its own line, body indented after colon.
; Indent ends at the close of the case_element node (before the next selector).
(case_element (case_selector_list) @prepend_hardline)
(case_element ":" @append_indent_start @append_hardline)
(case_element) @append_indent_end

; STRUCT indentation
(struct_type
  ["STRUCT" "struct" "Struct"] @append_indent_start
  ["END_STRUCT" "end_struct" "End_struct" "End_Struct"] @prepend_indent_end)

; Array type — keep entirely on one line: ARRAY[lo..hi] OF type
(array_type "]" @append_space)
(array_type ["OF" "of" "Of"] @append_space)

; REGION
(region
  ["REGION" "region" "Region"] @append_indent_start
  ["END_REGION" "end_region" "End_region" "End_Region"] @prepend_indent_end)

; -----------------------------------------------------------------------------
; Assignment and operator spacing
; -----------------------------------------------------------------------------

(var_declaration ":" @prepend_space @append_space)
(var_declaration ":=" @prepend_space @append_space)

(assignment_statement ":=" @prepend_space @append_space)
(for_statement        ":=" @prepend_space @append_space)
(argument             ":=" @prepend_space @append_space)
(argument             "=>" @prepend_space @append_space)
(attribute_pragma     ":=" @prepend_space @append_space)

";" @prepend_antispace

(binary_expression [
  "OR" "or" "Or" "XOR" "xor" "Xor" "AND" "and" "And"
  "=" "<>" "<" ">" "<=" ">="
  "+" "-" "*" "/" "MOD" "mod" "Mod"
  "**"
] @prepend_space @append_space)

(unary_expression ["NOT" "not" "Not"] @append_space)

; -----------------------------------------------------------------------------
; Function / block calls
; -----------------------------------------------------------------------------

; No space between name and opening paren
(invocation_statement "(" @prepend_antispace)
(call_expression      "(" @prepend_antispace)

; Soft-wrap argument lists
(invocation_statement
  "(" @append_indent_start @append_empty_softline
  ")" @prepend_empty_softline @prepend_indent_end)

(call_expression
  "(" @append_indent_start @append_empty_softline
  ")" @prepend_empty_softline @prepend_indent_end)

; Commas in argument lists — no space before, soft newline after
(argument_list "," @prepend_antispace @append_spaced_softline)

; No space before closing paren (when it's the last token in the call)
(invocation_statement ")" @prepend_antispace .)
(call_expression      ")" @prepend_antispace .)

; -----------------------------------------------------------------------------
; Variable member access — no spaces around dots or sigil
; -----------------------------------------------------------------------------

(lvalue "." @prepend_antispace @append_antispace)
(lvalue "#" @append_antispace)

; -----------------------------------------------------------------------------
; Subscript — no space before bracket
; -----------------------------------------------------------------------------

(subscript "[" @prepend_antispace)

; -----------------------------------------------------------------------------
; Attribute pragma spacing
; -----------------------------------------------------------------------------

(attribute_pragma "{" @prepend_hardline @append_space)
(attribute_pragma "}" @prepend_space)
