.model tiny
.code 
org 100h

local @@

Start: 
        
        mov ax, 1000d                 ; entered number
        call AddressVideo
        call Con2bin
        call MakeTabVideo
        mov ax, 2000d  
        call Con2bin
        call MakeTabVideo
        mov ax, 20d 
        call Con2bin
        ret

Con2bin    proc   ; converts into binary

            mov cx, 16                    ; counter (8 bits)

@@PRINT:  
        shl ax, 1                     ; shift to left
        jc @@ONE                        ; jmp if cf is 1
        jnc @@ZERO                      ; jmp if cf is 0 
@@OUT_PROG:
        loop @@PRINT  
        ret

@@ZERO:   mov word ptr es:[bx], 4e30h
        add bx, 2
        jmp @@OUT_PROG

@@ONE:    mov word ptr es:[bx], 4e31h
        add bx, 2
        jmp @@OUT_PROG

        ret 
        endp

AddressVideo  proc     ; addresses video memmory

                mov bx, 0b800h                ;
                mov es, bx                    ;
                xor bx, bx                    ; 

                ret
                endp

MakeTabVideo proc       ; makes tab in video memmory

             add bx, 8

             ret    
             endp


end Start
