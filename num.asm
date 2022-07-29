format ELF64
public _start

section '.bss' writable
    bss_char rb 1
section '.text' executable
_start:
    mov rax, 571
    sub rax, 99
    call print_number
    call print_line
    call exit
; 571 / 10 = 57 | 1 + '0'
; 57 / 10 = 5 | 7
; 5 / 10 = 0 | 5
; rax | rdx 
section '.print_number' executable
;input = rax
print_number:
    push rax
    push rbx
    push rcx
    push rdx
    xor rcx, rcx
    .next_iter:
        cmp rax, 0
        je .print_iter
        mov rbx, 10
        xor rdx, rdx
        div rbx ; rax already
        add rdx, '0'
        push rdx
        inc rcx ; number iteration
        jmp .next_iter
    .print_iter:
        cmp rcx, 0
        je .close
        pop rax
        call print_char
        dec rcx ; rcx - 1
        jmp .print_iter
    .close:
        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret
section '.print_char' executable
; input rax
; rax = char
print_char:
    push rax
    push rbx
    push rcx
    push rdx

    mov [bss_char], al
    mov rax, 4
    mov rbx, 1
    mov rcx, bss_char
    mov rdx, 1
    int 0x80 ; 32bit arch
    
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret
section '.print_line' executable
print_line:
    push rax
    mov rax, 0xA
    call print_char
    pop rax
    ret
section '.exit' executable
exit:
    mov rax, 1
    xor rbx, rbx
    int 0x80