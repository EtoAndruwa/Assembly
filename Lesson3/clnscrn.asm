.model tiny
.code 
org 100h

local @@

Start: 
          call ClrScrn                  ; cleans the screen 
          ret

;-------------------------------------------------------------------------;
;ClrScrn                                                                  ;  
;-------------------------------------------------------------------------;
;Entry:     es, cx, bx                                                    ;
;                                                                         ;
;Exit:      ----                                                          ;
;Expected:  cx = number of loops                                          ;            
;Destroys:  es, bx, cx                                                    ;      
;-------------------------------------------------------------------------;  

ClrScrn   proc
          mov bx, 0b800h                ; puts address of the video memmory to the reg bx
          mov es, bx                    ; puts 0b800h as extra segment
          xor bx, bx                    ; deletes value form bx
	
	      mov cx, 80*25                 ; counter = words on the screen
@@BLACK:  mov word ptr es:[bx], 0003h   ; puts character to the [bx] position on the screen on video memmory 
	      add bx, 2                     ; adds 2 bytes to the memmory address
	      loop @@BLACK                  ; loops

          xor bx, bx                    ; deletes value from bx
          xor cx, cx                    ; deletes value from cx

          ret                           ; exits from the function
          endp 

end       Start
