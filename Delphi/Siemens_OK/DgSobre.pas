// by: Treuk, Velislei A
//   email: velislei@gmail.com
//   Copyright(c) 2010-2011
//   Sistemas de Monitoramento e bloqueio de fraudes em portas ADSL em Massa 
//   Projeto, excecução p/ Oi S/A
//   All Rights Reserveds       

unit DgSobre;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, jpeg;

type
  TSobre = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Image1: TImage;
    StEgide: TStaticText;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText4: TStaticText;
    StaticText3: TStaticText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Sobre: TSobre;

implementation

{$R *.DFM}

end.
