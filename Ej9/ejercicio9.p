{$mode objfpc}{$H-}{$R+}{$T+}{$Q+}{$V+}{$D+}{$X-}{$warnings on}

program ejercicio9;

const
	NumMaxCar = 100;
	NumMaxBarcos = 100;
	NumMaxJugadores = 100;
	Esp = ' ';
	Tab = '	';
	Punto: char = '.';
type
	TipoModelo = (Submarino, Dragaminas, Fragata, Portaaviones, Fin);
	TipoOr = (horizontal, vertical);
	TipoPintura = (Azulada, Amarillenta, Roja);
	
	TipoBarco = record
		modelo: TipoModelo;
		columna: char;
		fila: integer;
		fincolumna: integer;
		finfila: integer;
		orientacion: TipoOr;
		pintura: TipoPintura;
	end;
	
	TipoLect = (LectOK, LectFin, LectErr);
	
	TipoBarcos = record
		barcos: array[1..NumMaxBarcos] of TipoBarco;
		numbarcos: integer;
	end;
	
	TipoJugadores = record
		barcos: array[1..NumMaxBarcos] of TipoBarcos;
		numjugadores: integer;
	end;
	
	TipoStr = string[NumMaxCar];
	
function longitud(barco: TipoBarco): integer;
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

function esblanco(c: char): boolean;
begin
	result := (c = Esp) or (c = Tab);
end;

procedure addcar(var pal: TipoStr; c: char);
var
	j: integer;
begin
	j := length(pal);
	j := j + 1;
	setlength(pal, j);
	pal[j] := c;
end;

procedure leerpal(var fich: Text; var pal: TipoStr);
var
	c: char;
begin
	setlength(pal, 0);
	c := ' ';
	while not eof(fich) and esblanco(c) do begin
		if eoln(fich) then begin
			readln(fich);
		end
		else begin
			read(fich, c);
		end;
	end;
	if not esblanco(c) then begin
		addcar(pal, c);
		while not eof(fich) and not eoln(fich) and not esblanco(c) do begin
			read(fich, c);
			if not esblanco(c) then begin
				addcar(pal, c);
			end;
		end
	end;
end;

procedure leermodelo(var fich: Text; var modelo: TipoModelo; var lect: TipoLect);
var
	str: TipoStr;
	pos: integer;
begin
	leerpal(fich, str);
	if (str = 'Fin') then begin
		lect := lectFin;
	end
	else begin
		val(str, modelo, pos);
		if pos = 0 then begin
			lect := LectOK;
		end
		else begin
			lect := LectErr;
		end;
	end;	
end;

procedure leercolumna(var fich: Text; var str: TipoStr; var lect: TipoLect);
begin
	leerpal(fich, str);
	if length(str) = 1 then begin
		lect := LectOK;
	end;
end;

procedure leerfila(var fich: Text; var fila: integer; var lect: TipoLect);
var
	str: TipoStr;
	pos: integer;
begin
	leerpal(fich, str);
	if (str = 'Fin') then begin
		lect := lectFin;
	end
	else begin
		val(str, fila, pos);
		if pos = 0 then begin
			lect := LectOK;
		end
		else begin
			lect := LectErr;
		end;
	end;	
end;

procedure leerorientacion(var fich: Text; var orientacion: TipoOr; var lect: TipoLect);
var
	str: TipoStr;
	pos: integer;
begin
	leerpal(fich, str);
	if (str = 'Fin') then begin
		lect := lectFin;
	end
	else begin
		val(str, orientacion, pos);
		if pos = 0 then begin
			lect := LectOK;
		end
		else begin
			lect := LectErr;
		end;
	end;	
end;

procedure leerpintura(var fich: Text; var pintura: TipoPintura; var lect: TipoLect);
var
	str: TipoStr;
	pos: integer;
begin
	leerpal(fich, str);
	if (str = 'Fin') then begin
		lect := lectFin;
	end
	else begin
		val(str, pintura, pos);
		if pos = 0 then begin
			lect := LectOK;
		end
		else begin
			lect := LectErr;
		end;
	end;	
end;

function estabien(barco: TipoBarco): boolean;
begin
	result := (barco.finfila <= 10) and (barco.fincolumna <= ord('J'))
end;

procedure leerbarcos(var fich: Text; var barcos: TipoBarcos; var lect: TipoLect);
var
	str: TipoStr;
	barco: TipoBarco;
