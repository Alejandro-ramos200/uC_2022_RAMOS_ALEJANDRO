PROCESSOR 18F57Q84
#include "Bit_config.inc"    ;/config statements should precede project file includes./
#include <xc.inc>
;#include "RETARDOS.inc"
;------------------------------------------------------------------------------------------------------
;AUTOR: RAMOS PALACIOS, JUAN ALEJANDRO 
;FECHA:_30/01/2023
;GRUPO 06
;PROGRAMA: MPLAB X IDE v6.00----compilador xc8
;TARJETA: PIC18F57Q84
;FUNCIÓN: Cuando se presiona el Boton RA3 comienza el programa, y empienza el programa cuando se encienden los
;lados extremos (RC0 y RC7), luego RC1 y RC6 y así consecutivamente hasta que se encuenden RC3 y RC4 y se apagan
;todos los leds y empienza el programa de manera inversa.
;La secuencia se detiene cuando se presione otro pulsador externo conectado en el pin RB4 o hasta que el número de
;repeticiones sea. El retardo entre el encendido y apagado de los leds será de 250 ms.
;Otro pulsador externo conectado al RF2 reinicia toda la secuencia y apaga los leds.;Mientras no se active ninguna interrupción, el programa principal, realice un toggle del led de la placa cada 500 ms.

PSECT udata_acs		    ;SE UTILIZA ACCESS RAM  ACCESS RAM
offset: DS	1	    ;SE GUARDA DS EN ACCESS RAM
contador: DS	1	    ;SE GUARDA DS EN ACCESS RAM 
repetidor_5: DS	1           ;SE GUARDA DS EN ACCESS RAM
stop1: DS	1           ;SE GUARDA DS EN ACCESS RAM
Reset2: DS	1           ;SE GUARDA DS EN ACCESS RAM
Muestreo: DS 1              ;SE GUARDA DS EN ACCESS RAM
CONT1: DS 1                 ;SE GUARDA DS EN ACCESS RAM
CONT2: DS 1                 ;SE GUARDA DS EN ACCESS RAM
    
PSECT resetVect,class=CODE,reloc=2  
resetVect:
    GOTO Main  
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------   
PSECT ISRVectLowPriority,class=CODE,reloc=2    
    
;PRIORIDAD BAJA (INT0)
    
ISRVectLowPriority:
    
    MOVLW   0x00
    MOVWF   stop1,0
    MOVWF   Reset2,0
    MOVLW   0x05
    MOVWF   repetidor_5,0
    BTFSS   PIR1,0,0	    ;Consulta si se produce la INT0
    GOTO    Exit
    GOTO    Reload       
Exit:    
    RETFIE		    ;REGRESAR A LA INSTRUCCIÓN
        
PSECT ISRVectHighPriority,class=CODE,reloc=2  ;Codigo INT1, INT2
 
; ALTA PRIORIDAD
    
ISRVectHighPriority:
    BTFSC   PIR6,0,0	    ; ¿SE PRODUCE LA INT1?
    GOTO    STOP_LEDS
CLEAR_LEDS:
    BTFSC   PIR10,0,0
    BCF	    PIR10,0,0
    CLRF    LATC,1
    SETF    Reset2,0
Exit_Int12:
    RETFIE                  ;REGRESAR A LA INSTRUCCIÓN

;--------------------------------------------------------------------------------------------------------------------------------------------------------   
PSECT CODE  
Main:
    
    ;SE VA A SALTAR A LAS SUB-RUTINAS
    ;"CALL" SE UTILIZA PARA SALTOS EN SUB-RUTINAS
    
    CAll    Config_OSC,1   ;SE SALTA A LA CONFIGURACIÓN DEL OSCILADOR INTERNO
    CALL    Config_PORT,1  ;SE SALTA A LA CONFIGURACIÓN DE PUERTOS
    CALL    Config_PPS,1   ;SE SALTA A LA CONFIGURACIÓN DE PPS (PERIPHERAL PIN SELECT)
    CALL    Config_INT,1  ;SE SALTA A LA CONFIGURACIÓN DE LAS INTERRUPCIONES 

Led_uc:
    
    ;PRINCIPAL PROGRAMA
    
    CALL    delay_250ms
    CALL    delay_250ms    
    BSF	    LATF,3,0 
    CALL    delay_250ms
    CALL    delay_250ms
    BCF	    LATF,3,0
    GOTO    Led_uc

