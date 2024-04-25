{$mode objfpc}{$H-}{$R+}{$T+}{$Q+}{$V+}{$D+}{$X-}{$warnings on}

{fpc -gl ejercicio4.p}

program ejercicio4;

var
	x1: integer;
	y1: integer;
	x2: integer;
	y2: integer;
	pto1xrectangulo:integer;
	pto1yrectangulo:integer;
	pto2xrectangulo:integer;
	pto2yrectangulo:integer;
	
procedure sistgrafico(x,y:integer);
begin
	if (x<0) or (x>1024) or (y<0) or (y>100) then begin
		writeln('Datos incorrectos');
		HALT;
	end;
end;
procedure intercambiar(x1,y1,x2,y2:integer);
var
	aux1: integer;
	aux2: integer;
begin
	aux1:= x1;
	aux2:= x2;
	x1:= x2;
	y1:= y2;
	x2:= aux1;
	y2:= aux2;
end;

procedure escribirpto(x,y:integer);
begin
	write('[');
	write(x);
	write(',');
	write(y);
	write(']');
end;

procedure ordenrectangulo(var x1,y1,x2,y2:integer);
begin
	if y1 > y2 then begin
	intercambiar(x1,y1,x2,y2);
	end
	else if (y1 = y2) and (x1 > x2) then begin
		intercambiar(x1,y1,x2,y2);
	end;
end;

procedure ptomenor(x1,y1,x2,y2:integer);
begin
	if y1 > y2 then begin
		escribirpto(x2,y2);
	end
	else if y1 < y2 then begin
		escribirpto(x1,y1);
	end
	else if (y1 = y2) and (x1 > x2) then begin
		escribirpto(x2,y2)
	end
	else if (y1 = y2) and (x1 < x2) then begin
			escribirpto(x1,y1)
	end;
end;

function ptoydentrorectangulo(y:integer):boolean;
begin
	result:= (y >= pto1yrectangulo) and (y<=pto2yrectangulo);
end;

function ptodentrorectangulo(x,y:integer):boolean;
begin
	if ptoydentrorectangulo(y) then begin
		if (x >= pto1xrectangulo) and (x <= pto2xrectangulo) then
			result:= True
		else
			result:= False
	end;
end;
procedure ptomayor(x1,y1,x2,y2:integer);
begin
	if y1 < y2 then begin
		escribirpto(x2,y2);
	end
	else if y1 > y2 then begin
		escribirpto(x1,y1);
	end
	else if (y1 = y2) and (x1 < x2) then begin
		escribirpto(x2,y2)
	end
		else if (y1 = y2) and (x1 > x2) then begin
			escribirpto(x1,y1)
	end;
end;

function base(x1,x2:integer):integer;
begin
	result:= x2 - x1;
end;

function altura(y1,y2:integer):integer;
begin
	result:= y2 - y1;
end;

function area(x1,y1,x2,y2:integer):integer;
begin
	result:= base(x1,x2) * altura(y1,y2);
end;

function perimetro(x1,y1,x2,y2:integer):integer;
begin
	result:= Abs((2 * base(x1,x2)) + (2 * altura(y1,y2)));
end;

function ptoxmedio(x1,x2:integer):integer;
begin
	result:= (x1 + x2) div 2;
end;

function ptoymedio(y1,y2:integer):integer;
begin
	result:= (y1 + y2) div 2;
end;

procedure ptomedio(x1,y1,x2,y2:integer);
begin
	write('[');
	write(ptoxmedio(x1,x2));
	write(',');
	write(ptoymedio(y1,y2));
	write(']');
end;

begin
	writeln('Escriba la coordenada x del primer punto');
	readln(x1);
	writeln('Escriba la coordenada y del primer punto');
	readln(y1);
	sistgrafico(x1,y1);
	writeln('Escriba la coordenada x del segundo punto');
	readln(x2);
	writeln('Escriba la coordenada y del segundo punto');
	readln(y2);
	sistgrafico(x2,y2);
	writeln('Escriba el punto x de arriba a la izquierda del rectángulo');
	readln(pto1xrectangulo);
	writeln('Escriba el punto y de arriba a la izquierda del rectángulo');
	readln(pto1yrectangulo);
	sistgrafico(pto1xrectangulo,pto1yrectangulo);
	writeln('Escriba el punto x de abajo a la derecha del rectángulo');
	readln(pto2xrectangulo);
	writeln('Escriba el punto y de abajo a la derecha del rectángulo');
	readln(pto2yrectangulo);
	sistgrafico(pto2xrectangulo,pto2yrectangulo);
	ordenrectangulo(pto1xrectangulo,pto1yrectangulo,pto2xrectangulo,
	pto2yrectangulo);
	ptomenor(x1,y1,x2,y2);
	writeln(' ');
	ptomayor(x1,y1,x2,y2);
	writeln(' ');
	write('[');
	escribirpto(pto1xrectangulo,pto1yrectangulo);
	escribirpto(pto2xrectangulo,pto2yrectangulo);
	write(']');
	writeln(' ');
	writeln(ptodentrorectangulo(x1,y1));
	writeln(ptodentrorectangulo(x2,y2));
	writeln(area(pto1xrectangulo,pto1yrectangulo,pto2xrectangulo,
	pto2yrectangulo));
	writeln(perimetro(pto1xrectangulo,pto1yrectangulo,pto2xrectangulo,
	pto2yrectangulo));
	ptomedio(pto1xrectangulo,pto1yrectangulo,pto2xrectangulo,
	pto2yrectangulo);
end.
