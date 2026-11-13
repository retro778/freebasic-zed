; =============================================================================
; FreeBASIC Tree-sitter Highlights for Zed
; =============================================================================

; -----------------------------------------------------------------------------
; Comments
; -----------------------------------------------------------------------------
(comment) @comment

; -----------------------------------------------------------------------------
; Literals
; -----------------------------------------------------------------------------
(string_literal) @string
(number_literal) @number
(boolean_literal) @constant.builtin

; -----------------------------------------------------------------------------
; Types
; -----------------------------------------------------------------------------
(builtin_type) @type.builtin

; User-defined type names in definitions
(type_definition
  name: (identifier) @type)
(enum_definition
  name: (identifier) @type)
(union_definition
  name: (identifier) @type)
(namespace_definition
  name: (identifier) @namespace)

; Type references
(typed_declaration
  type: (identifier) @type)
(typed_declaration
  type: (qualified_identifier) @type)
(parameter
  type: (identifier) @type)
(parameter
  type: (qualified_identifier) @type)
(function_declaration
  return_type: (identifier) @type)
(function_declaration
  return_type: (qualified_identifier) @type)

; Pointer types
(pointer_type) @type

; -----------------------------------------------------------------------------
; Functions and Subroutines
; -----------------------------------------------------------------------------

; Definitions
(function_declaration
  name: (identifier) @function)
(function_declaration
  name: (qualified_identifier) @function)
(sub_declaration
  name: (identifier) @function)
(sub_declaration
  name: (qualified_identifier) @function)
(property_declaration
  name: (identifier) @function.method)
(constructor_declaration) @function.method
(destructor_declaration) @function.method
(operator_declaration) @function.method

; Calls
(call_expression
  function: (identifier) @function.call)
(call_expression
  function: (qualified_identifier) @function.call)
(call_expression
  function: (member_expression
    member: (identifier) @function.method.call))

; -----------------------------------------------------------------------------
; Variables and Parameters
; -----------------------------------------------------------------------------

; Variable declarations
(typed_declaration
  name: (identifier) @variable)
(inferred_declaration
  name: (identifier) @variable)
(var_declarator
  name: (identifier) @variable)
(const_declarator
  name: (identifier) @constant)

; Parameters
(parameter
  name: (identifier) @variable.parameter)

; For loop variable
(for_statement
  variable: (identifier) @variable)

; Type fields
(type_field
  name: (identifier) @variable.member)

; Enum members are constants
(enum_member
  name: (identifier) @constant)

; Labels
(label
  (identifier) @label)

; General identifiers (fallback - lower priority)
(identifier) @variable

; -----------------------------------------------------------------------------
; Operators
; -----------------------------------------------------------------------------
[
  "+"
  "-"
  "*"
  "/"
  "\\"
  "^"
  "&"
  "="
  "<>"
  "<"
  ">"
  "<="
  ">="
  "+="
  "-="
  "*="
  "/="
  "\\="
  "&="
  "@"
] @operator

; Pointer dereference
(pointer_deref
  "*" @operator)

; Member access
(member_expression
  "." @punctuation.delimiter)
(member_expression
  "->" @punctuation.delimiter)

; -----------------------------------------------------------------------------
; Punctuation
; -----------------------------------------------------------------------------
["(" ")" "{" "}"] @punctuation.bracket
["," ";"] @punctuation.delimiter
(label ":" @punctuation.delimiter)

; -----------------------------------------------------------------------------
; Preprocessor
; -----------------------------------------------------------------------------
(pp_include
  "#" @keyword.directive)
(pp_define
  "#" @keyword.directive)
(pp_undef
  "#" @keyword.directive)
(pp_ifdef
  "#" @keyword.directive)
(pp_ifndef
  "#" @keyword.directive)
(pp_if
  "#" @keyword.directive)
(pp_else
  "#" @keyword.directive)
(pp_elseif
  "#" @keyword.directive)
(pp_endif
  "#" @keyword.directive)
(pp_macro
  "#" @keyword.directive)
(pp_pragma
  "#" @keyword.directive)
(pp_error
  "#" @keyword.directive)
(pp_print
  "#" @keyword.directive)
(pp_inclib
  "#" @keyword.directive)
(pp_libpath
  "#" @keyword.directive)
(pp_lang
  "#" @keyword.directive)
(pp_assert
  "#" @keyword.directive)

(pp_system_include) @string

; Macro/define names
(pp_define
  name: (identifier) @constant.macro)
(pp_macro
  name: (identifier) @constant.macro)

; -----------------------------------------------------------------------------
; Keywords (matched via #match? on anonymous nodes or parent context)
; -----------------------------------------------------------------------------

; Since keywords are case-insensitive regex patterns (anonymous nodes),
; we match them by their parent statement type. Tree-sitter will style
; the first token appropriately in many editors.

; Control flow - these are keyword-like constructs
(if_statement) @keyword
(if_single_line) @keyword
(elseif_clause) @keyword
(else_clause) @keyword
(while_statement) @keyword
(for_statement) @keyword
(do_statement) @keyword
(select_statement) @keyword
(case_clause) @keyword
(case_else_clause) @keyword

; Declarations
(dim_statement) @keyword
(redim_statement) @keyword
(const_statement) @keyword
(static_statement) @keyword
(shared_statement) @keyword
(common_statement) @keyword
(extern_statement) @keyword
(var_statement) @keyword

; Procedure-related
(sub_declaration) @keyword
(function_declaration) @keyword
(declare_statement) @keyword
(return_statement) @keyword

; Type definitions
(type_definition) @keyword
(enum_definition) @keyword
(union_definition) @keyword
(namespace_definition) @keyword

; I/O
(print_statement) @keyword
(input_statement) @keyword
(line_input_statement) @keyword
(open_statement) @keyword
(close_statement) @keyword
(get_statement) @keyword
(put_statement) @keyword

; Other statements
(sleep_statement) @keyword
(exit_statement) @keyword
(continue_statement) @keyword
(goto_statement) @keyword
(gosub_statement) @keyword
(with_statement) @keyword
(scope_statement) @keyword
(erase_statement) @keyword
(swap_statement) @keyword
(data_statement) @keyword
(read_statement) @keyword
(restore_statement) @keyword

; Access modifiers
(access_modifier) @keyword.modifier
(access_section) @keyword.modifier

; Calling conventions
(calling_convention) @keyword.modifier

; -----------------------------------------------------------------------------
; Special expressions
; -----------------------------------------------------------------------------
(cast_expression) @keyword
(sizeof_expression) @function.builtin
(len_expression) @function.builtin
(typeof) @function.builtin
(new_expression) @keyword
(delete_expression) @keyword
(iif_expression) @function.builtin
(addressof_expression) @keyword

; Binary operators as keywords
(binary_expression
  operator: (_) @keyword.operator)

; Unary NOT
(unary_expression
  operator: (_) @keyword.operator)