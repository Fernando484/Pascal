{$mode objfpc}{$H-}{$R+}{$T+}{$Q+}{$V+}{$D+}{$X-}{$warnings on}

program ejercicio6;
const
	FilamMin = 1;
	FilaMax = 10;
	ColumMin = 'A';
	ColumMax = 'J';
	Punto: char = '.';

type
	TipoPintura = (Roja, Azulada, Amarillenta);
	TipoBarco = (Submarino, Dragaminas, Fragata, Portaaviones, Fin);
	TipoPos = (horizontal, vertical);
	TipoFila = integer;
	TipoColumna = char;
	
	TipoTablero = record
		fila: TipoFila;
		columna: TipoColumna;
	end;
	
	TipoDatos = record
		barco: TipoBarco;
		pintura: TipoPintura;
		pos: TipoPos;
		tabl: TipoTablero;
	end;
var
	jugador: TipoDatos;
	i: char;
	j: integer;
	k: integer;
	total: integer;
	barcomayor: integer;
	barcomenor: integer;
	barcoaux1: TipoBarco;
	barcoaux2: TipoBarco;
	columnaaux1: TipoColumna;
	columnaaux2: TipoColumna;
	filaaux1: TipoFila;
	filaaux2: TipoFila;
	posaux1: TipoPos;
	posaux2: TipoPos;
	pinturaaux1: TipoPintura;
	pinturaaux2: TipoPintura;
	
procedure leertabl(var t: TipoTablero);
begin
	readln(t.columna);
	readln(t.fila);
end;
function casillas(b: TipoBarco): integer;
begin
	if b = Submarino then begin
		result:= 2;
	end
	else if b = Dragaminas then begin
		result:= 3;
	end
	else if b = Fragata then begin
		result:= 4;
	end
	else if b = Portaaviones then begin
		result:= 5;
	end;
end;

procedure tablerook(t: TipoTablero; b: TipoBarco; p:tipoPos);
begin
	if (b = submarino) and (p = vertical) and (t.fila = 10) then begin
		writeln('Barco mal definido');
	end
	else if (b = submarino) and (p = horizontal) and (t.columna = 'J') then begin
		writeln('Barco mal definido');
	end
	else if (b = dragaminas) and (p = vertical) and (t.fila > 8) then begin
		writeln('Barco mal definido');
	end
	else if (b = dragaminas) and (p = horizontal) and (t.columna > 'H') then begin
		writeln('Barco mal definido');
	end
	else if (b = fragata) and (p = vertical) and (t.fila > 7) then begin
		writeln('Barco mal definido');
	end
	else if (b = fragata) and (p = horizontal) and (t.columna > 'G') then begin
		writeln('Barco mal definido');
	end
	else if (b = portaaviones) and (p = vertical) and (t.fila > 6) then begin
		writeln('Barco mal definido');
	end
	else if (b = portaaviones) and (p = horizontal) and (t.columna > 'F') then begin
		writeln('Barco mal definido');
	end
	else if (t.fila >= 1) and (t.fila <= 10) and (t.columna >= 'A') and (t.columna <= 'J') then begin
		writeln('Barco bien definido');
	end
	else begin
		writeln('Barco mal definido');
	end;
end;
function estabien(t: TipoTablero; b: TipoBarco; p:tipoPos): boolean;
begin
	if (b = submarino) and (p = vertical) and (t.fila = 10) then begin
		result:= False;
	end
	else if (b = submarino) and (p = horizontal) and (t.columna = 'J') then begin
		result:= False;
	end
	else if (b = dragaminas) and (p = vertical) and (t.fila > 8) then begin
		result:= False;
	end
	else if (b = dragaminas) and (p = horizontal) and (t.columna > 'H') then begin
		result:= False;
	end
	else if (b = fragata) and (p = vertical) and (t.fila > 7) then begin
		result:= False;
	end
	else if (b = fragata) and (p = horizontal) and (t.columna > 'G') then begin
		result:= False;
	end
	else if (b = portaaviones) and (p = vertical) and (t.fila > 6) then begin
		result:= False;
	end
	else if (b = portaaviones) and (p = horizontal) and (t.columna > 'F') then begin
		result:= False;
	end
	else if (t.fila >= 1) and (t.fila <= 10) and (t.columna >= 'A') and (t.columna <= 'J') then begin
		result:= True;
	end
	else begin
		result:= False;
	end;
end;
procedure escrinicial(b: TipoBarco);
begin
	if b = Submarino then begin
		write('S');
	end
	else if b = Dragaminas then begin
		write('D');
	end
	else if b = Fragata then begin
		write('F');
	end
	else if b = Portaaviones then begin
		write('P');
	end;
end;
procedure escrfilas(t: TipoTablero; b: TipoBarco);
begin
	for j:= 1 to 10 do begin
		if (t.fila <> j) then begin
			for k:= 1 to 10 do begin
				write(Punto);
				write(' ');
			end;
			write(j);
			writeln();
		end
		else begin
			for i:='A' to (pred(t.columna)) do begin
				write(Punto);
				write(' ');
			end;
			escrinicial(b);
			for i:= (succ(t.columna)) to 'J' do begin
				write(' ');
				write(Punto);

			end;
			write(' ');
			write(j);
			writeln();
		end;
	end;
end;
procedure mayorbarco(d: TipoDatos);
begin
	if casillas(d.barco) > barcomayor then begin
		barcomayor:= casillas(d.barco);
		barcoaux1:= (d.barco);
		columnaaux1:= (d.tabl.columna);
		filaaux1:= (d.tabl.fila);
		posaux1:= (d.pos);
		pinturaaux1:= (d.pintura);
	end;
end;
procedure menorbarco(d: TipoDatos);
begin
	if casillas(d.barco) < barcomenor then begin
		barcomenor:= casillas(d.barco);
		barcoaux2:= (d.barco);
		columnaaux2:= (d.tabl.columna);
		filaaux2:= (d.tabl.fila);
		posaux2:= (d.pos);
		pinturaaux2:= (d.pintura);
	end;
end;
procedure dibujartabl(t: TipoTablero; b: TipoBarco; p: TipoPos);
begin
	if estabien(t, b, p) = True then begin
		for i:= 'A' to 'J' do begin
			write(i);
			write(' ');
		end;
		writeln();
		escrfilas(t, b);
	end;
end;
procedure leer(var d: TipoDatos); 
begin
	total:= 0;
	barcomenor:= 5;
	barcomayor:= 2;
	repeat
		readln(d.barco);
		if (d.barco <> Fin) then begin
			leertabl(d.tabl);
			readln(d.pos);
			readln(d.pintura);
			tablerook(d.tabl, d.barco, d.pos);
			dibujartabl(d.tabl, d.barco, d.pos);
			total:= total + casillas(d.barco);
			menorbarco(d);
			mayorbarco(d);
			
			
			
		end;
	until d.barco = Fin;
	write('casillas ocupadas:');
	write(total);
	writeln();
	writeln('menor barco:');
	write(barcomenor);
	write(' casillas. ');
	write(barcoaux2,' ');
	write(' ', columnaaux2,filaaux2, ' ');
	write(posaux2);
	writeln(' con pintura ', pinturaaux2);
	writeln('mayor barco:');
	write(barcomayor);
	write(' casillas. ');
	write(barcoaux1,' ');
	write(' ', columnaaux1,filaaux1, ' ');
	write(posaux1);
	write(' con pintura ', pinturaaux1);
	
end;
begin
	leer(jugador);
end.
