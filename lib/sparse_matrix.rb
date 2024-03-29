# = Fichero que contiene la gema para el trabajo con matrices.
# 
#  Operaciones con matrices *dispersas* y *densas*.
# 
#  Authors: KEVIN ISAAC ROBAYNA HERNANDEZ, JOSE ANTONIO RODRIGUEZ LEANDRO
# 
#  Email:  kevinirobaynahdez@gmail.com, alu0100696691@ull.edu.es
# 

# == Modulo que contiene la gema para el trabajo con matrices.
# 
#  Para la realizacion de esta practica se ha creado una jeraquia de clases. Todo esta integrado en un module llamado SparseMatrix,
#  el cual contiene la clase madre abstracta AbstractMatrix con la que creamos las clases SparseMatrix y DenseMatrix. 
#  Para almacenar los datos de la matriz dispersa usamos un vector de duplas usando la clase SparseVector.
#  Los metodos implementados usando metodologia funcional son:
# 
#  * suma
#  * multiplicacion
# 
module SparseMatrix
	#clase abstracta matrix
	class AbstractMatrix
		#Initialize, inicializa los valores a 0 por defecto o los que se les pase por parametro
		def initialize(r=0,c=0)
            		@row = r
            		@column = c
        	end
        	#Setter y Getter
        	attr_accessor :row,:column
        	#Retorna una excepcion ya que no debe ser llamada nunca
        	def read_matrix
           	 	raise "Error. metodo no definido."
        	end
        	#Retorna una excepcion ya que no debe ser llamada nunca
        	def to_s
            		raise "Error. metodo no definido."
        	end
        	#Retorna una excepcion ya que no debe ser llamada nunca
        	def print_matrix
            		raise "Error. metodo no definido."
        	end
        	#Retorna una excepcion ya que no debe ser llamada nunca
        	def +(b)
            		raise "Error. metodo no definido."
        	end
        	#Retorna una excepcion ya que no debe ser llamada nunca
		def *(b)
          		raise "Error. metodo no definido."
        	end
    	end
	#clase para guardar vector de tuplas
	class SparseVector
		#Initialize, inicializa los valores a 0 por defecto o los que se les pase por parametro
    		def initialize(i=0,j=0,v=0)
        		@i = i
        		@j = j
        		@value = v
    		end
    		#Setter y Getter
		attr_accessor :i,:j,:value
    		#Retorna un string con valor de i valor de j y el valor en dicha posicion
    		def to_s
        		"#{@i},#{@j},#{@value}"
    		end
    
	end
	#matrix dispersa
	class SparseMatrix < AbstractMatrix

		#Initialize, inicializa los valores a los que se les pase por parametro
		def initialize(*args)
        		@n,@m=args[0],args[1]
        		datos = args[2]
        		@MAT = Array.new()
        		for i in 0...@n
            			for j in 0...@m
                			if datos[i][j] != 0
                    				@MAT[i]=SparseVector.new(i,j,datos[i][j])
                			end
            			end
        		end
		end

    		#Setter y Getter
		attr_accessor :MAT

		#Introduce en la matriz un registro de la clase sparse_vector
		def insert(vector)
        		@MAT<<vector
    		end

    		#retorna un string con la matriz entera
		def to_s
			cadena="| "
        		for i in 0...@MAT.size
            			for j in 0...@MAT.size
                			if j==0 
                    				cadena+="{ "
                			end
                			cadena+="\t#{self.valor(i,j).to_s}\t"
                			if j == @MAT.size-1 || self.valor(i,j).to_s == "0"
                    				cadena+=" } , "
                			end
            			end
        		end
        		cadena+="|"        
    		end

		#para buscar un valor especifico
		def valor(k,j)
        		dev=0
        		for i in 0...@MAT.size
            			if(@MAT[i].i==k) && (@MAT[i].j==j)
                			return @MAT[i].value
            			end
        		end
        		dev
    		end
    
		#elemento maximo de la matrix
    		def max
        		maximo=@MAT[0].value
        		for i in 0...@m do
            			if maximo < @MAT[i].value
                			maximo=@MAT[i].value
            			end
        		end
			maximo
    		end

		#elemento minimo de la matrix
		def min
        		minimo=@MAT[0].value
        		for i in (0...@m) do
            			if minimo > @MAT[i].value
                			minimo=@MAT[i].value
            			end
        		end
			minimo
    		end

            	#metodo para sumar matrices, dispersa como densa
    		def +(other)
        		if other.instance_of? SparseMatrix
            			o=DenseMatrix.new(@n,@m,Array.new(@n){Array.new(@m)})
            			0.upto @MAT.size-1 do |i|
                			0.upto @MAT.size-1 do |j|
                    				o.mat[i][j]=self.valor(i,j)+other.valor(i,j)
                			end
            			end
            			return SparseMatrix.new(@n,@m,o.mat)                       #SparseMatrix.new(@n,@m,o)
			else
            			o=DenseMatrix.new(@n,@m,Array.new(@n){Array.new(@m)})
            			0.upto @n-1 do |i|
                			0.upto @m-1 do |j|
                    				o.mat[i][j]=self.valor(i,j)+other.mat[i][j]
                			end
            			end
            			return o
        		end
    		end
		
		#metodo para multiplicar matrices, dispersa como densas
		def *(b)
        		if b.instance_of? SparseMatrix
            			c = DenseMatrix.new(2,2,[[0.0,0.0],[0.0,0.0]])
            			0.upto @MAT.size-1 do |i|
                			0.upto @MAT.size-1 do |j|
                    				c.mat[i][j]=0
                    				0.upto @MAT.size-1 do |k|
                        				c.mat[i][j] += self.valor(i,k)*b.valor(k,j)
                    				end
                			end
            			end
            			c
        		else
            			c = DenseMatrix.new(2,2,[[0.0,0.0],[0.0,0.0]])
            			0.upto @MAT.size-1 do |i|
                			0.upto @MAT.size-1 do |j|
                    				c.mat[i][j]=0
                    				0.upto @MAT.size-1 do |k|
							c.mat[i][j] += self.valor(i,k)*b.mat[k][j]
                    				end
                			end
            			end
            			c
        		end
    		end
	end
	
	#clase para matrices densas
	class DenseMatrix < AbstractMatrix
		#Initialize, inicializa los valores a los que se les pase por parametro
    		def initialize(r=0,c=0,matrix=[])
        		super(r,c)
        		@mat = matrix
    		end
    		#Setter y getter
    		attr_accessor :mat,:r,:c

    		#devuelve cadena string
    		def to_s()
        		s="| "
        		for i in (0... @mat.length)
            			for j in (0... @mat.length)
                			if j==0
                    				s += "{ "
                			end
                			s += "\t#{@mat[i][j]}\t"
              	  			if j == @mat.length-1
                	    			s += " } , "
                			end
            			end
        		end
        		s += "|"
    		end
		
		#metodo que imprime la matrix en pantalla
		def print_matrix()
        		printf "| "
        		for i in (0... @mat.length)
            			for j in (0... @mat.length)
                			if j==0
                    				printf "{ "
                			end
                			printf "#{@mat[i][j]}\t"
                			if j == @mat.length-1
                    				printf " } ,"
                			end
            			end
        		end
        		printf "|"
    		end
	
		#suma de matrices, tando densas como dispersas
		def +(b)
        		c = DenseMatrix.new(2,2,[[0.0,0.0],[0.0,0.0]])
        		if b.instance_of? SparseMatrix
            			0.upto @mat.size-1 do |i|
                			0.upto @mat.size-1 do |j|
                    				c.mat[i][j] = self.mat[i][j]+b.valor(i,j)
                			end
            			end
            			c
        		else
            			0.upto @mat.size-1 do |i|
                			0.upto @mat.size-1 do |j|
						c.mat[i][j] = self.mat[i][j]+b.mat[i][j]
                			end
            			end
				c
        		end
    		end

		#multiplicacion de matrices, dispersas y densas
    		def *(b)
    			if b.instance_of? SparseMatrix
        			c = DenseMatrix.new(2,2,[[0.0,0.0],[0.0,0.0]])
        			0.upto @mat.length-1 do |i|
            				0.upto @mat.length-1 do |j|
                				c.mat[i][j]=0
                				0.upto @mat.length-1 do |k|
                    					c.mat[i][j] += @mat[i][k]*b.valor(k,j)
                				end
            				end
        			end
        			c
    			else
        			c = DenseMatrix.new(2,2,[[0.0,0.0],[0.0,0.0]])
        			0.upto @mat.length-1 do |i|
            				0.upto @mat.length-1 do |j|
                				c.mat[i][j]=0
                				0.upto @mat.length-1 do |k|
                    					c.mat[i][j] += @mat[i][k]*b.mat[k][j]
                				end
            				end
        			end
        			c
    			end
    		end
	end

	#clase para operaciones de numeros fraccionales
	class Fraction
		#Modulo que nos permite implementar el metodo starwars
    		include Comparable

    		#Initialize, inicializa los valores a los que se les pase por parametro
		def  initialize (*args)
        		if args.size == 2
            			c = gcd(args[0],args[1])
            			@num_ = (args[0]/c)
            			@den_ = (args[1]/c)
            		else
            			@num_ = args[0]
            			@den_ = 1
        		end
    		end
    		
		#getter y setter
		attr_accessor :num_,:den_
    
		#devuelve string
    		def to_s 
        		"#{@num_}/#{@den_}"
    		end
    
		#devuelve float
		def to_f 
      		  	@num_.to_f/@den_.to_f
    		end
    		
		#comparar
    		def ==(b) 
        		return @num_.eql?(b.num_) && @den_.eql?(b.den_)
    		end
		
		#valor absoluto
    		def abs
        		c = @num_.to_f/@den_.to_f
        		return c.abs
    		end

		#devuelve fraccion dada la vuelta
    		def reciprocal
        		f=Fraction.new
        		f.num_=@den_
        		f.den_ = @num_
        		f
    		end

		#opuesto
    		def -@ 
        		Fraction.new(-@num_,@den_)
    		end
    
		#suma de numeros fraccionarios
    		def +(b)
        		r=Fraction.new
        		if b.instance_of? Fraction
            			if (@den_==b.den_)
                			r.num_ = @num_ + b.num_
                			r.den_ = @den_
            			else
                			r.num_ = @num_ * b.den_ + b.num_ * @den_
                			r.den_ = @den_ * b.den_
            			end
        		else
            			r=self+Fraction.new(b,1)
        		end
        		r.num_,r.den_ = minimiza(r.num_,r.den_)
        		r
    		end
		
		#resta de numeros fraccionarios
		def -(b) 
        		r =Fraction.new
        		if b.instance_of? Fraction
            			if (@den_==b.den_)
                			r.num_ = @num_ - b.num_
                			r.den_ = @den_
            			else
                			r.num_ = @num_ * b.den_ - b.num_ * @den_
                			r.den_ = @den_ * b.den_
            			end
        		else
            			r=self-Fraction.new(b,1)
        		end
        		r.num_,r.den_ = minimiza(r.num_,r.den_)
        		r
    		end
		
		#multiplicacion de numeros fraccionarios
		def *(b)
        		r =Fraction.new
        		if b.instance_of? Fraction
            			r.num_=@num_ * b.num_
            			r.den_=@den_ * b.den_
            			r.num_,r.den_ = minimiza(r.num_,r.den_)
            			r
        		else
            			r=self*Fraction.new(b,1)
        		end
    		end

		#division de numeros fraccionarios
    		def /(b)
        		r =Fraction.new
        		if b.instance_of? Fraction
            			r.num_=@num_ / b.num_
            			r.den_=@den_ * b.den_
            			r.num_,r.den_ = minimiza(r.num_,r.den_)
            			r
        		else
            			r=self/Fraction.new(b,1)
        		end
    		end

		#comparar
    		def <=>(b)
        		self.to_f <=> b.to_f
    		end

		#minimizar fraccion
    		def minimiza(x,y)
        		d = gcd(x,y)
        		x = x/d
        		y = y/d
        		return x,y
    		end
		
		#Retorna la misma fraccion y el numero que le pasamos por parametro lo pasa a fraccion
    		def coerce(b)
        		[self,Fraction.new(b,1)]
    		end
	end

	#maximo comun divisor
	def gcd(u, v)
        	u, v = u.abs, v.abs
        	while v != 0
            		u, v = v, u % v
		end
        	u
    	end
