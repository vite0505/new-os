; Will print hexadecimal values using register DX and print_string.asm

; Ascii '0' - '9' = hex 0x30-0x39
; Ascii 'A' - 'F' = hex 0x41-0x46f
; Ascii 'a' - 'f' = hex 0x61-0x66
print_hex:
    pusha             ; Save registers to the stack
    mov cx, 0         ; Initialize counter to 0

hex_loop:
    cmp cx, 4         ; Compare cx to 4
    je end_hex_loop     ; If cx is 4, jump to end_hex_loop
    
    ; Convert dx hex value to ascii
    mov ax, dx        ; Move dx into ax
    and ax, 0x000F      ; I dunno what I am doing anymore
    add al, 0x30        ; get ascii number of letter value
    cmp al, 0x39        ; If al is equal to 0x39 the 
    jle move_into_bx    ; jump to move_into_bx
    add al, 0x7         ; to get ascii 'A' - 'F'
    
move_into_bx:
    mov bx, hexstring + 5   ; base address of hexstring + lenght of string
    sub bx, cx         ; subtract loop counter
    mov [bx], al      ; move al into bx. al = ascii character
    ror dx, 4         ; rotate dx right 4 bits. 0x12AB -> 0xB12A ->  0xAB12 -> 0x2AB1 -> 0x12AB
    add cx, 1          ; increment loop counter
    jmp hex_loop       ; jump back to hex_loop

end_hex_loop:
    ; Print the hex value
    mov bx, hexstring    ; Move hexstring to bx
    call print_string   ; Call print_string   
    popa              ; Restore registers from the stack
    ret               ; Return to the calling function

hexstring:      db '0x0000', 0 