begin
	lect := LectOK;
	barcos.numbarcos := 0; 
	repeat
		leermodelo(fich, barco.modelo, lect);
		if (barco.modelo <> Fin) and (lect = LectOK) then begin
			leercolumna(fich, str, lect);
			if lect = LectOK then begin
				leerfila(fich, barco.fila, lect);
				if lect = LectOK then begin
					leerorientacion(fich, barco.orientacion, lect);
					if lect = LectOK then begin
						leerpintura(fich, barco.pintura, lect);
						if lect = LectOK then begin
							barcos.numbarcos := barcos.numbarcos + 1;
							barcos.barcos[barcos.numbarcos].modelo := barco.modelo;
							barcos.barcos[barcos.numbarcos].columna := str[1];
							barcos.barcos[barcos.numbarcos].fila := barco.fila;
							barcos.barcos[barcos.numbarcos].orientacion := barco.orientacion;
							barcos.barcos[barcos.numbarcos].pintura := barco.pintura;
							if barco.orientacion = horizontal then begin
								barco.fincolumna := (longitud(barco) - 1) + ord(str[1]);
								barco.finfila := barco.fila;
								barcos.barcos[barcos.numbarcos].fincolumna := barco.fincolumna;
								barcos.barcos[barcos.numbarcos].finfila := barco.finfila;
							end
							else if barco.orientacion = vertical then begin
								barco.fincolumna := ord(str[1]);
								barco.finfila := (longitud(barco) - 1) + barco.fila;
								barcos.barcos[barcos.numbarcos].fincolumna := barco.fincolumna;
								barcos.barcos[barcos.numbarcos].finfila := barco.finfila;
							end;
						end;
					end;
				end;
			end;
		end;
	until lect <> LectOK;
end;

procedure pasarjugador(var fich: Text; var barco: TipoBarco; var lect: TipoLect);
var
	str: TipoStr;
begin
	if lect = LectErr then begin
		leerpal(fich, str);
	end;
end;

function haybarco(barco: TipoBarco; var x: char; var y: integer): boolean;
begin
	result := (ord(x) >= ord(barco.columna)) and (y >= barco.fila) and (ord(x) <= barco.fincolumna) and (y <= barco.finfila); 
end;

procedure haybarcos(barcos: TipoBarcos; var x: char; var y: integer; var hay: boolean);
var
	n: integer;
begin
	n := 1;
	hay := False;
	while(n <= barcos.numbarcos) and (not hay) do begin
		if haybarco(barcos.barcos[n], x, y) then begin
			if estabien(barcos.barcos[n]) then begin
				write(inicial(barcos.barcos[n]), ' ');
				hay := True;
			end;
		end
		else begin
			hay := False;
		end;
		n := n + 1;
	end;
end;

procedure dibujartablero(barcos: TipoBarcos);
var
	i: char;
	j: integer;
	x: char;
	y: integer;
	hay: boolean;
begin
	for i := 'A' to 'J' do begin
		write(i, ' ');
	end;
	writeln();
	for j := 1 to 10 do begin
		y := j;
		for i := 'A' to 'J' do begin
			x := i;
			haybarcos(barcos, x, y, hay);
			if not hay then begin
				write(Punto, ' ');
			end;
		end;
		writeln(j);
	end;
end;
function hayjugador(barcos: TipoBarcos): boolean;
begin
	result := barcos.numbarcos > 0;
end;

procedure leerjugadores(var fich: Text; var jugadores: TipoJugadores);
var
	barcos: TipoBarcos;
	barco: TipoBarco;
	lect: TipoLect;
begin
	jugadores.numjugadores := 0;
	while not eof(fich) do begin
		leerbarcos(fich, barcos, lect);
		pasarjugador(fich, barco, lect);
		if hayjugador(barcos) then begin
			jugadores.numjugadores := jugadores.numjugadores + 1;
			jugadores.barcos[jugadores.numjugadores] := barcos;
		end;
	end;
end;

procedure escrjugadores(jugadores: TipoJugadores);
var
	j: integer;
begin
	for j := 1 to jugadores.numjugadores do begin
		dibujartablero(jugadores.barcos[j]);
	end;
end;

var
	fich: Text;
	jugadores: TipoJugadores;
begin
	assign(fich, 'datos.txt');
	reset(fich);
	while not eof(fich) do begin
		leerjugadores(fich, jugadores);
		escrjugadores(jugadores);
	end;
	close(fich);
end.