end

#DSL INTERNO PARA OPERAR CON MATRICES
class MatrixDsl
	#Initialize, inicializa los valores a los que se les pase por parametro
	def initialize(operation = "", &block)
		@name= operation
           	@represent = 0 
           	@typeMatrix = ""
           	@DM = []
           	instance_eval &block
       end
       
       #SE ESPECIFICA QUE OPERACION REALIZAR CON LAS MATRICES
       def operation(opt)
           	@name = opt
       end
       
       #OPCIONES PARA CREAR Y MOSTRAR LAS MATRICES
       def option(opt)
           	case opt
           	when "dense"  
               		@typeMatrix = "dense"
           	when "sparse" 
               		@typeMatrix = "sparse"
           	when "console"
               		@represent = 1
           	when "matrix"
               		@represent = 0
           	end               
       end
       
       #MATRIZ DE OBJETOS PARA GUARDAR LOS OPERANDOS MATRIZ
       def operand(fil1,fil2)
           	n = fil1.size
           	m = fil2.size
           	case @typeMatrix
           	when "dense" 
            		@DM << SparseMatrix::DenseMatrix.new(n,m,[fil1,fil2])
           	when "sparse" 
            		@DM << SparseMatrix::SparseMatrix.new(n,m,[fil1,fil2])
           	end 
       end
       
       #METODO PRINCIPAL PARA REALIZAR LAS OPERACIONES CON LAS MATRICES
       def run
		case @name
           	when "suma"
               		resultado = (@DM[0]+@DM[1]).to_s
           	when "multiplicar"
               		resultado = (@DM[0]*@DM[1]).to_s
           	end

		if @represent == 1
               		result(resultado)
           	else
               		return resultado
           	end                  
       end

       #REPRESENTAR POR PANTALLA LAS OPERACIONES
       def result(res)
		case @name
           	when "suma"
              		printf "\t\tSUMA DE MATRICES \n"
               		printf "\t\t----------------\n\n"
               		printf " OPERANDO A:\t%s\n ", @DM[0].to_s
               		printf "OPERANDO B:\t%s\n\n ", @DM[1].to_s
               		printf "RESULTADO:\t%s\n\n\n", res
           	when "multiplicar"                                  
               		printf "\t\tMULTIPLICACION DE MATRICES \n"
               		printf "\t\t--------------------------\n\n"
               		printf " OPERANDO A:\t%s\n ", @DM[0].to_s
               		printf "OPERANDO B:\t%s\n\n ", @DM[1].to_s
               		printf "RESULTADO:\t%s\n\n\n", res
           	end
	end
end
