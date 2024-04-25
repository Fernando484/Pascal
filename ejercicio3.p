{$mode objfpc}{$H-}{$R+}{$T+}{$Q+}{$V+}{$D+}{$X-}{$warnings on}

program ejercicio3;

uses math;
const
    anyomin: integer = 0;
    anyomax: integer = 3000;
    Enero: integer = 1;
    Diciembre: integer = 12;

function anyovalido(anyo:integer): boolean;
begin
    result:= (anyo>= anyomin) and (anyo<= anyomax);
end;

function mesvalido(mes:integer): boolean;
begin
    result:= (mes>= Enero) and (mes<= Diciembre);
end;

function anyobisiesto(anyo:integer): boolean;
begin
    result:= (anyo mod 4 = 0) and (anyo mod 100 <> 0) or
        (anyo mod 400 = 0);
end;

function diasdelmes(anyo,mes:integer): integer;
 begin
    case mes of
    1, 3, 5, 7, 8, 10, 12:
        result := 31;
    2:
        if anyobisiesto(anyo) then begin
            result := 29
        end
        else begin
            result := 28;
        end;
    otherwise
        result := 30;
    end;
end;

function diavalido(anyo, mes, dia:integer):boolean;
begin
    result:= (dia>=1) and (dia<=diasdelmes(anyo,mes));
end;

function horavalida(hora:integer):boolean;
begin
    result:= (hora>=0) and (hora<=23);
end;

function minvalido(min:integer):boolean;
begin
    result:= (min>=0) and (min<=59);
end;

function segundovalido(s:integer):boolean;
begin
    result:= (s>=0) and (s<=59);
end;


function mismoanyo(anyo, anyo2:integer):boolean;
begin
    result:= (anyo=anyo2);
end;
const
{Fecha 1}
    Anyo: integer = 2002;
    Mes: integer = 12;
    Dia: integer = 12;
    Hora: integer = 2;
    Minuto: integer = 58;
    Segundo: integer = 40;
{Fecha 2}
    Anyo2: integer = 2002;
    Mes2: integer = 5;
    Dia2: integer = 24;
    Hora2: integer = 7;
    Minuto2: integer = 12;
    Segundo2: integer = 31;
    
function fechavalida(anyo, anyo2, mes, mes2, dia, dia2, hora, hora2, min,
    min2, s, s2:integer):boolean;
begin
    result:=(anyovalido(anyo)) and (mesvalido(mes)) and 
        (diavalido(anyo,mes,dia)) and
        (horavalida(hora)) and (minvalido(min)) and 
        (segundovalido(s)) and (mismoanyo(anyo,anyo2)) and 
        (anyovalido(anyo2)) and(mesvalido(mes2)) and 
        (diavalido(anyo2,mes2,dia2)) and
        (horavalida(hora2)) and (minvalido(min2)) and 
        (segundovalido(s2));
            if not fechavalida = True then begin
                writeln('Fecha inválida')
            end
end;

function pasarmesasegundos(mes:integer):integer;
begin
     case mes of
    1, 3, 5, 7, 8, 10, 12:
        result:= (24*3600*31);
    2:
        if anyobisiesto(anyo) then begin
            result := (24*3600*29);
        end
        else begin
            result := (24*3600*28);
        end;
    otherwise
        result := (24*3600*30);
    end;
end;
function diasensegundos(dia:integer):integer;
begin
    result:= (dia*24*3600);
end;

function horaensegundos(hora:integer):integer;
begin
    result:= (hora*3600);
end;

function minutoensegundos(min:integer):integer;
begin
    result:= (min*60);
end;
function diferenciaensegundos(mes, dia, hora, min, s, mes2, dia2, hora2, min2, s2: integer):integer;
begin
    result:= Abs(((pasarmesasegundos(mes)) + (diasensegundos(dia)) +
    (horaensegundos(hora)) + (minutoensegundos(minuto)) +
    (s)) - ((pasarmesasegundos(mes2)) + (diasensegundos(dia2)) +
    (horaensegundos(hora2)) + (minutoensegundos(minuto2)) + (s2)));
end;

{Segundos desde el 1 de enero para fecha 1}
function dif1enefecha1(mes, dia, hora, min, s:integer):integer;
begin
    result:= (pasarmesasegundos(mes)) + (diasensegundos(dia)) +
    (horaensegundos(hora)) + (minutoensegundos(minuto)) + (s);
end;
{Segundos desde el 1 de enero para fecha 2}
function dif1enefecha2(mes2, dia2, hora2, min2, s2:integer):integer;
begin
    result:= (pasarmesasegundos(mes2)) + (diasensegundos(dia2)) +
    (horaensegundos(hora2)) + (minutoensegundos(minuto2)) + (s2);
end;

function pasarsegundosadia(s:integer):integer;
begin
    result:= ((s div 3600) div 24);
end;

function segundosrestantesdia(s:integer):integer;
begin
    result:= (s-(pasarsegundosadia(s)*3600*24));
end;

function pasarsegundosahora(s:integer):integer;
begin
    result:= ((segundosrestantesdia(s))div 3600);
end;

function segundosrestanteshora(s:integer):integer;
begin
    result:= (s-(pasarsegundosahora(s)*3600));
end;

function pasarsegundosamin(s:integer):integer;
begin
    result:= (segundosrestanteshora(s)div 60);
end;

function segundosrestantesmin(s:integer):integer;
begin
    result:= (s-(pasarsegundosamin(s)*60));
end;
begin
    writeln(fechavalida(Anyo, Anyo2, Mes, Mes2, Dia, Dia2, Hora, Hora2, Minuto, Minuto2, Segundo, Segundo2));
    writeln(dif1enefecha1(Mes, Dia, Hora, Minuto, Segundo));
    writeln(dif1enefecha2(Mes2, Dia2, Hora2, Minuto2, Segundo2));
    writeln(diferenciaensegundos(Mes, Mes2, Dia, Dia2, Hora, Hora2, Minuto, Minuto2, Segundo, Segundo2));
    write(pasarsegundosadia(diferenciaensegundos(Mes, Mes2, Dia, Dia2, Hora, Hora2, Minuto, Minuto2, Segundo, Segundo2)));
    write(chr (47));
    write(pasarsegundosahora(segundosrestantesdia(diferenciaensegundos(Mes, Mes2, Dia, Dia2, Hora, Hora2, Minuto, Minuto2, Segundo,
        Segundo2))));
    write(chr (47));
    write(pasarsegundosamin(segundosrestanteshora(segundosrestantesdia((diferenciaensegundos(Mes, Mes2, Dia, Dia2, Hora, Hora2, Minuto, Minuto2, Segundo, Segundo2))))));
    write(chr (47));
    write(segundosrestantesmin(segundosrestanteshora(((diferenciaensegundos(Mes, Mes2, Dia, Dia2, Hora, Hora2, Minuto, Minuto2, Segundo, Segundo2))))));
end.