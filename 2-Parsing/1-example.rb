require 'ripper'
require 'pp'
code = <<STR
10.times do |n|
 puts n
end
STR

pp Ripper.sexp(code)

## OUTPUT
# [:program,
#  [[:method_add_block,
#    [:call,
#     [:@int, "10", [1, 0]],
#     [:@period, ".", [1, 2]],
#     [:@ident, "times", [1, 3]]],
#    [:do_block,
#     [:block_var,
#      [:params, [[:@ident, "n", [1, 13]]], nil, nil, nil, nil, nil, nil],
#      false],
#     [:bodystmt,
#      [[:command,
#        [:@ident, "puts", [2, 1]],
#        [:args_add_block, [[:var_ref, [:@ident, "n", [2, 6]]]], false]]],
#      nil,
#      nil,
#      nil]]]]]
