	include "includes.i"
	
	xdef 	WaitVerticalBlank
	xdef	WaitRaster

	
WaitVerticalBlank:	
	movem.l	d0,-(sp)
.loop:
	move.l	$dff004,d0
	and.l	#$1ff00,d0
	cmp.l	#303<<8,d0	; wait for the scan line
	bne.b	.loop
.loop2:
	move.l	$dff004,d0
	and.l	#$1ff00,d0
	cmp.l	#303<<8,d0	; wait for the scan line to pass (A4000 is fast!)
	beq.b	.loop2
	movem.l (sp)+,d0
	rts	


WaitRaster:		;wait for rasterline d0.w. Modifies d0-d2/a0.
	movem.l d0-a6,-(sp)
	move.l #$1ff00,d2
	lsl.l #8,d0
	and.l d2,d0
	lea $dff004,a0
.wr:
	move.l (a0),d1
	and.l d2,d1
	cmp.l d1,d0
	bne.s .wr
	movem.l (sp)+,d0-a6
	rts



