section .text
	global sort

; struct node {
;     	int val;
;    	struct node* next;
; };

;; struct node* sort(int n, struct node* node);
; 	The function will link the nodes in the array
;	in ascending order and will return the address
;	of the new found head of the list
; @params:
;	n -> the number of nodes in the array
;	node -> a pointer to the beginning in the array
; @returns:
;	the address of the head of the sorted list
sort:
	enter 0, 0

	mov ebx, [ebp + 8] ;;int n
	mov ecx, [ebp + 12] ;;struct node* node
	mov edx, 65536 ;;folosit pt gasirea celui mai mic element

loop_findMin:
	dec ebx
	cmp edx, [ecx + ebx * 8]
	jg updateMin

loop_afterMin:
	cmp ebx, 0
	jg loop_findMin
	
	mov esi, edi ;;salvam adresa celui mai mic element
	mov eax, esi ;;salvam in eax pt ca aceasta va fi returnata de functie
	push eax ;;salvam eax pe stiva
	mov dword [esi + 4], 1 ;;inlocuim NULL din campul next al celui mai mic
	                   ;;element pt a-l ignora la urmatoarea cautare

	;;trecem la cautarea urmatorului celui mai mic element pt
	;;a-l lega in lista
	mov eax, [ebp + 8] ;;contor pt sortare
	dec eax

loop_sort:
	dec eax
	mov ebx, [ebp + 8] ;;resetam contorul
	mov edx, 65536 ;;resetam cel mai mic nr

loop_findNextMin:
	dec ebx
	cmp edx, [ecx + ebx * 8]
	jg updateNextMin

loop_afterNextMin:
	cmp ebx, 0
	jg loop_findNextMin

	mov dword [esi + 4], edi ;;cream legatura in lista (punem in campul next
	                   		 ;;adresa elementului urmator)
	mov esi, edi ;;salvam adresa elementului curent
	mov dword [esi + 4], 1 ;;inlocuim NULL din campul next al celui mai mic
	                   ;;element pt a-l ignora la urmatoarea cautare
	cmp eax, 0
	jg loop_sort
	je end

updateMin:
	mov edx, [ecx + ebx * 8] ;;salvam valoarea elementului minim
	lea edi, [ecx + ebx * 8] ;;salvam adresa elementului minim
	
	jmp loop_afterMin

updateNextMin:

	;;verificam daca campul next este nenul, daca da ignoram elementul
	push edx
	mov edx, [ecx + ebx * 8 + 4]
	cmp edx, 0
	pop edx
	jnz loop_afterNextMin

	mov edx, [ecx + ebx * 8] 
	lea edi, [ecx + ebx * 8]

	jmp loop_afterNextMin

end:
	mov dword [esi + 4], 0 ;;punem NULL inapoi campul next al ultimului elem
	pop eax ;;readucem de pe stiva in eax valoarea care trebuie
	        ;;intoarsa de catre functie

	leave
	ret
