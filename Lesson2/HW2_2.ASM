.model tiny
.code
org 100h

Start:  	mov bx, 0b800h 				; address of video memmory to the bx reg
			mov es, bx					; 0b800h to extra segment
			xor bx, bx					; deletes the value from bx

			mov cx, 80*25				; total number of chars on the screen
			mov dx, 4c41h				; ASCII code of the char and its color to the reg dx

ALL_COLOR:	mov word ptr es:[bx], dx	; puts the word with char ASCII code and its color to the video memmory stored in reg dx
			add bx, 2					; adds 2 bytes to the bx	
			inc dh						; increases the value stored in dh (changes color and background)
			loop ALL_COLOR				; loops

			mov ax, 4c00h				; Terminate program function code in reg ax
			int 21h						; Dos function call

end			Start