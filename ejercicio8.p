{$mode objfpc}{$H-}{$R+}{$T+}{$Q+}{$V+}{$D+}{$X-}{$warnings on}

program ejercicio8;

const
	LongMaxCars = 50;
	NumMaxFigs = 100;
	Papel: char = '.';
	Ancho: integer = 40;
	Alto: integer = 20;
	Esp: char = ' ';
	Tab: char = '	';
type
	TipoStr = string[LongMaxCars];
	TipoClaseFigura = (punto, linea, rectangulo);
	TipoPosLin = (horizontal, vertical);
	TipoLect = (LectErr, LectOk, LectFin);
	TipoPapel = char;
	
	TipoPto = record
		p: char;
		xp: integer;
		yp: integer;
	end;
	
	TipoLin = record
		l: char;
		xl: integer;
		yl: integer;
		longlin: integer;
		finx: integer;
		finy: integer;
		poslin: TipoPosLin;
	end;
	
	TipoRec = record
		r: char;
		xr_n: integer;
		yr_n: integer;
		xr_s: integer;
		yr_s: integer;
	end;
	
	TipoFig = record
		clase: TipoClaseFigura;
		pto: TipoPto;
		lin: TipoLin;
		rec: TipoRec;
	end;
	
	TipoFigs = record
		figs: array[1..NumMaxFigs] of TipoFig;
		numfigs: integer;
	end;

		
function esblanco(c: char): boolean;
begin
	result := (c = Esp) or (c = Tab);
end;

procedure saltaresp(var c: char);
begin
	c := ' ';
	while not eof() and esblanco(c) do begin
		if not eoln() then begin
			read(c);
		end
		else if eoln() then begin
			readln();
		end;
	end;
end;

procedure addcar(var pal: TipoStr; c: char);
var
	l: integer;
begin
	l := length(pal);
	l := l + 1;
	setlength(pal, l);
	pal[l] := c;
end;

procedure leerpal(var pal: TipoStr);
var
	c: char;
begin
	c := ' ';
	setlength(pal, 0);
	saltaresp(c);
	if not esblanco(c) then begin
		addcar(pal, c);
		while not eof() and not eoln() and not esblanco(c) do begin
			read(c);
			if not esblanco(c) then begin
				addcar(pal, c);
			end;
		end;
	end;
end;

procedure leerclase(var clase: TipoClaseFigura; var lect: TipoLect);
var
	pos: integer;
	str: TipoStr;
begin
	leerpal(str);
	val(str, clase, pos);
	if pos = 0 then begin
		lect := LectOk;
	end
	else if eof() then begin
		lect := LectFin;
	end
	else begin
		lect := LectErr;
	end;
end;

procedure leerentero(var n: integer; var lect: TipoLect);
var
	pos: integer;
	str: TipoStr;
begin
	leerpal(str);
	val(str, n, pos);
	if pos = 0 then begin
		lect := LectOk;
	end
	else if eof() then begin
		lect := LectFin;
	end
	else begin
		lect := LectErr;
	end;
end;

procedure leercaracter(var c: TipoStr; var lect: TipoLect);
begin
	leerpal(c);
	if length(c) = 1 then begin
		lect := LectOk;
	end
	else if eof() then begin
		lect := LectFin;
	end
	else begin
		lect := LectErr;
	end;
end;

procedure leerpos(var poslin: TipoPosLin; var lect: TipoLect);
var
	pos: integer;
	str: TipoStr;
begin
	leerpal(str);
	val(str, poslin, pos);
	if pos = 0 then begin
		lect := LectOk;
	end
	else if eof() then begin
		lect := LectFin;
	end
	else begin
		lect := LectErr;
	end;
end;

procedure leerpto(var pto: TipoPto; var figs: TipoFigs; var lect: TipoLect);
var
	pal: TipoStr;
	pt: TipoPto;
begin
	leerpal(pal);
	if length(pal) = 1 then begin
		leerentero(pt.xp, lect);
		if lect = LectOk then begin
			leerentero(pt.yp, lect);
			if lect = LectOk then begin
				figs.numfigs := figs.numfigs + 1;
				figs.figs[figs.numfigs].pto.p := pal[1];
				figs.figs[figs.numfigs].pto.xp := pt.xp;
				figs.figs[figs.numfigs].pto.yp := pt.yp;
			end;
		end;
	end
	else begin
		lect := LectErr;
	end;
end;

procedure leerlinea(var lin: TipoLin; var figs: TipoFigs; var lect: TipoLect);
var
	pal: TipoStr;
	line: TipoLin;
