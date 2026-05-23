require 'ripper'
require 'pp'

code = <<STR
  10.times do |n|
    puts n
  end
STR

puts code
pp Ripper.lex(code)

## OUTPUT
# 10.times do |n|
#  puts n
# end
# [[[1, 0], :on_int, "10", END],
#  [[1, 2], :on_period, ".", DOT],
#  [[1, 3], :on_ident, "times", ARG],
#  [[1, 8], :on_sp, " ", ARG],
#  [[1, 9], :on_kw, "do", BEG],
#  [[1, 11], :on_sp, " ", BEG],
#  [[1, 12], :on_op, "|", BEG|LABEL],
#  [[1, 13], :on_ident, "n", ARG],
#  [[1, 14], :on_op, "|", BEG|LABEL],
#  [[1, 15], :on_ignored_nl, "\n", BEG|LABEL],
#  [[2, 0], :on_sp, " ", BEG|LABEL],
#  [[2, 1], :on_ident, "puts", CMDARG],
#  [[2, 5], :on_sp, " ", CMDARG],
#  [[2, 6], :on_ident, "n", END|LABEL],
#  [[2, 7], :on_nl, "\n", BEG],
#  [[3, 0], :on_kw, "end", END],
#  [[3, 3], :on_nl, "\n", BEG]]
