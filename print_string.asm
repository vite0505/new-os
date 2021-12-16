; Will print characters in BX register

print_string:
    pusha           ; Pushing all registers values into the stack
    mov ah, 0x0e    ; int 0x10/ ah 0x0E = tele-type output

print_char:
    mov al, [bx]    ; Move character value at address in bx into al
    cmp al, 0       ; Compare al with 0
    je end_print    ; If al is 0, jump to end_print
    int 0x10        ; Calls the video BIOS interrupt and prints in al
    add bx, 1      ; Increments bx by 1 so that we can print the next letter
    jmp print_char ; Jump back to print_string

end_print:
    popa            ; Pops(restores) all registers values
    ret           ; Return from function

