.model tiny
.code 
org 100h

local @@

Start:          call ClrScrn                ; clears the screen          
                mov ax, 2d                  ; coords y
                mov bx, 10d                 ; coords x
                mov  bp, 60d                ; width
                mov  si, 21d                ; height
                call PrintRamka             ; prints frame from coords (x,y) with height and width

                ret                         ; exits from program
            


       

;-------------------------------------------------------------------------;
;AddressVideo                                                             ;  
;-------------------------------------------------------------------------;
;Entry:     es, bx                                                        ;
;                                                                         ;
;Exit:      es = 0b800h                                                   ;
;Expected:  video memmory addresing                                       ;            
;Destroys:  es, bx                                                        ;      
;-------------------------------------------------------------------------;
AddressVideo    proc                        ; addresses video memmory

                mov bx, 0b800h              ; puts to bx address of video memmory
                mov es, bx                  ; movs bx's data to reg es
                xor bx, bx                  ; deletes value form bx

                ret
                endp                        ; end of the function 

;-------------------------------------------------------------------------;
;ClrScrn                                                                  ;  
;-------------------------------------------------------------------------;
;Entry:     es, cx, bx                                                    ;
;                                                                         ;
;Exit:      ----                                                          ;
;Expected:  cx = number of loops                                          ;            
;Destroys:  es, bx, cx                                                    ;      
;-------------------------------------------------------------------------;  

ClrScrn         proc
                call AddressVideo           ; calls function which puts to reg es address of video memmory
	
                mov cx, 80 * 25             ; counter = words on the screen

@@BLACK:        mov word ptr es:[bx], 0003h ; puts character to the [bx] position on the screen on video memmory 
	            add bx, 2                   ; increases bx to 2 bytes
	            loop @@BLACK                ; loops BLACK

                ret                            
                endp                        ; end of the function

;-------------------------------------------------------------------------;
;PrintRamka                                                               ;  
;-------------------------------------------------------------------------;
;Entry:    cx, si                                                         ;
;                                                                         ;
;Exit:     ------                                                         ;
;Expected: printed frame on new coords                                    ;           
;Destroys: cx                                                             ;      
;-------------------------------------------------------------------------;
PrintRamka      proc
                call GetNewCoords           ; puts the memmory address in se in the right place according to the new coords
                call PrintTop               ; prints the top part of the frame

                mov cx, si                  ; puts number of lines into counter
                dec cx                      ; 
                dec cx                      ; makes cx - 2(without top and bottom parts)

@@PrintAllVer:  call PrintVer               ; prints the central parts of the frame
                loop @@PrintAllVer          ; loops

                call PrintBot               ; prints the bottom part of the frame

                ret
                endp                        ; end of the function

;-------------------------------------------------------------------------;
;PrintVer                                                                 ;  
;-------------------------------------------------------------------------;
;Entry:    di, bx, bp, ax, cx                                             ;
;                                                                         ;
;Exit:     --------                                                       ;
;Expected: printed central part of the frame                              ;           
;Destroys: di, ax, cx, bx                                                 ;      
;-------------------------------------------------------------------------;
PrintVer        proc

                mov di, bx                  ; stores entering memmory address
                mov ax, bp                  ; puts width into reg ax
                dec ax                      ; 

                push bp                     ; saves value of bp reg to the stack 
                mov bp, 2                   ; puts multipler in bp
                mul bp                      ; ax now contains 2 * width
                pop bp                      ; gets the bp reg value from the stack

                mov word ptr es:[bx], 4ec3h ; prints right bracket

                add bx, ax                  ; shifts the memmory

                mov word ptr es:[bx], 4eb4h ; prints left bracket

                mov bx, 160                 ; shift to the next line from entering memmory address
                add di, bx                  ; sum of entering + shift
                xchg di, bx                 ; result now in bx

                ret
                endp                        ; end of the function

;-------------------------------------------------------------------------;
;PrintTop                                                                 ;  
;-------------------------------------------------------------------------;
;Entry:    ax, bx, cx, bp                                                 ;
;                                                                         ;
;Exit:     ---------                                                      ;
;Expected: printed top part of the frame                                  ;           
;Destroys: ax, cx, bx                                                     ;      
;-------------------------------------------------------------------------;
PrintTop        proc

                mov ax, bx                  ; stores entering memmory address
                mov cx, bp                  ; puts width to the counter
                dec cx                      ;
                dec cx                      ; makes cx - 2(angles)
                
                mov word ptr es:[bx], 4edah ; prints left top edge of the frame
                add bx, 2                   ; shifts to the next memmory cell

@@Print_line:   mov word ptr es:[bx], 4ec2h ; prints top central edge of the frame
                add bx, 2                   ; shifts to the next memmory cell
                loop @@Print_line           ; loops 

                mov word ptr es:[bx], 4ebfh ; prints top right edge of the frame

                mov bx, 160                 ; shift to the next line from entering memmory address
                add ax, bx                  ; sum of entering + shift
                xchg ax, bx                 ; result now in bx

                ret
                endp                        ; end of the function

;-------------------------------------------------------------------------;
;PrintBot                                                                 ;  
;-------------------------------------------------------------------------;
;Entry:    ax, bx, bp, cx                                                 ;
;                                                                         ;
;Exit:     ---------                                                      ;
;Expected: printed bottom part of the frame                               ;           
;Destroys: ax, cx, bx                                                     ;      
;-------------------------------------------------------------------------;
PrintBot        proc

                mov ax, bx                  ; stores entering memmory address
                mov cx, bp                  ; puts width to the counter
                dec cx                      ;
                dec cx                      ; makes cx - 2(angles)
                
                mov word ptr es:[bx], 4ec0h ; prints left bottom edge of the frame
                add bx, 2                   ; shifts to the next memmory cell

@@Print_line2:  mov word ptr es:[bx], 4ec1h ; prints bottom central edge of the frame
                add bx, 2                   ; shifts to the next memmory cell 
                loop @@Print_line2          ; loops

                mov word ptr es:[bx], 4ed9h ; prints bottom right edge of the frame

                ret 
                endp                        ; end of the function


;-------------------------------------------------------------------------;
;GetNewCoords                                                             ;  
;-------------------------------------------------------------------------;
;Entry:     di, ax, bx                                                    ;
;                                                                         ;
;Exit:      bx = the start in video memmory                               ;
;Expected:  -----                                                         ;            
;Destroys:  ax, bx, di                                                    ;      
;-------------------------------------------------------------------------;
GetNewCoords    proc
                
                mov di, 160     ; moves to the reg di width of one line
                mul di          ; multiples by the y coords in ax

                mov di, 2       ; 2 bytes multipler for x-coords
                xchg ax, bx     ; y-coords * multipler right now in bx (ax<->bx)
                mul di          ; ax contains x-coords * multipler

                add ax, bx      ; adds the x-coords * multipler coords to the y-coords * multipler coords (resul in ax)
                xchg ax, bx     ; changes values ax<->bx (result in bx)

                ret             ; exits from function
                endp

end             Start
