PSECT udata_acs
Contador1: DS 1		    ;RESERVA 8 bits (1 bytes)
Contador2: DS 1    

PSECT code

;Autor: RAMOS PALACIOS, JUAN ALEJANDRO -----
;Fecha:_14/01/2023
;programa: MPLAB X IDE v6.00----compilador xc8
;----PIC18F57Q84-----------------------------    
;------A UNA FRECUENCIA DE 4MHZ, SE CALCULA LOS SIGUIENTES TIEMPOS ESTABLECIDOS

 
    
;250ms -->(
delay_250ms:                ; 
    MOVLW   250             ; 
    MOVWF   Contador2,0     ; 
   ;T=(6+4k)us              ; 
Ext_Loop:
    MOVLW   249             ;
    MOVWF   Contador1,0     ;
Int_Loop:
    NOP                     ; 
    DECFSZ Contador1,1,0    ; 
    GOTO Int_Loop           ; 
    DECFSZ  Contador2,1,0
    GOTO  Ext_Loop
    RETURN		    ;




