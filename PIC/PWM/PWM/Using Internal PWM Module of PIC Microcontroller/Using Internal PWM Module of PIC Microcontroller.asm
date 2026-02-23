
_main:

;Using Internal PWM Module of PIC Microcontroller.c,2 :: 		void main()
;Using Internal PWM Module of PIC Microcontroller.c,4 :: 		short current_duty_1  = 16; // initial value for current_duty_1
	MOVLW      16
	MOVWF      main_current_duty_1_L0+0
	MOVLW      16
	MOVWF      main_current_duty_2_L0+0
;Using Internal PWM Module of PIC Microcontroller.c,7 :: 		TRISD = 0xFF;
	MOVLW      255
	MOVWF      TRISD+0
;Using Internal PWM Module of PIC Microcontroller.c,8 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;Using Internal PWM Module of PIC Microcontroller.c,10 :: 		PWM1_Init(5000);  //Initialize PWM1
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      99
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;Using Internal PWM Module of PIC Microcontroller.c,11 :: 		PWM2_Init(5000);  //Initialize PWM2
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      99
	MOVWF      PR2+0
	CALL       _PWM2_Init+0
;Using Internal PWM Module of PIC Microcontroller.c,13 :: 		PWM1_Start();  // start PWM1
	CALL       _PWM1_Start+0
;Using Internal PWM Module of PIC Microcontroller.c,14 :: 		PWM2_Start();  // start PWM2
	CALL       _PWM2_Start+0
;Using Internal PWM Module of PIC Microcontroller.c,16 :: 		PWM1_Set_Duty(current_duty_1); // Set current duty for PWM1
	MOVF       main_current_duty_1_L0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;Using Internal PWM Module of PIC Microcontroller.c,17 :: 		PWM2_Set_Duty(current_duty_2); // Set current duty for PWM2
	MOVF       main_current_duty_2_L0+0, 0
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;Using Internal PWM Module of PIC Microcontroller.c,19 :: 		while (1)        // endless loop
L_main0:
;Using Internal PWM Module of PIC Microcontroller.c,21 :: 		if (!RD0_bit)   // if button on RD0 pressed
	BTFSC      RD0_bit+0, 0
	GOTO       L_main2
;Using Internal PWM Module of PIC Microcontroller.c,23 :: 		Delay_ms(40);
	MOVLW      104
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	NOP
;Using Internal PWM Module of PIC Microcontroller.c,24 :: 		current_duty_1++;  // increment current_duty_1
	INCF       main_current_duty_1_L0+0, 1
;Using Internal PWM Module of PIC Microcontroller.c,25 :: 		PWM1_Set_Duty(current_duty_1);  //Change the duty cycle
	MOVF       main_current_duty_1_L0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;Using Internal PWM Module of PIC Microcontroller.c,26 :: 		}
L_main2:
;Using Internal PWM Module of PIC Microcontroller.c,28 :: 		if (!RD1_bit)               // button on RD1 pressed
	BTFSC      RD1_bit+0, 1
	GOTO       L_main4
;Using Internal PWM Module of PIC Microcontroller.c,30 :: 		Delay_ms(40);
	MOVLW      104
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	NOP
;Using Internal PWM Module of PIC Microcontroller.c,31 :: 		current_duty_1--;  // decrement current_duty_1
	DECF       main_current_duty_1_L0+0, 1
;Using Internal PWM Module of PIC Microcontroller.c,32 :: 		PWM1_Set_Duty(current_duty_1);
	MOVF       main_current_duty_1_L0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;Using Internal PWM Module of PIC Microcontroller.c,33 :: 		}
L_main4:
;Using Internal PWM Module of PIC Microcontroller.c,35 :: 		if (!RD2_bit)     // if button on RD2 pressed
	BTFSC      RD2_bit+0, 2
	GOTO       L_main6
;Using Internal PWM Module of PIC Microcontroller.c,37 :: 		Delay_ms(40);
	MOVLW      104
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	NOP
;Using Internal PWM Module of PIC Microcontroller.c,38 :: 		current_duty_2++;    // increment current_duty_2
	INCF       main_current_duty_2_L0+0, 1
;Using Internal PWM Module of PIC Microcontroller.c,39 :: 		PWM2_Set_Duty(current_duty_2);
	MOVF       main_current_duty_2_L0+0, 0
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;Using Internal PWM Module of PIC Microcontroller.c,40 :: 		}
L_main6:
;Using Internal PWM Module of PIC Microcontroller.c,42 :: 		if (!RD3_bit)       //if button on RD3 pressed
	BTFSC      RD3_bit+0, 3
	GOTO       L_main8
;Using Internal PWM Module of PIC Microcontroller.c,44 :: 		Delay_ms(40);
	MOVLW      104
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_main9:
	DECFSZ     R13+0, 1
	GOTO       L_main9
	DECFSZ     R12+0, 1
	GOTO       L_main9
	NOP
;Using Internal PWM Module of PIC Microcontroller.c,45 :: 		current_duty_2--;   // decrement current_duty_2
	DECF       main_current_duty_2_L0+0, 1
;Using Internal PWM Module of PIC Microcontroller.c,46 :: 		PWM2_Set_Duty(current_duty_2);
	MOVF       main_current_duty_2_L0+0, 0
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;Using Internal PWM Module of PIC Microcontroller.c,47 :: 		}
L_main8:
;Using Internal PWM Module of PIC Microcontroller.c,49 :: 		Delay_ms(10);      // slow down change pace a little
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	NOP
;Using Internal PWM Module of PIC Microcontroller.c,50 :: 		}
	GOTO       L_main0
;Using Internal PWM Module of PIC Microcontroller.c,51 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
