section .text
	global cmmmc

;; int cmmmc(int a, int b)
;
;; calculate least common multiple fow 2 numbers, a and b
cmmmc:
	pop edi ;;salvam adresa de retur

	pop eax ;;salvam a in eax 
	pop ebx ;;salvam b in ebx
	push eax ;;salvam copii ale a si b pe stiva
	push ebx

	;;calculam a*b
	imul ebx
	push eax ;;punem a*b pe stiva
	pop ecx ;;si il salvam in ecx
	pop ebx ;;salvam inapoi a si b in eax si ebx
	pop eax

	
loop_cmmdc:
	;;calculare cmmdc prin scaderi repetate
	cmp eax, ebx
	jg sub_aGreater
	jl sub_bGreater
	je end


sub_aGreater:
	sub eax, ebx
	jmp loop_cmmdc

sub_bGreater:
	sub ebx, eax
	jmp loop_cmmdc

end:
	push ecx ;;punem a*b din ecx pe stiva
	pop eax ;;luam a*b de pe stiva si il punem in eax
	div ebx ;;calculam cmmmc=a*b/cmmdc
	;;rezultatul va fi in eax
	
	;;refacere stiva
	push 69
	push 69
	push edi ;;punem inapoi adresa de retur
	
	ret