;----------------------------------------------------------------------------------------------------------------------------------------------
Reload:
    BCF	    PIR1,0,0	    ; SE LIMPIA EL "FLAG"
    MOVLW   0x0A	    ; SE DEFINE EL OFFSET 
    MOVWF   contador,0	    ; OFFSET (9 VECES EL CORRIMIENTO)
    MOVWF   offset,0	    ; VALOR INCIAL DE OFFSET=0
    GOTO    BUZON
    
BUZON:   
    BANKSEL PCLATU
    MOVLW   low highword(Table) ;DEL ACUMULADOR (W) AL REGISTRO(F) PCLATU
    MOVWF   PCLATU,1
    MOVLW   high(Table)
    MOVWF   PCLATH,1
    RLNCF   offset,0,0	    ;SE GUARDARÁ EN EL ACUMULADOR (W)
    CALL    Table
    BTFSC   Reset2,1,0
    GOTO    Exit
    BTFSC   stop1,1,0
    GOTO    Exit
    MOVWF   LATC,0
    MOVWF   Muestreo,0
    CALL    delay_250ms
    DECFSZ  contador,1,0
    GOTO    Nex_seq
    GOTO    SEC_5   

SEC_5:
    DECFSZ  repetidor_5,1,0
    GOTO    Reload
    GOTO    Exit
    
    
Nex_seq:
    INCF    offset,1,0
    GOTO    BUZON  

   
Table:
    ;SE PRESENTA A CONTINUACIÓN LA TABLA DEL CORRIMIENTEO DE LEDS
    
    ADDWF   PCL,1,0	    ;(w) + PCL  = (offset) + PCL
    RETLW   10000001B	    ;offset: 0
    RETLW   01000010B	    ;offset: 1
    RETLW   00100100B	    ;offset: 2
    RETLW   00011000B	    ;offset: 3
    RETLW   00000000B	    ;offset: 4
    RETLW   00011000B	    ;offset: 5
    RETLW   00100100B	    ;offset: 6
    RETLW   01000010B	    ;offset: 7
    RETLW   10000001B	    ;offset: 8
    RETLW   00000000B	    ;offset: 9
    RETURN  
    
;---------------------------------------------------------------------------------------------------------------------------------------------------
STOP_LEDS:
    BCF	    PIR6,0,0	    ;SE LIMPIA EL FLAG (RB0)
    MOVF    Muestreo,0,0
    MOVWF   LATC,1
    SETF    stop1,0
    GOTO    Exit_Int12

    
;SUB-RUTINAS: 
    
Config_OSC:
  ;SE VA A CONGIRUAR EL OSCILOSCOPIO
  
    BANKSEL OSCCON1
    MOVLW   0x60         ; DIVISIÓN=1
    MOVWF   OSCCON1,1
    MOVLW   0x02         ; FRECUENCIA DE 8 MHZ.
    MOVWF   OSCFRQ,1
    RETURN
    
Config_PORT:
   ;CONFIGURACION DE PUERTOS
   
    BANKSEL PORTF	; CONF. DE LED DEL MICROCONTROLADOR
    BCF	    PORTF,3,1   ; LEE CEROS
    BSF	    LATF,3,1    ;ESCRIBE UNOS
    CLRF    ANSELF,1    ;DIGITAL=0
    BCF	    TRISF,3,1;  ;SALIDA=0
    
    ;CONFIGURACION DE RF2 (BUTTON)
    
    BCF	    PORTF,2,1   ;PUEETO F SELECCIONAMOS (CERO)
    BSF	    TRISF,2,1   ; ENTRADA =1
    BSF	    WPUF,2,1    ; RESISTENCIA PULL UP (ACTIVA)

    ;CONFIGURACION DE RB4 (BUTTON)
    BANKSEL PORTB
    BCF    PORTB,4,1     ;PUERTO B 
    BCF    ANSELB,4,1    ;DIGITAL=0
    BSF     TRISB,4,1    ;ENTRADA=1
    BSF	    WPUB,4,1     ;RESISTENCIA PULL UP (ACTIVA)
       
    BANKSEL PORTA	 ;CONF. DEL BOTÓN A3 DEL MICROCONTROLADOR (RA3)
    BCF	    PORTA,3,1    ;LEE "0"
    CLRF    ANSELA,1     ;DIGITAL=0
    BSF	    TRISA,3,1    ;ENTRADA=1
    BSF	    WPUA,3,1     ; RESISTENCIA PULL UP (ACTIVA)
    
    BANKSEL PORTC	;CONF. DEL PUERTO C
    SETF    PORTC,1     ;LEE UNOS
    CLRF    LATC,1      ;ESCRIBE CEROS
    CLRF    ANSELC,1    ;DIGITAL=1
    CLRF    TRISC,1     ;SALIDA=0
    RETURN
       
