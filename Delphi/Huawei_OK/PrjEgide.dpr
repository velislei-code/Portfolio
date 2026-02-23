program PrjEgide;

uses
  Forms,
  UnMain in 'UnMain.pas' {Main},
  DgSobre in 'DgSobre.pas' {Sobre};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TSobre, Sobre);
  Application.Run;
end.
