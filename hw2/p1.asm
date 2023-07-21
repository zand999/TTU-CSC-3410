SECTION .data
    title DB 'The Adding Program'
    titleln EQU $-title

    prompt1 DB 'Please enter a single digit number: '
    prompt1ln EQU $-title

    prompt2 DB 'Please enter a single digit number: '
    prompt2ln EQU $-title

    exit DB 'The answer is: '
    exitln EQU $-title


SECTION .text
    GLOBAL _start

_start:

    mov eax, 4
    mov ebx, 1
    mov ecx, title
    mov edx, titleln
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, prompt1
    mov edx, prompt1ln
    int 80h

    ;take input

    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, prompt2ln
    int 80h

    ;take input

    mov eax, 4
    mov ebx, 1
    mov ecx, exit
    mov edx, exitln
    int 80h


    mov eax, 1
    mov ebx, 0
    int 0x80



