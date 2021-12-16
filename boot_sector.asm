; Simple boot loader that prints characters and hex value using BIOS interrupts
; and also reads the disk into memory using int13 ah2 

    org 0x7c00 ; makes sure addresses don't change and the origin of the boot code
    
    ; Set up ES:BX memory address/segment:offset to load sectors into
    mov bx, 0x1000  ;load sector to memory address 0x1000
    mov es, bx  ; es = 0x1000
    mov bx, 0x0   ; es:bx = 0x1000:0x0

    ; Setting up disk read
    mov dh, 0x0     ; head 0
    mov dl, 0x0     ; drive 0
    mov ch, 0x0     ; cylinder 0
    mov cl, 0x02     ; starting sector to read from disk  

read_disk:
    mov ah, 0x02    ; ah = 0x02
    mov al, 0x01    ; number of sectors to read
    int 0x13        ; BIOS interrupt for disk functions

    jc read_disk    ; retry if disk read error (carry flag set/ = 1)
 
    ; reset segment registers for RAM
    mov ax, 0x1000      ; ax = 0x1000
    mov ds, ax          ; data segment
    mov es, ax          ; extra segment
    mov fs, ax          ; ""
    mov gs, ax          ; ""
    mov ss, ax          ; stack segment

    jmp 0x1000:0x0      ; never return from this

    
; Basic bootloader 
    times 510-($-$$) db 0   ; Somehow makes 512 bytes I dunno
    dw 0xaa55   ; Boot magic numbers you can also write 0xaa55 instead of two magic numbers
; Makes a continuous loop 