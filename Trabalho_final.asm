Segment code
start..
	mov ax, data
	mov ds, ax ; inicializando o segmento de dados
	mov si, vetor ; move o vetor para SI

abre: 	mov ax,3dh ; abre arquivo 
	mov al, 2 ; move 2 para al, 2 = modo leitura e escrita
	mov dx,arq ; Copia o nome do arquivo para DX
	int 21h  ; abre o arquivo	
	jc error ; Se der erro pula para erro
    	mov [handle], ax ; move ax para a posição do handle


inicio:	mov ah, 9 
	mov dx, msg1 ; Copia o conteudo de msg1 para dx
	int 21h ;  imprime na tela
	mov ah, 1 ;  pausa
	int 21h
	cmp al, 27 ; Compara se digitou ESC
	je sair ;  se Esc Sair
	sub al, 48 ; transforma em decimal
	mov numero1, al ; copia numero digitado para a variavel numero 1
	mov [si], al ; move al para o conteudo de SI
           inc si ; incrementa SI
	mov al, 10 ; adiciona espaço em SI
	mov [si], al ; move o al para o conteudo de SI
	inc si
	mov ah, 40h ; interrupção de gravação no arquivo
    	mov bx,[handle] ; move o conteudo de handle (posição de escrita) para bx
   	mov cx, 20 ; numero de bytes a serem gravados
    	mov dx, [si] ; move o conteudo de si para o dx
    	int 21h ; grava no arquivo

	mov ah, 9 ; interrupção de impressão de string
	mov dx, msg3 ; copia msg3 para dx
	int 21h ; imprime na tela
	mov ah, 1 ; pausa
	int 21h
	mov operando, al ; move conteudo de ax digitado para a variável operando
	mov [si], al
           inc si
	mov al, 10
	mov [si], al
	inc si
	mov ah, 40h ; interrupção de gravação no arquivo
    	mov bx,[handle] ; 
   	mov cx, 20 ; numero de bytes a serem gravados
    	mov dx, [si] ; 
    	int 21h ; grava no arquivo
	
	mov ah, 9 ; mostra mensagem na tela
	mov dx, msg2 
	int 21h
	mov ah, 1 ; pausa
	int 21h
	sub al, 48 ; transforma em numero
	mov numero2, al ; move al para conteudo de numero2
	mov [si], al
           inc si
	mov al, 10
	mov [si], al
	inc si
	mov ah, 40h ; interrupção de gravação no arquivo
    	mov bx,[handle] ; 
   	mov cx, 20 ; numero de bytes a serem gravados
    	mov dx, [si] ; 
    	int 21h ; grava no arquivo
	
	cmp operando, '+' ; compara se digitou +
	je soma ; se sim pula para soma
	cmp operando, '-' ; compara se digitou -
	je subtracao ; se sim pula para subtração
	cmp operando, '*' ; compara se digitou *
	je multiplicação ; se sim pula para multiplicação
	cmp operando, '/' ; compara se digitou /
	je divisão; se sim pula para divisão

somar:	mov ah, 9 ; Valor de ah para interrupçao
	mov dx, msg4 ; mostra mensagem na tela
	int 21h 
	mov al, numero1 ; move numero1 para al
	add al, numero2 ; adiciona o conteudo de al com numero2
	mov soma, al ; move o al para a variavel soma
	mov dl, soma ; move soma para dl
	add dl, 48 ; adiciona com 48 para transformar para decimal
	mov ah, 2 ; interrupção de impressão na tela
	int 21h
	mov [si], dl ; move dl para o conteúdo de si
          inc si ; incrementa si
	mov al, 10 ; line feed
	mov [si], al ;  move al para dentro do conteudo de si
	inc si ; incrementa si
mov al, 13 ;  enter
	mov [si], al ; move o al para o si
	inc si ; incrementa si
	mov ah, 40h ; interrupção de gravação no arquivo
    	mov bx,[handle] ; 
   	mov cx, 20 ; numero de bytes a serem gravados
    	mov dx, [si] ; 
    	int 21h ; grava no arquivo	
	jmp inicio ; volta para o inicio
	
subtração:mov ah, 9
	mov dx, msg4 
	int 21h 
	mov al, numero1
	sub al, numero2
	mov subtracao, al
	mov dl, subtracao
	add dl, 48h
	mov ah, 2
	int 21h
	mov [si], dl
           inc si
	mov al, 10
	mov [si], al
	inc si
mov al, 13
	mov [si], al
	inc si
	mov ah, 40h ; interrupção de gravação no arquivo
    	mov bx,[handle] ; 
   	mov cx, 20 ; numero de bytes a serem gravados
    	mov dx, [si] ; 
    	int 21h ; grava no arquivo	
	jmp inicio

multiplicação:	mov ah, 9
	mov dx, msg4 
	int 21h
	mov al, numero1
	mul numero2
	mov multiplicacao, al
	mov dl, multiplicacao
	add dl, 48
	mov ah, 2
	int 21h
	mov [si], dl
           inc si
	mov al, 10
	mov [si], al
	inc si
mov al, 13
	mov [si], al
	inc si
	mov ah, 40h ; interrupção de gravação no arquivo
    	mov bx,[handle] ; 
   	mov cx, 20 ; numero de bytes a serem gravados
    	mov dx, [si] ; 
    	int 21h ; grava no arquivo	
	jmp inicio

divisão:mov ah, 9
	mov dx, msg4 
	int 21h
	mov al, numero1
	div numero2
	mov divisao, al
	mov dl, divisao
	add dl, 48
	mov ah, 2
	int 21h
	mov [si], dl
           inc si
	mov al, 10
	mov [si], al
	inc si
mov al, 13
	mov [si], al
	inc si
	mov ah, 40h ; interrupção de gravação no arquivo
    	mov bx,[handle] 
   	mov cx, 20 ; numero de bytes a serem gravados
    	mov dx, [si] ; 
    	int 21h ; grava no arquivo	
	jmp inicio

error: mov ah, 9 ; move 9 para ah
	mov dx, erro ; move o erro para dx 
	int 21h ; interrupção imprime na tela
	mov ah, 1
	int 21h

sair: 	mov ah, 3Eh ; Fecha o arquivo aberto
	int 21h
mov ah, 1
	int 21h
	mov ah, 4ch ; Interrupção para saída do programa
	int 21h
	
segment data
numero1 db 0 ; primeiro numero
numero2 db 0 ;  segundo numero
operando db 0; operador
soma db 0; armazena resultado da soma
subtracao db 0 ; armazena o resultado da subtração
multiplicacao db 0 ; armazena o resultado da multiplicação
divisao db 0 ; armazena o resultado da divisao
msg1 db 10,13, "Digite o primeiro valor ou ESC para sair:  ", '$'
msg2 db 10,13, "Digite o segundo valor:  " , '$'
msg3 db 10,13, "Digite o operando: + - * / " , '$'
msg4 db 10,13, "Resultado   =  ",'$'
arq db "arquivo.txt"
erro db 10,13, "Ocorreu um erro com o arquivo", '$'
handle dw 0
vetor resb 200
