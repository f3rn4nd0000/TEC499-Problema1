.global _start

_start:

	ldr r0, =fileName	@ r0 = nome do arquivo
	mov r1, #2		@ move um hexadecimal para r1
	mov r7, #5		@ sys_open
	svc 0			@ chama o supervisor do SO
	mov r4, r0		@ salva o descritor do arquivo
	
	@sys_mmap2
	mov r0, #0		@ NULL
	ldr r1, =pageLen
	ldr r1, [r1]		@ pageLen (tamanho da pagina de mem.)
	mov r2, #3		@ protecao de escrita e leitura
	mov r3, #1		@ indica que é map shared
	ldr r5, =gpioAddr
	ldr r5, [r5]
	mov r7, #192		@ sys_mmap2
	svc 0

	mov r8, r0
	ldr r6, [r8, #0x004]
	
	lsl r6, r6, #4
	add r6, #1
	str r6, [r8, #0x004] 	@ seta PAB como saída

	ldr r0, [r8, #0x010]	@ Endereço do registrador de dados
	add r1, r0, #1
	lsl r1, r1, #24
	str r1, [r0, #0x810]	@ Acende o LED

	mov r0, #0
	mov r7, #1
	svc 0

.data
	fileName: .asciz "/dev/mem" @ Caminho do arquivo p/ mapeamento de mem. virtual
	gpioAddr: .word 0x1C20	    @ Endereco base PIO/4096
	pageLen: .word 0x1000
