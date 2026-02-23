//package prjJxTrader;
/*
 * by: Treuk, Velislei A
 *   email: velislei@gmail.com
 *   Copyright(c) 2016-2018
 *   Sistemas de testes de portas ADSL em Massa 
 *   Projeto, excecução p/ Oi S/A
 *   All Rights Reserveds       
 */
 
import java.awt.Dimension;
import java.awt.Toolkit;

public class Posicao {

	
	// Pega dimensões da tela
    Toolkit tkTela = Toolkit.getDefaultToolkit();  
    Dimension dDimTela = tkTela.getScreenSize(); 
    
    public int iTelaLarg = dDimTela.width; 
    public int iTelaAlt = dDimTela.height;
    
    double dDiv3LargTela = iTelaLarg / 3;
    double dDiv6AltTela = iTelaLarg / 12;

     
    /***************************************************************************************************************************************/
    // Barras Ferramentas - Altura padrão
    static int iAltPadraoMenu = 25;		// Altura padrão da barra de menu, status
    static int iAltPadraoBfBtn = 50;	// Altura padrão da barra de ferramentas, botoes
    static int iAltPadraoBF = 25;		// Altura padrão da barra de ferramentas, Add, Parametros, Resultados
    
    /***************************************************************************************************************************************/
    // Posição dos Menus 
    static int bfMenuLin = 1;		// Posição padrão da linha do menu
    
    // Menu Cadastros
    static int bfMenuCadCol = 1;	// Coluna inicial
    static int iMenuCadLarg = 55;	// Largura do menu

    
    // Menu Projeto
    static int bfMenuPrjCol = 1;	// Coluna inicial
    static int iMenuPrjLarg = 55;	// Largura do menu

    // Menu Sistema
    static int bfMenuSysCol = 56;	// Coluna inicial
    static int iMenuSysLarg = 60;	// Largura do menu
    
    // Menu Ferramentas
    static int bfMenuFerCol = 116;	// Posição inicial(linha) do menu
    static int iMenuFerLarg = 90;	// Largura do menu - Ferramentas(8px/char)
    
    // Menu Opção
    static int bfMenuOpcCol = 206;	// Posição inicial(linha) do menu
    static int iMenuOpcLarg = 70;	// Largura do menu - opcao(8px/char)
    
    // Menu Info
    static int bfMenuInfoCol = 276;	// Posição inicial(linha) do menu
    int iMenuInfoLarg = iTelaLarg - 276;	// Largura do menu - opcao(8px/char)
    
    /***************************************************************************************************************************************/
    // Posições da Barra de ferramentas dos botões  
    int bfBtnPosLin = (iAltPadraoMenu * 1) + 1; 		// Posição padrão inicial da linha da bar.fer.botões

    // BF-Botoes Ctrl 
    static int bfBtnPosCol = 1; 					// Pos.inicial Coluna 
    int bfBtnLarg = 370;							// largura da B.Fer.Projeto    
    
    // Bf-Btn-ClickSaltar
    static int bfClickSaltarPosCol = 371; 					// Pos.inicial Coluna 
    int bfClickSaltarLarg = 70;							// largura da B.Fer.Projeto    
  
    // Bf-Btn-ClickSaltar
    static int bfBtnContasPosCol = 391; 					// Pos.inicial Coluna 
    int bfBtnContasLarg = 210;							// largura da B.Fer.Projeto    
  
    // Bf-Btn-Sair
    static int bfBtnSairPosCol = 601; 					// Pos.inicial Coluna 
    int bfBtnSairLarg = 70;							// largura da B.Fer.Projeto    
  
    /***************************************************************************************************************************************/
    // BF-AddCotacao, Acima da tabela
    int bfAddLin = (iAltPadraoBfBtn * 1) + iAltPadraoBF; 		// Posição padrão inicial da linha da bar.fer.botões
   	int bfAddCol = 1;
   	int bfAddLinLarg = (int)(iTelaLarg*0.5);						// O que sobrar da barra de Botoes
    	
    // BF-Parametros
	int bfParamCol = 1;  
	int bfParamLin = (iAltPadraoBF * 4); 
	int bfParamLarg = (int)(iTelaLarg * 0.99);	// Largura BF-50%
  	int bfParamEspaco = (int)(iTelaLarg*0.01);	// BF-Espaçador a direita - 20%

  	// BF-Resultado-Parametros
  	int bfResParamCol = 1;
 	int bfResParamLin = (iAltPadraoBF * 3); 
 	int bfResParamLarg = (int)(iTelaLarg * 0.99);	// Largura BF-50%

 
	// BF-Coord/Media/Acao
  	int BfCoordMediaAcaoCol = 1;
 	int BfCoordMediaAcaoLin = (iAltPadraoBF * 6); 
 	int BfCoordMediaAcaoLarg = (int)(iTelaLarg * 0.99);	// Largura BF-50%

      
    /***************************************************************************************************************************************/
    // Posições Bar.fer Filtro e coordenadas - Substituido por: BF-Coord/Media/Acao
    static int iAltBfFiltro = 25;
    int bfPlanFiltroLin = (iAltPadraoBF * 7); 							// Linha padrão
    int bfPlanFiltroCol = 1; //bfTabColIni;					// Coluna inicial do Filtro
    
