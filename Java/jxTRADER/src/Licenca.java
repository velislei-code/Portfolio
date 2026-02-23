/*
 * by: Treuk, Velislei A
 *   email: velislei@gmail.com
 *   Copyright(c) 2016-2018
 *   Sistemas de testes de portas ADSL em Massa 
 *   Projeto, excecução p/ Oi S/A
 *   All Rights Reserveds       
 */
 
/*
 * Gerencia rotina de licença do software
 * 1 - Na primeira execução do programa o mesmo vai buscar no cfg.ini o code de autorização
 * 2 - Se este code não existir, o sistem produz uma chave combinando com o SN-HD
 * 3 - Esta rotina de produção de Chave tera validade de 1 mes, para evitar q usuario delete cfg.ini
 * 		- Caso a pasta(completa) do software seja copiada para outra máquina, 
 * 		a chave copiada(cfg.ini) nao vai validadr o SN-HD
 *  	- Se deletar o cfg.ini, não vai rodar E, 
 *  	  se tiver dentro da validade(não informada ao user) produz a chave
 *  		caso contrario bloqueia	
 *  	- 
 */
public class Licenca {

	// Ctrl status da licença do software
	static boolean bLicenca = true;
	public void fixeLicenca(boolean bL){ bLicenca = bL; }
	public boolean pegueLicenca(){ return bLicenca; }
	
	
	
}
