{$mode objfpc}{$H-}{$R+}{$T+}{$Q+}{$V+}{$D+}{$X-}{$warnings on}

program figuras;

const
	LongMaxCars = 50;
	NumMaxFigs = 100;
	Esp: char = ' ';
	Tab: char = '	';
type
	TipoStr = string[LongMaxCars];
	TipoClaseFigura = (punto, linea, rectangulo, papel, mover, alreves, borrar, pantalla);
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

procedure saltaresp(var fich: Text; var c: char);
begin
	c := ' ';
	while not eof(fich) and esblanco(c) do begin
		if not eoln(fich) then begin
			read(fich, c);
		end
		else if eoln(fich) then begin
			readln(fich);
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

procedure leerpal(var fich: Text; var pal: TipoStr);
var
	c: char;
begin
	c := ' ';
	setlength(pal, 0);
	saltaresp(fich, c);
	if not esblanco(c) then begin
		addcar(pal, c);
		while not eof(fich) and not eoln(fich) and not esblanco(c) do begin
			read(fich, c);
			if not esblanco(c) then begin
				addcar(pal, c);
			end;
		end;
	end;
end;

procedure leerclase(var fich: Text; var clase: TipoClaseFigura; var lect: TipoLect);
var
	pos: integer;
	str: TipoStr;
begin
	leerpal(fich, str);
	val(str, clase, pos);
	if pos = 0 then begin
		lect := LectOk;
	end
	else if eof(fich) then begin
		lect := LectFin;
	end
	else begin
		lect := LectErr;
		writeln('Error');
	end;
end;

procedure leerentero(var fich: Text; var n: integer; var lect: TipoLect);
var
	pos: integer;
	str: TipoStr;
begin
	leerpal(fich, str);
	val(str, n, pos);
	if pos = 0 then begin
		lect := LectOk;
	end
	else if eof(fich) then begin
		lect := LectFin;
	end
	else begin
		lect := LectErr;
		writeln('Error');
	end;
end;

procedure leercaracter(var fich: Text; var c: TipoStr; var lect: TipoLect);
begin
	leerpal(fich, c);
	if length(c) = 1 then begin
		lect := LectOk;
	end
	else if eof(fich) then begin
		lect := LectFin;
	end
	else begin
		lect := LectErr;
		writeln('Error');
	end;
end;

procedure leerpos(var fich: Text; var poslin: TipoPosLin; var lect: TipoLect);
var
	pos: integer;
	str: TipoStr;
begin
	leerpal(fich, str);
	val(str, poslin, pos);
	if pos = 0 then begin
		lect := LectOk;
	end
	else if eof(fich) then begin
		lect := LectFin;
	end
	else begin
		lect := LectErr;
		writeln('Error');
	end;
end;

procedure leerpapel(var fich: Text; var papel: TipoPapel; var lect: TipoLect);
var
	c: TipoStr;
begin
	papel := '.';
	leercaracter(fich, c, lect);
	if lect = LectOk then begin
		papel := c[1];
	end;
end;

procedure leerpantalla(var fich: Text; var ancho: integer; var alto: integer; var lect: TipoLect);
var
	x: integer;
	y: integer;
begin
	ancho := 40;
	alto := 40;
	leerentero(fich, x, lect);
	if lect = LectOk then begin
		leerentero(fich, y, lect);
		if lect = LectOk then begin
			ancho := x;
			alto := y;
		end;
	end;
end;

procedure leerborrar(var fich: Text; var x: integer; var y: integer; var lect: TipoLect);
var
	pos_x: integer;
	pos_y: integer;
begin
	leerentero(fich, pos_x, lect);
	if lect = LectOk then begin
		leerentero(fich, pos_y, lect);
		if lect = LectOk then begin
			x := pos_x;
			y := pos_y;
		end;
	end;
end;

procedure leermover(var fich: Text; var pos_x: integer; var pos_y: integer; var new_x: integer; var new_y: integer; var lect: TipoLect);
var
	x: integer;
	y: integer;
	mov_x: integer;
	mov_y: integer;
begin
	leerentero(fich, x, lect);
	if lect = LectOk then begin
		leerentero(fich, y, lect);
		if lect = LectOk then begin
			leerentero(fich, mov_x, lect);
			if lect = LectOk then begin
				leerentero(fich, mov_y, lect);
				if lect = LectOk then begin
					pos_x := x;
					pos_y := y;
					new_x := mov_x;
					new_y := mov_y;
				end;
			end;
		end;
	end;
