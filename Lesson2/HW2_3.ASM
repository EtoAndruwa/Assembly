.model tiny
.code
org 100h


Start:  mov bx, 0b800h								; address of video memmory to the bx reg
		mov es, bx									; 0b800h to extra segment
		xor bx, bx									; deletes the value from bx

		mov byte ptr cl, ds:[80h] 					; number of elements in string from ds:[80h] stored in cl
		dec cx
		mov ax, 0d   								; element index stored in ax
		mov dh, 31d									; color and background code
		
PRINT:	mov bx, ax  								; element index from ax	stored in bx reg
		mov dl, [bx + 82h] 							; char ASCII

		add bx, bx

		mov word ptr es:[bx + 160 * 10 + 70], dx	; puts the char to the video memmory
        inc ax						        		; increases the value stored in ax

		add dh, 16									; adds 16 to change the background's color
		and dh, 01111111b							; in order to prevent dx = 128 (blinking of the background)
		loop PRINT									; loops

	 	ret											; exits 

end    Start