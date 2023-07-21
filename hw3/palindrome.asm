;sys_read leaves the length of the string in eax
SECTION .data
    
    prompt1: DB 'Please enter string: ', 0xa
    prompt1ln EQU $-prompt1

    poisitiveanswer DB 'It is a palindrome: ', 0xa
    poisitiveanswerln EQU $-poisitiveanswer

    negativeanswer DB 'It is NOT a palindrome: ', 0xa
    negativeanswerln EQU $-negativeanswer

    exitstment DB 'done', 0xa
    exitstmentln EQU $-exitstment

    check DB 'test', 0xa
    
    returnline DB 0xa


SECTION .bss
    string RESB 64
    stringln RESB 1

SECTION .text
    GLOBAL _start
teststmt:
    pusha
    mov eax, 4
    mov ebx, 1
    mov ecx, check
    mov edx, 5    
    int 0x80
    popa
    ret
exit:
    mov eax, 4
    mov ebx, 1
    mov ecx, exitstment
    mov edx, exitstmentln    
    int 0x80
    mov eax, 1
    int 0x80 
print:
    push ebp
    mov ebp, esp
    pushf
    mov eax, 4
    mov ebx, 1
    mov edx, [ebp+8]
    mov ecx, [ebp+12]
    int 0x80
    popf
    pop ebp
    ret 
println:
    push ebp
    mov ebp, esp
    pushf
    mov eax, 4
    mov ebx, 1
    mov edx, [ebp+8]
    mov ecx, [ebp+12]
    int 0x80
    mov eax, 4
    mov ebx, 1
    mov edx, 1
    mov ecx, returnline
    int 0x80
    popf
    pop ebp
    ret 
    


;proof of concept
    ;mov bl, byte [eax + 0]
    ;mov bh, byte [eax + 7]
    ;cmp bl, bh
is_palindrome: ;char array, len
    ;save stack
    push ebp
    mov ebp, esp
    pushf
    pusha
    
    ;get string in register
    mov ebx, [ebp+12]
    ;get string length in register and remove endline char as well as set to char position
    mov edx, [ebp+8]
    sub edx, 2
    ;move "i" into ecx
    mov ecx, 0
    
    palindromeloop:
    
    cmp edx, ecx 
    jle itispalindrome
    push ecx
    push edx
    
    
    mov ah, [ebx + ecx]
    mov al, byte [ebx + edx]
    cmp ah, al  
    jne not_palindrome
    pop edx
    dec edx
    pop ecx   
    inc ecx
    jmp palindromeloop    
    
    not_palindrome:
    pop eax
    pop eax
    popa
    mov eax, 0 ;false
    jmp palindrome_end
    
    
    
    itispalindrome:
    popa
    mov eax, 1 ;true
    
    palindrome_end:
    popf
    pop ebp
    ret                   
                                                          
_start:
    
    ;print input propt
    push prompt1
    push prompt1ln
    call print
    add esp, 8
    
    ;take input
    mov eax, 3
    mov ebx, 2
    mov ecx, string
    mov edx, 63
    int 0x80
    
    ;check if text in only one character ie '\n'
    cmp eax, 1
    je stop
    
    
    mov [stringln], eax
    
    ;push string and length onto stack on call is palindrome
    push string
    push eax
    call is_palindrome
    
    ;if returned value is 1 jump to print positive answer else print negitive answer
    cmp eax, 1
    je posresponce
    
    push negativeanswer
    push negativeanswerln
    call print
    jmp _start
    
    posresponce:
    push poisitiveanswer
    push poisitiveanswerln
    call print
    jmp _start
    
    
    ;end of script function
    stop:
    call exit





    


