/*
	Nombre: Alán René López Lucas
	Codigo: IN5AM
    Fecha de creación: 24/2/2022
    Fecha de modificación: 24/02/2022
*/


Drop database if exists DBLaboratorio;
Create database DBLaboratorio;

Use DBLaboratorio;

Create table Lab(
	codigoLab int not null auto_increment,
    num1 int not null,
    num2 int not null,
    num3 int not null,
    num4 int not null,
    multiplicacion int,
    division int,
    raiz int,
    serie decimal (10,2),
    primary key PK_codigoLab (codigoLab)
);

-- Primero se requiere el Procedimiento Almacenado para Agregar
-- 4, 2, 8, 9

-- Procedimiento almacenado de Listar (mostrar todos los datos)

-- Funciones

/*
	1. Multiplicacion de dos numeros sin utilizar el *
    2. Division (cociente) de dos numeros sin utilizar DIV
    3. La raiz cuadrada de un numero no pueden utilizar sqrt(), pow()
    4. Serie
		1/n!
        
        1/1!+1/2!+1/3!+1/4!+1/5!
        
	Actualizar la tupla de la entidad 1 procedimiento almacenado
    
    call sp_ListarLab();
    
*/

Delimiter $$
	Create procedure sp_agregarLab(in num1 int, in num2 int, in num3 int, in num4 int)
		Begin
			insert into Lab (num1, num2, num3, num4)
				values(num1, num2, num3, num4);
        End $$
Delimiter ;

call sp_agregarLab(4,2,8,9);


Delimiter $$
	Create function fn_Multiplicacion(numero1 int, numero2 int)
    Returns int
    READS SQL DATA DETERMINISTIC
    Begin
		Declare contador int default 0;
        Declare multiplicacion int default 0;
        While(contador < numero1) do
			set contador = contador + 1;
            set multiplicacion = multiplicacion + numero2;
		End while;
        Return multiplicacion;
    End$$
Delimiter ;


Delimiter $$
	Create function fn_Division(numero3 int, numero4 int)
    Returns int
    READS SQL DATA DETERMINISTIC
    Begin
		Declare contador int default 0;
        Declare division int default 0;
        While(division < numero3) do
			set contador = contador +1;
            set division = contador * numero4;
		End while;
        Return contador;
    End$$
Delimiter ;


Delimiter $$
	Create function fn_Raiz(numero5 int)
    Returns int
    READS SQL DATA DETERMINISTIC
    Begin
		Declare contador int default 0;
        Declare raiz int default 0;
        While(raiz < numero5) do
			set contador = contador +1;
            set raiz = contador * contador;
		End while;
        Return contador;
    End$$
Delimiter ;


Delimiter $$
	Create function fn_Factorial(valor1 int)
	Returns int
    READS SQL DATA DETERMINISTIC
    Begin
		Declare contador int default 0;
        Declare factorial int default 1;
        While (contador < valor1) do
			set contador = contador + 1;
            set factorial = factorial * contador;
        End while;
        Return factorial;
    End$$
Delimiter ;

Delimiter $$
	Create function fn_Serie(num int)
	Returns int
    READS SQL DATA DETERMINISTIC
    Begin
		Declare contador int default 0;
        Declare serie decimal (10,2) default 0.00;
        While(contador < num) do
			set contador = contador + 1;
            set serie = serie + ( 1/fn_Factorial(contador)) ;
		End while;
        Return serie;
    End$$
Delimiter ;

Delimiter $$
	Create procedure sp_EditarLab(in codLab int)
    Begin
		Update Lab L
			set L.multiplicacion = fn_Multiplicacion(L.num1, L.num2),
                L.division = fn_Division(L.num2, L.num1),
                L.raiz = fn_Raiz(L.num3),
                L.serie = fn_Serie(L.num4)
                where codigoLab = codLab;
    End$$
Delimiter ;

Delimiter $$
	Create Procedure sp_ListarLab()
    Begin
		select 
			L.codigoLab,
			L.num1,
			L.num2,
			L.num3,
			L.num4,
			L.multiplicacion,
			L.division,
			L.raiz
            from Lab L;
    End $$
Delimiter ;
Call sp_EditarLab(1);
Call sp_ListarLab();