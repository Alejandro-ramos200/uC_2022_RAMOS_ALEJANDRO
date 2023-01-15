;Autor: RAMOS PALACIOS, JUAN ALEJANDRO-----
;Fecha:_14/01/2023
;Programa: MPLAB X IDE v6.00----compilador xc8
;Funcionamiento:Desarrollar un programa que permita realizar un corrimiento de leds conectados al puerto C, con
;un retardo de 500 ms en un numero de corrimientos pares y un retardo de 250ms en un
;numero de corrimientos impares. El corrimiento inicia cuando se presiona el pulsador de la placa una vez y se detiene cuando se vuelve a
;presionar. Agregar dos leds en los pines RE0 y RE1, para visualizar cuando se da el corrimiento par o impar.
;----PIC18F57Q84-----------------------------    
PROCESSOR 18F57Q84
#include "Config_Bits.inc"   /*config statements should precede project file includes.*/
#include <xc.inc>
#include "Retardos.inc"
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT CODE
Main:
    CALL Config_OSC,1
    CALL Config_Port,1
    
    
Loop_Button:
    BTFSC PORTA,3,0
    GOTO  Loop_Button
RUN_LED1:		    
    
;CORRIMIENTO IMPAR
    MOVLW  00000000B
    MOVWF   LATE,1
    MOVLW  00000001B
    MOVWF   LATE,1
    BCF	  LATC,7,1
    BSF	  LATC,0,1
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO RUN_LED2
STOP_LED1:
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO  STOP_LED1     
RUN_LED2:
    BCF	  LATC,0,1
    BSF	  LATC,1,1
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO RUN_LED3
STOP_LED2:
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO  STOP_LED2   
RUN_LED3:
    BCF	  LATC,1,1
    BSF	  LATC,2,1
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO RUN_LED4
STOP_LED3:
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO  STOP_LED3   
RUN_LED4:
    BCF	  LATC,2,1
    BSF	  LATC,3,1
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO RUN_LED5
STOP_LED4:
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO  STOP_LED4 
RUN_LED5:
    BCF	 LATC,3,1
    BSF	  LATC,4,1
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO RUN_LED6
STOP_LED5:
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO  STOP_LED5  
RUN_LED6:
    BCF	 LATC,4,1
    BSF	  LATC,5,1
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO RUN_LED7
STOP_LED6:
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO  STOP_LED6  
RUN_LED7:
    BCF	 LATC,5,1
    BSF	  LATC,6,1
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO RUN_LED8
STOP_LED7:
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO  STOP_LED7 
RUN_LED8:
    BCF	 LATC,6,1
    BSF	  LATC,7,1
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO RUN_LED1I
STOP_LED8:
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO  STOP_LED8
    GOTO RUN_LED1I
   
RUN_LED1I:		
    
;CORRIEMIENTO PAR
    MOVLW  00000000B
    MOVWF   LATE,1
    MOVLW  00000010B
    MOVWF   LATE,1
    BCF	  LATC,7,1
    BSF	  LATC,0,1
    CALL delay_250ms
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO RUN_LED2I
STOP_LED1I:
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO  STOP_LED1I     
RUN_LED2I:
    BCF	  LATC,0,1
    BSF	  LATC,1,1
    CALL delay_250ms
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO RUN_LED3I
STOP_LED2I:
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO  STOP_LED2I   
RUN_LED3I:
    BCF	  LATC,1,1
    BSF	  LATC,2,1
    CALL delay_250ms
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO RUN_LED4I
STOP_LED3I:
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO  STOP_LED3I   
RUN_LED4I:
    BCF	  LATC,2,1
    BSF	  LATC,3,1
    CALL delay_250ms
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO RUN_LED5I
STOP_LED4I:
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO  STOP_LED4I 
RUN_LED5I:
    BCF	 LATC,3,1
    BSF	  LATC,4,1
    CALL delay_250ms
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO RUN_LED6I
STOP_LED5I:
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO  STOP_LED5I  
RUN_LED6I:
    BCF	 LATC,4,1
    BSF	  LATC,5,1
    CALL delay_250ms
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO RUN_LED7I
STOP_LED6I:
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO  STOP_LED6I  
RUN_LED7I:
    BCF	 LATC,5,1
    BSF	  LATC,6,1
    CALL delay_250ms
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO RUN_LED8I
STOP_LED7I:
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO  STOP_LED7I 
RUN_LED8I:
    BCF	 LATC,6,1
    BSF	  LATC,7,1
    CALL delay_250ms
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO RUN_LED1
STOP_LED8I:
    CALL delay_250ms
    BTFSC PORTA,3,0
    GOTO  STOP_LED8I
    GOTO RUN_LED1    
    
    
; SALTAMOS A LAS SUBRRUTINAS 
Config_OSC:		;Se configura el oscilador interno a una frecuencia de 4MHz
    BANKSEL OSCCON1
    MOVLW   0x60	;seleccionamos el bloque del oscilador interno(HFINTOSC) con un div:1
    MOVWF   OSCCON1,1	;cargo el valor al Osc
    MOVLW   0x02
    MOVWF   OSCFRQ,1	;Seleccionamos la frecuenta del Oscilador(4MHz)
    RETURN
    
Config_Port:		;Configuramos los puertos del uC -> PORT-LAT-ANSEL-TRIS
    
    ;Configuracion del puertos C como salida
    ;Como sera salida el LATC pondremos CLRF para que los leds inicien en cero
    BANKSEL PORTC	;En este uC port,lat,ansel y tris estan en un mismo banco
    SETF    PORTC,1	;PORTC<7:0> = 1 , Me mostrara los LEDS ON
    CLRF    LATC,1	;LATC<7:0>  = 0	, Estado inicial de LEDS -> OFF
    CLRF    ANSELC,1	;Puerto ->   digital
    CLRF    TRISC,1	;Puerto -> salida
    
    
    ;Configuracion del puerto E
    BANKSEL PORTE
    SETF    PORTE,1
    CLRF    LATE,1
    CLRF    ANSELE,1	;Puerto ->   digital
    CLRF    TRISE,1	;Puerto -> salida
    
    ;Configuracion del button -> PIN RA3:
    BANKSEL PORTA
    CLRF    PORTA,1	;EL LAT ya no se pone porque no escribire nada, PORTA<7:0> = 0
    CLRF    ANSELA,1	;ANSELF<7:0>  -> puerto A es digital
    BSF	    TRISA,3,1	;Configuramos el pin RA3 como entrada ya que pulsaremos el button
    BSF	    WPUA,3,1	;Activamos la resistencia Pull Up del pin RA3
    RETURN
    
END resetVect