{$mode objfpc}{$H-}{$R+}{$T+}{$Q+}{$V+}{$D+}{$X-}{$warnings on}

program ejercicio7;

const
	NumMaxBarcos = 100;
	NumMaxJugadores = 3;
	Papel: char = '.';
type
	TipoModelo = (Submarino, Fragata, Dragaminas, Portaaviones, Fin);
	TipoPos = (horizontal, vertical);
	TipoPintura = (Amarillenta, Azulada, Roja);
	
	TipoBarco = record
		modelo: TipoModelo;
		columna: char;
		fila: integer;
		finfila: integer;
		fincolumna: integer;
		pos: TipoPos;
		pintura: TipoPintura;
		
	end;
	
	TipoBarcos = record
		barcos: array[1..NumMaxBarcos] of TipoBarco;
		numbarcos: integer;
	end;
	
	TipoJugadores = record
		jugadores: array[1..NumMaxJugadores] of TipoBarcos;
		numjugadores: integer;
	end;
	
function barcook(barco: TipoBarco): boolean;
begin
	result := (barco.finfila <= 10) and (barco.finfila >= 1) and (barco.fincolumna <= ord('J')) and (barco.fincolumna >= ord('A'));
end;

function longitud(var barco: TipoBarco): integer;
begin
	if barco.modelo = Submarino then begin
		result := 2;
	end
	else if barco.modelo = Dragaminas then begin
		result := 3;
	end
	else if barco.modelo = Fragata then begin
		result := 4;
	end
	else if barco.modelo = Portaaviones then begin
		result := 5;
	end;
end;

procedure finbarco(var barco: TipoBarco);
begin
	if barco.pos = horizontal then begin
		barco.finfila := barco.fila;
		barco.fincolumna := longitud(barco) - 1 + ord(barco.columna);
	end
	else if barco.pos = vertical then begin
		barco.finfila := longitud(barco) - 1 + barco.fila;
		barco.fincolumna := ord(barco.columna);
	end;
end;
	
procedure leerentrada(var barcos: TipoBarcos);
var
	barco: TipoBarco;
begin
	barcos.numbarcos := 0;
	repeat
		readln(barco.modelo);
		if barco.modelo <> Fin then begin
			readln(barco.columna);
			readln(barco.fila);
			readln(barco.pos);
			readln(barco.pintura);
			finbarco(barco);
			if barcook(barco) then begin
				barcos.numbarcos := barcos.numbarcos + 1;
				barcos.barcos[barcos.numbarcos].modelo := barco.modelo;
				barcos.barcos[barcos.numbarcos].columna := barco.columna;
				barcos.barcos[barcos.numbarcos].fila := barco.fila;
				barcos.barcos[barcos.numbarcos].pos := barco.pos;
				barcos.barcos[barcos.numbarcos].pintura := barco.pintura;
				barcos.barcos[barcos.numbarcos].finfila := barco.finfila;
				barcos.barcos[barcos.numbarcos].fincolumna := barco.fincolumna;
				
			end;
		end;
	until barco.modelo = Fin;
end;

function inicial(barco: TipoBarco): char;
begin
	if barco.modelo = Submarino then begin
		result := 'S';
	end
	else if barco.modelo = Dragaminas then begin
		result := 'D';
	end
	else if barco.modelo = Fragata then begin
		result := 'F';
	end
	else if barco.modelo = Portaaviones then begin
		result := 'P';
	end;
end;

function haybarco(barco: TipoBarco; var x: char; var y: integer): boolean;
begin
	result := (barco.modelo <> Submarino) and (x >= barco.columna) and (ord(x) <= barco.fincolumna) and (y >= barco.fila) and (y <= barco.finfila);
end;

procedure haybarcos(barcos: TipoBarcos; var x: char; var y: integer; var hay: boolean);
var
	n: integer;
begin
	n := 1;
	hay := False;
	while (n <= barcos.numbarcos) and (not hay) do begin
		if haybarco(barcos.barcos[n], x, y) then begin
			hay := True;
			write(inicial(barcos.barcos[n]), ' ');
		end
		else begin
			hay := False;
		end;
		n := n + 1;
	end;
end;

procedure tablero(barcos: TipoBarcos);
var
	fila: char;
	col: integer;
	hay: boolean;
	x: char;
	y: integer;
begin
	hay := False;
	for fila := 'A' to 'J' do begin
		write(fila, ' ');
	end;
	writeln();
	for col := 1 to 10 do begin
		y := col;
		for fila := 'A' to 'J' do begin
			x := fila;
			haybarcos(barcos, x, y, hay);
			if not hay then begin
				write(Papel, ' ');
			end;
		end;
		writeln(col);
	end;
end;

procedure cantidadbarcos(var barcos: Tipobarcos);
var
	n: integer;
	s: integer;
	d: integer;
	f: integer;
	p: integer;
begin
	s := 0;
	d := 0;
	f := 0;
	p := 0;
	for n := 1 to barcos.numbarcos do begin
		if barcos.barcos[n].modelo = Submarino then begin
			s := s + 1;
		end
		else if barcos.barcos[n].modelo = Dragaminas then begin
			d := d + 1;
		end
		else if barcos.barcos[n].modelo = Fragata then begin
			f := f + 1;
		end
		else if barcos.barcos[n].modelo = Portaaviones then begin
			p := p + 1;
		end;
	end;
	if s > 0 then begin
		writeln(s, ' submarino');
	end;
	if d > 0 then begin
		writeln(d, ' dragaminas');
	end;
	if f > 0 then begin
		writeln(f, ' fragata');
	end;
	if p > 0 then begin
		writeln(p, ' portaaviones');
	end;
end;

procedure leerjugador(var jug: TipoJugadores);
var
	barcos: TipoBarcos;
begin
	jug.numjugadores := 1;
	while jug.numjugadores <= NumMaxJugadores do begin
		leerentrada(barcos);
		jug.jugadores[jug.numjugadores] := barcos;
		jug.numjugadores := jug.numjugadores + 1;
	end;
end;

procedure escrjugador(jug: Tipojugadores);
var
	n: integer;
begin
	for n := 1 to jug.numjugadores - 1 do begin
		tablero(jug.jugadores[n]);
		cantidadbarcos(jug.jugadores[n]);
	end;
end;
var
	jug: TipoJugadores;
begin
	leerjugador(jug);
	escrjugador(jug);
end.
