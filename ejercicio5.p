{$mode objfpc}{$H-}{$R+}{$T+}{$Q+}{$V+}{$D+}{$X-}{$warnings on}

program ejercicio5;

const
	LetraMin = 'A';
	LetraMax = 'Z';
	NotaAlfMin = 'F';
	
type
	TipoNumero = integer;
	TipoLetra = LetraMin..LetraMax;
	TipoCamp = (Fuenlabrada, Alcorcon, Mostoles, Madrid, Aranjuez);
	TipoEdificio = (labI, labII, labIII);
	TipoAula = integer;	
	TipoAlfabetica = LetraMin..NotaAlfMin;
	TipoNum = real;
	
	TipoNif = record
		numero: TipoNumero;
		letra: TipoLetra;
	end;
	TipoEdad = integer;
		
	TipoLab = record
		campus: TipoCamp;
		edificio: TipoEdificio;
		aula: TipoAula;
	end;
	TipoCurso = 1..5;
		
	TipoPto = record
		alfabetica: TipoAlfabetica;
		numerica: TipoNum;
	end;
	TipoDatos = record
		nif: TipoNif;
		edad: TipoEdad;
		laboratorio: TipoLab;
		curso: TipoCurso;
		pto: TipoPto
	end;
var
	datos1, datos2, datos3: TipoDatos;
	c: TipoCamp;
	
procedure leerdatosnif(var n:TipoNif);
begin
	readln(n.numero);
	readln(n.letra);
end;
procedure leerlab(var l:TipoLab);
begin
	readln(l.campus);
	readln(l.edificio);
	readln(l.aula);
end;
procedure leerptos(var p: TipoPto);
begin
	readln(p.alfabetica);
	readln(p.numerica);
end;
procedure leerdatos(var d:TipoDatos);
begin
	leerdatosnif(d.nif);
	readln(d.edad);
	leerlab(d.laboratorio);
	readln(d.curso);
	leerptos(d.pto);
end;
procedure escrdatosnif(n:TipoNif);
begin
	writeln(n.numero);
	writeln(n.letra);
end;
procedure escrlab(l:TipoLab);
begin
	writeln(l.campus);
	writeln(l.edificio);
	writeln(l.aula);
end;
procedure escrptos(p: TipoPto);
begin
	writeln(p.alfabetica);
	writeln(p.numerica);
end;
procedure escrdatos(d:TipoDatos);
begin
	escrdatosnif(d.nif);
	writeln(d.edad);
	escrlab(d.laboratorio);
	writeln(d.curso);
	escrptos(d.pto);
end;
procedure escrestudiantes(d: TipoDatos);
begin
	escrdatosnif(d.nif);
	writeln(d.edad);
	escrlab(d.laboratorio);
	writeln(d.curso);
end;
procedure escrnotas(d: TipoDatos);
begin
	escrptos(d.pto);
end;
function medianotas(d1, d2, d3: TipoDatos): real;
begin
	result:= (d1.pto.numerica + d2.pto.numerica + d3.pto.numerica) / 3;
end;
procedure notaalf(d1, d2, d3: TipoDatos);
begin
	if (ord (d1.pto.alfabetica) < ord (d2.pto.alfabetica)) and (ord (d1.pto.alfabetica) < ord (d3.pto.alfabetica)) then begin
		writeln(d1.pto.alfabetica);
	end
	else if (ord (d1.pto.alfabetica) > ord (d2.pto.alfabetica)) and (ord (d2.pto.alfabetica) > ord(d3.pto.alfabetica)) then begin
		writeln(d3.pto.alfabetica);
	end
	else if (ord (d1.pto.alfabetica) > ord (d2.pto.alfabetica)) and (ord(d2.pto.alfabetica) < ord (d3.pto.alfabetica)) then begin
		writeln(d2.pto.alfabetica);
	end;
end;
procedure datoscamp(d: TipoDatos; c: TipoCamp);
begin
	if c = d.laboratorio.campus then begin
		escrdatos(d);
	end;
end;
begin
	leerdatos(datos1);
	leerdatos(datos2);
	leerdatos(datos3);
	escrdatos(datos1);
	escrdatos(datos2);
	escrdatos(datos3);
	escrestudiantes(datos1);
	escrestudiantes(datos2);
	escrestudiantes(datos3);
	escrnotas(datos1);
	escrnotas(datos2);
	escrnotas(datos3);
	writeln(medianotas(datos1, datos2, datos3));
	notaalf(datos1, datos2, datos3);
	readln(c);
	datoscamp(datos1, c);
	datoscamp(datos2, c);
	datoscamp(datos3, c);
end.
