	xdef vectorBase
	if TRACKLOADER=0
; from Photon http://coppershade.org/asmskool/SOURCES/Developing-Demo-Effects/DDE2/Coppershade-DDE2/PhotonsMiniWrapper1.04!.S	

StartupFromOS:			
	move.l	4.w,a6		;Exec library base address in a6
	sub.l	a4,a4
	btst 	#0,297(a6)	;68000 CPU?
	beq.s 	.yes68k
	lea 	GetVBR(PC),a5	;else fetch vector base address to a4:
	jsr 	-30(a6)		;enter Supervisor mode
	move.l	a4,vectorBase
	move.l	a4,P61_VBR

	    *--- save view+coppers ---*

.yes68k:
	lea 	GfxLib(PC),a1 	;either way return to here and open
	jsr 	-408(a6)	;graphics library
	tst.l 	d0		;if not OK,
	beq 	quit		;exit program.
	move.l 	d0,a5		;a5=gfxbase

	bsr	SaveSystemClock

	move.l 	a5,a6		;gfxbase -> a6
	move.l 	34(a6),-(sp)    ;save old view ?
	sub.l 	a1,a1		;blank screen to trigger screen switch
	jsr 	-222(a6)	;on Amigas with graphics cards
	jsr 	-270(a6)    	;WaitTOF
	jsr 	-270(a6)    	;WaitTOF
	jsr 	-456(a6)    	;OwnBlitter

	    *--- save int+dma ---*

	lea 	$dff000,a6
	bsr 	WaitEOF		;wait out the current frame
	move.l 	$1c(a6),-(sp)	;save intena+intreq
	move.w 	2(a6),-(sp)	;and dma
	move.l 	$6c(a4),-(sp)	;and also the VB int vector for sport.
	bsr 	AllOff		;turn off all interrupts+DMA

	    *--- call demo ---*

	movem.l a4-a6,-(sp)
	move.l	a7,longJump	; save the stack pointer
	jmp	Entry2
LongJump:	
	move.l	longJump,a7	; this isn't required as the stack pointer will not be corrupted
	movem.l (sp)+,a4-a6     ; but it does allow us to bail out of the middle of a subroutine

	    *--- restore all ---*

	bsr 	WaitEOF		;wait out the demo's last frame
	bsr 	AllOff		;turn off all interrupts+DMA
	move.l 	(sp)+,$6c(a4)	;restore VB vector
	move.l 	38(a5),$80(a6)	;and copper pointers
	move.l 	50(a5),$84(a6)
	addq.w 	#1,d2		;$7fff->$8000 = master enable bit
	or.w 	d2,(sp)
	move.w 	(sp)+,$96(a6)	;restore DMA
	or.w 	d2,(sp)
	move.w 	(sp)+,$9a(a6)	;restore interrupt mask
	or.w 	(sp)+,d2
	bsr.s 	IntReqD2	;restore interrupt requests

	bsr	RestoreSystemClock

	move.l 	a5,a6          	;gfxbase -> a6
	move.l 	(sp)+,a1        ;previously saved view
	jsr 	-222(a6)	;restore OS screen
	jsr 	-270(a6)       	;WaitTOF
	jsr 	-270(a6)        ;WaitTOF
	jsr 	-228(a6)        ;WaitBlit
	jsr 	-462(a6)        ;DisownBlitter

	    *--- close lib+exit ---*

	move.l 	a6,a1		;close graphics library
	move.l 	4.w,a6
	jsr 	-414(a6)

quit:
	moveq	 #0,d0		;clear error return code to OS
	rts			;back to AmigaDOS/Workbench.

GetVBR:
	dc.w 	$4e7a,$c801 	;hex for "movec VBR,a4"
	rte			;return from Supervisor mode

longJump:
	dc.l	0
GfxLib:
	dc.b 	"graphics.library",0,0

WaitEOF:			;wait for end of frame
	bsr.s 	WaitBlitter
	move.w 	#$138,d0
WaitRaster:			;Wait for scanline d0. Trashes d1.
	.l:	move.l 4(a6),d1
	lsr.l 	#1,d1
	lsr.w 	#7,d1
	cmp.w 	d0,d1
	bne.s 	.l		;wait until it matches (eq)
	rts
AllOff:
	move.w 	#$7fff,d2 	;clear all bits
	move.w 	d2,$96(a6)	;in DMACON,
	move.w 	d2,$9a(a6)	;INTENA,
