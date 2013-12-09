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
    class AbstractMatrix #clase abstracta matrix
        
        def initialize(r=0,c=0)
            @row = r
            @column = c
        end
        
        attr_accessor :row,:column
        
        def read_matrix
            raise "Error. metodo no definido."
        end
        
        def to_s
            raise "Error. metodo no definido."
        end
        
        def print_matrix
            raise "Error. metodo no definido."
        end
        
        def +(b)
            raise "Error. metodo no definido."
        end
        def *(b)
            raise "Error. metodo no definido."
        end
    end

class SparseVector #clase para guardar vector de tuplas
    def initialize(i=0,j=0,v=0)
        @i = i
        @j = j
        @value = v
    end
    attr_accessor :i,:j,:value
    
    def to_s
        "#{@i},#{@j},#{@value}"
    end
    
end

class SparseMatrix < AbstractMatrix #matrix dispersa
    
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
        @max=max()
        @min=min()
    end
    attr_accessor :MAT
    
    def insert(vector)
        @MAT<<vector
    end
    
    def to_s #devuelve una cadena string
        cadena=""
        for i in 0...@n
            cadena+="["
            for j in 0...@m
                cadena+=self.valor(i,j).to_s
                if j < @m-1
                    cadena+=", "
                end
            end
            cadena+="]"
        end
        return cadena
        
    end
    
    def valor(k,j)  #para buscar un valor especifico
        dev=0
        for i in 0...@MAT.size
            if(@MAT[i].i==k) && (@MAT[i].j==j)
                return @MAT[i].value
            end
        end
        dev
    end
    
    def max  #elemento maximo de la matrix
        maximo=@MAT[0].value
        for i in 0...@m do
            if maximo < @MAT[i].value
                maximo=@MAT[i].value
            end
        end
        return maximo
    end
        
    def min  #elemento minimo de la matrix
        minimo=@MAT[0].value
        for i in (0...@m) do
            if minimo > @MAT[i].value
                minimo=@MAT[i].value
            end
        end
        return minimo
    end
            
    def +(other)  #metodo para sumar matrices, dispersa como densa
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
        
    def *(b)  #metodo para multiplicar matrices, dispersa como densas
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


class DenseMatrix < AbstractMatrix  #clase para matrices densas
    @mat
    def initialize(r=0,c=0,matrix=[])
        super(r,c)
        @mat = matrix
    end
    
    attr_accessor :mat,:r,:c
    
    def to_s() #devuelve cadena string
        s="| "
        for i in (0... @mat.length)
            for j in (0... @mat.length)
                if j==0
                    s += "{ "
                end
                s += "#{@mat[i][j]}\t"
                if j == @mat.length-1
                    s += " } , "
                end
            end
        end
        s += "|"
    end
    
    def print_matrix()  #metodo que imprime la matrix en pantalla
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
    
    def +(b)  #suma de matrices, tando densas como dispersas
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

    def *(b)  #multiplicacion de matrices, dispersas y densas
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

class Fraction  #clase para operaciones de numeros fraccionales
    include Comparable
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
    attr_accessor :num_,:den_
    
    def to_s #devuelve string
        "#{@num_}/#{@den_}"
    end
    def to_f #devuelve float
        @num_.to_f/@den_.to_f
    end
    
    def ==(b) #comparar
        return @num_.eql?(b.num_) && @den_.eql?(b.den_)
    end

    def abs  #valor absoluto
        c = @num_.to_f/@den_.to_f
        return c.abs
    end

    def reciprocal #devuelve fraccion dada la vuelta
        f=Fraction.new
        f.num_=@den_
        f.den_ = @num_
        f
    end

    def -@  #opuesto
        Fraction.new(-@num_,@den_)
    end
    
    def +(b) #suma de numeros fraccionarios
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

    def -(b) #resta de numeros fraccionarios
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

    def *(b)  #multiplicacion de numeros fraccionarios
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

    def /(b)  #division de numeros fraccionarios
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

    def <=>(b)  #comparar
        self.to_f <=> b.to_f
    end

    def minimiza(x,y) #minimizar fraccion
        d = gcd(x,y)
        x = x/d
        y = y/d
        return x,y
    end

    def coerce(b)
        [self,Fraction.new(b,1)]
    end
end

    def gcd(u, v) #maximo comun divisor
        u, v = u.abs, v.abs
        while v != 0
            u, v = v, u % v
        end
        u
    end
end