end;

procedure leerpto(var fich: Text; var pto: TipoPto; var figs: TipoFigs; var lect: TipoLect);
var
	pal: TipoStr;
	pt: TipoPto;
begin
	leerpal(fich, pal);
	if length(pal) = 1 then begin
		leerentero(fich, pt.xp, lect);
		if lect = LectOk then begin
			leerentero(fich, pt.yp, lect);
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
		writeln('Error');
	end;
end;

procedure leerlinea(var fich: Text; var lin: TipoLin; var figs: TipoFigs; var lect: TipoLect);
var
	pal: TipoStr;
	line: TipoLin;
begin
	leerpal(fich, pal);
	if length(pal) = 1 then begin
		leerpos(fich, line.poslin, lect);
		if lect = lectOk then begin
			leerentero(fich, line.xl, lect);
			if lect = LectOk then begin
				leerentero(fich, line.yl, lect);
				if lect = LectOk then begin
					leerentero(fich, line.longlin, lect);
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
		writeln('Error');
	end;
end; 

procedure leerrectangulo(var fich: Text; var rec: TipoRec; var figs: TipoFigs; var lect: TipoLect);
var
	pal: TipoStr;
	rect: TipoRec;
begin
	leerpal(fich, pal);
	if length(pal) = 1 then begin
		leerentero(fich, rect.xr_n, lect);
		if lect = LectOk then begin
			leerentero(fich, rect.yr_n, lect);
			if lect = LectOk then begin
				leerentero(fich, rect.xr_s, lect);
				if lect = LectOk then begin
					leerentero(fich, rect.yr_s, lect);
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
		writeln('Error');
	end;
end;

function haypto(pto: TipoPto; var x: integer; var y: integer): boolean;
begin
	result := (x = pto.xp) and (y = pto.yp);
end;

function haylinea(lin: TipoLin; var x: integer; var y: integer): boolean;
begin
	result := (x >= lin.xl) and (y >= lin.yl) and (x <= lin.finx) and (y <= lin.finy);
end;

function hayrect(rec: TipoRec; var x: integer; var y: integer): boolean;
begin
	result := (x >= rec.xr_n) and (y >= rec.yr_n) and (x <= rec.xr_s) and (y <= rec.yr_s);
end;

procedure hayfiguras(figs: TipoFigs; var x: integer; var y: integer; var hay: boolean);
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

procedure ordenaralreves(var figs: TipoFigs);
var
	n: integer;
	aux_clase: TipoClaseFigura;
	aux_pto_p: char;
	aux_pto_xp: integer;
	aux_pto_yp: integer;
	aux_lin_l: char;
	aux_lin_xl: integer;
	aux_lin_yl: integer;
	aux_lin_longlin: integer;
	aux_lin_finx: integer;
	aux_lin_finy: integer;
	aux_lin_poslin: TipoPosLin;
	aux_rec_r: char;
	aux_rec_xr_n: integer;
	aux_rec_yr_n: integer;
	aux_rec_xr_s: integer;
	aux_rec_yr_s: integer;
