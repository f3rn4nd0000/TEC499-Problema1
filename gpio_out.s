

.macro set_gpio_output pin
	ldr r0, =gpio_base
	ldr r1, [r0, #0x400]
	lsl r2, #1, \pin
	orr r1, r1, r2
	str r1, [r0, #0x400]
.endm

.data
	gpio_base: .word 0x1C20	    @ Endereco base PIO/4096
	
