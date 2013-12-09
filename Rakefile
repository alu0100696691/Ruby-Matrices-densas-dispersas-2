
$:.unshift File.dirname(__FILE__) + 'lib'

task :default => :all

desc "Ejecucion de la suma y la multiplicacion" 
task :all do
	 sh "clear"
     sh "ruby lib/dsl.rb lib/suma.rb"
	 sh "ruby lib/dsl.rb lib/multiplicacion.rb"
end

desc "Ejecucion de la Suma"
task :suma do
	 sh "clear"
     sh "ruby lib/dsl.rb lib/suma.rb"
end

desc "Ejecucion de la Multiplicacion"
task :multiplicacion do
	 sh "clear"
     sh "ruby lib/dsl.rb lib/multiplicacion.rb"
end

