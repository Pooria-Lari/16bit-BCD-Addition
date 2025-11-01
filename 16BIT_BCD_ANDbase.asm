        .MODEL SMALL
        .STACK 64
        .DATA
RESULT_BITS DW ?
REPORT      DB 0 
        
        .CODE
MAIN PROC FAR
          MOV AX,@DATA
          MOV DS,AX 
          
          

;CLEAR REGESTERS---------------------------------    
          
; AND BASE ALGORITM
XOR AX,AX ; AH FOR CHEACK FLAG
XOR BX,BX ; 16 BIT NUMBER 1
XOR DX,DX ; 16 BIT NUMBER 2
MOV CL,0  ; COUNTER LABELS
XOR CH,CH
; AL,CH IS FREE TO USE FOR ALGORITM
;------------------------------------------------    
                                                  
;PROCESS-----------------------------------------    
PROCESS:
    MOV BX,5057H
    MOV DX,5165H
    ADD BX,DX
     
    
    CMP CL,0
    JZ  CHEACK_000XH  
    
    CMP CL,1
    JZ  CHEACK_00X0H    
    
    CMP CL,2
    JZ  CHEACK_0X00H

    CMP CL,3
    JZ  CHEACK_X000H    
    
    
    AND AH, 1H
    OR  REPORT, AH  
   
    
    MOV AH,CH
    MOV RESULT_BITS, AX
    
    
    
    JMP END_PROCESS       
;------------------------------------------------     
                   
;CHEACK_000XH------------------------------------    
CHEACK_000XH:

    MOV CL,1
    
    AND BX,000FH    
    CMP BX,0009H
    
    JA  D0_GREATER_THAN_9
    JBE D0_LESS_OR_EQUL_9
                  
D0_GREATER_THAN_9:
    ADD BX,6H      ;ADD 6
    AND BX,1FH     ;CARRY
    
    ADD AL,BL      ;ADD TO DATA



    JMP PROCESS 
D0_LESS_OR_EQUL_9:  
    ADD AL,BL   ;ADD TO DATA    
    
    JMP PROCESS      
          
;------------------------------------------------
                            
;CHEACK_00X0H------------------------------------    
CHEACK_00X0H:

    MOV CL,2
    
    AND BX,00F0H    
    CMP BX,0090H
    
    JA  D3_GREATER_THAN_9
    JBE D3_LESS_OR_EQUL_9
                  
D3_GREATER_THAN_9:

    ADD BX,0060H      ;ADD 6
    AND BX,01F0H     ;CARRY

    
    ADD AL,BL  ;ADD TO DATA
    ADD CH,BH


    JMP PROCESS 
D3_LESS_OR_EQUL_9:  
             
    ADD AL,BL  ;ADD TO DATA    
    JMP PROCESS                
;------------------------------------------------ 

;CHEACK_0X00H------------------------------------    
CHEACK_0X00H:

    MOV CL,3
    
    AND BX,0F00H    
    CMP BX,0900H
    
    JA  D7_GREATER_THAN_9
    JBE D7_LESS_OR_EQUL_9
                  
D7_GREATER_THAN_9:

    ADD BX,0600H    ;ADD 6
    AND BX,1F00H    ;CARRY                  
    ADD CH,BH       ;ADD TO DATA
    JMP PROCESS                 
    
D7_LESS_OR_EQUL_9:               
    ADD CH,BH  ;ADD TO DATA    
    JMP PROCESS                
;------------------------------------------------

;CHEACK_X000H------------------------------------    
CHEACK_X000H:

    MOV CL,4
    
    AND BX,0F000H    
    CMP BX, 9000H
    
    JA  D11_GREATER_THAN_9
    JBE D11_LESS_OR_EQUL_9
                  
D11_GREATER_THAN_9:

    ADD BX, 6000H    ;ADD 6 
    LAHF             ;LOAD AH FLAG
    AND BX,0F000H    ;CARRY        
    ADD CH,BH       ;ADD TO DATA 
   ;STC             ;OVERFLOW CARRY
  
    JMP PROCESS                 
    
D11_LESS_OR_EQUL_9:               
    ADD CH,BH  ;ADD TO DATA    
    JMP PROCESS                
;------------------------------------------------       
       
       
       
;END_PROCESS-------------------------------------     
END_PROCESS:                                         
              
          MOV AH,4CH
          INT 21H
MAIN ENDP
        END MAIN  
        
        



