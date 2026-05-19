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
# [:on_op, "/", BEG]                       # <---------- as an operator
# [:on_sp, " ", BEG]
# [:on_int, "2", END]

# --- Scenario B (Regex) ---
# [:on_ident, "total", CMDARG]
# [:on_sp, " ", CMDARG]
# [:on_op, "=", BEG]
# [:on_sp, " ", BEG]
# [:on_regexp_beg, "/", BEG]               # <---------- as an regex beginner
# [:on_tstring_content, "2", BEG]
# [:on_regexp_end, "/", BEG]
