#!/usr/bin/env rake
require "bundler/gem_tasks"

$:.unshift File.dirname(__FILE__) + 'lib'

task :default => :all

desc "Ejecucion de la suma y la multiplicacion" 
task :all do
	sh ruby dsl.rb lib/suma.rb
	sh ruby dsl.rb multiplicacion.rb
end

desc "Ejecucion de la Suma"
task :suma do
	sh ruby dsl.rb suma.rb
end

desc "Ejecucion de la Multiplicacion"
task :multiplicacion do
	sh ruby dsl.rb multiplicacion.rb
end
