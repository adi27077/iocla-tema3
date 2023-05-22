section .data
	count dd 0
	returnTrue dd 1
	returnFalse dd 0
	par1 db '('
	par2 db ')'

section .text
	global par

;; int par(int str_length, char* str)
;
; check for balanced brackets in an expression
par:	
	pop edi ;;salvam adresa de retur a functiei
	pop eax ;;int str_length
	pop ebx ;;char *str
	push dword [count]
	pop ecx ;;contor sir
	push dword [count]
	pop esi ;;contor paranteze

loop_checkPar:
	;;verificare secventa paranteze
	push dword [ebx + ecx]
	pop edx
	inc ecx
	cmp dl, [par1] ;;trb comparat doar un byte
	je incCount
	cmp dl, [par2] ;;trb comparat doar un byte
	je decCount

incCount:
	;;pt o paranteza ( crestem contorul din esi
	inc esi
	cmp ecx, eax
	jl loop_checkPar
	jmp end

decCount:
	;;pt o paranteza ) scadem contorul din esi
	dec esi
	cmp ecx, eax
	jl loop_checkPar
	jmp end

end:
	;;daca este 0 contorul de paranteza, secventa e corecta
	cmp esi, 0
	jz reTrue
	jnz reFalse
	
reTrue:
	push dword [returnTrue]
	pop eax
	jmp final

reFalse:
	push dword [returnFalse]
	pop eax
	jmp final

final:

	;;refacere stiva
	push 420
	push 420
	push edi ;;punem la loc pe stiva adresa de retur

	ret
