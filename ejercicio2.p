{$mode objfpc}{$H-}{$R+}{$T+}{$Q+}{$V+}{$D+}{$X-}{$warnings on}

program ejercicio2;

uses math;

function esletra(c: char): boolean;
begin
	result := (c >='A') and (c <='Z') or (c >='a') and (c <= 'z');
end;

function esnum(c: char): boolean;
begin
	result := (c >='1') and (c <='9');
end;

function caracterparteident(c: char): boolean;
begin
	result := esletra(c) or esnum(c) or (c= '_');
end;

function principioident(c: char): boolean;
begin
	result := esletra(c) or (c= '_');
end;

function carahexadec (c:char): integer;
begin
	result := 10 + (ord(c) -(ord ('A')));
end;

function minamayusc(c: char): char;
begin
	result := upcase(c);
end;

function mayuscamin(c: char): char;
begin
	result := lowercase(c);
end;

function pxrectangulo(n: integer): boolean;
begin
	result := (n>=(0)) and (n<=(100));
end;

function pyrectangulo(n: integer): boolean;
begin
	result := (n<=(0)) and (n>=(-100));
end;

function primersolecuacion(n: real): real;
const
    	a: real = 2.0;
	b: real = 6.0;
	c: real = 3.0;
begin
	result := ((-b + sqrt( b ** 2 - 4 * a * c))/(2 * a));
	{(a * x ** 2) + (b * x) + c}
end;

function segundasolecuacion(n: real): real;
const
    	a: real = 2.0;
	b: real = 6.0;
	c: real = 3.0;
begin
	result := ((-b - sqrt( b ** 2 - 4 * a * c))/(2 * a));
end;
const
	caracter: char ='1';
	letramin: char = 'a';
	letramayusc: char = 'B';
    	Puntox: integer = 11;
    	Puntoy: integer = -22;
    	caracterhexa: char = 'C';
begin
	
	writeln (caracterparteident(caracter));
	writeln (esnum(caracter) or esletra(caracter));
	writeln (principioident(caracter));
	writeln (carahexadec(caracterhexa));
	writeln (minamayusc(letramin));
	writeln (mayuscamin(letramayusc));
	writeln (pxrectangulo(Puntox) and pyrectangulo(Puntoy));
	writeln (primersolecuacion(5):(2));
	writeln (segundasolecuacion(5):(2));
end.
