## A forward slash / can mean division or a Regular Expression. 
## The tokenizer decides this entirely based on its internal lexical state (EXPR_END vs EXPR_BEG).

require 'ripper'

# Scenario A: Division
code_a = "total / 2"
# Scenario B: Regex
code_b = "total = /2/"

puts "--- Scenario A (Division) ---"
Ripper.lex(code_a).each { |tok| p tok[1..3] }

puts "\n--- Scenario B (Regex) ---"
Ripper.lex(code_b).each { |tok| p tok[1..3] }

## Output:
# 40 ms | 15.6 MB
# --- Scenario A (Division) ---
# [:on_ident, "total", CMDARG]
# [:on_sp, " ", CMDARG]
# [:on_op, "/", BEG]                       # <---------- Tokenized as an Operator (:on_op)
# [:on_sp, " ", BEG]
# [:on_int, "2", END]

# --- Scenario B (Regex) ---
# [:on_ident, "total", CMDARG]
# [:on_sp, " ", CMDARG]
# [:on_op, "=", BEG]                       # <---------- The '=' changes the state to EXPR_BEG
# [:on_sp, " ", BEG]
# [:on_regexp_beg, "/", BEG]               # <---------- Tokenized as the BEGINNING of a string/regex!
# [:on_tstring_content, "2", BEG]
# [:on_regexp_end, "/", BEG]

## NOTE
# The lexer can't just see / and output a single token type. It has to look at its own history. 
# Because the assignment operator = puts the lexer into the EXPR_BEG (Beginning of an expression) state, 
# the lexer knows the next / must be a Regular Expression literal, not division.
