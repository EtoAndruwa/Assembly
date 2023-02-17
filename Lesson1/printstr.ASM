
.model tiny
.code
org 100h

Start:  mov ah, 09h
        mov dx, offset Text
        int 21h

        mov ah, 4ch                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
        int 21h                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
       
.data
Text:   db 'Salam, Kirill!$'

end     Start
