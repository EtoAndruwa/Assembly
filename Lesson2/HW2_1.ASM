.model tiny
.code
org 100h


Start:
		mov bx, 0b800h					; address of video memmory to the bx reg
		mov es, bx						; 0b800h to extra segment
		xor bx, bx						; deletes the value from bx
		
		mov cx, 80*25					; total number of chars on the screen
BLINK:  mov word ptr es:[bx], 08c03h	; puts the word with char ASCII code and its color to the video  memmory
		add bx, 2						; adds 2 bytes to the bx
		loop BLINK						; loops

		mov ax, 4c00h					; Terminate program function code in reg ax
		int 21h							; Dos function call 

end 	Start