begin
	for n := 1 to figs.numfigs div 2 do begin
		aux_clase := figs.figs[figs.numfigs - n + 1].clase;
		aux_pto_p := figs.figs[figs.numfigs - n + 1].pto.p;
		aux_pto_xp := figs.figs[figs.numfigs - n + 1].pto.xp;
		aux_pto_yp := figs.figs[figs.numfigs - n + 1].pto.yp;
		aux_lin_l := figs.figs[figs.numfigs - n + 1].lin.l;
		aux_lin_xl := figs.figs[figs.numfigs - n + 1].lin.xl;
		aux_lin_yl := figs.figs[figs.numfigs - n + 1].lin.yl;
		aux_lin_longlin := figs.figs[figs.numfigs - n + 1].lin.longlin;
		aux_lin_finx := figs.figs[figs.numfigs - n + 1].lin.finx;
		aux_lin_finy := figs.figs[figs.numfigs - n + 1].lin.finy;
		aux_lin_poslin := figs.figs[figs.numfigs - n + 1].lin.poslin;
		aux_rec_r := figs.figs[figs.numfigs - n + 1].rec.r;
		aux_rec_xr_n := figs.figs[figs.numfigs - n + 1].rec.xr_n;
		aux_rec_yr_n := figs.figs[figs.numfigs - n + 1].rec.yr_n;
		aux_rec_xr_s := figs.figs[figs.numfigs - n + 1].rec.xr_s;
		aux_rec_yr_s := figs.figs[figs.numfigs - n + 1].rec.yr_s;
		figs.figs[figs.numfigs - n + 1].clase := figs.figs[n].clase;
		figs.figs[n].clase := aux_clase;
		figs.figs[figs.numfigs - n + 1].pto.p := figs.figs[n].pto.p;
		figs.figs[n].pto.p := aux_pto_p;
		figs.figs[figs.numfigs - n + 1].pto.xp := figs.figs[n].pto.xp;
		figs.figs[n].pto.xp := aux_pto_xp;
		figs.figs[figs.numfigs - n + 1].pto.yp := figs.figs[n].pto.yp;
		figs.figs[n].pto.yp := aux_pto_yp;
		figs.figs[figs.numfigs - n + 1].lin.l := figs.figs[n].lin.l;
		figs.figs[n].lin.l := aux_lin_l;
		figs.figs[figs.numfigs - n + 1].lin.xl := figs.figs[n].lin.xl;
		figs.figs[n].lin.xl := aux_lin_xl;
		figs.figs[figs.numfigs - n + 1].lin.yl := figs.figs[n].lin.yl;
		figs.figs[n].lin.yl := aux_lin_yl;
		figs.figs[figs.numfigs - n + 1].lin.longlin := figs.figs[n].lin.longlin;
		figs.figs[n].lin.longlin := aux_lin_longlin;
		figs.figs[figs.numfigs - n + 1].lin.finx := figs.figs[n].lin.finx;
		figs.figs[n].lin.finx := aux_lin_finx;
		figs.figs[figs.numfigs - n + 1].lin.finy := figs.figs[n].lin.finy;
		figs.figs[n].lin.finy := aux_lin_finy;
		figs.figs[figs.numfigs - n + 1].lin.poslin := figs.figs[n].lin.poslin;
		figs.figs[n].lin.poslin := aux_lin_poslin;
		figs.figs[figs.numfigs - n + 1].rec.r := figs.figs[n].rec.r;
		figs.figs[n].rec.r := aux_rec_r;
		figs.figs[figs.numfigs - n + 1].rec.xr_n := figs.figs[n].rec.xr_n;
		figs.figs[n].rec.xr_n := aux_rec_xr_n;
		figs.figs[figs.numfigs - n + 1].rec.yr_n := figs.figs[n].rec.yr_n;
		figs.figs[n].rec.yr_n := aux_rec_yr_n;
		figs.figs[figs.numfigs - n + 1].rec.xr_s := figs.figs[n].rec.xr_s;
		figs.figs[n].rec.xr_s := aux_rec_xr_s;
		figs.figs[figs.numfigs - n + 1].rec.yr_s := figs.figs[n].rec.yr_s;
		figs.figs[n].rec.yr_s := aux_rec_yr_s;
	end;
end;

procedure moverfigura(var figs: TipoFigs; var pos_x: integer; var pos_y: integer; var new_x: integer; var new_y: integer);
var
	n: integer;
	m: integer;
	o: integer;
	hay: boolean;
begin
	hay := False;
	n := NumMaxFigs;
	while (n >= 1) and (not hay) do begin
		if haypto(figs.figs[n].pto, pos_x, pos_y) then begin
			hay := True;
			figs.figs[n].pto.xp := figs.figs[n].pto.xp + new_x;
			figs.figs[n].pto.yp := figs.figs[n].pto.yp + new_y;
		end
		else begin
			hay := False;
		end;
		n := n - 1;
	end;
	m := NumMaxFigs;
	while(m >= 1) and (not hay) do begin
		if haylinea(figs.figs[m].lin, pos_x, pos_y) then begin
			hay := True;
			figs.figs[m].lin.xl := figs.figs[m].lin.xl + new_x;
			figs.figs[m].lin.yl := figs.figs[m].lin.yl + new_y;
			figs.figs[m].lin.finx := figs.figs[m].lin.finx + new_x;
			figs.figs[m].lin.finy := figs.figs[m].lin.finy + new_y;
		end
		else begin
			hay := False;
		end;
		m := m - 1;
	end;
	o := NumMaxFigs;
	while (o >= 1) and (not hay) do begin
		if hayrect(figs.figs[o].rec, pos_x, pos_y) then begin
			hay := True;
			figs.figs[o].rec.xr_n := figs.figs[o].rec.xr_n + new_x;
			figs.figs[o].rec.yr_n := figs.figs[o].rec.yr_n + new_y;
			figs.figs[o].rec.xr_s := figs.figs[o].rec.xr_s + new_x;
			figs.figs[o].rec.yr_s := figs.figs[o].rec.yr_s + new_y;
		end
		else begin
			hay := False;
		end;
		o := o - 1;
	end;
