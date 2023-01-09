PSECT udata_acs
Contador1: DS 1		    ;RESERVA 8 bits (1 bytes)
Contador2: DS 1    

PSECT code
 --------------------------------------------------------------------------------

;Autor: RAMOS PALACIOS, JUAN ALEJANDRO -----
;Fecha:_08/01/2023
;programa: MPLAB X IDE v6.00----compilador xc8
;----PIC18F57Q84-----------------------------    
;------A UNA FRECUENCIA DE 4MHZ, SE CALCULA LOS SIGUIENTES TIEMPOS ESTABLECIDOS
 --------------------------------------------------------------------------------
 
;10us 
Delay_10us:                  ;
    MOVLW   1                ;
    MOVWF   Contador1,0      ;
Ext_Loop:
    NOP                      ;
    DECFSZ Contador1,1,0     ;
    GOTO   Ext_Loop          ;
    RETURN                   ;
--------------------------------------------------------------------------------
;25us 
Delay_25us:                  ;
    MOVLW  6                 ;
    MOVWF  Contador,0        ;
    NOP                      ;
Ext_Loop:             
    DECFSZ Contador1,1,0     ;
    GOTO   Ext_Loop          ;
    RETURN                   ;
--------------------------------------------------------------------------------
;50us 
Delay_50us:                  ;
    MOVLW   11               ;
    MOVWF   Contador1,0      ;
Ext_Loop:
    NOP                      ;
    DECFSZ Contador1,1,0     ;
    GOTO   Ext_Loop          ;
    RETURN                   ;
--------------------------------------------------------------------------------
;100us 
Delay_100us:                 ;             
    MOVLW  31                ;
    MOVWF  Contador,0        ;
    NOP                      ;
Ext_Loop:             
    DECFSZ Contador1,1,0     ;
    GOTO   Ext_Loop          ;
    RETURN                   ;
--------------------------------------------------------------------------------
;200us 
Delay_200us:                 ;
    MOVLW  48                ;
    MOVWF  Contador,0        ;
    NOP                      ;
    NOP                      ;
Ext_Loop:
    NOP                      ;
    DECFSZ Contador1,1,0     ;
    GOTO   Ext_Loop          ;
    RETURN                   ;
--------------------------------------------------------------------------------
;250us 
Delay_250us:                 ;               
    MOVLW  81                ;
    MOVWF  Contador,0        ;
    NOP                      ;
Ext_Loop:             
    DECFSZ Contador1,1,0     ;
    GOTO   Ext_Loop          ;
    RETURN                   ;
--------------------------------------------------------------------------------
;500us 
Delay_500us:                 ;
    MOVLW  123               ;
    MOVWF  Contador,0        ;
    NOP                      ;
    NOP                      ;
Ext_Loop:
    NOP                      ;
    DECFSZ Contador1,1,0     ;
    GOTO   Ext_Loop          ;
    RETURN                   ;
--------------------------------------------------------------------------------
;1ms 
Delay_1ms:                   ; 
    MOVLW   1                ; 
    MOVWF   Contador2,0      ; 
   ;T=(6+4k)us               ; 
Ext_Loop:
    MOVLW   249              ;
    MOVWF   Contador1,0      ;
Int_Loop:
    NOP                      ; 
    DECFSZ Contador1,1,0     ; 
    GOTO Int_Loop            ; 
    DECFSZ  Contador2,1,0
    GOTO  Ext_Loop
    RETURN		     ;
--------------------------------------------------------------------------------
;5ms 
Delay_5ms:                   ; 
    MOVLW   5                ; 
    MOVWF   Contador2,0      ; 
   ;T=(6+4k)us               ; 
Ext_Loop:
    MOVLW   249              ;
    MOVWF   Contador1,0      ;
Int_Loop:
    NOP                      ; 
    DECFSZ Contador1,1,0     ; 
    GOTO Int_Loop            ; 
    DECFSZ  Contador2,1,0
    GOTO  Ext_Loop
    RETURN		     ;
--------------------------------------------------------------------------------
;10ms 
Delay_10ms:                  ; 
    MOVLW   10               ; 
    MOVWF   Contador2,0      ; 
   ;T=(6+4k)us               ; 
Ext_Loop:
    MOVLW   249              ;
    MOVWF   Contador1,0      ;
Int_Loop:
    NOP                      ; 
    DECFSZ Contador1,1,0     ; 
    GOTO Int_Loop            ; 
    DECFSZ  Contador2,1,0
    GOTO  Ext_Loop
    RETURN		     ;
--------------------------------------------------------------------------------
;25ms 
Delay_25ms:                  ; 
    MOVLW   25               ; 
    MOVWF   Contador2,0      ; 
   ;T=(6+4k)us               ; 
Ext_Loop:
    MOVLW   249              ;
    MOVWF   Contador1,0      ;
Int_Loop:
    NOP                      ; 
    DECFSZ Contador1,1,0     ; 
    GOTO Int_Loop            ; 
    DECFSZ  Contador2,1,0
    GOTO  Ext_Loop
    RETURN		     ;
--------------------------------------------------------------------------------
;50ms -->(
Delay_50ms:                  ; 
    MOVLW   50               ; 
    MOVWF   Contador2,0      ; 
   ;T=(6+4k)us               ; 
Ext_Loop:
    MOVLW   249              ;
    MOVWF   Contador1,0      ;
Int_Loop:
    NOP                      ; 
    DECFSZ Contador1,1,0     ; 
    GOTO Int_Loop            ; 
    DECFSZ  Contador2,1,0
    GOTO  Ext_Loop
    RETURN		     ;
--------------------------------------------------------------------------------
;100ms -->(
Delay_100ms:                 ; 
    MOVLW   100              ; 
    MOVWF   Contador2,0      ; 
   ;T=(6+4k)us               ; 
Ext_Loop:
    MOVLW   249              ;
    MOVWF   Contador1,0      ;
Int_Loop:
    NOP                      ; 
    DECFSZ Contador1,1,0     ; 
    GOTO Int_Loop            ; 
    DECFSZ  Contador2,1,0
    GOTO  Ext_Loop
    RETURN		    ;
--------------------------------------------------------------------------------
;200ms -->(
Delay_200ms:                ; 
    MOVLW   200             ; 
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
--------------------------------------------------------------------------------    
;250ms -->(
Delay_250ms:                ; 
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