    /***************************************************************************************************************************************/
    // Posição da Planilha - Tabela
    static int iAlturaLinTab = 20;								// Altura padrão da linha na tabela
    int bfTabLinIni = bfPlanFiltroLin + 25;					// Posição inicial da linha da bar.fer.Tabela
    
    
    double dRestoDaAlt = ( iTelaAlt-(iAltPadraoBfBtn*3) ) / 7;		// Divide o resto da Altura da tela por 7    
    int AltTabela = (int)dRestoDaAlt*4;							// Pega 4 partes do restante da Alt-da-Tela 

  
    /***************************************************************************************************************************************/
 	// Text-Areas: Telnet, SLine, Log    
    int TAreaAlt = ( (int)dRestoDaAlt*3) - (int)(iAltPadraoBF*3.6);	// Calcula a sobra de tela para a altura das B.Fer	
   
    
    // int TAreaLarg = (int)dDiv3LargTela;			// Largura padrão do T.Area
    int TAreaLarg = (int)iTelaLarg/2;				// Largura padrão do T.Area
    int TAreaLin = AltTabela + bfTabLinIni + 3;		// Num da linha(px - do topo esquerdo) na Tela do T.Area        
    
    static int taTelnetCol = 1;						// Posição inicial da coluna da B.Ferramentas
    int taSLineCol = (int)dDiv3LargTela;			// Posição inicial da coluna da B.Ferramentas
    int taLogCol = (int)dDiv3LargTela * 2;			// Posição inicial da coluna da B.Ferramentas
  
    // Bar.Fer Testes
    static int bfTesteLarg = 140;
 	static int bfTesteCol = 450;	
 	//	int bfTesteLin = TAreaLin + TAreaAlt -25;		

    
    // barra de Status
    int iBStLinIni = iTelaAlt - 88;

    
    // Final Posicao formPrincipal
    
    /***************************************************************************************************************************************/
    /* FormPlan, FormCadClientes,  DlgCadCli,  2019 */
    // BF-Plan Botoes
    static int bfPlanBtnPosLin = 1; 					// Pos.inicial Linha BF
    static int bfPlanBtnPosCol = 1; 					// Pos.inicial Coluna BF
    static int bfPlanBtnLarg = 210;						// largura da B.Fer.Projeto    

    static boolean bJanelaAtiva = true;					// Informa sistema que janela esta ativa

    // Form-Negocios
    static int FrmNegocioBfAddCol = 1;
    static int FrmNegocioBfAddLin = (iAltPadraoBfBtn + 1);    		
   	int FrmNegocioBfAddLarg = (int)(iTelaLarg*0.5);						// O que sobrar da barra de Botoes

   	
    int bfNegPlanFiltroLin = FrmNegocioBfAddLin + iAltPadraoBF;; 							// Linha padrão
    int bfNegPlanFiltroCol = 1; //bfTabColIni;					// Coluna inicial do Filtro
  
   	static int FrmNegocioBfTabColIni = 1;
    int FrmNegocioBfTabLinIni = bfNegPlanFiltroLin + (iAltPadraoBF*2);   		
   	int FrmNegocioLargTabForm = (int)(iTelaLarg * 0.99);   	
	int FrmNegocioAltTabForm = (int)(iTelaAlt * 0.7);
 
		
    /***************************************************************************************************************************************/
    // Form-Plan set2016
    static double dZoomTela = 1.0;				// Percentual do tamanho da tela para FormPlanilha
    int iLargTelaForm =(int)(iTelaLarg * dZoomTela);		
    int iAltTelaForm = (int)(iTelaAlt * dZoomTela);

    static double dZoomTab = dZoomTela - 0.5;				// Percentual do tamanho da tabela para FormPlanilha
    int iLargTabForm = iLargTelaForm - 50;		//(int)(iTelaLarg * dZoomTab) + 200;		
    int iAltTabForm = (int)(iTelaAlt * dZoomTab);
    int bfTabColIni = (int)((iLargTelaForm - iLargTabForm)/2) - 7;	// Pos.Col.Ini. Centraliza tabela dentro do form

    /***************************************************************************************************************************************/
    // Posições das Sub-Bar.fer coordenadas - Em desuso, uniu-se a Filtro  
    /* Não esta em uso
    int bfCoordLin = (iAltPadraoBfBtn * 3) + 1;				// Linha padrão
    
    static int bfCoordFilCol = 1;							// Coluna inicial do Filtro    
    static int bfCoordFilLarg = 190;						// Largura do Filtro
    
    static int bfCoordPosCol = 191;							// Coluna inicial do Posição (1, 1)    
	static int bfCoordPosLarg = 150;						// Largura do Posição		(A1)
	
    static int bfCoordTitCol = 342;							// Coluna inicial do Tiulo    
	static int bfCoordTitLarg = 200;						// Largura do Titulo
	
	static int bfCoordCampoCol = 543;						// Coluna inicial do Campo  
	static int bfCoordCampoLarg = 730;						// Largura do Campo
	*/
    
}	// Final da class