Config_PPS:
    BANKSEL INT0PPS
    MOVLW   0x03
    MOVWF   INT0PPS,1	; VA DE "INT0 -> RA3"
    
    BANKSEL INT1PPS
    MOVLW   0x0C
    MOVWF   INT1PPS,1	;VA DE "INT1 -> RB4"
    
    BANKSEL INT2PPS
    MOVLW   0x2A
    MOVWF   INT2PPS,1	;VA DE "INT2 -> RF2"
    RETURN
    
    
Config_INT:
;   SECUENCIA PARA LA CONFIGURACIONES DE LA INTERRUPCIO:
;    1. SE DEFINIRÁ LAS PRIORIDADES
;    2. SE VA A CONFIGURAR LA INTERRUPCION
;    3. SE TIENE QUE LIMPIAR EL FLAG (PIR0)
;    4. SE HABLITARÁ LA INTERRUPCIÓN (PIE)
;    5. SE HABLITARÁ LAS INTERRUPCIONES GLOBALES (GIE)
    
    BSF	    INTCON0,5,0 ;INTCON0<IPEN> (HABILITA PRIORIDADES)
    BANKSEL IPR1
    BCF	    IPR1,0,1    ;IPR1<INT0IP> = 0 (INT0-BAJA PRIORIDAD)
    BSF	    IPR6,0,1    ;IPR6<INT1IP> = 1 (INT1-ALTA PRIORIDAD)
    BSF	    IPR10,0,1   ;IPR10<INT2IP> =1 (INT2-ALTA PRIORIDAD)
    
   ;CONF. INT0
    BCF	INTCON0,0,0 ; INTCON0<INT0EDG> = 0 (INT0/FLANCO DE BAJADA)
    BCF	PIR1,0,0    ; PIR1<INT0IF> = 0  (SE LIMPIA FLAG)
    BSF	PIE1,0,0    ; PIE1<INT0IE> = 1  (HABILITA INTERRUPCION EXT0)
    
    
   ;CONF. INT1
   
    BCF	INTCON0,1,0 ; INTCON0<INT1EDG> = 0 (INT0/FLANCO DE BAJADA)
    BCF	PIR6,0,0    ; PIR6<INT1IF> = 0  (SE LIMPIA FLAG)
    BSF	PIE6,0,0    ; PIE6<INT1IE> = 1  (HABILITA INTERRUPCION EXT1)
   
   
   
   ;CONF. INT2
   
    BCF	INTCON0,2,0 ; INTCON0<INT2EDG> = 0 (INT0/FLANCO DE BAJADA)
    BCF	PIR10,0,0    ; PIR10<INT2IF> = 0  (SE LIMPIA FLAG)
    BSF	PIE10,0,0    ; PIE10<INT2IE> = 1  (HABILITA INTERRUPCION EXT2)
    
   ;CONF. GLOBAL
   
    BSF	INTCON0,7,0 ; INTCON0<GIE/GIEH> = 1 (SE HABILITA INTERRUPCIONES DE FORMA GLOBAL)
    BSF	INTCON0,6,0 ; INTCON0<GIEL> = 1 (HABLITA INTERRUPCIONES DE BAJA PRIORIDAD)
    RETURN
    
delay_250ms:  
    
    MOVLW   250		    ;ACUMULADOR(W) = 250
    MOVWF   CONT2,0	    ;(CONTADOR 2) 
    
ext_250ms_a:	
    
    MOVLW   249		    ;ACUMULADOR(W) = 249
    MOVWF   CONT1,0	    ;(CONTADOR1) 
    
ext_250ms_b:
    
    NOP			   
    DECFSZ  CONT1,1,0       ;(K1)-1->(d), SALTA SI ES CERO
    GOTO    ext_250ms_b	    ;SALTO ETIQUETA   
    DECFSZ  CONT2,1,0       ;(K2)-1->(d), SALTA SI ES CERO
    GOTO    ext_250ms_a	    ;SALTO ETIQUETA
    RETURN		    		      


    
END resetVect


