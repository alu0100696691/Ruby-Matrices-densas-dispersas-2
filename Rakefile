#!/usr/bin/env rake
require "bundler/gem_tasks"

$:.unshift File.dirname(__FILE__) + 'lib'
require 'rspec/core/rake_task' 
RSpec::Core::RakeTask.new

task :default => :spec

desc "Ejecucion de pruebas rspec" 
task :spec do
    sh "rspec --color --format documentation -Ilib -Ispec spec/dsl_matrix_spec.rb"
end
