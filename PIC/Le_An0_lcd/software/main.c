/*
 * by: Treuk, Velislei A
 *   email: velislei@gmail.com
 *   Copyright(c) 2021-2022
 *   Sistemas de controle a esteira de caminhada com LCD
 *   All Rights Reserveds
 */

#include <main.h>

#include <lcd.c>

// -- Decla vari�veis ---
int16 analogico;             // Var para pegar 10bits(0-1023) da entrada analogica(AN0)-leitura de tens�o de sa�da
unsigned short duty1, duty2; // Var do PWM

// --- Declara fun��es ---
int16 Volts();

void main()
{
   setup_adc_ports(sAN0);
   setup_adc(ADC_CLOCK_INTERNAL);

   lcd_init();

   printf(lcd_putc, "\f Voltimetro PIC"); // imprimir no lcd (\f limpa o lcd)
   delay_ms(50);                          // atualiza��o de tela a cada X ms

   while (TRUE)
   {
      set_adc_channel(0); // Config qual entrada analogica sera lida
      delay_us(10);       // tempo para sele��o
      // analogico = read_adc();       // leitura da entrada analogica

      printf(lcd_putc, "\f %lu volts \n \r", volts()); // imprimir no lcd (\f limpa o lcd)
      delay_ms(50);                                    // atualiza��o de tela a cada X ms
   }
}

int16 volts()
{

   analogico = read_adc();                  // leitura da entrada analogica
   int16 t_Volts = (analogico * 40) / 1023; // 400 = 40.0 Volt(tens�o m�x, com 1 decimal) - Converte valor para Volts(1023 Resolu��o de 10 bits do conversor AD)

   /* caso se tenha um Volt�metro at� 60V:
    * Reprojetar o divisor de tens�o p/ 60V
    * Alterar calc para:
    * t_Volts = (store*600)/1023;
    */

   return (t_Volts);
}
