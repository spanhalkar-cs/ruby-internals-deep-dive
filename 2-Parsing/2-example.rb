require 'ripper'
require 'pp'
code = <<STR
2 + 2 * 3
STR

pp Ripper.sexp(code)

## OUTPUT
# [:program,
#  [[:binary,
#    [:@int, "2", [1, 0]],
#    :+,
#    [:binary, 
#      [:@int, "2", [1, 4]], 
#      :*, 
#      [:@int, "3", [1, 8]]]]]]
