//package mtaview;
/*
 * by: Treuk, Velislei A
 *   email: velislei@gmail.com
 *   Copyright(c) 2014-2016
 *   Sistemas de testes de portas ADSL em Massa 
 *   Projeto, excecução p/ Oi S/A
 *   All Rights Reserveds       
 */
public class Bugs {
	
	/*
	 * Lista de Bugs no software:
	 * 
	 * 1 - Aplico filtro, lista 4 portas, exec.testes, varre as 4 portas ok, qdo pe�o continuar 
	 *     como n�o h� outras portas no filtro ele roda uma seq.de teste mas nada aparece e 
	 *     fico perdido, apos 1min ele acorda(termina seq.) e informa que n�o portas a testar; 
	 *     
	 * 2 - Ao salvar, se n�o colocar *.mta ele salva o arquivo sem *.mta;   [RESOLVIDO ! - 20FEV]
	 * 3 - O set Simular nao esta salvando o config.ini, so lendo o mesmo:
	 * 		em: C:\Liwix\Projetos\Eclipse\mtaView\src\config.ini
	 * 4 - Ao retornar um testes que ja teve algumas portas testadas o sistema retorna no 0, deveria continuar de onde paraou
	 * 5 - Teste Ping: N�o esta funcionando, sempre retorna True, mesmo qdo ip n�o existe
	 * 6 - Qdo Inicio com abrir->arq.mta->iniciar testes o sistema trava(Deve estar faltando inicar var)
	 * 7 - Led�s do Gr�ficos continuam verdes de uma seq. para outra
	 */

}
