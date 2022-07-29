format ELF64
public _start

section '.data' writeable
    msg db "hello, world", 10, 0 ; 10 == \n
    
section '.text' executable
    _start:
        mov rax, msg
        call print_string
        call exit

section '.print_string' executable
    print_string:
        push rax
        push rcx
        push rbx
        push rdx

        mov rcx, rax
        call lenght_string
        mov rdx, rax
        mov rax, 4
        mov rbx, 1
        int 0x80

        pop rdx
        pop rbx
        pop rcx
        pop rax
        ret
section '.lenght_string' executable
    lenght_string:
        push rdx ; put into stack
        xor rdx, rdx
        .next_iter: ; . = local 
            cmp [rax+rdx], byte 0 ; if [rax+rdx]; [] get value = go to variable,byte = iteration step, 0 = nullterminator 
            je .close ; if True then close 
            inc rdx ; incriment
            jmp .next_iter ; jmp = goto
        .close:
            mov rax, rdx ; from rdx to rax 
            pop rdx ; return from stack rdx register
            ret
        ret
section '.exit' executable
    exit:
        mov rax, 1 ; 1 - exit
        mov rbx, 0 ; 0 - return (can be error)
        int 0x80