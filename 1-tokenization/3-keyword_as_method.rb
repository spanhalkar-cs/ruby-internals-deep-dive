# Ruby allows reserved language keywords (if, class, end, while) to be used as method identifiers, 
# provided they have an explicit receiver (like a dot operator . or a safe navigation operator &.).

require 'ripper'

# 'if' acting as control flow
code_a = "if condition; end"

# 'if' acting as a method name
code_b = "object.if(condition)"

puts "--- Scenario A (Keyword) ---"
Ripper.lex(code_a).each { |tok| p tok[1..2] }

puts "\n--- Scenario B (Method Identifier) ---"
Ripper.lex(code_b).each { |tok| p tok[1..2] }

## Output
# --- Scenario A (Keyword) ---
# [:on_kw, "if"]                           # <-- Identified strictly as a Keyword (:on_kw)
# [:on_sp, " "]
# [:on_ident, "condition"]
# [:on_semicolon, ";"]
# [:on_sp, " "]
# [:on_kw, "end"]

# --- Scenario B (Method Identifier) ---
# [:on_ident, "object"]
# [:on_period, "."]                       # <-- The period shifts the lexer context
# [:on_ident, "if"]                       # <-- 'if' is downgraded to a normal identifier (:on_ident)
# [:on_lparen, "("]
# [:on_ident, "condition"]
# [:on_rparen, ")"]

## NOTE
# Why it's complex: Ruby’s lexer must dynamically track if a . or &. immediately precedes a keyword. 
# If it does, it suppresses the keyword designation and treats it as an ordinary method identifier.