IntReqD2:
	move.w 	d2,$9c(a6)	;and INTREQ
	move.w 	d2,$9c(a6)	;twice for A4000 compatibility
	rts


WaitBlitter:			;wait until blitter is finished
	tst.w 	(a6)		;for compatibility with A1000
	.loop:	btst #6,2(a6)
	bne.s 	.loop
	rts


SaveSystemClock:
	movem.l	d0-a6,-(sp)
	move.l  $4.w,a6            ;Execbase
	lea     timer_request_struc(pc),a1 ;Timer-request-structure
	moveq   #0,d0              ;Unit 0 (UNIT_MICROHZ) & Null for entrys in struc
	move.b  d0,8(a1)           ;LN_Type: Entry type = Null
	move.b  d0,9(a1)           ;LN_Pri: Priority of the structure = Null
	moveq   #0,d1              ;No Flags for device
	move.l  d0,$a(a1)          ;LN_Name: No name for the structure
	lea     timer_device_name(pc),a0 ;Pointer to name of Timer-Device
	move.l  d0,$e(a1)          ;MN_ReplyPort: No Reply-Port
	jsr     -444(a6)           ;OpenDevice()
	tst.l   d0
	bne   	quit
	lea     timer_request_struc(pc),a1
	move.w  #$a,$1c(a1)        ;IO_Command = TR_GETSYSTIME
	jsr     -456(a6)           ;DoIO()
	jsr     -120(a6)           ;Disable()
	;Take over the machine...
	move.l  #$bfe001,a4        ;CIA-A base adress
	moveq   #0,d0
	move.b  $a00(a4),d0        ;TOD-clock bits 23-16
	swap    d0                 ;Shift bits to the right position
	move.b  $900(a4),d0        ;TOD-clock bits 15-8
	lsl.w   #8,d0              ;Shift bits to the right position
	move.b  $800(a4),d0        ;TOD-clock bits 7-0
	move.l  d0,TOD_time_save   ;Save time before demo/intro starts
	movem.l	(sp)+,d0-a6
	rts


RestoreSystemClock:
	movem.l	d0-a6,-(sp)
	move.l  #$bfe001,a4        ;CIA-A base adress
	move.l  TOD_time_save(pc),d0 ;Time before starting demo/intro
	moveq   #0,d1
	move.b  $a00(a4),d1        ;TOD-clock Bits 23-16
	swap    d1
	move.b  $900(a4),d1        ;TOD-clock Bits 15-8
	lsl.w   #8,d1
	move.b  $800(a4),d1        ;TOD-clock Bits 7-0
	cmp.l   d0,d1              ;TOD overflow?
	bge.s   .no_TOD_overflow   ;No -> skip
	move.l  #$ffffff,d2        ;Max TOD value
	sub.l   d0,d2              ;Difference until overflow
	add.l   d2,d1              ;+ value after overflow
	bra.s   .TOD_okay
	CNOP 0,4                   ;Longword alignment for 68020+
.no_TOD_overflow:
	sub.l   d0,d1              ;Get normal difference without overflow
.TOD_okay:
	move.l  d1,TOD_time_save   ;Save period of demo/intro
	;Restore system...
	move.l  $4.w,a6            ;Execbase
	jsr     -126(a6)           ;Enable()
	moveq	#0,d1
	move.l  TOD_time_save(pc),d0 ;Period of demo/intro
	move.b  $212(a6),d1        ;Get VBlankFrequency
	lea     timer_request_struc(pc),a1
	divu.w  d1,d0              ;Calculate seconds
	move.w  #$b,$1c(a1)        ;IO_command = TR_SETSYSTIME
	move.l  d0,d1              ;Save seconds in d1
	ext.l   d0                 ;Word to longword
	add.l   d0,$20(a1)         ;TV_SECS: Set Unix-Time seconds
	swap    d1                 ;Remainder of division
	mulu.w  #10000,d1          ;*10000 = µs
	add.l   d1,$24(a1)         ;TV_MICRO: Set Unix-Time microseconds
	jsr     -456(a6)           ;DoIO()
	movem.l	(sp)+,d0-a6
	rts


	cnop 0,4
TOD_time_save:
	dc.l 0

timer_request_struc:
	ds.b 40

timer_device_name:
	dc.b "timer.device",0
	even

	endif
vectorBase:
	dc.l	0
