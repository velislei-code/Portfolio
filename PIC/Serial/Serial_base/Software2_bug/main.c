/*
 * by: Treuk, Velislei A
 *   email: velislei@gmail.com
 *   Copyright(c) 2021-2022
 *   CTRL da porta serial com PIC
 *   All Rights Reserveds
 */
#include <main.h>

#include <lcd.c>

char error, byte_read;

void main()
{
    ANSEL = 0; // Configure AN pins as digital
    ANSELH = 0;

    UART1_Init(9600); // Initialize UART module at 9600 bps
    Delay_ms(100);    // Wait for UART module to stabilize

    UART1_Write_Text("Start");
    UART1_Write(10);
    UART1_Write(13);

    while (1)
    { // Endless loop
        if (UART1_Data_Ready())
        {                           // If data is received,
            uart_rd = UART1_Read(); // read the received data,
            UART1_Write(uart_rd);   // and send data via UART
        }
    }
}
