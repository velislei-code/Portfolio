// by: Treuk, Velislei A
//   email: velislei@gmail.com
//   Copyright(c) 2010-2011
//   Sistemas de Monitoramento e bloqueio de fraudes em portas ADSL em Massa 
//   Projeto, excecução p/ Oi S/A
//   All Rights Reserveds       

unit UnMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ToolWin, ComCtrls, StdCtrls, Buttons, ExtCtrls, jpeg, DBCtrls,
  Grids, DBGrids, Db, ZAbstractRODataset, ZAbstractDataset, ZAbstractTable,
  ZDataset, ZConnection, OleCtrls, CHILKATSSHLib_TLB, Mask;

type
  TMain = class(TForm)
    ToolBar1: TToolBar;
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Abrir1: TMenuItem;
    Novo1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    MenuSistema: TMenuItem;
    MenuConectar: TMenuItem;
    Info1: TMenuItem;
    Sobre1: TMenuItem;
    N2: TMenuItem;
    Sobre2: TMenuItem;
    BtIdaeia: TSpeedButton;
    BtPlaneta: TSpeedButton;
    BtTools: TSpeedButton;
    N3: TMenuItem;
    MenuComandos1: TMenuItem;
    MenuResultado1: TMenuItem;
    MenuShell1: TMenuItem;
    ZCon: TZConnection;
    MenuRastrear2: TMenuItem;
    MenuRepositorio2: TMenuItem;
    PnConectar: TPanel;
    PgCtrlDslam: TPageControl;
    TSDslam: TTabSheet;
    GBShell: TGroupBox;
    GBRastrear: TGroupBox;
    GBComandos: TGroupBox;
    GBResultado: TGroupBox;
    GBMySql: TGroupBox;
    DbGTbPortas: TDBGrid;
    DbGTbDslam: TDBGrid;
    DbNTbPortas: TDBNavigator;
    DbNTbDslam: TDBNavigator;
    GBRepositorio: TGroupBox;
    DbEdStatus: TDBEdit;
    DdEdVelUP: TDBEdit;
    DbEdVelDN: TDBEdit;
    DbEdDslam_Reg: TDBEdit;
    DbEdDslamID: TDBEdit;
    DbEdDslamVersao: TDBEdit;
    DbEdDslamPlacas: TDBEdit;
    MemoShell: TMemo;
    MemoComandos: TMemo;
    MemoResultado: TMemo;
    MemoRastrear: TMemo;
    PnBotoes: TPanel;
    BtConectar: TBitBtn;
    Image1: TImage;
    Bevel1: TBevel;
    BtSair: TBitBtn;
    Bevel2: TBevel;
    Image2: TImage;
    GbLogErro: TGroupBox;
    MemoLogErro: TMemo;
    MenuLogErro: TMenuItem;
    LbData: TLabel;
    Timer1: TTimer;
    ZTbPtZTE: TZTable;
    ZTbDslamZTE: TZTable;
    DsPtZTE: TDataSource;
    DsDslamZTE: TDataSource;
    procedure MenuConectarClick(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure MenuComandos1Click(Sender: TObject);
    procedure MenuRastrear2Click(Sender: TObject);
    procedure MenuResultado1Click(Sender: TObject);
    procedure MenuShell1Click(Sender: TObject);
    procedure BtScanearClick(Sender: TObject);
    procedure MenuRepositorio2Click(Sender: TObject);
    procedure Sobre2Click(Sender: TObject);
    procedure BtConectarClick(Sender: TObject);
    procedure BtSairClick(Sender: TObject);
    procedure MenuLogErroClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    function Main: Boolean;
    function Inicializar: Boolean;
    function Conectar(hostname: String; port: Integer; login, senha: String): Boolean;
    function Scanear: Boolean;
    function Desconectar: Boolean;
    function Rastrear(funcao: String): Boolean;
    function ZteGisA(ID_Dslam: String): boolean;
    function ZteGisB(ID_Dslam: String): boolean;
    function Script(comando, prompt: String): Boolean;
    function ShState(Versao: String): string;
    function PortasMySql(Porta, Status, Profile, VelUP, VelDN: String): boolean;
    function DslamMySql(ID_Dslam, Placas: String): boolean;
    function ContarPlacas: Integer;

    procedure ProfileZTE(var Profile, Up, Dn: String);

  public
    { Public declarations }
  end;

var
  Main: TMain;
  ssh: TChilkatSsh;
  success: Integer;
  channelNum: Integer;
  prompt_anterior, resposta: string;              // Recebe o retorno de show port state X
  Teste_num_placas, Teste_num_portas: Integer;    // Num de portas a testar

implementation

uses DgSobre;

{$R *.DFM}

procedure TMain.MenuConectarClick(Sender: TObject);
begin
        if MenuConectar.Checked then
        begin
            MenuConectar.Checked := false;
            PnConectar.visible := false;
        end else begin
            MenuConectar.Checked := true;
            PnConectar.visible := true;
        end;
end;

procedure TMain.Sair1Click(Sender: TObject);
begin
        application.terminate;
end;

procedure TMain.BitBtn2Click(Sender: TObject);
begin
        application.terminate;
end;

procedure TMain.MenuComandos1Click(Sender: TObject);
begin
        if MenuComandos1.Checked then
        begin
           MenuComandos1.Checked := false;
           GBComandos.Visible := false;
        end else begin
           MenuComandos1.Checked := true;
           MenuConectar.Checked := true;
           PnConectar.visible := true;
           GBComandos.Visible := true;
        end;
end;

procedure TMain.MenuRastrear2Click(Sender: TObject);
begin
        if MenuRastrear2.Checked then
        begin
           MenuRastrear2.Checked := false;
           GBRastrear.Visible := false;
        end else begin
           MenuRastrear2.Checked := true;
           GBRastrear.Visible := true;
           MenuConectar.Checked := true;
           PnConectar.visible := true;
        end;

end;

procedure TMain.MenuResultado1Click(Sender: TObject);
begin
        if MenuResultado1.Checked then
        begin
           MenuResultado1.Checked := false;
           GBResultado.Visible := false;
        end else begin
           MenuResultado1.Checked := true;
           GBResultado.Visible := true;
           MenuConectar.Checked := true;
           PnConectar.visible := true;
        end;

end;

procedure TMain.MenuShell1Click(Sender: TObject);
begin
        if MenuShell1.Checked then
        begin
           MenuShell1.Checked := false;
           GBShell.Visible := false;
        end else begin
           MenuShell1.Checked := true;
           GBShell.Visible := true;
           MenuConectar.Checked := true;
           PnConectar.visible := true;
        end;
end;


//******************************************************************************
// Funções

function TMain.Main: Boolean;
begin
        if MenuRastrear2.Checked then Rastrear('Main()');
        Inicializar();
	if ( Conectar('10.61.184.16',22,'tr109065','14qrafzv') ) then           // Inicia conexão com Servidor
        begin Scanear(); end;                     			         // Inicia varredura das portas 
        Desconectar();
end;

function TMain.Inicializar: Boolean;
begin
        if MenuRastrear2.Checked then Rastrear('Inicializar()');

        Teste_num_placas := 6;
        Teste_num_portas := 3;
        prompt_anterior := '';                                                 // Limita num de portas por placas

end;


function TMain.Rastrear(funcao: String): Boolean;
begin
	MemoRastrear.Lines.Add(funcao);
end;

function TMain.Conectar(hostname: String; port: Integer; login, senha: String): Boolean;
var
   termType: String;
   widthInChars: Integer;
   heightInChars: Integer;
   pixWidth: Integer;
   pixHeight: Integer;
   resultado: boolean;

begin

    if MenuRastrear2.Checked then Rastrear('Conectar()');

    resultado := true;						// Inicialmente considera conexão como OK

// Importante: É útil para enviar o conteúdo do
// Propriedade ssh.LastErrorText / ao solicitar apoio.

ssh := TChilkatSsh.Create(Self);


// Qualquer string começa automaticamente a um julgamento totalmente funcional por 30 dias.
success := ssh.UnlockComponent('30-day trial');
if (success <> 1) then
begin
    MemoLogErro.Lines.Add('ERRO 1001 ! [UnlockComponent] ');
    MemoLogErro.Lines.Add(ssh.LastErrorText);
    resultado := false;
    Exit;
end;

// Mantenha um registro de sessão, que está disponível através do SessionLog
// Propriedade:
ssh.KeepSessionLog := 1;

MemoShell.Lines.Add('Iniciando conexão com o servidor Tacaks! Aguarde...');
success := ssh.Connect(hostname,port);
if (success <> 1) then
begin
    MemoLogErro.Lines.Add('ERRO 1002 ! [Connect]');
    MemoLogErro.Lines.Add(ssh.LastErrorText);
    MemoLogErro.Lines.Add(ssh.SessionLog);
    resultado := false;
    Exit;
end;


// Ao ler, se não houver dados adicionais chega a mais de
// 5 segundos, então abortar:
ssh.IdleTimeoutMs := 5000;

// Autenticação de Servidor SSH
// Se não houver um login / password necessário, você ainda deve chamar
// AuthenticatePw e usar quaisquer valores para login / password.
success := ssh.AuthenticatePw(login,senha);
if (success <> 1) then
  begin
    // MemoLogErro.Lines.Add(ssh.LastErrorText);
    MemoLogErro.Lines.Add('ERRO 1003 ! [AuthenticatePw]');
    MemoLogErro.Lines.Add(ssh.SessionLog);
    resultado := false;
    Exit;
end;


// Abrir um canal de sessão.
channelNum := ssh.OpenSessionChannel();
if (channelNum < 0) then
  begin
    MemoLogErro.Lines.Add(ssh.LastErrorText);
    MemoLogErro.Lines.Add('ERRO 1004! [OpenSessionChannel]');
    MemoLogErro.Lines.Add(ssh.SessionLog);
    resultado := false;
    Exit;
end;


// Pedir uma pseudo-terminal
termType := 'dumb';
widthInChars := 120;
heightInChars := 80;
pixWidth := 0;
pixHeight := 0;
success := ssh.SendReqPty(channelNum,termType,widthInChars,heightInChars,pixWidth,pixHeight);
if (success <> 1) then
  begin
    MemoLogErro.Lines.Add(ssh.LastErrorText);
    MemoLogErro.Lines.Add('ERRO 1005 ! [SendReqPty]');
    MemoLogErro.Lines.Add(ssh.SessionLog);
    resultado := false;
    Exit;
end ;


// Iniciar uma shell no canal:
success := ssh.SendReqShell(channelNum);
if (success <> 1) then
  begin
    MemoLogErro.Lines.Add(ssh.LastErrorText);
    MemoLogErro.Lines.Add('ERRO 1006 ! [SendReqShell]');
    MemoLogErro.Lines.Add(ssh.SessionLog);
    resultado := false;
    Exit;
end;

        result := resultado;

end; // final função Acessar

function TMain.Scanear: Boolean;
var
	TD, Total_Dslam, Num_Placas: Integer;
	Nome_Dslam, Versao_Dslam: String;

begin
//********************************************************************************************
// Inicia varredura

        if MenuRastrear2.Checked then Rastrear('Scanear()');

        ZTbDslamZTE.last;                             // Aponta para o ultimo registro
        Total_Dslam := StrToInt(DbEdDslam_Reg.Text);    // Pega total de Dslam´s na tabela
        for TD := 1 to Total_Dslam do
        begin
             ZTbDslamZTE.Locate('registro',TD,[]);          // Aponta para registro correspondente
             Nome_Dslam := (DbEdDslamID.text);               // Pega ID do dslam
             Versao_Dslam := DbEdDslamVersao.text;                // Pega Versao

//             if (Versao_Dslam = 'GisA') then MemoComandos.Lines.Add('Teste ! Conexão com: ' + IntToStr(TD) + '=' + Nome_Dslam + '-' + Versao_Dslam + '-' + IntToStr(Num_Placas) );
             if (Versao_Dslam = 'GisA') then ZteGisA(Nome_Dslam);  // Executa acesso ao ZTE

            if (Versao_Dslam = 'GisB') then MemoComandos.Lines.Add('Teste ! Conexão com: ' + IntToStr(TD) + '=' + Nome_Dslam + '-' + Versao_Dslam + '-' + IntToStr(Num_Placas) );
//             if (Versao_Dslam = 'GisB') then ZteGisB(Nome_Dslam);  // Executa acesso ao ZTE

        end;

//        Script('exit','tr109065@wsacesso-CTA:~$');    // Sai do servidor ZTE
        Script('exit','');                            // Sai do servidor Tacaks
//********************************************************************************************
end;   // Final da função Scanear

function TMain.Desconectar: Boolean;
begin

 if MenuRastrear2.Checked then Rastrear('Desconectar()');
 
// Envia um comando. Neste caso, estamos enviando o "exit" comando:
success := ssh.ChannelSendString(channelNum,'exit' + #13,'ansi');
if (success <> 1) then
  begin
    MemoLogErro.Lines.Add(ssh.LastErrorText);
    MemoLogErro.Lines.Add(ssh.SessionLog);
    Exit;
  end;


// Você pode continuar a enviar comandos adicionais.
// A técnica é: enviar o comando, leia até o próximo comando prompt,
// E depois buscar / limpar o buffer de recepção interna.

// Nós somos feitos, então desligá-lo ..

// Enviar um EOF. Isso informa ao servidor que mais nenhum dado será
// Ser enviadas neste canal. O canal permanece aberto e
// O cliente SSH pode ainda receber saída neste canal.
success := ssh.ChannelSendEof(channelNum);
if (success <> 1) then
  begin
    MemoLogErro.Lines.Add(ssh.LastErrorText);
    MemoLogErro.Lines.Add(ssh.SessionLog);
    Exit;
  end;


//  Fechar canal:
success := ssh.ChannelSendClose(channelNum);
if (success <> 1) then
  begin
    MemoLogErro.Lines.Add(ssh.LastErrorText);
    MemoLogErro.Lines.Add(ssh.SessionLog);
    Exit;
  end;

        BtConectar.enabled := true;
        BtSair.enabled := true;
  
//  Disconnect
 ssh.Disconnect();

   result := true;
end;  // Final função Desconectar

function TMain.ZteGisA(ID_Dslam: String): boolean;
var
   slot_adsl, porta_adsl: Integer;
   cmd_slot, prompt_slot, cmd_porta, prompt_porta: String;
   slotAD, portaAD, ID_Porta: String;
   Profile, Up, Dn : String;
   Estado_porta: String;
   T, Num_Placas: Integer;

begin
	 if MenuRastrear2.Checked then Rastrear('ZTE()');

//******************************************************************************
// Script´s

        // Entra no Dslam
        Script('telnet ' + ID_Dslam + ' 1123','Login:');

        Script('root','Password:');
        Script('root',ID_Dslam + '#');
        Script('config',ID_Dslam + '(config)#');

        // Teste

{
        // Consulta num placas no shelf
        Script('show card',ID_Dslam + '(config)#');  // Lista placas
        Num_Placas := ContarPlacas();                                   // Conta N.placas no Dslam
        DslamMySql(ID_Dslam,IntToStr(Num_Placas));                      // Atualiza N.Placas BD MySql Dslam
}
        //**********************************************************************
        //Entra no slot
        for slot_adsl:=3 to Teste_Num_Placas do
        begin
        if (slot_adsl <> 9)and(slot_adsl <> 10) then begin   // Saltar placas 9 e 10 (CXM)

          //********************************************************************
          // Consulta a porta dentro do slot
          for porta_adsl:=1 to Teste_num_portas do
          begin
                  //************************************************************
                  // ENVIA COMANDO E PROCURA Status da porta
                  cmd_slot := 'show adsl port 0/' + IntToStr(slot_adsl) + '/' + IntToStr(porta_adsl);         // Comando
                  prompt_slot := ID_Dslam + '(config)#';
                  Script(cmd_slot,prompt_slot);
                  // Verifica status da porta
                  Estado_porta := ShState('GISB');
                 //************************************************************

                  //************************************************************
                  // ENVIA COMANDO E PROCURA Profile da porta
                  cmd_slot := 'show adsl port slot 0/' + IntToStr(slot_adsl);   // Comando
                  prompt_slot := ID_Dslam + '(config)#';                                                                   // Prompt
                  Script(cmd_slot,prompt_slot);                                 // Envia comando ao Dslam
                  // Verifica profile da porta
                  ProfileZTE(Profile,Up,Dn);                                       // Analisa Vel Up-Down
                 //************************************************************

                //************************************************************
                // Formatação de slot e porta para comparar com BD_MySql
                if slot_adsl < 10 then slotAD := '0' + IntToStr(slot_adsl)
                else slotAD := IntToStr(slot_adsl);
                if porta_adsl < 10 then portaAD := '0' + IntToStr(porta_adsl)
                else portaAD := IntToStr(porta_adsl);
                ID_Porta := ID_Dslam + '-' + slotAD + '/' + portaAD;
               //************************************************************

                PortasMySql(ID_Porta,Estado_porta,Profile,Up,Dn);      // Atualizar registros no BD MySql
//                Rastrear('EditarMySql(' + ID_Porta + ', ' + Estado_porta + ', ' + Profile +', ' + Up +', ' + Dn);

                // Mostrar relatorio da consulta
                // State(): verifica se Inativa, Ativa ou bloqueada
                // Profile(): Analiza a velocidade da Porta
                MemoResultado.Lines.Add('[' + ID_Porta + ']' + ' - ' + Estado_porta + ' - ' + Up + '-' + Dn );

          end;  // for porta_adsl
           //********************************************************************************
         end;  // if... salta Ctrl 9 e 10
         end; // for slot_adsl

        //*********************************************************************************
       Script('end',ID_Dslam + '#');                   // sai do config
       Script('logout','tr109065@BTDF0195>');       // sai do Dslam

   result := true;

end;   // Final da função

function TMain.ZteGisB(ID_Dslam: String): boolean;
var
   slot_adsl, porta_adsl: Integer;
   cmd_slot, prompt_slot, cmd_porta, prompt_porta: String;
   slotAD, portaAD, ID_Porta: String;
   Profile, Up, Dn : String;
   Estado_porta: String;
   T, Num_Placas: Integer;

begin
	 if MenuRastrear2.Checked then Rastrear('ZTE()');

//******************************************************************************
// Script´s
        // Entra no Dslam
        Script('telnet ' + ID_Dslam,'Username:');
        Script('zte','Password:');
        Script('zte',ID_Dslam + '#');
        Script('conf ter',ID_Dslam + '(config)#');

        // Consulta num placas no shelf
        Script('show card',ID_Dslam + '(config)#');  // Lista placas
        Num_Placas := ContarPlacas();                                   // Conta N.placas no Dslam
        DslamMySql(ID_Dslam,IntToStr(Num_Placas));                      // Atualiza N.Placas BD MySql Dslam

        //**********************************************************************
        //Entra no slot
        for slot_adsl:=3 to Teste_Num_Placas do
        begin
        if (slot_adsl <> 9)and(slot_adsl <> 10) then begin   // Saltar placas 9 e 10 (CXM)

          //********************************************************************
          // Consulta a porta dentro do slot
          for porta_adsl:=1 to Teste_num_portas do
          begin
                  //************************************************************
                  // ENVIA COMANDO E PROCURA Status da porta
                  cmd_slot := 'show adsl port-info adsl_1/' + IntToStr(slot_adsl) + '/' + IntToStr(porta_adsl);         // Comando
                  prompt_slot := ID_Dslam + '(config)#';
                  Script(cmd_slot,prompt_slot);
                  // Verifica status da porta
                  Estado_porta := ShState('GISB');
                 //************************************************************

                 //************************************************************
                 // Verifica profile da porta
                  ProfileZTE(Profile,Up,Dn);                                       // Analisa Vel Up-Down
                //************************************************************

                //************************************************************
                // Formatação de slot e porta para comparar com BD_MySql
                if slot_adsl < 10 then slotAD := '0' + IntToStr(slot_adsl)
                else slotAD := IntToStr(slot_adsl);
                if porta_adsl < 10 then portaAD := '0' + IntToStr(porta_adsl)
                else portaAD := IntToStr(porta_adsl);
                ID_Porta := ID_Dslam + '-' + slotAD + '/' + portaAD;
                //************************************************************

                PortasMySql(ID_Porta,Estado_porta,Profile,Up,Dn);      // Atualizar registros no BD MySql
                Rastrear('EditarMySql(' + ID_Porta + ', ' + Estado_porta + ', ' + Profile +', ' + Up +', ' + Dn);

                // Mostrar relatorio da consulta
                // State(): verifica se Inativa, Ativa ou bloqueada
                // Profile(): Analiza a velocidade da Porta
                MemoResultado.Lines.Add('[' + ID_Porta + ']' + ' - ' + Estado_porta + ' - ' + Profile +', ' + Up + '-' + Dn );

          end;  // for porta_adsl
           //********************************************************************************
         end;  // if... salta Ctrl 9 e 10
         end; // for slot_adsl

        //*********************************************************************************
       Script('exit',ID_Dslam + '#');                   // sai do config
       Script('exit','tr109065@BTDF0195>');       // sai do Dslam

   result := true;

end;   // Final da função


function TMain.Script(comando, prompt: String) : Boolean;
var
   resultado: Boolean;
begin

 LbData.Caption := DateTimeToStr(Now);   // Atualiza data no Painel
 if MenuRastrear2.Checked then Rastrear('Script( ' + comando + ', ' + prompt + ' )');

 // Mostra comandos enviados
 MemoComandos.Lines.add(prompt_anterior + ' ' + comando);


// Envia um comando. Neste caso, estamos enviando o comando_X + <enter>
success := ssh.ChannelSendString(channelNum,comando + #13,'ansi');
if (success <> 1) then
  begin
    MemoLogErro.Lines.Add(ssh.LastErrorText);
    MemoLogErro.Lines.Add(ssh.SessionLog);
    MemoLogErro.Lines.Add('ERRO 2001 ! [ ChannelSendString ]');
    resultado := false;
    Exit;
  end;

// Lê até o próximo comando prompt: TEBAJ663>
success := ssh.ChannelReceiveUntilMatch(channelNum,prompt,'ansi',1);
if (success <> 1) then
  begin
    // Verificar as informações de erro da última sessão e log ...
    MemoLogErro.Lines.Add(ssh.LastErrorText);
    MemoLogErro.Lines.Add(ssh.SessionLog);
    // Check para ver o que foi recebido.
    MemoShell.Lines.Add(ssh.GetReceivedText(channelNum,'ansi'));
    MemoLogErro.Lines.Add('ERRO 2002 ! [ ChannelReceiveUntilMatch ]');
    resultado := false;
    Exit;
  end;

  prompt_anterior := prompt;

// Mostra a saída do comando:
resposta := ssh.GetReceivedText(channelNum,'ansi');
MemoShell.Lines.Add(resposta);

result := resultado;

end;

//******************************************************************************
function TMain.ShState(Versao: String): string;
var
   PTstatus: String;

begin
   PTstatus := '';
   if Versao = 'GISB' then
   begin
        PTstatus := 'GISB ?';
        if pos('up/  up', resposta)>0 then PTstatus := 'Sincronizada';
        if pos('up/down', resposta)>0 then PTstatus := 'Não sincroni';
        if pos('down/down', resposta)>0 then PTstatus := 'Bloqueada';
   end;


  if MenuRastrear2.Checked then Rastrear('ShState( ' + PTstatus + ' )'); 
   result := PTstatus;
   
end;

procedure TMain.ProfileZTE(var Profile, Up, Dn: String);
begin

       if pos('DEFVAL.PRF', resposta)>0 then begin Profile := 'DEFVAL.PRF'; Dn := 'DEFVAL'; Up :='DEFVAL'; end;
        if pos('DEF2M.PRF', resposta)>0 then begin Profile := 'DEF2M.PRF'; Dn := 'DEF2M'; Up :='DEF2M'; end;
        if pos('DEF1M.PRF', resposta)>0 then begin Profile := 'DEF1M.PRF'; Dn := 'DEF1M'; Up :='DEF1M'; end;
        if pos('DEFHM.PRF', resposta)>0 then begin Profile := 'DEFHM.PRF'; Dn := 'DEFHM'; Up :='DEFHM'; end;
        if pos('64_64.PRF', resposta)>0 then begin Profile := '64_64.PRF'; Dn := '64'; Up :='64'; end;
        if pos('128_128.PRF', resposta)>0 then begin Profile := '128_128.PRF'; Dn := '128'; Up :='128'; end;
        if pos('160_64.PRF', resposta)>0 then begin Profile := '160_64.PRF'; Dn := ''; Up :=''; end;
        if pos('224_128.PRF', resposta)>0 then begin Profile := '224_128.PRF'; Dn := ''; Up :=''; end;
        if pos('256_128.PRF', resposta)>0 then begin Profile := '256_128.PRF'; Dn := ''; Up :=''; end;
        if pos('256_256.PRF', resposta)>0 then begin Profile := '256_256.PRF'; Dn := ''; Up :=''; end;
        if pos('320_128.PRF', resposta)>0 then begin Profile := '320_128.PRF'; Dn := ''; Up :=''; end;
        if pos('320_160.PRF', resposta)>0 then begin Profile := '320_160.PRF'; Dn := ''; Up :=''; end;
        if pos('384_384.PRF', resposta)>0 then begin Profile := '384_384.PRF'; Dn := ''; Up :=''; end;
        if pos('416_224.PRF', resposta)>0 then begin Profile := '416_224.PRF'; Dn := ''; Up :=''; end;
        if pos('512_128.PRF', resposta)>0 then begin Profile := '512_128.PRF'; Dn := ''; Up :=''; end;
        if pos('512_512.PRF', resposta)>0 then begin Profile := '512_512.PRF'; Dn := ''; Up :=''; end;
        if pos('608_160.PRF', resposta)>0 then begin Profile := '608_160.PRF'; Dn := ''; Up :=''; end;
        if pos('608_320.PRF', resposta)>0 then begin Profile := '608_320.PRF'; Dn := ''; Up :=''; end;
        if pos('608_512.PRF', resposta)>0 then begin Profile := '608_512.PRF'; Dn := ''; Up :=''; end;
        if pos('640_640.PRF', resposta)>0 then begin Profile := '640_640.PRF'; Dn := ''; Up :=''; end;
        if pos('768_128.PRF', resposta)>0 then begin Profile := '768_128.PRF'; Dn := ''; Up :=''; end;
        if pos('800_320.PRF', resposta)>0 then begin Profile := '800_320.PRF'; Dn := ''; Up :=''; end;
        if pos('1024_320.PRF', resposta)>0 then begin Profile := '1024_320.PRF'; Dn := ''; Up :=''; end;
        if pos('1024_512.PRF', resposta)>0 then begin Profile := '1024_512.PRF'; Dn := ''; Up :=''; end;
        if pos('1504_320.PRF', resposta)>0 then begin Profile := '1504_320.PRF'; Dn := ''; Up :=''; end;
        if pos('1536_256.PRF', resposta)>0 then begin Profile := '1536_256.PRF'; Dn := ''; Up :=''; end;
        if pos('2016_512.PRF', resposta)>0 then begin Profile := '2016_512.PRF'; Dn := ''; Up :=''; end;
        if pos('2048_416.PRF', resposta)>0 then begin Profile := '2048_416.PRF'; Dn := ''; Up :=''; end;
        if pos('4096_416.PRF', resposta)>0 then begin Profile := '4096_416.PRF'; Dn := ''; Up :=''; end;
        if pos('8192_416.PRF', resposta)>0 then begin Profile := '8192_416.PRF'; Dn := ''; Up :=''; end;
        if pos('14016_1024.PRF', resposta)>0 then begin Profile := '14016_1024.PRF'; Dn := ''; Up :=''; end;
        if pos('14336_1024.PRF', resposta)>0 then begin Profile := '14336_1024.PRF'; Dn := ''; Up :=''; end;
        if pos('8000_1024.PRF', resposta)>0 then begin Profile := '8000_1024.PRF'; Dn := ''; Up :=''; end;
        if pos('6016_1024.PRF', resposta)>0 then begin Profile := '6016_1024.PRF'; Dn := ''; Up :=''; end;
        if pos('4032_1024.PRF', resposta)>0 then begin Profile := '4032_1024.PRF'; Dn := ''; Up :=''; end;
        if pos('2048_1024.PRF', resposta)>0 then begin Profile := '2048_1024.PRF'; Dn := ''; Up :=''; end;
        if pos('1536_512.PRF', resposta)>0 then begin Profile := '1536_512.PRF'; Dn := ''; Up :=''; end;
        if pos('1088_512.PRF', resposta)>0 then begin Profile := '1088_512.PRF'; Dn := ''; Up :=''; end;
        if pos('1024_1024.PRF', resposta)>0 then begin Profile := '1024_1024.PRF'; Dn := ''; Up :=''; end;
        if pos('704_640.PRF', resposta)>0 then begin Profile := '704_640.PRF'; Dn := ''; Up :=''; end;
        if pos('8064_1024.PRF', resposta)>0 then begin Profile := '8064_1024.PRF'; Dn := ''; Up :=''; end;
        if pos('3456_256.PRF', resposta)>0 then begin Profile := '3456_256.PRF'; Dn := ''; Up :=''; end;
        if pos('3744_416.PRF', resposta)>0 then begin Profile := '3744_416.PRF'; Dn := ''; Up :=''; end;
        if pos('4160_416.PRF', resposta)>0 then begin Profile := '4160_416.PRF'; Dn := ''; Up :=''; end;
        if pos('3392_224.PRF', resposta)>0 then begin Profile := '3392_224.PRF'; Dn := ''; Up :=''; end;
        if pos('3648_224.PRF', resposta)>0 then begin Profile := '3648_224.PRF'; Dn := ''; Up :=''; end;
        if pos('3392_352.PRF', resposta)>0 then begin Profile := '3392_352.PRF'; Dn := ''; Up :=''; end;
        if pos('3296_160.PRF', resposta)>0 then begin Profile := '3296_160.PRF'; Dn := ''; Up :=''; end;
        if pos('3744_256.PRF', resposta)>0 then begin Profile := '3744_256.PRF'; Dn := ''; Up :=''; end;
        if pos('3744_608.PRF', resposta)>0 then begin Profile := '3744_608.PRF'; Dn := ''; Up :=''; end;
        if pos('3552_320.PRF', resposta)>0 then begin Profile := '3552_320.PRF'; Dn := ''; Up :=''; end;
        if pos('3936_416.PRF', resposta)>0 then begin Profile := '3936_416.PRF'; Dn := ''; Up :=''; end;
        if pos('3456_224.PRF', resposta)>0 then begin Profile := '3456_224.PRF'; Dn := ''; Up :=''; end;
        if pos('4160_608.PRF', resposta)>0 then begin Profile := '4160_608.PRF'; Dn := ''; Up :=''; end;
        if pos('5184_512.PRF', resposta)>0 then begin Profile := '5184_512.PRF'; Dn := ''; Up :=''; end;
        if pos('7232_512.PRF', resposta)>0 then begin Profile := '7232_512.PRF'; Dn := ''; Up :=''; end;
        if pos('11328_512.PRF', resposta)>0 then begin Profile := '11328_512.PRF'; Dn := ''; Up :=''; end;
        if pos('23616_1124.PRF', resposta)>0 then begin Profile := '23616_1124.PRF'; Dn := ''; Up :=''; end;
        if pos('4640_416.PRF', resposta)>0 then begin Profile := '4640_416.PRF'; Dn := ''; Up :=''; end;
        if pos('4672_352.PRF', resposta)>0 then begin Profile := '4672_352.PRF'; Dn := ''; Up :=''; end;
        if pos('17472_1120.PRF', resposta)>0 then begin Profile := '17472_1120.PRF'; Dn := ''; Up :=''; end;
        if pos('23616_1120.PRF', resposta)>0 then begin Profile := '23616_1120.PRF'; Dn := ''; Up :=''; end;

   if MenuRastrear2.Checked then Rastrear('Profile24( ' + Profile +', ' + Up + ', ' + Dn + ')');

end;
function TMain.DslamMySql(ID_Dslam, Placas: String): boolean;
var
   velUP_pt, velDN_pt: String;
   status_pt, analise_st, Info_analise: String;

begin
    if MenuRastrear2.Checked then Rastrear('DslamMySql( ' + ID_Dslam +', '+ Placas + ' )');

    // Procura registro, aponta para -> Porta
        ZTbDslamZTE.Locate('dslam',ID_Dslam,[]);

    // Este código edita o registro que foi localizado acima
       ZTbDslamZTE.Edit;
       ZTbDslamZTE.FieldByName('placas').Value := Placas;
       ZTbDslamZTE.FieldByName('data').Value := DateTimeToStr(Now);
       ZTbDslamZTE.UpdateRecord;
       ZTbDslamZTE.next;

       result := true;

end;


function TMain.PortasMySql(Porta, Status, Profile, VelUP, VelDN: String): boolean;
var
   velUP_pt, velDN_pt: String;
   status_pt, analise_st, Info_analise: String;

begin
    if MenuRastrear2.Checked then Rastrear('PortasMySql( ' + Porta + ' )');

    // Seta valor vazio
    velUP_pt :='';
    velDN_pt :='';
    analise_st := '';
    Info_analise := 'Normal';
   // data := Time;


    // Procura registro, aponta para -> Porta
    ZTbPtZTE.Locate('obj_porta',Porta,[]);

    // Comparar Status
    if ( Status = 'Sincronizada') or (Status = 'Não sync') then status_pt := 'Ativa';
    if ( Status = 'Bloqueda' ) then status_pt := 'Ativa';

    if ( DbEdStatus.Text = 'Ativa') and (status_pt <> 'Ativa' ) then begin
        analise_st := 'Status irregular';
        Info_analise := 'Irregular';
    end;

    if ( DbEdStatus.Text <> 'Ativa') and (status_pt = 'Ativa' ) then begin
        analise_st := 'Status irregular';
        Info_analise := 'Irregular';
    end;

    if ( DdEdVelUP.Text <> VelUP ) then begin
        velUP_pt :='Vel.Up Irregular';
        Info_analise := 'Irregular';
    end;

    if ( DbEdVelDN.Text <> VelDN ) then begin
        velUP_pt :='Vel.Dn Irregular';
        Info_analise := 'Irregular';
    end;


    // Este código edita o registro que foi localizado acima
       ZTbPtZTE.Edit;
       ZTbPtZTE.FieldByName('egd_status').Value := Status;
       ZTbPtZTE.FieldByName('egd_profile').Value := Profile;
       ZTbPtZTE.FieldByName('egd_vel_up').Value := VelUP;
       ZTbPtZTE.FieldByName('egd_vel_dn').Value := VelDN;
       ZTbPtZTE.FieldByName('egd_analise').Value := Info_analise;
       ZTbPtZTE.FieldByName('egd_acao').Value := 'Monitorada';
       ZTbPtZTE.FieldByName('egd_obs').Value := analise_st +', ' + velUP_pt +', ' + velDN_pt;
       ZTbPtZTE.FieldByName('egd_data').Value := DateTimeToStr(Now);
       ZTbPtZTE.UpdateRecord;
       ZTbPtZTE.next;

       result := true;

end;

// final das funções
//******************************************************************************

function TMain.ContarPlacas: Integer;
var
   SS: Integer;
   Shelf: double;       // Float
begin

  //Contar ocorrencia de uma palavra(unknown) em um Memo
  Shelf := 0;                                          // 14 placas IUADSL72 + 2 CTRL(CXM)
  for SS := 1 to length(resposta) do begin
        if copy(resposta,SS,length('GAGLC')) = 'GAGLC' then
        Shelf := Shelf+1;
  end;   
  // Relatório emite 2 ocorrencias de GAGLC por placa existente
  //  1    1     3    GAGLC   GAGLC    32    070400  V3.1P01         INSERVICE
  Shelf := Shelf/2;

  if MenuRastrear2.Checked then Rastrear('ContarPlacas(): [' + FloatToStr(Shelf) + ']');

  result := Trunc(Shelf);       // Retorna o numero inteiro de Shelf

end;

procedure TMain.BtScanearClick(Sender: TObject);
begin
        MenuConectar.Checked := true;
        PnConectar.visible := true;
        Main();
end;

procedure TMain.MenuRepositorio2Click(Sender: TObject);
begin
        if MenuRepositorio2.Checked then
        begin
           MenuRepositorio2.Checked := false;
           GBRepositorio.Visible := false;
        end else begin
           MenuRepositorio2.Checked := true;
           GBRepositorio.Visible := true;
           MenuConectar.Checked := true;
           PnConectar.visible := true;
        end;

end;

procedure TMain.Sobre2Click(Sender: TObject);
begin
        Sobre.showmodal;
end;

procedure TMain.BtConectarClick(Sender: TObject);
begin

        BtConectar.enabled := false;
        BtSair.enabled := false;
        Main();
end;

procedure TMain.BtSairClick(Sender: TObject);
begin
        application.terminate;
end;


procedure TMain.MenuLogErroClick(Sender: TObject);
begin
        if MenuLogErro.Checked then
        begin
           MenuLogErro.Checked := false;
           GBLogErro.Visible := false;
        end else begin
           MenuLogErro.Checked := true;
           GBLogErro.Visible := true;
        end;

end;

procedure TMain.Timer1Timer(Sender: TObject);
begin
        LbData.caption := DateTimeToStr(Now);
end;

end.
