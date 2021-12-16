; Basic kernel loaded from the boot-sector 

 ; Set video mode 
    mov ah, 0x00    ; int 0x10/ ah 0x00 = set video mode
    mov al, 0x01    ; don't know the dimension but looks good
    int 0x10        ; Calls video BIOS interrupt

    ; Change colour 
    mov ah, 0x0B    
    mov bh, 0x00    ; Sets the background colour in b high register
    mov bl, 0x01    ; Moves colour value to b low register.Note(changing this value will change the background colour) for ex 0x01 is blue and 0x00 is black
    int 0x10    ; Calls the interrupt

    mov si, welcomestring       ; Loads the welcome string into the si register
    call print_string           ; Calls the print_string function

    hlt                    ; Halts the processor

print_string:
    mov ah, 0x0e    ; int 0x10/ ah 0x0E = tele-type output
    mov bh, 0x0     ; page number
    mov bl, 0x07    ; colour

print_char:
    mov al, [si]    ; Move character value at address in bx into al
    cmp al, 0       ; Compare al with 0
    je end_print    ; If al is 0, jump to end_print
    int 0x10        ; Calls the video BIOS interrupt and prints in al
    add si, 1      ; Increments bx by 1 so that we can print the next letter
    jmp print_char ; Jump back to print_string

end_print:
    ret           ; Return from function

; Variables
welcomestring:     db 'Welcome to test-os lol', 0xA, 0xD, 0 ; String to print and 0 at the end to indicate null

    ; Sector padding magic
    times 512-($-$$) db 0   ; pad file with 0s until 510th byte