begin
	leerpal(pal);
	if length(pal) = 1 then begin
		leerpos(line.poslin, lect);
		if lect = lectOk then begin
			leerentero(line.xl, lect);
			if lect = LectOk then begin
				leerentero(line.yl, lect);
				if lect = LectOk then begin
					leerentero(line.longlin, lect);
					if lect = LectOk then begin
						figs.numfigs := figs.numfigs + 1;
						figs.figs[figs.numfigs].lin.l := pal[1];
						figs.figs[figs.numfigs].lin.poslin := line.poslin;
						figs.figs[figs.numfigs].lin.xl := line.xl;
						figs.figs[figs.numfigs].lin.yl := line.yl;
						figs.figs[figs.numfigs].lin.longlin := line.longlin;
						if line.poslin = horizontal then begin
							line.finx := line.xl + (line.longlin - 1);
							line.finy := line.yl;
							figs.figs[figs.numfigs].lin.finx := line.finx;
							figs.figs[figs.numfigs].lin.finy := line.finy;
						end
						else if line.poslin = vertical then begin
							line.finx := line.xl;
							line.finy := line.yl + (line.longlin - 1);
							figs.figs[figs.numfigs].lin.finx := line.finx;
							figs.figs[figs.numfigs].lin.finy := line.finy;
						end;
					end;
				end;
			end;
		end;
	end
	else begin
		lect := LectErr;
	end;
end; 

procedure leerrectangulo(var rec: TipoRec; var figs: TipoFigs; var lect: TipoLect);
var
	pal: TipoStr;
	rect: TipoRec;
begin
	leerpal(pal);
	if length(pal) = 1 then begin
		leerentero(rect.xr_n, lect);
		if lect = LectOk then begin
			leerentero(rect.yr_n, lect);
			if lect = LectOk then begin
				leerentero(rect.xr_s, lect);
				if lect = LectOk then begin
					leerentero(rect.yr_s, lect);
					if lect = LectOk then begin
						figs.numfigs := figs.numfigs + 1;
						figs.figs[figs.numfigs].rec.r := pal[1];
						figs.figs[figs.numfigs].rec.xr_n:= rect.xr_n;
						figs.figs[figs.numfigs].rec.yr_n:= rect.yr_n;
						figs.figs[figs.numfigs].rec.xr_s:= rect.xr_s;
						figs.figs[figs.numfigs].rec.yr_s:= rect.yr_s;
					end;
				end;
			end;
		end;
	end
	else begin
		lect := LectErr;
	end;
end;

function haypto(var pto: TipoPto; var x: integer; var y: integer): boolean;
begin
	result := (x = pto.xp) and (y = pto.yp);
end;

function haylinea(var lin: TipoLin; var x: integer; var y: integer): boolean;
begin
	result := (x >= lin.xl) and (y >= lin.yl) and (x <= lin.finx) and (y <= lin.finy);
end;

function hayrect(var rec: TipoRec; var x: integer; var y: integer): boolean;
begin
	result := (x >= rec.xr_n) and (y >= rec.yr_n) and (x <= rec.xr_s) and (y <= rec.yr_s);
end;

procedure hayfiguras(var figs: TipoFigs; var x: integer; var y: integer; var hay: boolean);
var
	n: integer;
begin
	hay := False;
	n := NumMaxFigs;
	while (n >= 1) and (not hay) do begin
		if haypto(figs.figs[n].pto, x, y) then begin
			hay := True;
			write(figs.figs[n].pto.p);
		end
		else if haylinea(figs.figs[n].lin, x, y) then begin
			write(figs.figs[n].lin.l);
			hay := True;
		end
		else if hayrect(figs.figs[n].rec, x, y) then begin
			write(figs.figs[n].rec.r);
			hay := True;
		end
		else begin
			hay := False;
		end;
		n := n - 1;
	end;
end;

procedure tablero(var figs: TipoFigs);
var
	j: integer;
	y: integer;
	k: integer;
	x: integer;
	hay: boolean;

begin
	for j := 1 to alto do begin
		y := j;
		for k := 1 to ancho do begin
			x := k;
			hayfiguras(figs, x, y, hay);
			if not hay then begin
				write(papel);
			end;
		end;
		writeln();
	end;
end;

procedure leercomandos(var figs: TipoFigs);
var
	clase: TipoClaseFigura;
	pt: TipoPto;
	lin: TipoLin;
	rec: TipoRec;
	lect: TipoLect;
begin
	figs.numfigs := 0;
	repeat
		leerclase(clase, lect);
		if lect = LectOk then begin
			if clase = punto then begin
				leerpto(pt, figs, lect);
				if lect = LectOk then begin
					figs.figs[figs.numfigs].clase := clase;
				end;
			end
			else if clase = linea then begin
				leerlinea(lin, figs, lect);
				if lect = LectOk then begin
					figs.figs[figs.numfigs].clase := clase;
				end;
			end
			else if clase = rectangulo then begin
				leerrectangulo(rec, figs, lect);
				if lect = LectOk then begin
					figs.figs[figs.numfigs].clase := clase;
				end;
			end;
		end;
	until lect <> LectOk;
end;


var
	figs: TipoFigs;
begin
	leercomandos(figs);
	tablero(figs);
end.
