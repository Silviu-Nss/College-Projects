; Nastasescu George-Silviu

%include "io.inc"

%define MAX_INPUT_SIZE 4096

section .bss
	expr: resb MAX_INPUT_SIZE

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
	push ebp
	mov ebp, esp

	GET_STRING expr, MAX_INPUT_SIZE

        xor ebx, ebx
        mov bh, 1; bh = 1 means that will be parsed as an operand
        xor ecx, ecx
        xor edx, edx 
        mov esi, expr
beginning:
        xor eax, eax
        lodsb; loads the first byte from string
        cmp al, 0; check if we reached the end
        jz end
        cmp al, '/'
        jz division
        cmp al, '*'
        jz multiplication
        cmp al, '+'
        jz addition
        cmp al, '-'
        jz verification; check if we substract or we have a negative number
        cmp al, ' '
        jz space
        sub al, 48; convert from ascii to digit
        jmp append
        
verification:
        mov cl, [esi]
        cmp cl, 0
        jz substraction
        cmp cl, ' '
        jz substraction
        mov bl, 1; bl = 1 means we have a negative number
        jmp beginning
        
substraction:
        pop ebx
        pop eax
        sub eax, ebx
        push eax
        xor cl, cl
        xor ebx, ebx
        jmp beginning
        
addition:
        pop ebx
        pop eax
        add eax, ebx
        push eax
        xor ebx, ebx
        jmp beginning

multiplication:
        pop ebx
        pop eax
        imul ebx
        push eax
        xor ebx, ebx
        jmp beginning
        
division:
        xor edx, edx
        pop ebx
        pop eax
        cdq
        idiv ebx
        push eax
        xor ebx, ebx
        jmp beginning
        
append:
        cmp bh, 1
        jz first_digit
        xor edx, edx
        xor ecx, ecx
        mov cl, al
        pop eax
        mov edx, 10
        imul edx
        xor edx, edx
        add eax, ecx
        push eax
        xor bh, bh
        xor ecx, ecx
        jmp beginning

first_digit:
        push eax
        xor bh, bh
        jmp beginning

space:
        mov bh, 1
        cmp bl, 1
        jnz beginning
        pop eax
        neg eax
        push eax
        xor bl, bl
        jmp beginning

end:
        pop eax
        PRINT_DEC 4, eax

	xor eax, eax
	pop ebp
	ret
