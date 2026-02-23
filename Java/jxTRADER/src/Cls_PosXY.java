/*
 * by: Treuk, Velislei A
 *   email: velislei@gmail.com
 *   Copyright(c) 2016-2018
 *   Sistemas de testes de portas ADSL em Massa 
 *   Projeto, excecução p/ Oi S/A
 *   All Rights Reserveds       
 */

/*********************************************************
 * Programando Jogos com Java
 * by Velislei A Treuk
 * Cls_PosXY Class
 **********************************************************/
class Cls_PosXY extends mtaView{
    
	public double iPosX, iPosY;
    
    Log objLog = new Log();
    
    Cls_PosXY(){
    	
    }
    //Contrutor de inteiros
    Cls_PosXY(int iPosX, int iPosY) {
        Mtd_FixeX(iPosX);
        Mtd_FixeY(iPosY);
    }
    
    //Contrutor de float
    Cls_PosXY(float iPosX, float iPosY) {
        Mtd_FixeX(iPosX);
        Mtd_FixeY(iPosY);
    }
    //Contrutor de double
    Cls_PosXY(double iPosX, double iPosY) {
        Mtd_FixeX(iPosX);
        Mtd_FixeY(iPosY);
    }
	
    //Mtd_PosX
    double Mtd_PosX() { return iPosX; }
    public void Mtd_FixeX(double iPosX) { this.iPosX = iPosX; }
    public void Mtd_FixeX(float iPosX) { this.iPosX = (double) iPosX; }
    public void Mtd_FixeX(int iPosX) { this.iPosX = (double) iPosX; }

    //Mtd_PosY
    double Mtd_PosY() { return iPosY; }
    public void Mtd_FixeY(double iPosY) { this.iPosY = iPosY; }
    public void Mtd_FixeY(float iPosY) { this.iPosY = (double) iPosY; }
    public void Mtd_FixeY(int iPosY) { this.iPosY = (double) iPosY; }
    
     
    
   
}

