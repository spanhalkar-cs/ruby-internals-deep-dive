# When processing a string with interpolation, the tokenizer must pause string processing, 
# dive back into code parsing mode, and resume string processing when done.

require 'ripper'

code = '"Hello #{user.name}!"'

Ripper.lex(code).each { |tok| p tok[1..2] }

## OUTPUT

# [:on_tstring_beg, "\""]         # Starts double-quoted string
# [:on_tstring_content, "Hello "] # String literal content
# [:on_embexpr_beg, "\#{"]        # <-- ESCAPE VELOCITY! Switches to Embedded Expression mode
# [:on_ident, "user"]             # Back to regular Ruby code evaluation (Identifier)
# [:on_period, "."]               # Period operator
# [:on_ident, "name"]             # Identifier
# [:on_embexpr_end, "}"]          # <-- Pops back out of Embedded Expression mode
# [:on_tstring_content, "!"]      # String literal content resumes
# [:on_tstring_end, "\""]         # Concludes double-quoted string

## NOTE
# Why it's complex: The tokenizer effectively runs a stack. When it hits #{, it pushes the "string state" onto a stack 
# and spins up a brand-new code tokenization state. 
# It must also keep track of balancing internal braces—if your interpolation includes a hash literal like "#{ {key: 'val'} }", 
# it has to count the open/close curly brackets perfectly so it doesn't accidentally trigger the string-resume phase 
# (:on_embexpr_end) too early!