end;

procedure borrarfigura(var figs: TipoFigs; var x: integer; var y: integer);
var
	n: integer;
	m: integer;
	o: integer;
	hay: boolean;
begin
	hay := False;
	n := NumMaxFigs;
	while (n >= 1) and (not hay) do begin
		if haypto(figs.figs[n].pto, x, y) then begin
			hay := True;
			figs.figs[n].pto.xp := 0;
			figs.figs[n].pto.yp := 0;
		end
		else begin
			hay := False;
		end;
		n := n - 1;
	end;
	m := NumMaxFigs;
	while(m >= 1) and (not hay) do begin
		if haylinea(figs.figs[m].lin, x, y) then begin
			hay := True;
			figs.figs[m].lin.xl := 0;
			figs.figs[m].lin.yl := 0;
			figs.figs[m].lin.longlin := 0;
			figs.figs[m].lin.finx := 0;
			figs.figs[m].lin.finy := 0;
		end
		else begin
			hay := False;
		end;
		m := m - 1;
	end;
	o := NumMaxFigs;
	while (o >= 1) and (not hay) do begin
		if hayrect(figs.figs[o].rec, x, y) then begin
			hay := True;
			figs.figs[o].rec.xr_n := 0;
			figs.figs[o].rec.yr_n := 0;
			figs.figs[o].rec.xr_s := 0;
			figs.figs[o].rec.yr_s := 0;
		end
		else begin
			hay := False;
		end;
		o := o - 1;
	end;
end;

procedure tablero(figs: TipoFigs; var papel: char; var ancho: integer; var alto: integer);
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

procedure leercomandos(var fich: Text; var figs: TipoFigs);
var
	clase: TipoClaseFigura;
	pt: TipoPto;
	lin: TipoLin;
	rec: TipoRec;
	lect: TipoLect;
	pap: TipoPapel;
	ancho: integer;
	alto: integer;
	pos_x: integer;
	pos_y: integer;
	new_x: integer;
	new_y: integer;
	x: integer;
	y: integer;
begin
	figs.numfigs := 0;
	pap := '.';
	ancho := 40;
	alto := 40;
	while not eof(fich) do begin
		leerclase(fich, clase, lect);
		if lect = LectOk then begin
			if clase = punto then begin
				leerpto(fich, pt, figs, lect);
				if lect = LectOk then begin
					figs.figs[figs.numfigs].clase := clase;
				end;
			end
			else if clase = linea then begin
				leerlinea(fich, lin, figs, lect);
				if lect = LectOk then begin
					figs.figs[figs.numfigs].clase := clase;
				end;
			end
			else if clase = rectangulo then begin
				leerrectangulo(fich, rec, figs, lect);
				if lect = LectOk then begin
					figs.figs[figs.numfigs].clase := clase;
				end;
			end
			else if clase = papel then begin
				leerpapel(fich, pap, lect);
			end
			else if clase = pantalla then begin
				leerpantalla(fich, ancho, alto, lect);
			end
			else if clase = alreves then begin
				ordenaralreves(figs);
			end
			else if clase = borrar then begin
				leerborrar(fich, x, y, lect);
				if lect = LectOk then begin
					borrarfigura(figs, x, y);
				end;
			end
			else if clase = mover then begin
				leermover(fich, pos_x, pos_y, new_x, new_y, lect);
				if lect = LectOk then begin
					moverfigura(figs, pos_x, pos_y, new_x, new_y);
				end;
			end;
		end;
		if lect = LectOk then begin
			tablero(figs, pap, ancho, alto);
			writeln();
		end;
	end;
end;


var
	fich: Text;
	figs: TipoFigs;
begin
	assign(fich, 'datos.txt');
	reset(fich);
	leercomandos(fich, figs);
	close(fich);
end.
