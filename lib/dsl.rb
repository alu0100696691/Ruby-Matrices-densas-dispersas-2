#!/usr/bin/env ruby

filename = ARGV.shift

calc = File.open(filename).read
calc = <<"CALC"
require './sparse_matrix'

MatrixDsl.new() do
    #{calc}
end
CALC
matrixdsl = eval calc

matrixdsl.run
