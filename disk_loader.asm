; Read DH sectors into ES:BX memory location from drive DL 
; This will do some disk reated stuff like reading sectors after the first 512 bytes

disk_main:
    push dx     ; Will store dx on stack so we can check of sectors actually read (past) later
    mov ah, 0x02   ; BIOS Read disk sectors into memory
    mov al, dh     ; Number of sector we want to read
    mov ch, 0x00   ; cylinder 0
    mov dh, 0x00   ; head 0
    mov cl, 0x02   ; start reading at cl sector 2 right after our boot sector
    int 0x13    ; Call BIOS interrupt for disk functions
    jc disk_error   ; jump if something goes wrong 
    pop dx      ; restore dx from the stack
    cmp dh, al      ; checks if dh(sectors we want to read) and al(sectors actually read) are equal 
    jne disk_error
    ret

disk_error:
    mov bx, disk_error_message      ; moves error message to bx
    call print_string       ; call print_string.asm
    hlt     ; halt the processor

disk_error_message:
    db "Disk error, coudn't read!!111!", 0    
        