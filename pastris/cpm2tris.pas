program cpm2tris;

{this is the init routines for pastirs, we can unload them completely from
memory this should be compiled as the main program and the m2tmainp.pas as
a chain program. this lets us only load that data into memory on the PI
by unloading it just before executing the main program.}

(* custom BIOS call only version *)

{$I gbinit.inc} (* custom g4 lib for loading fonts *)

const
 difstart = 500; { starting difficulty}
 difoffset = 50; { this is the offset each difficulty level }

var
 inputtbl : array [2..90] of byte;
 level : array [0..10] of real;
 mainpg : file;
 P : integer;

{ define the squares that make up the pieces }

procedure definesprites;
var
 color : string[3];
 dot : string[7];
begin
 for P := 0 to 7 do
  begin
   color := NumStr(P);
   dot := ';7;0;1;';
   statement := esc + '#' + color + ';8;8;16A' + color + ';9;0;6;' + color;
   statement := statement + dot + color + dot + color + dot + color + dot + color;
   statement := statement + dot + color + ';9;';
   piout(statement);
  end;
end;

 begin
  SetModeGFX(20,0,0);
  GFXLoadMaxPal(7,1,7,0);
  write('loading...');
  loadfont;
  loadnumfont;
  definesprites;
  assign(mainpg,'cptmainp.chn');
  chain(mainpg);
 end.                                                                    