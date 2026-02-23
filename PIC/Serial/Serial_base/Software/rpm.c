/*
 * by: Treuk, Velislei A
 *   email: velislei@gmail.com
 *   Copyright(c) 2021-2022
 *   CTRL da porta serial com PIC
 *   All Rights Reserveds
 */

#INCLUDE < 16F1827.h>
// #INCLUDE <16F628A.h>

//--------------------------------------------//
// Config Geral
#FUSES INTRC_IO, NOWDT, NOMCLR
#USE DELAY(INTERNAL = 4M)
#include <lcd.c>

//--------------------------------------------//
// Config Pinos LCD-PIC
#define LCD_ENABLE_PIN PIN_B0
#define LCD_RS_PIN PIN_B1
#define LCD_RW_PIN PIN_B2
#define LCD_DATA4 PIN_B4
#define LCD_DATA5 PIN_B5
#define LCD_DATA6 PIN_B6
#define LCD_DATA7 PIN_B7

//--------------------------------------------//
// var�s de RPM(Hz)

int8 iPulsos, memPulsos;        // variable para almacenar datos del TMR0, de 8 bits( 0-255)
int varrePulsos;                // var que varre os pulsos de entrada
#int_timer0                     // interrupcion con timer 0
int iCiclos = 0, maxCiclos = 0; // Tempos de varredura
int iFreq = 0, iRpm = 0;

//--------------------------------------------//

void interrupcion()
{                // subrutina "interrupcion", puede llevar cualquier nombre
  set_timer0(0); // cada vez que se desborde el conteo "interrupcion" el contador se reinicie en cero
}

char valor; // variavel q recebe um valor da serial

void main()
{

  uart1_init(9600);         // inicia o modulo UART com velocidade de 9600bps
  delay_ms(10);             // espere 10ms para estabilizar
  lcd_init();               // inicia o LCD
  lcd_cmd(_LCD_CURSOR_OFF); // desliga o cursor do lcd

  while (1)
  {
    if (uart1_data_ready()) // se algum dado foi recebido
    {
      valor = uart1_read(); // salva o dado na variavel
      lcd_chr_CP(valor);    // exibe o caracter no lcd
    }
  }

  /*

     //-------------------------------------------------------------------------------------------------------------------------//
     // Rpm
     setup_timer_0(rtcc_ext_L_to_H|rtcc_div_1);   // contador de estados bajos a altos| usaremos un prescaler de 1
                                                  //si en caso pusieramos un prescaler de 2, cada dos pulsos los contaria como 1
                                                  // el prescaler divide la frecuencia...eje dos helices.
     set_timer0(0);                               //habilitamos la configuracio para que la iPulsos se inicie en cero
     enable_interrupts(int_timer0);               //habilitamos la interrupcion que hemos declarado
     enable_interrupts(GLOBAL);                   //habilitamos tambien de forma global

     //-------------------------------------------------------------------------------------------------------------------------//


     lcd_init();                               //configuracion para inicializar el trabajo en LCD



     WHILE (TRUE){

              //-------------------------------------------------------------------------------------------------------------------------//
              // RPM
              /* get_timer0(): faz a leitura de Pulsos de entrada em Timer0(RA4/T0CKI/CMP2)
               * Esta leitura gera numeros de 0 a 255
               * O que muda � o Tempo que leva, para ir de 0 a 255, cfe frequencia dos pulsos
               * 10hz leva 4X seg para ir de 0 a 255
               * 20hz leva 2X seg para ir de 0 a 255
               * 40hz leva 1X seg para ir de 0 a 255
               * No fim, dividimos 255 pelo numero de ciclos(processamento while) de tempo que leva para ir de 0 a 255
               * para obter a frequencia(+ ajuste-que tb depende do tipo pic e delay)
               * Delay 100ms, ajuste 10x, 200ms 5x, 1000ms 1x
               *


               iPulsos = get_timer0();      //"get_timer" captura la funcion del registro y lo guarda en la variable "iPulsos"
               delay_ms(1000);
               varrePulsos = iPulsos;       // se multiplica por 60, por que 1Hz=60 RPM

               if(iPulsos > memPulsos){ memPulsos = iPulsos; }   // Armazena Num pulsos maior
               else{ // Se for menor pq atingiu limite, e voltou a zero, ent�o exec...
                   maxCiclos = iCiclos;
                   iFreq = (255/iCiclos);      // Ajuste(1.25 P/ 16F628A E 5 P/ 16F1827 p/ delay 200ms[5*200ms=1000ms]),  p/ acertar tempo de varredura - que tb depende do delay
                   iRpm = iFreq*60;            // 1Hz = 60 RPM...Esta multiplica��o N�O ESTA FUNCIONANDO... verificar...
                   iCiclos = 0;
                   memPulsos = 0;

               }
               //-------------------------------------------------------------------------------------------------------------------------//

               lcd_gotoxy(1,1);
               printf(LCD_PUTC,"RPM= %3u, T=%3u \n\r %3uhz, %4uRpm", varrePulsos, maxCiclos, iFreq, iRpm); //muestra el conteo: %=configura la variable, 3=tres cifras, u=entera
               iCiclos++;    // Incrementa num. de ciclos While p/ medir tempo de leitura de frequencia

     }
     */
}
