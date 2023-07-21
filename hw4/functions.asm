BITS 32
GLOBAL is_palindrome
GLOBAL addstr
GLOBAL factstr
EXTERN fact
EXTERN atoi
EXTERN is_palindromec
GLOBAL palindrome_check
SECTION .data
    
    poisitiveanswer DB 'It is a palindrome: ', 0xa
    poisitiveanswerln EQU $-poisitiveanswer

    negativeanswer DB 'It is NOT a palindrome: ', 0xa
    negativeanswerln EQU $-negativeanswer
    
    prompt1 DB 'Please enter string: ', 0xa
    prompt1ln EQU $-prompt1

    check DB 'test', 0xa
   
SECTION .bss
    string RESB 64    
      
SECTION .text
savereg:
    push ebx
    push ecx
    push edx
    ret
getreg:
    pop edx
    pop ecx
    pop ebx
    ret

teststmt:
    pusha
    mov eax, 4
    mov ebx, 1
    mov ecx, check
    mov edx, 5    
    int 0x80
    popa
    ret
print:
    
    push ebp
    mov ebp, esp
    pusha
    pushf
    mov eax, 4
    mov ebx, 1
    mov edx, [ebp+8];length
    mov ecx, [ebp+12];string
    int 0x80
    popf
    popa
    pop ebp
    ret 
    

is_palindrome: ;char array, len

    push ebp
    mov ebp, esp
    push esi
    pusha
    
    
    ;get string in register
    mov esi, [ebp+8]
    ;get string length in register and remove endline char as well as set to char position
    mov edx, [ebp+12]
    mov ebx, 0
    
    palindromeloop:
    
    cmp edx, ebx
    jle itispalindrome
    
    
    add esi, ebx    
    mov al, [esi]
    sub esi, ebx 
    
    add esi, edx
    mov ah, [esi]
    sub esi, edx
    

    
    cmp al, ah
    jne not_palindrome
    
    inc ebx
    dec edx
    
    
        
    
    
    jmp palindromeloop 
    
    not_palindrome:
    popa
    mov eax, 0 ;false
    jmp palindrome_end

    itispalindrome:
    popa
    mov eax, 1 ;true
    
    palindrome_end:
    pop esi
    pop ebp
    ret

addstr:
    
    
    push ebp
    mov ebp, esp
    
    push ebx
    push ecx
    push edx
    
    
    
    mov eax, [ebp+8]
    push eax
    call atoi
    add esp, 4
    push eax
    
    mov eax, [ebp+12]
    push eax
    call atoi
    add esp, 4
    
    pop edx
    
    
    add eax, edx
    
    
    
    pop edx
    pop ecx
    pop ebx
 
    pop ebp
    
    
    ret 
factstr:
    push ebp
    mov ebp, esp
    
    push ebx
    push ecx
    push edx
    
    mov eax, [ebp+8]
    push eax
    call atoi
    add esp, 4
    
    mov edx,eax
    push edx
    call fact
    add esp, 4
    
    pop edx
    pop ecx
    pop ebx
 
    pop ebp
    ret

palindrome_check:
    push ebp
    mov ebp, esp
    pusha
    
    ;call teststmt
    
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
    
    ;mov eax, [string]
    ;ush eax
    push string
    ;call teststmt
    call is_palindromec
    add esp, 4    
    
    cmp eax, 1
    je posresponce
    
    push negativeanswer
    push negativeanswerln
    call print
    add esp, 8
    jmp endpalcheck
    
    
    posresponce:
    push poisitiveanswer
    push poisitiveanswerln
    call print
    add esp, 8
    endpalcheck:
    
    popa
    pop ebp
    ret