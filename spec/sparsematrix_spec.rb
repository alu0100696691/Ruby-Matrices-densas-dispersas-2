require 'spec_helper'
include SparseMatrix

describe SparseMatrix do

    describe AbstractMatrix do
        before :all do
            AA = AbstractMatrix.new
        end
        
        describe "Basic" do
            it 'existe una clase Abstracta Matrix' do
                AA.instance_of?(AbstractMatrix) == true
            end
            it 'se puede acceder a los atributos (row)?' do
                AA.row.should == 0
            end
            it 'se puede acceder a los atributos (column)' do
                AA.column.should == 0
            end
        end
        describe "Existen los Metodos?" do
            it 'Existe metodo imprimir matriz abstracto?' do
                AA.should respond_to("print_matrix")
            end
            it 'Existe metodo to_s abstracto?' do
                AA.should respond_to("to_s")
            end
            it 'Existe el operador sumar abstracto??' do
                AA.should respond_to("+")
            end
            it 'Existe el operador multiplicar abstracto?' do
                AA.should respond_to("*")
            end
        end
    end

    describe SparseVector do
        before :all do
            SV = []
            SVF = []
            SV << SparseVector.new(1,2,3.0)
            FRAC = Fraction.new(1,4)
            SVF << SparseVector.new(1,1,FRAC)
            
        end
        describe "Basicas" do
            it 'existe una clase sparse vector' do
                SV.instance_of?(SparseVector) == true
            end
            it 'existen los getter y setter? (i)' do
                SV[0].i.should == 1
            end
            it 'existen los getter y setter? (j)' do
                SV[0].j.should == 2
            end
            it 'existen los getter y setter? (value)' do
                SV[0].value.should == 3.0
            end
        end
        describe "Configuracion y muestreo" do
           it 'existe un metodo to_s' do
              SV.should respond_to("to_s") 
           end
           it 'se retorna correctamente un vector (sin Fraccion)' do
              SV[0].to_s.should eq("1,2,3.0")
           end
           it 'se retorna correctamente un vector (con Fraccion)' do
              SVF[0].to_s.should eq("1,1,1/4")
           end
        end
    end
    
    describe SparseMatrix do
        before :all do
            DM = DenseMatrix.new(2,2,[[1.0,2.0],[4.0,5.0]])
            SM = SparseMatrix::SparseMatrix.new(2,2,[[2.0,0.0],[4.0,0.0]])
        end
        describe "Basicas" do
            it 'existe una clase sparse Matrix' do
                SM.instance_of?(SparseMatrix) == true
            end
            it 'Existe metodo insertar registro' do
                SM.should respond_to("insert")
            end
            it 'Existe metodo to_s' do
                SM.should respond_to("to_s")
            end
        end
        describe "funcionalidades" do
            it 'existe metodo maximo' do
                SM.should respond_to("max")
            end
            it 'existe metodo minimo' do
                SM.should respond_to("min")
            end
            it 'calcula el maximo correctamente' do
                SM.max.should==4  
            end
            it 'calcula el minimo correctamente' do
                SM.min.should==2
            end
            it 'calcula la suma de matrices dispersa + densa' do
                (SM+DM).to_s.should=="| { 3.0\t2.0\t } , { 8.0\t5.0\t } , |"
            end
            it 'calcula la suma de matrices densa + dispersa' do
                (DM+SM).to_s.should=="| { 3.0\t2.0\t } , { 8.0\t5.0\t } , |"
            end
            it 'calcula la suma de matrices dispersa + dispersa' do
                (SM+SM).to_s.should=="[4.0, 0][8.0, 0]"
            end
            it 'calcula la multiplicacion matrices dispersa * densa' do
                (SM*DM).to_s.should=="| { 2.0\t4.0\t } , { 4.0\t8.0\t } , |"
            end
            it 'calcula la multiplicacion matrices densa * dispersa' do
                (DM*SM).to_s.should=="| { 10.0\t0.0\t } , { 28.0\t0.0\t } , |"
            end
            it 'calcula la multiplicacion matrices dispersa * dispersa' do
                (SM*SM).to_s.should=="| { 4.0\t0.0\t } , { 8.0\t0.0\t } , |"
            end
    end

    describe DenseMatrix do
        before :all do
            DMA = DenseMatrix.new(2,2,[[1.0,2.0],[4.0,5.0]])
            DMB = DenseMatrix.new(2,2,[[1.0,2.0],[3.0,4.0]])
        end
        
        it 'existe una clase Matrix' do
            DMA.instance_of?(DenseMatrix) == true
        end
        
        it 'Se han cargado los datos al objeto A' do
            DMA.mat.should be_kind_of(Array)
        end
        
        it 'Se han cargado los datos al objeto B' do
            DMB.mat.should be_kind_of(Array)
        end
        
        it 'Existe metodo imprimir matrix?' do
            DMA.should respond_to("print_matrix")
        end
        
        it 'Se muetra la matriz correctamente?' do
            DMA.print_matrix.should eq(nil)
        end
        
        it 'Se convierte la matriz correctamente?' do
            DMA.to_s.should eq("| { 1.0\t2.0\t } , { 4.0\t5.0\t } , |")
        end
        
        it 'suma de matrices, existe metodo?' do
            DMA.should respond_to("+")
        end
        
        it 'suma de matrices, suma correctamente?' do
            (DMA+DMB).to_s.should eq("| { 2.0\t4.0\t } , { 7.0\t9.0\t } , |")
        end
        
        it 'multiplicar matrices, existe metodo?' do
            DMA.should respond_to("*")
        end
        
        it 'multiplicar matrices, multiplica correctamente?' do
            (DMA*DMB).to_s.should eq("| { 7.0\t10.0\t } , { 19.0\t28.0\t } , |")
        end
     end
    end

    describe Fraction do
        before :all do
            FA = Fraction.new(1,1)
            FB = Fraction.new(1,4)
        end

        describe" basicas" do
            it "Existe un numerador" do
                FA.num_.should == 1
            end
            it "Existe un denominador" do
                FA.den_.should == 1
            end
            it "se debe mostrar en consola de la forma a/b" do
                FA.to_s.should == "1/1"
            end
            it "se debe mostrar en consola la fraccion en formato flotante" do
                FA.to_f.should == 1.0
            end
        end

        describe "Unarias" do
            it "Se debe comparar si dos fracciones son iguales con ==" do
                (FA==FB).should == false
            end

            it "Se debe calcular el valor absoluto de una fraccion con el meto abs" do
                FA.abs.should == 1
            end
            it "Se debe calcular el reciproco" do
                (FB.reciprocal).to_s.should == "4/1"
            end
            it "Calcular el opuesto de la fraccion con -" do
                (-FA).to_s.should == "-1/1"
            end
        end

        describe "aritmeticas" do
            it "Se debe sumar dos fracciones con +" do
                (FA+FB).to_s.should == "5/4"
            end
            it "Se debe restar dos fracciones con -" do
                (FA-FB).to_s.should == "3/4"
            end
            it "Se debe multiplicar dos fracciones con *" do
                (FA*FB).to_s.should == "1/4"
            end
            it "Se debe dividir dos fracciones con /" do
                (FA/FB).to_s.should == "1/4"
            end
        end

        describe "Comparacion" do
            it "Se debe de poder comprobar si una fraccion es menor que otra" do
                (FB<FA).should == true 
            end
            it "Se debe de poder comprobar si una fraccion es mayor que otra" do
                (FA>FB).should == true
            end
            it "Se debe de poder comprobar si una fraccion es menor o igual que otra" do
                (FB<=FA).should == true
            end
            it "Se debe de poder comprobar si una fraccion es mayor o igual que otra" do
                (FA>=FB).should == true
            end
        end
    end

end
