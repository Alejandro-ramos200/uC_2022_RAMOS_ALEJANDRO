Processor 18F57Q84
#include "Config_Bits.inc"// config statements should precede project file includes.   
#include <xc.inc>
#include "Retardos.inc"
    
;Autor: RAMOS PALACIOS, JUAN ALEJANDRO -----
;Fecha:_15/01/2023
;programa: MPLAB X IDE v6.00----compilador xc8
;----PIC18F57Q84-----------------------------    
;FUNCIONAMIENTO: CORRE DEL 0 al 9 (SIN PRESIONAR),AL PRESIONAR CORRE LAS LETRAS, DEL A-F
resetvect:
    GOTO main
PSECT CODE
main:
    CALL config_osc,1 ; SALTAMOS A LA CONFIGURACIÓN DEL OSC.INTERNO
    CALL config_port,1; SALTAMOS A LA CONFIGURACIÓN DE LOS PUERTOS
    BTFSS LATA,3,0
    GOTO LETRA_A   ;NOS VA A LLEVAR A LA ETIQUETA "LETRA_A"
NUMERO_0:
    CALL Delay_250ms  ;
    CALL Delay_250ms  
    MOVLW 01000000B   
    MOVWF LATD,1      
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO LETRA_A
NUMERO_1:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 01111001B ;f
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO LETRA_A
NUMERO_2:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00100100B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO LETRA_A
NUMERO_3:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00110000B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO LETRA_A
NUMERO_4:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00011001B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO LETRA_A
NUMERO_5:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00010010B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO LETRA_A
NUMERO_6:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVlW 00000010B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO LETRA_A
NUMERO_7:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 01111000B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO LETRA_A
NUMERO_8:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00000000B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    GOTO LETRA_A
NUMERO_9:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00011000B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSS PORTA,3,0
    CALL LETRA_A
    GOTO NUMERO_0
LETRA_A:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00001000B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSC PORTA,3,0
    GOTO NUMERO_0
LETRA_B:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00000011B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSC PORTA,3,0
    GOTO NUMERO_0
LETRA_C:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 01000110B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSC PORTA,3,0
    GOTO NUMERO_0
LETRA_D:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00100001B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSC PORTA,3,0
    GOTO NUMERO_0
LETRA_E:
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00000100B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSC PORTA,3,0
    GOTO NUMERO_0
LETRA_F:
    
    CALL Delay_250ms
    CALL Delay_250ms
    MOVLW 00001110B
    MOVWF LATD,1
    CALL Delay_250ms
    CALL Delay_250ms
    BTFSC PORTA,3,0
    GOTO NUMERO_0
    GOTO LETRA_A
    
config_osc:
    BANKSEL OSCCON1
    MOVLW 0X60      ;SELECIONAMOS EL BLOQUE DEL OSCILADOR INTERNO CON UN DIV:1
    MOVWF OSCCON1,1
    BANKSEL OSCFRQ
    MOVLW 0x02      ;SELECIONAMOS UNA FRECUENCIA DE 8MHZ
    MOVWF OSCFRQ,1
    RETURN
    
config_port:
    BANKSEL PORTD
    SETF PORTD,1; PORTF=0
    SETF LATD,1; LATF<3>=1 , LED OFF 
    CLRF ANSELD,1; ANSELF <7:0> - PORTF DIGITAL 
    CLRF TRISD,1 ; RF3-> COMO SALIDA 
;CONFIGURANDO BOTÓN 
    BANKSEL PORTA    ;SELECCIONAMOS PUERTA A
    SETF PORTA,1 
    CLRF ANSELA,1    ;PORTA DIGITAL 
    BSF TRISA,3,1    ;RA3 COMO ENTRADA
    BSF WPUA,3,1     ;ACTIVAMOS LA RESISTENCIA PULL-UP DEL PIN RA3
    RETURN  
END resetvect





