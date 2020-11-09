.model small
.stack 100h
.data

inputMsg db 0dh,0ah,"Enter Integer (0-75)$"
invalidMsg db 0dh,0ah,"Invalid Input.Input range(0-75)$"
GradeMsg db 0dh,0ah,"Grade is=$"
v1 db ?    ;this will contain our input number
count db ? ;used for validating input integer with respect to length

.code
main proc
mov ax,@data
mov ds,ax

;1 input
mov ah,9
mov dx,offset inputMsg
int 21h

call inputDecimal

mov ah,9
mov dx,offset GradeMsg
int 21h

call CalcGrade

mov ah,2
mov dl,al
int 21h


;2nd input
mov ah,9
mov dx,offset inputMsg
int 21h

call inputDecimal

mov ah,9
mov dx,offset GradeMsg
int 21h

call CalcGrade

mov ah,2
mov dl,al
int 21h

;3rd input

mov ah,9
mov dx,offset inputMsg
int 21h

call inputDecimal

mov ah,9
mov dx,offset GradeMsg
int 21h

call CalcGrade

mov ah,2
mov dl,al
int 21h




    
    
mov ah,4ch 
int 21h
    
main endp 


CalcGrade proc
 push bx ;not preserving ax because we are returning our result in al to main proc
 push cx
 push dx
 
 cmp v1,' '
 je nograde
 cmp v1,49
 jle gradeF
 cmp v1,59
 jle gradeC
 cmp v1,69
 jle gradeB
 
     MOV AL,'A'
     jmp stopproc
gradeF:
    mov al,'F'
    jmp stopproc

gradeC:     
    mov al,'C'
    jmp stopproc

gradeB:    
    mov al,'B'
    jmp stopproc
nograde: 
    mov al,' '
 

stopproc: 
 pop dx
 pop cx
 pop bx
 ret   
CalcGrade endp





inputDecimal proc
 push ax
 push bx ;not preserving ax because we are returning our result in al to main proc
 push cx
 push dx
 
 
 
 
   mov v1,0
   xor dx,dx 
   mov count,0
    
l1:
    mov ah,1
    int 21h
    
    cmp al,0dh
    je validate
    cmp al,'0'
    jl invalidNumber
    cmp al,'9'
    jg invalidNumber
    
     
    sub al,30h
    
    mov v1,al 
    
    mov al,10
    mul dl
            
    add al,v1
    
    mov dl,al
    inc count
                
    jmp l1

validate:
jo invalidNumber
cmp count,2
jg invalidNumber
cmp dl,75
jge invalidNumber
cmp dl,0
jl invalidNumber
mov v1,dl
jmp stopInput



invalidNumber:
mov ah,9
mov dx,offset invalidMsg
int 21h
mov v1,' '
    
stopInput:
 
 pop dx
 pop cx
 pop bx
 pop ax   
    ret    
    
inputDecimal endp    



end main
