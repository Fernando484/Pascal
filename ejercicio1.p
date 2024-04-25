{$mode objfpc}{$H-}{$R+}{$T+}{$Q+}{$V+}{$D+}{$X-}{$warnings on}

program expresiones;

const
Letra: char = 'L';
A: integer = 2;
B: integer = 1;
C: integer = 3;
C1: integer = 12;
C2: integer = 13;
C3: integer = 14;
F: integer = 8;
N1: integer = 9;
N2: integer = 4;
N3: integer = 6;
begin
{1}
writeln((Letra >='A') and (Letra<='Z') or (Letra >='a') and (Letra <= 'z') or (Letra>='1') and (Letra<='9'));
{2}
writeln((Letra >='A') and (Letra<='Z') or (Letra >='a') and (Letra <= 'z'));
{3}
writeln(F*2);
{4}
writeln(sqrt((B * B) + (C * C)));
{5}
writeln(A = (sqrt((B * B) + (C * C))));
{6}
writeln((N1<N2) and (N2<N3));
{7}
writeln((C1<C2) and (C2<C3));
end.
