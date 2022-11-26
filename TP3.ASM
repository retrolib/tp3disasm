	;*** TURBO PASCAL version 3.01 A source code
	;*** Predecessor of Turbo Pascal 5.5
	;*** Software architect : Anders Hejlsberg
	;*** 
	;*** Code Copyright 1986 Borland International
	;*** version 5.5 released by successor company Embarcadero
	;*** https://edn.embarcadero.com/article/20803
	;*** 
	;*** Thanks to the original author of these disassembly comments
	;*** Archived here for educational purposes
	;*** 
	;"***
				cseg	$100	;"COM file...
	;
	;I/O port equates
	;
				timerfrq	=	$0042	;timer: frequency
				timercmd	=	$0043	;timer: command
				timerflg	=	$0061	;"PPI:   sound enable
	;
	;interrupt numbers
	;
				bioscrt	=	$0010	;BIOS: CRT driver
				bioskbd	=	$0016	;BIOS: KBD driver
				msdos	=	$0021	;"MS-DOS entry
	;
	;variable definitions
	;
				attnrm	=	$0000	;attribute NormVideo
				attlow	=	$0001	;attribute LowVideo
				att2	=	$0002	;attribute #2 (used by editor)
				att3	=	$0003	;attribute #3
				txwinx1	=	$0004	;upper left edge current window
				txwiny1	=	$0005
				scrmod	=	$0006	;video mode
				coltxt	=	$0007	;color or text ?
				attcur	=	$0008	;current attribute
				grmod	=	$0009	;graphics mode
				grwinx1	=	$000A	;graphics window: upper left edge
				grwinx2	=	$000C
				grwiny1	=	$000E	;  bottom right edge
				grwiny2	=	$0010
				delaycnt	=	$0012	;number of loop's for 1 ms
				collin	=	$0014	;line color
				lnxdir	=	$0016	;X direction
				lnydir	=	$0018	;Y direction
				lnxpos	=	$001A	;X position
				lnypos	=	$001C	;Y position
				lndda	=	$001E	;DDA register
				grback	=	$0020	;"graphics: background color
	;heap pointer
				hpstrt	=	$0022	;beginning of heap
				hpstrt1	=	$0024
				hpdstpt	=	$0026	;^ destination pointer
				hpdstpt1	=	$0028
				hpesize	=	$002A	;size of entry to delete
				hpesize1	=	$002C
				hplast	=	$002E	;^ previous entry
				hplast1	=	$0030
				hpmerg	=	$0032	;length of entry to be merged
				hpmerg1	=	$0034	;"with next entry
				coninbuf	=	$0036	;CON input buffer
				pnbuf0	=	$00B5
				pnbuf	=	$00B6	;buffer for filename etc.
				pnbuf1	=	$00B7
				pnbuf2	=	$00B8
				pnbuf3	=	$00B9
				pndiratt	=	$00CB	;for Dir: file attribute
				pndirnm	=	$00D4	;name of file
				pndirpad	=	$00E4	;^ end for formatting
				pnbufend	=	$0135	;"end of buffer
	;I/O vectors
				vkbdstat	=	$0136	;KBD stat (ConStPtr)
				vkbdget	=	$0138	;KBD get (ConInPtr)
				vconput	=	$013A	;CON put (ConOutPtr)
				vprnput	=	$013C	;PRN put (LstOutPtr)
				vauxput	=	$013E	;AUX put (AuxOutPtr)
				vauxget	=	$0140	;AUX get (AuxInPtr)
				vusrput	=	$0142	;USR put (UsrOutPtr)
				vusrget	=	$0144	;"USR get (UsrInPtr)
	;file entries for std files
				filcon	=	$0146	;CON, TRM
				filkbd	=	$014A	;KBD
				fillst	=	$014E	;LST
				filaux	=	$0152	;AUX
				filusr	=	$0156	;USR
				stdin	=	$015A	;MS-DOS input file
				stdinfl	=	$015C	;flag
				stdinof	=	$015E	;^ buffer
				stdinsz	=	$0160	;buffer size
				stdout	=	$0166	;MS-DOS output file
				stdoutfl	=	$0168	;flag
				stdoutof	=	$016A	;^ buffer
				stdoutsz	=	$016C	;"buffer size
				modeflg	=	$0172	;option flag - see initmem
				spval	=	$0174	;SP on initialisation
				turbocs	=	$0176	;CS for return to Turbo
				turbods	=	$0178	;DS for return to Turbo
				filtabpt	=	$017A	;^ into list of open files
				filemax	=	$017C	;max number of open files
				verror	=	$017E	;ErrorPtr
				errnum	=	$0180	;error number
				conbufln	=	$0181	;BufLen (for ReadLn)
				conbufpt	=	$0182	;^ into input buffer
				conbfend	=	$0184	;end of input buffer
				errpos	=	$0186	;return address ->
				errpos2	=	$0188	;position of error
				hptop	=	$018A	;HeapPtr: ^ end of heap
				hptop1	=	$018C
				svintv	=	$018E	;buffer for vector:
				svintv1	=	$0190	;DIV/0 interrupt
				lastkey	=	$0192	;code of last key pressed
				cbreak	=	$0194	;CBreak
				ovrpnbuf	=	$0196	;"buffer for overlay filename
				fmtfield	=	$01E6	;formatting: field size
				fmttype	=	$01E7	;type of conversion
				fmtsdst	=	$01E8	;^ dest string (STR)
				fmtsdst1	=	$01EA
				fmtvdst	=	$01EC	;^ dest var    (VAL)
				fmtvdst1	=	$01EE
				fmtpdst	=	$01F0	;^ error var   (VAL)
				fmtpdst1	=	$01F2
				recvbuf	=	$01F4	;"real buffer: number to convert
				errio	=	$01FA	;flag: return because of error
				rndseed	=	$01FC	;random seed: last random number
				rndseed1	=	$01FE
				strdstln	=	$0200	;string operations: max. length of result
				strpos	=	$0202	;Pos
				strnum	=	$0204	;Num
				strtrgt	=	$0206	;^ dest string
				strtrgt1	=	$0208
				strobj	=	$020A	;^ object string
				strobj1	=	$020C	;"
				remul11	=	$020E	;real arithmetics
				remul11a	=	$020F	;first number * /
				remul12	=	$0210
				remul13	=	$0212
				remul21b	=	$0213
				remul21	=	$0214	;second number * /
				remul21a	=	$0215
				remul22	=	$0216
				remul23	=	$0218
				retrc1	=	$021A	;number for Sqrt, ArcTan, polynomials
				retrc2	=	$021C
				retrc3	=	$021E
				resign	=	$0220	;sign for + -
				resave	=	$0221
				remant	=	$0222	;mantissa + -
				remant1	=	$0223	;"
				cvdecexp	=	$0224	;real -> ASCII: decimal exponent
				cvexpcnt	=	$0225	;ASCII -> real: counter for exponent
				cvoutbuf	=	$0226	;output buffer for result
				currfil	=	$0232	;^ current file var
				currfil1	=	$0234
				filfunc	=	$0238	;function code file operation
				filerr	=	$0239	;error code, if failure
				prnum	=	$023A	;real: number to print
				filetab	=	$0240	;"table of open files (file handles)
	;kernel variables
				freemem	=	$0260	;free memory (paragraphs)
				stackseg	=	$0262	;stack segment on start
				stackpt	=	$0264	;stack pointer
				destseg	=	$0266	;segment of compiled program
				codesize	=	$0268	;code size (paragraphs)
				datasize	=	$026A	;data size (paragraphs)
				minstksz	=	$026C	;min size stack + heap
				mincssz	=	$026E	;min size CS
				mindssz	=	$0270	;min size DS
				minhpsz	=	$0272	;min size free heap
				maxhpsz	=	$0274	;max size free heap
				txbeg	=	$0276	;^ beginning of text
				txend	=	$0278	;^ end of text
				txmemend	=	$027A	;^ end of text memory
				txerrpos	=	$027C	;^ error in text
				vfilbig	=	$027E	;vector: file too big
				vnewfil	=	$0280	;vector: file not found
				txcomp	=	$0282	;0 = text not translated
				cpmode	=	$0283	;(0 memory, 1 find error, 2 COM, 3 CHN)
				cperr	=	$0284	;compiler's error number
				txchg	=	$0285	;0 = text not changed
				defdrv	=	$0286	;number of default drive
				scrpn	=	$0287	;buffer for filename processing
				scrpnend	=	$02C6	;end of buffer
				workpn	=	$02C7	;filename work file
				mainpn	=	$0307	;filename main file
				mainflg	=	$0347	;0 = work file used
				msgflg	=	$0348	;0 = error messages not read
				codedest	=	$0349	;(1 = memory, 2 = COM, 3 = CHN)
				parmlin	=	$034A	;buffer: input line for program
				knumbuf	=	$0386	;number output buffer
				curatt	=	$038E	;"number current video attribute
	;editor variables
				srend	=	$0390	;^ block end for search
				srbeg	=	$0392	;^ block beg for search
				bkbeg	=	$0394	;^ block beg
				bkend	=	$0396	;^ block end
				lnupper	=	$0398	;^ line above
				disbeg	=	$039A	;^ beginning of text displayed
				oldpos	=	$039C	;old position
				eolpos	=	$039E	;^ end of line
				srpos	=	$03A0	;current search pos
				srcnt	=	$03A2	;search counter
				horscr	=	$03A4	;horizontal scrolling
				attflg	=	$03A5	;(1 = block beg, 2 = block end in curr line)
				phrow	=	$03A6	;cursor position
				phcol	=	$03A7
				statobs	=	$03A8	;0 = invalid status line
				edcol	=	$03A9	;column
				attchg	=	$03AA	;FF = attribute changes in curr line
				sropt	=	$03AB	;options for search
	; 1=entire words,  2=replace without query
	; 4=upper = lower, 8=global
	;10=backwards     20=L (?)
				srmode	=	$03AC	;0=search, FF=search and replace
				editflg	=	$03AD	;? never referenced !
				bkhide	=	$03AE	;FF = invisible block
				scrfl1	=	$03AF	;FF = short redisplay
				statera	=	$03B0	;# chars to delete in status line
				oldlen	=	$03B1	;old length curr line
				dislin	=	$03B2	;redisplay from line ...
				overflg	=	$03B3	;0 = overwrite, FF = insert
				indntflg	=	$03B4	;0 = normal, FF = indent
				disflg	=	$03B6	;FF = don't display
				scrfl2	=	$03B7	;redisplay: 0 = small displacement
				bkbegl	=	$03BA	;^ block beg in curr line
				bkendl	=	$03BC	;^ block end in curr line
				edpos	=	$03BE	;^ current line
				lnpos	=	$03C0	;pos in line buffer
				posfifo	=	$03C2	;old position for ^QP
				pfifosrc	=	$03C5
				qppos	=	$03C6
				qppos1	=	$03C8
				pfifodst	=	$03C9	;(for block transfer)
				cmdbuf	=	$03CA	;buffer for command entry
				cmdbuf1	=	$03CB
				srword	=	$03CE	;max length of search word
				srword1	=	$03CF	;length
				srword2	=	$03D0	;string
				srrepl	=	$03EF	;replace word
				srrepl1	=	$03F0
				srrepl2	=	$03F1
				stopt	=	$0410	;options for search / replace
				sropt1	=	$0411
				fnbuf	=	$041D	;buffer for filename entry
				fnbuf2	=	$041F
				fnbufend	=	$0460
				nbkbeg	=	$0461	;block transfer destination
				nbk	=	$0463	;block
				sepptr	=	$0465	;^ word separator table
				explen	=	$0467	;expected length
				curpast	=	$0469	;1 = cursor past end of line
				line0	=	$046B
				line	=	$046C	;buffer: current line
				lineend0	=	$04E9
				lineend1	=	$04EA
				lineend	=	$04EB
				dmabuf	=	$04EE	;buffer for redisplay
				scrseg	=	$0590	;segment of video memory
				scrrow	=	$0592	;video row
				scrbad	=	$0593	;"FF = snowy screen
	;compiler variables
				spsav	=	$0594	;SP at start
				symtop	=	$0596	;current end of symbol table
				symtop2	=	$0598	;end of symbol table
				ptcbeg	=	$059A	;^ beg symbol table, patch list
				tyfence	=	$059C	;limit for undefined pointer types
				fence	=	$059E	;limit for search on new definition
				pc	=	$05A0	;PC of emitted code
				dc	=	$05A2	;data offset of emitted code
				varspc	=	$05A4	;space used on stack
				cdptr	=	$05A6	;^ into code buffer
				cdbufpt	=	$05A8	;PC of beg code buffer
				cdbegpt	=	$05AA	;^ code buffer
				cdfoff	=	$05AC	;buffer's offset in file
				cdprcoff	=	$05AD	;offset for overlay
				cdfoff1	=	$05AE
				lincnt	=	$05B0	;line counter
				cdinval	=	$05B2	;<> 0: invalid code
				recnum	=	$05B3	;number of current record
				reccnt	=	$05B4	;record counter
				scalcnt	=	$05B5	;enumeration type counter
				srcend	=	$05B6	;<> 0: end of source reached
				lexnest	=	$05B7	;lexical nesting
				flgpshax	=	$05B8	;<> 0: save AX on stack
				flgpshes	=	$05B9	;<> 0: save ES on stack
				flgpshdi	=	$05BA	;<> 0: save DI on stack
				usrint	=	$05BB	;<> 0: user interrupt used
				ovrcnt	=	$05BC	;overlay counter
				inclflg	=	$05BD	;FF = include file used
				cmaxfil	=	$05BF	;max number of open files
				cinpsize	=	$05C1	;size of std input buffer
				coutsize	=	$05C3	;size of std output buffer
				direct	=	$05C5	;compiler directives:
	; 1 = I/O check
	; 2 = range check
	; 4 = I/O mode (CON or TRM)
	; 8 = value for CBreak
	;10 = user interrupt
	;20 = stack check
	;40 = type check
	;80 = device check
				destpn	=	$05C7	;object filename
				destpne	=	$0603
				dstfile	=	$0607	;object file handle
				ptctop	=	$0609	;current end of patch list
				ptcend	=	$060B	;limit for patch list
				srcptr	=	$060D	;^ into text
				srclnbeg	=	$060F	;^ beg of source line
				chptr	=	$0611	;^ into line buffer
	;variable entry 1:
				indflg	=	$0615	;<> 0: indexed var
				indptflg	=	$0616	;<> 0: indirect via pointer
				varseg	=	$0617	;segment (FF=DS, FE=CS, FD=ES, else:
	;lexical nesting
				varofs	=	$0618	;variable offset
				vartp	=	$061A	;type
				varctp	=	$061C	;element type
				varnest	=	$061D	;<>0: record #, FF: undef pointer
				lower	=	$061E	;lower bound or ^ index type
				upper	=	$0620	;upper bound or ^ element type
				varsize	=	$0622	;variable size
				parm1end	=	$0624
				parm2	=	$0625	;variable entry 2
				var2ctp	=	$062C	;type
				lower2	=	$062E	;lower bound
				upper2	=	$0630	;upper bound
				var2size	=	$0632	;size
				maxsize	=	$0634	;max size for variant records
				uncrlink	=	$0636	;link for uncrunch list
				flgvar	=	$0638	;F = VAR parameter
				vrecflg	=	$0639	;number of record variant
				procfnc	=	$063A	;procedure or function
				ovrproc	=	$063B	;<>0: overlay procedure
				absflg	=	$0647	;FF = Absolute variable
				var3ofs	=	$0648	;offset
				var3seg	=	$064A	;segment
				ovrlen	=	$064C	;max length of overlay procedures in a file
				creal1	=	$064E	;buffer for real constant
				creal2	=	$0650
				creal3	=	$0652
				cresign	=	$0653
				stklev	=	$0654	;stack use (WITH, FOR, display)
				casectp	=	$0655	;CASE element type
				direcsv	=	$0656	;directives at beg of statement
				brnchop	=	$0658	;branch op on comparision
				rdlnflg	=	$0659	;flag: Read / ReadLn
				forptr	=	$065A	;pointer for FOR: TO / DOWNTO
				withnest	=	$065C	;WITH nesting
				inlinflg	=	$065D	;inline flag
				withtab	=	$065E	;WITH table: record number, segment
				withtab1	=	$0660	;offset, FFFF = indexed
				functp	=	$069E	;^ result type
				comptp	=	$06A0	;^ type for comparison
				oldpc	=	$06A2	;PC before translation of this atom
				negflg	=	$06A4	;negation flag
				exres	=	$06A6	;integer constant
				cxbuf	=	$06A8	;buffer for CX
				direcin	=	$06AA	;directives before include
				semiflg	=	$06AC	;flag for missing ; error
				wordflg	=	$06AD	;type of word read
				typept	=	$06AE	;^ type
				sympos	=	$06B0	;^ into symbol table
				wrdend	=	$06B2	;end of word read
				retbuf	=	$06B4	;buffer for return address
				inclpn	=	$06B6	;include filename
				incfile	=	$06F6	;include file handle
				bufpt	=	$06F8	;include pointer
				bufend	=	$06FA	;end of include buffer
				srclnbg	=	$06FC	;beg of line in buffer
				frelpos	=	$06FE	;relative position in file
				ptcbuf1	=	$0700	;buffer for patch
				wordbuf	=	$0702	;buffer for word, filename, string...
				wrdbuf1	=	$0703
				inclbuf	=	$0782	;include buffer
				txstrt	=	$0802	;"beg of text space / error messages
0100	JMP	start	;"jump to main code
0103	B	$90,$90,$CD,$AB
0107	B	"Copyright (C) 1985 BORLAND Inc"
0125	B	$02,$04,$00
0128	W	ecmd1	;ptrs for TINST.COM
012A	B	$00
012B	W	errpath
012D	B	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
013B	B	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
0149	B	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
0155displstr	B	$14,"Default display mod"
0169	B	$65
016Atxwinx2	B	$50	;lower edge of text window
016Btxwiny2	B	$19
016C	B	$01,$FF,$FF
016Fattmono	B	$0F,$07,$07,$70	;monochrome attributes
0173attbwgr	B	$0F,$07,$07,$70	;mono graphic atts
0177attcolgr	B	$0E,$07,$07,$4F	;"color graphic atts
017Bputstr	CS:		;put attribute string
017C	MOV.B	AH,[BX]	;length
017E	OR.B	AH,AH
0180	STC	
0181	JZ	puts2	;nothing to put
0183putstrl	INC	BX	;next char
0184	CS:	
0185	MOV.B	AL,[BX]	;get it
0187	PUSH	AX	;save cnt
0188	CALL	conput	;put CRT
018B	POP	AX
018C	DEC.B	AH	;another one ?
018E	JNZ	putstrl	;:yes
0190	CLC	
0191puts2	RET		;"
0192meascnt	W	$0000
0194measdone	B	$00
0195vtimer	W	$0000	;"space for timer int vector
0197vtimer1	W	$0000
0199msspeed	MOV	delaycnt,#$006E	;measure CPU speed
019F	CS:		;measurement value
01A0	MOV.B	measdone,#$00	;flag:not done
01A5	MOV	SI,#timvec	;ptr to timer INT
01A8	ES:	
01A9	MOV	AX,[SI]
01AB	CS:	
01AC	MOV	vtimer,AX	;save it
01AF	ES:	
01B0	MOV	AX,[SI]$02
01B3	CS:	
01B4	MOV	vtimer1,AX
01B7	CLI	
01B8	ES:	
01B9	MOV	[SI],#msint1
01BD	ES:	
01BE	MOV	[SI]$02,CS
01C1	STI		;INT ok again
01C2	JMP.b	mssploop	;"measurement loop
01C4msint1	PUSH	DS	;first INT entry
01C5	PUSH	AX
01C6	XOR	AX,AX
01C8	MOV	DS,AX
01CA	MOV	timvec,#msint2	;set second vector
01D0	CS:	
01D1	MOV	meascnt,AX	;clear counter
01D4	POP	AX
01D5	POP	DS
01D6	CS:	
01D7	JMPF	[vtimer]	;"do timer routine
01DBmsint2	CS:		;second INT entry
01DC	MOV.B	measdone,#$FF	;set flag:done
01E1	CS:	
01E2	JMPF	[vtimer]	;"do timer routine
01E6mssploop	CALL	delay1ms	;wait one step
01E9	CS:	
01EA	INC	meascnt	;count those steps
01EE	CS:	
01EF	CMP.B	measdone,#$FF	;done ?
01F4	JNZ	mssploop	;no, continue counting
01F6	CS:	
01F7	MOV	AX,vtimer1	;restore timer INT vec
01FA	CLI	
01FB	ES:	
01FC	MOV	[SI]$02,AX
01FF	CS:	
0200	MOV	AX,vtimer
0203	ES:	
0204	MOV	[SI],AX
0206	STI		;INT ok again
0207	CS:	
0208	MOV	AX,meascnt	;number of steps done
020B	ADD	AX,AX	;*2
020D	MOV	delaycnt,AX	;-> result
0210	RET		;"
0211delaybx	MOV	AX,BX	;Delay(BX)
0213xdelay	MOV	CX,AX	;DELAY(AX)
0215	JCXZ	delay2	;:no delay
0217delay1	CALL	delay1ms	;delay 1ms
021A	LOOP	delay1
021Cdelay2	RET		;"
021Ddelay1ms	PUSH	CX	;Delay 1 ms
021E	MOV	CX,delaycnt	;get count for 1ms
0222delay3	LOOP	delay3	;do it
0224	POP	CX	;restore cnt
0225	RET		;"
0226xclrscr	PUSH	BP	;CLRSCR
0227	MOV	AH,#$0F	;get screen stat
0229	INT	bioscrt
022B	POP	BP
022C	CMP.B	AL,scrmod	;= current screen mode ?
0230	JZ	clrscr1	;:ok
0232	MOV	AL,scrmod	;no: do set it
0235	JMP	xtxtmode	;'
0238clrscr1	PUSH	BP
0239	MOV	AX,#$0600	;scroll window up, 0 lines
023C	MOV.B	BH,attcur
0240	MOV	CX,txwinx1	;upper left edge
0244	CS:	
0245	MOV	DX,txwinx2	;lower right edge
0249	DEC.B	DH
024B	DEC.B	DL
024D	INT	bioscrt	;clear window
024F	MOV	AH,#$02	;set cursor position
0251	MOV	DX,txwinx1	;upper left edge
0255	XOR.B	BH,BH
0257	INT	bioscrt	;do it
0259	POP	BP
025A	RET		;"
025Bxdelline	PUSH	BX	;DelLine
025C	PUSH	CX
025D	PUSH	DX
025E	PUSH	BP
025F	CALL	getcpos	;get cursor pos
0262	MOV	AH,#$06	;scroll window up
0264doscroll	MOV	AL,#$01	;one line
0266	MOV.B	BH,attcur
026A	MOV.B	CH,DH
026C	MOV.B	CL,txwinx1	;upper left edge
0270	CS:	
0271	MOV	DX,txwinx2	;lower right of window
0275	DEC.B	DH
0277	DEC.B	DL
0279	CMP.B	CH,DH	;same ?
027B	JNZ	dellin1	;:no
027D	XOR.B	AL,AL	;no lines
027Fdellin1	INT	bioscrt	;do it
0281	POP	BP
0282	POP	DX
0283	POP	CX
0284	POP	BX
0285	RET		;"
0286xinsline	PUSH	BX	;InsLine
0287insline2	PUSH	CX
0288	PUSH	DX
0289	PUSH	BP
028A	CALL	getcpos	;get cursor pos
028D	MOV	AH,#$07	;scroll window down
028F	JMP	doscroll	;"as above
0291xlowvid	PUSH	AX	;LowVideo
0292	MOV	AL,attlow	;set low attribute
0295	MOV	attcur,AL
0298	POP	AX
0299	RET		;"
029Axnormvid	PUSH	AX	;NormVideo, HighVideo
029B	MOV	AL,attnrm	;set normal attribute
029E	MOV	attcur,AL
02A1	POP	AX
02A2	RET		;"
02A3getcpos	MOV	AH,#$03	;get cursor position
02A5	XOR.B	BH,BH	;page 0
02A7	INT	bioscrt	;do it
02A9	RET		;"
02AAxclreol	PUSH	BX	;ClrEol
02AB	PUSH	CX
02AC	PUSH	DX
02AD	PUSH	BP
02AE	CALL	getcpos	;get cursor pos
02B1	MOV	AX,#$0600	;clear window
02B4	MOV.B	BH,attcur
02B8	MOV	CX,DX	;pos -> upper left
02BA	CS:	
02BB	MOV.B	DL,txwinx2	;X-position
02BF	DEC.B	DL	;Y-pos from current pos
02C1	INT	bioscrt	;do it
02C3	POP	BP
02C4	POP	DX
02C5	POP	CX
02C6	POP	BX
02C7	RET		;"
02C8xcrtinit	CALL	xnosound	;CrtInit
02CB	CS:		;Screen mode
02CC	MOV	AL,scrmodch	;defined with TINST
02CF	CMP	AL,#$FF
02D1	JNZ	xtxtmode	;do change it
02D3	PUSH	BP
02D4	MOV	AH,#$0F	;get current screen mode
02D6	INT	bioscrt
02D8	POP	BP
02D9xtxtmode	MOV.B	txwinx1,#$00	;TextMode
02DE	MOV.B	txwiny1,#$00	;set window
02E3	MOV.B	grmod,#$FF	;no graphics mode
02E8	CMP	AL,#$07	;monochrome ?
02EA	MOV	BH,#$50
02EC	MOV	BL,#$00
02EE	MOV	SI,#attmono	;ptr to screen attributes
02F1	JZ	txtmd3	;:yes, mono
02F3	MOV	SI,#attcolgr
02F6	CMP	AL,#$02	;BW80 ?
02F8	JZ	txtmd2	;:yes
02FA	CMP	AL,#$04
02FC	JB	txtmd1	;:C80, C40, BW40
02FE	MOV	AL,#$03
0300txtmd1	MOV	BL,#$FF
0302	CMP	AL,#$03	;C80 ?
0304	JZ	txtmd3	;:yes
0306	MOV	BH,#$28
0308	CMP	AL,#$01	;C40 ?
030A	JZ	txtmd3	;:yes
030C	XOR.B	AL,AL	;monochrome
030E	MOV	BL,#$00
0310txtmd2	MOV	SI,#attbwgr
0313txtmd3	MOV	scrmod,AL	;set screen mode
0316	MOV.B	coltxt,BL	;color or mono
031A	CS:	
031B	MOV.B	txwinx2,BH	;set screen size
031F	CS:	
0320	MOV	AX,[SI]	;get screen attributes
0322	MOV	attnrm,AX
0325	CS:	
0326	MOV	AX,[SI]$02
0329	MOV	att2,AX
032C	PUSH	BP
032D	MOV	AH,#$0F	;get screen status
032F	INT	bioscrt
0331	CMP.B	AL,scrmod	;correct mode ?
0335	JZ	txtmd4	;:yes
0337	MOV	AL,scrmod
033A	XOR.B	AH,AH	;set screen mode
033C	INT	bioscrt
033Etxtmd4	POP	BP
033F	JMP	xnormvid	;"
0342xcrtexit	RET		;"CrtExit
0343setcpos	PUSH	AX	;Set cursor position
0344	PUSH	BX	;DL=row
0345	PUSH	CX	;DH=col
0346	PUSH	DX	;pos relative to curr window
0347	PUSH	SI
0348	PUSH	DI
0349	PUSH	BP
034A	PUSHF	
034B	XCHG.B	DL,DH
034D	ADD	DX,txwinx1	;add window pos
0351	CS:	
0352	CMP.B	DH,txwiny2	;over edge of screen ?
0356	JNB	setcbad	;:yes
0358	CS:	
0359	CMP.B	DL,txwinx2
035D	JNB	setcbad	;:yes
035F	MOV	AH,#$02	;set cursor
0361	XOR.B	BH,BH	;page 0
0363	INT	bioscrt
0365setcbad	POPF	
0366	POP	BP
0367	POP	DI
0368	POP	SI
0369	POP	DX
036A	POP	CX
036B	POP	BX
036C	POP	AX
036D	RET		;"
036Exupcase	JMP	upcase	;"UpCase
0371xwherex	CALL	getcpos	;WhereX
0374	MOV.B	AL,DL	;get cursor pos
0376	SUB.B	AL,txwinx1	;col-window col
037A	INC.B	AL	;+1
037C	XOR.B	AH,AH
037E	RET		;"
037Fxwherey	CALL	getcpos	;WhereY
0382	MOV.B	AL,DH	;get cursor pos
0384	SUB.B	AL,txwiny1	;row-window row
0388	INC.B	AL	;+1
038A	XOR.B	AH,AH
038C	RET		;"
038Dxwindow	POP	BX	;Window
038E	CMP	AL,#$19	;Row 2 - limit to 25
0390	JA	window1	;:too much
0392	CS:	
0393	MOV	txwiny2,AL	;set it
0396window1	POP	AX	;Col 2
0397	CMP	AL,#$50	;limit to 80
0399	JA	window2	;:too much
039B	CS:	
039C	MOV	txwinx2,AL	;set it
039Fwindow2	POP	AX	;Row 1
03A0	CS:	
03A1	CMP.B	AL,txwiny2	;> row 2 ?
03A5	JNB	window3	;: no good
03A7	DEC.B	AL
03A9	MOV	txwiny1,AL	;set it
03ACwindow3	POP	AX	;Col 1
03AD	CS:	
03AE	CMP.B	AL,txwinx2	;> col 2
03B2	JNB	window4	;:no good
03B4	DEC.B	AL
03B6	MOV	txwinx1,AL	;set it
03B9window4	JMP	BX	;"return
03BBxtxtcol	AND	AL,#$1F	;TextColor
03BD	TEST	AL,#$10	;Blink ?
03BF	JZ	txtcol1	;:no
03C1	AND	AL,#$0F
03C3	OR	AL,#$80	;set blink flag
03C5txtcol1	AND.B	attcur,#$70
03CA	OR.B	attcur,AL	;set new attribute
03CE	RET		;"
03CFxtxtbg	AND	AL,#$07	;TextBackground
03D1	MOV	CL,#$04
03D3	SHL.B	AL,CL
03D5	AND.B	attcur,#$8F
03DA	OR.B	attcur,AL	;set attribute
03DE	RET		;"
03DFsetgmod	PUSH	BP	;Set graphic mode
03E0	MOV	grwinx2,AX	;X-size
03E3	MOV	grwinx1,#$0000	;clear window
03E9	MOV	grwiny1,#$0000
03EF	MOV	grwiny2,#$00C7	;Y-size = 199
03F5	MOV	AL,grmod
03F8	XOR.B	AH,AH
03FA	INT	bioscrt	;set graph mode
03FC	XOR	BX,BX
03FE	MOV.B	grback,BL	;clear background
0402	MOV	AH,#$0B	;set palette -> backgrnd
0404	INT	bioscrt
0406	INC.B	BH	;set foregrnd
0408	MOV	AH,#$0B
040A	INT	bioscrt	;set palette
040C	POP	BP
040D	RET		;"
040Exgrcolmd	MOV.B	grmod,#$04	;GraphColorMode
0413setgmod2	MOV	AX,#$013F	;X-size = 319
0416	JMP	setgmod	;'set it
0418xgrmode	MOV.B	grmod,#$05	;GraphMode
041D	JMP	setgmod2	;"set it
041Fxhires	MOV.B	grmod,#$06	;Hires
0424	MOV	AX,#$027F	;X-size = 639
0427	CALL	setgmod	;set it
042A	MOV	AX,#$000F	;set background
042D	JMP.b	xhirscol	;"
042Fxgrbg	AND	AL,#$0F	;GraphBackground
0431	MOV.B	AH,grback	;get old color
0435	AND.B	AH,#$10
0438	OR.B	AL,AH
043A	MOV	grback,AL	;store it
043Dsetbg	PUSH	BP	;set graph background
043E	XOR.B	BH,BH
0440	MOV.B	BL,grback
0444	MOV	AH,#$0B	;set palette
0446	INT	bioscrt	;do it
0448	POP	BP
0449	RET		;"
044Axpalette	PUSH	BP	;set palette AL
044B	MOV.B	BL,grback	;get current color
044F	AND.B	BL,#$EF	;clear palette
0452	MOV	AH,#$02
0454	CMP.B	grmod,#$04	;color graphics ?
0459	JZ	setpal1	;yes
045B	MOV	AH,#$01
045Dsetpal1	CMP.B	AL,AH
045F	JB	setpal2
0461	SUB.B	AL,AH	;upper bit: part of backgnd
0463	OR.B	BL,#$10
0466setpal2	MOV.B	grback,BL	;set it
046A	MOV	BH,#$01	;set palette
046C	MOV.B	BL,AL	;palette number
046E	MOV	AH,#$0B
0470	INT	bioscrt	;do it
0472	POP	BP
0473	JMP	setbg	;"set backgnd color
0475xhirscol	PUSH	BP	;HiresColor
0476	MOV	BX,AX	;as background
0478	MOV	AH,#$0B	;set palette
047A	INT	bioscrt	;do it
047C	POP	BP
047D	RET		;"
047Exgrwindw	POP	BX	;GraphWindow
047F	MOV	CX,#$027F	;max. X = 639
0482	CMP.B	grmod,#$06	;Hires ?
0487	JZ	gwind1	;:yes
0489	MOV	CX,#$013F	;max. X = 319
048Cgwind1	CMP	AX,#$00C7	;Y2 > 199
048F	JA	gwind2	;:no good
0491	MOV	grwiny2,AX	;set Y2
0494gwind2	POP	AX	;X2
0495	CMP	AX,CX	;> max X ?
0497	JA	gwind3	;:no good
0499	MOV	grwinx2,AX	;set X2
049Cgwind3	POP	AX	;Y1
049D	CMP	AX,grwiny2	;>= Y2 ?
04A1	JNB	gwind4	;:no good
04A3	MOV	grwiny1,AX	;set Y1
04A6gwind4	POP	AX	;X1
04A7	CMP	AX,grwinx2	;>= X2 ?
04AB	JNB	gwind5	;:no good
04AD	MOV	grwinx1,AX	;set X1
04B0gwind5	JMP	BX	;"return
04B2xplot	POP	BX	;Plot
04B3	POP	DX	;Y-pos
04B4	POP	CX	;X-pos
04B5	PUSH	BX	;restore return addr
04B6	MOV	AH,#$0C	;set point, AL is color
04B8doplot	OR	CX,CX	;test X-pos (do clipping)
04BA	JS	noplot	;negative: clip it
04BC	ADD	CX,grwinx1	;add window offset
04C0	CMP	CX,grwinx2	;outside window ?
04C4	JA	noplot	;yes: clip it
04C6	OR	DX,DX	;test Y-pos
04C8	JS	noplot	;negative: clip it
04CA	ADD	DX,grwiny1	;add window offset
04CE	CMP	DX,grwiny2	;outside window ?
04D2	JA	noplot	;yes: clip it
04D4	PUSH	BP
04D5	INT	bioscrt	;do plot
04D7	POP	BP
04D8noplot	RET		;"
04D9xdraw	MOV	AH,#$0C	;Line. AL is color
04DB	MOV	collin,AX	;set color, command:plot
04DE	POP	DI	;return addr
04DF	POP	AX	;Y2
04E0	POP	DX	;X2
04E1	POP	BX	;Y1
04E2	MOV	lnypos,BX	;store it
04E6	CALL	getdelta	;calculate direction
04E9	MOV	lnydir,CX	;store it
04ED	CALL	iabs	;ABS(AX)
04F0	XCHG	AX,DX	;DX:=Y-distance YD
04F1	POP	BX	;X1
04F2	PUSH	DI	;restore ret addr
04F3	MOV	lnxpos,BX	;store X1
04F7	CALL	getdelta	;calculate direction
04FA	MOV	lnxdir,CX	;store it
04FE	CALL	iabs	;ABS(AX)
0501	MOV	BX,AX	;BX:=X-distance XD
0503	CMP	BX,DX	;XD <= YD ?
0505	JLE	lnyline	;yes:Y-oriented line
0507	MOV	AX,DX	;X-oriented line
0509	ADD	AX,AX
050B	SUB	AX,BX
050D	MOV	lndda,AX	;DDA:=YD+YD-XD
0510	MOV	CX,BX	;XD -> count
0512	INC	CX
0513lnxloop	CALL	lnplot	;plot point with clipping
0516	MOV	AX,lndda	;test DDA
0519	OR	AX,AX
051B	JLE	lnxnostp	;:no step
051D	ADD	AX,DX	;DDA:=DDA+YD+YD-XD-XD
051F	ADD	AX,DX
0521	SUB	AX,BX
0523	SUB	AX,BX
0525	MOV	lndda,AX
0528	MOV	AX,lnydir	;Ypos:=Ypos+Ydir
052B	ADD	lnypos,AX
052F	JMP.b	lnxcont	;'
0531lnxnostp	ADD	AX,DX	;DDA:=DDA+YD+YD;
0533	ADD	AX,DX
0535	MOV	lndda,AX
0538lnxcont	MOV	AX,lnxdir	;Xpos:=Xpos+Xdir
053B	ADD	lnxpos,AX
053F	LOOP	lnxloop	;another step
0541	RET		;'
0542lnyline	MOV	AX,BX	;Y-oriented line
0544	ADD	AX,AX
0546	SUB	AX,DX
0548	MOV	lndda,AX	;DDA:=XD+XD-YD
054B	MOV	CX,DX	;YD -> count
054D	INC	CX
054Elnyloop	CALL	lnplot	;plot point with clipping
0551	MOV	AX,lndda	;test DDA
0554	OR	AX,AX
0556	JLE	lnynostp	;:no step
0558	ADD	AX,BX	;DDA:=DDA+XD+XD-YD-YD
055A	ADD	AX,BX
055C	SUB	AX,DX
055E	SUB	AX,DX
0560	MOV	lndda,AX
0563	MOV	AX,lnxdir	;Xpos:=Xpos+Xdir
0566	ADD	lnxpos,AX
056A	JMP.b	lnycont	;'
056Clnynostp	ADD	AX,BX	;DDA:=DDA+XD+XD
056E	ADD	AX,BX
0570	MOV	lndda,AX
0573lnycont	MOV	AX,lnydir	;Ypos:=Ypos+Ydir
0576	ADD	lnypos,AX
057A	LOOP	lnyloop	;:another one
057C	RET		;"
057Dgetdelta	XOR	CX,CX	;calculate direction -> CX
057F	SUB	AX,BX	;compare them
0581	JZ	deltazer	;equal: CX=0
0583	JS	deltaneg	;:negative
0585	INC	CX	;positive: CX=1
0586	RET		;'
0587deltaneg	DEC	CX	;negative: CX=-1
0588deltazer	RET		;"
0589lnplot	PUSH	CX	;Set line point with clipping
058A	PUSH	DX	;save count, YD
058B	MOV	AX,collin	;color, command
058E	MOV	CX,lnxpos	;Xpos
0592	MOV	DX,lnypos	;Ypos
0596	CALL	doplot	;plot that point
0599	POP	DX
059A	POP	CX
059B	RET		;"
059Cxsound	MOV	BX,AX	;Sound
059E	MOV	AX,#$34DD	;for frequency calculation
05A1	MOV	DX,#$0012
05A4	CMP	DX,BX	;frequency < 12 Hz ?
05A6	JNB	sounddis	;:might damage speaker
05A8	DIV	BX	;calculate timer value
05AA	MOV	BX,AX
05AC	IN	AL,timerflg	;sound on ?
05AE	TEST	AL,#$03
05B0	JNZ	soundon	;:yes
05B2	OR	AL,#$03	;switch it on
05B4	OUT	timerflg,AL
05B6	MOV	AL,#$B6	;set frequency
05B8	OUT	timercmd,AL
05BAsoundon	MOV.B	AL,BL	;set freq lo
05BC	OUT	timerfrq,AL
05BE	MOV.B	AL,BH	;set freq hi
05C0	OUT	timerfrq,AL
05C2sounddis	RET		;"
05C3xnosound	IN	AL,timerflg	;NoSound
05C5	AND	AL,#$FC	;switch it off
05C7	OUT	timerflg,AL
05C9	RET		;"
05CAxgetmem	XCHG	AX,CX	;GetMem, AX=length requested
05CB	POP	BX	;ret addr
05CC	POP	DI	;dest ptr
05CD	JMP.b	new1	;"like New
05CFhpconv	PUSH	AX	;change representation:
05D0	PUSH	CX	;AX=ofs 0..15, BX=seg
05D1	MOV	CL,#$04
05D3	SHR	AX,CL
05D5	ADD	BX,AX	;seg:=seg+ofs DIV 16
05D7	POP	CX
05D8	POP	AX
05D9	AND	AX,#$000F	;ofs:=ofs MOD 16
05DC	RET		;"
05DDhpcmp	CMP	BX,DX	;Compare BX:AX with DX:CX
05DF	JNZ	hpcmp1
05E1	CMP	AX,CX
05E3hpcmp1	RET		;"
05E4hpadd	ADD	AX,CX	;BX:AX + DX:CX -> BX:AX
05E6	ADD	BX,DX
05E8	JMP	hpconv	;"change representation
05EAhplen	ES:		;Get length of entry
05EB	MOV	AX,[DI]$04
05EE	ES:	
05EF	MOV	BX,[DI]$06
05F2	PUSH	AX
05F3	OR	AX,BX	;test if end of heap = 0
05F5	POP	AX
05F6	RET		;"
05F7xnew	POP	BX	;New
05F8new1	POP	ES	;dest ptr
05F9	PUSH	BX	;restore ret
05FA	MOV	hpdstpt,DI	;save addr dest ptr
05FE	MOV	hpdstpt1,ES
0602	MOV	AX,CX	;number of bytes wanted
0604	ADD	AX,#$0007	;+7
0607	MOV	BX,#$1000	;carry ?
060A	JB	new2	;:yes
060C	XOR	BX,BX	;no carry
060Enew2	AND	AL,#$F8	;space allocated is n*8
0610	CALL	hpconv	;convert to seg,ofs
0613	MOV	CX,AX	;needed size
0615	MOV	DX,BX
0617	MOV	hplast,#$0022	;last entry
061D	MOV	hplast1,DS
0621	LES	DI,hpstrt	;get start of heap
0625newseek	CALL	hplen	;get len of entry
0628	JZ	newend	;:end of heap
062A	CALL	hpcmp	;sufficient size ?
062D	JNB	newfnd	;:large enough
062F	MOV	hplast,DI	;remember last entry
0633	MOV	hplast1,ES
0637	ES:		;get next entry
0638	LES	DI,[DI]
063A	JMP	newseek	;'continue searching
063Cnewfnd	CALL	newdest	;store ES:DI to dest ptr
063F	JZ	newfits	;equal - nothing to crunch
0641	SUB	AX,CX	;calculate superfluous mem
0643	SBB	BX,DX
0645	AND	AX,#$000F
0648	JMP.b	newrem	;'mark the remainder as free
064Anewfits	ES:		;get next entry
064B	LES	DI,[DI]
064D	JMP.b	newlink	;'set link to it
064Fnewend	CALL	newdest
0652	MOV	AX,DI
0654	MOV	BX,ES
0656	CALL	hpadd	;sum up sizes
0659	MOV	hptop,AX	;new heap top
065C	MOV	hptop1,BX
0660	PUSH	CX	;save size of entry
0661	PUSH	DX
0662	MOV	CX,AX	;test if heap overflow
0664	MOV	DX,BX
0666	MOV	AX,SP	;heap top - stack top
0668	MOV	BX,SS
066A	SUB	BX,#$0E
066D	CALL	hpconv	;convert sp
0670	XOR	AX,AX
0672	CALL	hpcmp	;compare them
0675	POP	DX
0676	POP	CX
0677	JA	newmemok	;:ok
0679	JMP	chkstk1	;'Error FF - memory overflow
067Cnewmemok	XOR	AX,AX	;mark next entry
067E	XOR	BX,BX	;as end of heap
0680newrem	PUSH	BX	;save length
0681	PUSH	AX
0682	ES:		;save ptr to next entry
0683	PUSH	[DI]$02
0686	ES:	
0687	PUSH	[DI]
0689	MOV	AX,DI	;try to put together with
068B	MOV	BX,ES	;next entry
068D	CALL	hpadd	;calc end of this entry
0690	MOV	DI,AX	;new top
0692	MOV	ES,BX
0694	ES:		;now produce that entry
0695	POP	[DI]	;link
0697	ES:	
0698	POP	[DI]$02
069B	ES:	
069C	POP	[DI]$04	;length
069F	ES:	
06A0	POP	[DI]$06
06A3newlink	PUSH	ES	;save ES
06A4	PUSH	ES
06A5	LES	SI,hplast	;store ES:DI in last
06A9	ES:		;entry as link to next entry
06AA	MOV	[SI],DI
06AC	ES:	
06AD	POP	[SI]$02
06B0	POP	ES	;restore ES
06B1	RET		;"
06B2newdest	PUSH	ES	;store ES:DI in dest ptr
06B3	PUSH	ES
06B4	LES	SI,hpdstpt
06B8	ES:	
06B9	MOV	[SI],DI
06BB	ES:	
06BC	POP	[SI]$02
06BF	POP	ES
06C0	RET		;"
06C1xfreemem	XCHG	AX,CX	;FreeMem
06C2	POP	BX	;ret addr
06C3	POP	DI	;get ptr
06C4	JMP.b	disp1	;'like Dispose
06C6xdispose	POP	BX	;Dispose
06C7disp1	POP	ES	;get dest ptr
06C8	PUSH	BX	;restore ret
06C9	MOV	AX,CX	;number of bytes
06CB	ES:	
06CC	MOV	CX,[DI]	;get value of ptr
06CE	ES:	
06CF	MOV	DX,[DI]$02
06D2	ADD	AX,#$0007	;size+7
06D5	MOV	BX,#$1000	;carry ?
06D8	JB	disp2	;:yes
06DA	XOR	BX,BX	;no carry
06DCdisp2	AND	AL,#$F8
06DE	CALL	hpconv
06E1	MOV	hpesize,AX	;save size of
06E4	MOV	hpesize1,BX	;entry to erase
06E8	LES	DI,hpstrt	;start at the beginning
06EC	MOV	AX,DI
06EE	MOV	BX,ES
06F0	CALL	hpcmp	;= entry to erase ?
06F3	JNB	dispdel	;:no free space before
06F5dispseek	ES:		;get link
06F6	MOV	AX,[DI]
06F8	ES:	
06F9	MOV	BX,[DI]$02
06FC	CALL	hpcmp	;compare with our entry
06FF	JNB	dispfnd
0701	MOV	DI,AX	;go to next entry
0703	MOV	ES,BX
0705	JMP	dispseek	;'continue
0707dispfnd	PUSH	ES	;ES:DI last entry
0708	MOV	SI,CX	;DX:CX searched one
070A	MOV	ES,DX	;AX:BX current entry
070C	PUSH	hpesize1
0710	PUSH	hpesize
0714	ES:		;store link in disposed entry
0715	MOV	[SI],AX
0717	ES:	
0718	MOV	[SI]$02,BX
071B	ES:		;store length
071C	POP	[SI]$04
071F	ES:	
0720	POP	[SI]$06
0723	POP	ES	;restore ES
0724	ES:	
0725	MOV	[DI],CX	;store addr in last entry
0727	ES:	
0728	MOV	[DI]$02,DX
072B	ES:	
072C	MOV	AX,[DI]$04	;get length of this entry
072F	ES:	
0730	MOV	BX,[DI]$06
0733	CALL	dispmerg	;try to put them together
0736	JZ	dispdone	;:end of heap
0738	ES:		;get addr of next one
0739	LES	DI,[DI]
073Bdispdone	ES:		;get length of this entry
073C	MOV	AX,[DI]$04
073F	ES:	
0740	MOV	BX,[DI]$06
0743	ES:		;get link of this entry
0744	MOV	CX,[DI]
0746	ES:	
0747	MOV	DX,[DI]$02
074A	JMP.b	dispmerg	;'try to put them together
074Cdispdel	MOV	hpstrt,CX	;link to next entry
0750	MOV	hpstrt1,DX
0754	MOV	DI,CX	;ptr to this entry
0756	MOV	ES,DX
0758	ES:		;store link to next one
0759	MOV	[DI],AX
075B	ES:	
075C	MOV	[DI]$02,BX
075F	MOV	CX,AX	;link for collect
0761	MOV	DX,BX
0763	MOV	AX,hpesize	;store its len
0766	MOV	BX,hpesize1
076A	ES:	
076B	MOV	[DI]$04,AX
076E	ES:	
076F	MOV	[DI]$06,BX
	;try to merge contiguous entries - thus reducing
	;fragmentation of the heap.
0772dispmerg	MOV	hpmerg,AX	;length of this entry
0775	MOV	hpmerg1,BX
0779	ADD	AX,DI	;+ its address
077B	MOV	BX,ES
077D	ADD	BX,hpmerg1
0781	CALL	hpconv	;convert
0784	CALL	hpcmp	;= next entry ?
0787	JNZ	disprt	;no:cannot put them together
0789	MOV	AX,hptop	;= heap top ?
078C	MOV	BX,hptop1
0790	CALL	hpcmp
0793	JZ	disptop	;yes:set new, lower heap top
0795	PUSH	ES	;save ES
0796	MOV	SI,CX	;addr of next entry
0798	MOV	ES,DX
079A	ES:		;get link to next entry
079B	MOV	AX,[SI]
079D	ES:	
079E	MOV	BX,[SI]$02
07A1	ES:		;get length
07A2	MOV	CX,[SI]$04
07A5	ES:	
07A6	MOV	DX,[SI]$06
07A9	POP	ES	;restore ES
07AA	ES:		;store link
07AB	MOV	[DI],AX
07AD	ES:	
07AE	MOV	[DI]$02,BX
07B1	MOV	AX,hpmerg	;get length
07B4	MOV	BX,hpmerg1
07B8	CALL	hpadd	;add them
07BB	ES:		;store new length
07BC	MOV	[DI]$04,AX
07BF	ES:	
07C0	MOV	[DI]$06,BX
07C3	XOR	AX,AX
07C5	RET		;'
07C6disptop	MOV	hptop,DI	;set new heap top
07CA	MOV	hptop1,ES
07CE	PUSH	DI	;clear 8 bytes
07CF	XOR	AX,AX	;= marker for end of heap
07D1	CLD	
07D2	MOV	CX,#$0004
07D5	REPZ	
07D6	STOS	
07D7	POP	DI	;restore
07D8	XOR	AX,AX
07DAdisprt	RET		;"
07DBxmemavl	XOR	CX,CX	;MemAvail
07DD	XOR	DX,DX	;clear sum
07DF	XOR	SI,SI
07E1	LES	DI,hpstrt	;get heap start
07E5memav1	CALL	hplen	;get length
07E8	JZ	memav2	;:end of heap
07EA	CALL	hpaddcmp	;sum it up, test size
07ED	ES:		;get next entry
07EE	LES	DI,[DI]
07F0	JMP	memav1	;'continue
07F2memav2	MOV	AX,SP	;last entry: free space
07F4	MOV	BX,SS	;between stack and heap
07F6	SUB	BX,#$10	;leave some space
07F9	CALL	hpconv	;convert
07FC	XOR	AX,AX	;clear offset
07FE	SUB	BX,hptop1	;subtract heap top
0802	JB	memav3	;:nothing left
0804	CALL	hpaddcmp	;sum it up
0807memav3	MOV	AX,DX	;space left (paragraphs)
0809	RET		;"
080Ahpaddcmp	CMP	SI,BX	;is it the largest one ?
080C	JNB	hpac2	;:no
080E	MOV	SI,BX	;yes, remember its size
0810hpac2	CALL	hpadd	;sum it up
0813	MOV	CX,AX	;remember sum
0815	MOV	DX,BX
0817	RET		;"
0818xmaxavl	CALL	xmemavl	;MaxAvail: do MemAvail
081B	MOV	AX,SI	;get largest size
081D	RET		;"
081Exmark	POP	BX	;Mark
081F	POP	ES	;get ptr
0820	MOV	AX,hptop	;Heap top -> ptr
0823	ES:	
0824	MOV	[DI],AX
0826	MOV	DX,hptop1
082A	ES:	
082B	MOV	[DI]$02,DX
082E	JMP	BX	;"return
0830xrelease	POP	BX	;Release
0831	POP	ES	;ptr addr
0832	ES:		;get pointer
0833	LES	DI,[DI]
0835	MOV	hptop,DI	;-> heap top
0839	MOV	hpstrt,DI	;-> heap start
083D	MOV	hptop1,ES
0841	MOV	hpstrt1,ES
0845	XOR	AX,AX	;clear 8 bytes in entry
0847	LES	DI,hpstrt	;= marker for end of heap
084B	MOV	CX,#$0004
084E	CLD	
084F	REPZ	
0850	STOS	
0851	JMP	BX	;"return
0853kbdstat	CMP.B	lastkey,#$00	;Get key stat
0858	MOV	AL,#$FF	;something there ?
085A	JNZ	kbdst2	;:true
085C	MOV	AH,#$01	;test kbd stat
085E	INT	bioskbd
0860	MOV	AL,#$00	;false
0862	JZ	kbdst2	;:nothing available
0864	DEC.B	AL	;true
0866kbdst2	AND	AX,#$0001
0869	RET	$0001	;"
086Ckbdget	MOV	AL,lastkey	;Get KBD char
086F	MOV.B	lastkey,#$00	;clear last key code
0874	OR.B	AL,AL
0876	JNZ	kbdg3	;:was full - take it
0878	XOR.B	AH,AH	;get key
087A	INT	bioskbd
087C	OR.B	AL,AL	;test it
087E	JNZ	kbdg2	;:normal char
0880	MOV.B	lastkey,AH	;store scan code
0884	MOV	AL,#$1B	;return ESC
0886	OR.B	AH,AH
0888	JNZ	kbdg3
088A	MOV	AL,#$03	;Break !
088Ckbdg2	CMP.B	cbreak,#$01	;Break allowed ?
0891	JNZ	kbdg3	;:no
0893	CMP	AL,#$03	;Break ?
0895	JNZ	kbdg3	;:no
0897	JMP	brkmsg	;'
089Akbdg3	XOR.B	AH,AH	;clear hi byte
089C	RET	$0001	;"
089Fcrtput	POP	AX	;Print char to screen
08A0	POP	DX	;char to be printed
08A1	PUSH	AX	;restore ret
08A2	PUSH	DX	;save regs
08A3	PUSH	BP
08A4	PUSH	DX
08A5	CALL	getcpos	;get cursor pos
08A8	POP	AX	;char to be printed
08A9	CMP	AL,#$0D	;Carriage Return ?
08AB	JNZ	crtlf	;:no
08AD	MOV.B	DL,txwinx1	;go to left margin
08B1	JMP.b	crtsetps	;'set new pos
08B3crtlf	CMP	AL,#$0A	;Line Feed ?
08B5	JNZ	crtbs	;:no
08B7	INC.B	DH	;add 1 to line
08B9	CS:	
08BA	CMP.B	DH,txwiny2	;>= bottom ?
08BE	JB	crtsetps	;:no, set pos
08C0	JMP.b	crtscrol	;'scroll up
08C2crtbs	CMP	AL,#$08	;Backspace ?
08C4	JNZ	crtbell	;:no
08C6	CMP.B	DL,txwinx1	;at the left ?
08CA	JZ	crtsetps	;yes, no change
08CC	DEC.B	DL	;go back
08CE	JMP.b	crtsetps	;'set cursor pos
08D0crtbell	CMP	AL,#$07	;Bell ?
08D2	JNZ	crtchar	;:no
08D4	MOV	AH,#$0E	;write char
08D6	XOR.B	BH,BH
08D8	INT	bioscrt
08DA	JMP.b	crttest	;'no pos change
08DCcrtchar	PUSH	DX	;remember position - put char
08DD	MOV	AH,#$09	;write char
08DF	XOR.B	BH,BH	;screen page 0
08E1	MOV	CX,#$0001	;1 char
08E4	MOV.B	BL,attcur	;current attribute
08E8	INT	bioscrt	;do it
08EA	POP	DX	;restore pos
08EB	INC.B	DL	;go right one char
08ED	CS:	
08EE	CMP.B	DL,txwinx2	;= right margin ?
08F2	JB	crtsetps	;:no, set new pos
08F4	MOV.B	DL,txwinx1	;go to the left
08F8	INC.B	DH	;next line
08FA	CS:	
08FB	CMP.B	DH,txwiny2	;= bottom ?
08FF	JB	crtsetps	;no: set pos
0901crtscrol	DEC.B	DH	;scroll up
0903	PUSH	DX	;save pos
0904	MOV	AX,#$0601	;scroll up one line
0907	MOV.B	BH,attcur	;att for empty line
090B	MOV	CX,txwinx1	;position upper left
090F	CS:	
0910	MOV	DX,txwinx2	;position lower right
0914	DEC.B	DH
0916	DEC.B	DL
0918	INT	bioscrt	;do it
091A	POP	DX
091Bcrtsetps	MOV	AH,#$02	;set cursor pos
091D	XOR.B	BH,BH	;screen 0
091F	INT	bioscrt	;do it
0921crttest	POP	BP
0922	CMP.B	cbreak,#$01	;test for break ?
0927	JNZ	crtnobrk	;:no
0929	DEC	SP
092A	CALL	kbdstat	;get key stat
092D	JZ	crtnobrk	;:nothing
092F	DEC	SP
0930	CALL	kbdget	;get key
0933	CMP	AL,#$13	;^S ?
0935	JNZ	crtnobrk	;:no
0937	DEC	SP
0938	CALL	kbdget	;get key
093Bcrtnobrk	POP	AX	;restore char
093C	RET		;"
093Dlstput	POP	AX	;put to LST
093E	POP	DX	;get char
093F	PUSH	AX	;restore ret
0940	MOV	AH,#$05	;operation
0942	JMP.b	dos	;'do MS-DOS
0944	NOP		;Courtesy of LINK
0945auxput	POP	AX	;put to AUX
0946	POP	DX	;get char
0947	PUSH	AX	;restore ret
0948	MOV	AH,#$04	;operation
094A	JMP.b	dos	;'do MS-DOS
094C	NOP	
094Dauxget	MOV	AH,#$03	;Get from AUX
094F	CALL	dos	;do MS-DOS
0952	XOR.B	AH,AH	;clear hi byte
0954	RET	$0001	;'
0957dos	CMP.B	AH,#$3D	;do MS-DOS-operation
095A	JZ	openfil	;:Open file
095C	CMP.B	AH,#$3C
095F	JZ	openfil	;:Create file
0961	CMP.B	AH,#$3E
0964	JZ	closfil	;:Close file
0966	CMP.B	AH,#$80
0969	JZ	closeall	;:Close all files
096Bdodos	PUSH	BP	;save this
096C	INT	msdos
096E	POP	BP	;restore it
096F	RET		;'
0970openfil	PUSH	SI	;put file into table of
0971	PUSH	CX	;open files, open/create it
0972	MOV	SI,filtabpt	;start of file table
0976	MOV	CX,filemax
097Aopenlp	CMP	[SI],#$00	;empty ?
097D	JZ	opendoit	;:yes
097F	INC	SI
0980	INC	SI
0981	LOOP	openlp	;another one
0983	POP	CX	;restore regs
0984	POP	SI
0985	MOV	AX,#$0004	;Error: file not open
0988	STC	
0989	RET		;'
098Aopendoit	POP	CX	;get offset to filename
098B	PUSH	DS	;save DS
098C	PUSH	ES	;ES -> DS
098D	POP	DS
098E	CALL	dodos	;open file
0991	POP	DS	;restore DS
0992	JB	openerr	;:error
0994	MOV	[SI],AX	;file handle -> file list
0996openerr	POP	SI	;restore
0997	RET		;"
0998closfil	PUSH	CX	;Close file
0999	PUSH	SI
099A	MOV	SI,filtabpt	;start of file table
099E	MOV	CX,filemax
09A2closlp	CMP	[SI],BX	;is it this file ?
09A4	JNZ	clsother	;:no
09A6	MOV	[SI],#$0000	;clear its entry
09AAclsother	INC	SI	;next one
09AB	INC	SI
09AC	LOOP	closlp	;:not yet done
09AE	POP	SI	;restore regs
09AF	POP	CX
09B0	JMP	dodos	;'do it
09B2closeall	MOV	SI,filtabpt	;Close all files
09B6	MOV	CX,filemax
09BAclall1	MOV	BX,[SI]	;test all file handles
09BC	OR	BX,BX
09BE	JZ	clall2	;:not open
09C0	MOV	AH,#$3E	;close file
09C2	CALL	dodos	;do it
09C5	MOV	[SI],#$0000	;store a 0: closed
09C9clall2	INC	SI	;next one
09CA	INC	SI
09CB	LOOP	clall1	;:continue
09CD	RET		;"
09CEinitio	XOR	AX,AX	;Init files, I/O
09D0initiofl	MOV	modeflg,AX	;clear flag
09D3	MOV	DI,#filetab	;set pt to file tab
09D6	MOV	filtabpt,DI
09DA	MOV	filemax,CX	;CX=max number of open files
09DE	XOR	AX,AX	;clear file list
09E0	PUSH	DS	;DS -> ES
09E1	POP	ES
09E2	CLD	
09E3	REPZ	
09E4	STOS	
09E5	MOV	ES,AX	;segment 0:
09E7	ES:	
09E8	MOV	verrhnd,#errhndl	;set vector:
09EE	ES:		;error handler
09EF	MOV	verrhnd1,CS
09F3	CALL	msspeed	;measure CPU speed
09F6reinit1	MOV.B	cbreak,#$00	;no test for break
09FBreinit2	MOV	SI,#inittab	;transfer vectors into table
09FE	MOV	DI,#vkbdstat
0A01	PUSH	DS	;DS -> ES
0A02	POP	ES
0A03	PUSH	CS	;CS -> DS
0A04	POP	DS
0A05	MOV	CX,#$001E	;count
0A08	CLD	
0A09	REPZ		;move it
0A0A	MOVS	
0A0B	PUSH	ES	;restore DS
0A0C	POP	DS
0A0D	XOR	AX,AX	;clear vars
0A0F	MOV	lastkey,AX	;no key stored
0A12	MOV	errnum,AL	;no error
0A15	MOV	conbufpt,AX	;no con buf
0A18	MOV	conbfend,AX
0A1B	MOV.B	conbufln,#$7E
0A20	MOV.B	coninbuf,#$0D	;mark end of buffer
0A25	RET		;"
0A26inittab	W	kbdstat,kbdget,crtput,lstput,auxput,auxget,crtput,kbdget
0A36	W	$FFFF,$00C1,$FFFF,$0082,$FFFF,$0043,$FFFF,$00C4,$FFFF
0A48	W	$00C5,$FFFF,$00C1,$0000,$0000,$0000,$0000,$FFFF,$00C1
0A5A	W	$0000,$0000,$0000,$0000	;"
0A62errhndl	IRET		;"Error handler
0A63conput	PUSH	BX	;put to CON
0A64	PUSH	CX	;save registers
0A65	PUSH	DX
0A66	PUSH	DI
0A67	PUSH	SI
0A68	XOR.B	AH,AH
0A6A	PUSH	AX	;char to put
0A6B	CALL	[vconput]	;put it
0A6Fconret	POP	SI	;restore regs
0A70	POP	DI
0A71	POP	DX
0A72	POP	CX
0A73	POP	BX
0A74	RET		;"
0A75keyget	PUSH	BX	;Get from KBD
0A76	PUSH	CX	;save regs
0A77	PUSH	DX
0A78	PUSH	DI
0A79	PUSH	SI
0A7A	DEC	SP
0A7B	CALL	[vkbdget]	;do it
0A7F	JMP	conret	;"restore
0A81prints	PUSH	BP	;Print inline string
0A82	MOV	BP,SP
0A84	XCHG	BX,[BP]$02	;return addr -> BX
0A87prsl	CS:	
0A88	MOV.B	AL,[BX]	;get char
0A8A	INC	BX	;go to next one
0A8B	OR.B	AL,AL	;test it
0A8D	JZ	prsend	;0:end
0A8F	CALL	conput	;put to CRT
0A92	JMP	prsl	;'continue
0A94prsend	XCHG	BX,[BP]$02	;restore ret to pos after text
0A97	POP	BP
0A98	RET		;"
0A99xwriteln	CALL	prints	;Writeln CRT
0A9C	B	$0D,$0A,$00	;print string: CR,LF
0A9F	RET		;"
0AA0upcase	CMP	AL,#$61	;UpCase. < a ?
0AA2	JB	upcas1	;:not lower case
0AA4	CMP	AL,#$7A	;> z ?
0AA6	JA	upcas1	;yes:not lower case
0AA8	SUB	AL,#$20	;change to upper
0AAAupcas1	RET		;"
0AABwhexword	PUSH	AX	;Write Hex number: save it
0AAC	MOV.B	AL,AH	;do hi byte
0AAE	CALL	whexbyte	;do it
0AB1	POP	AX	;restore lo byte
0AB2whexbyte	PUSH	AX	;write hex byte: save low nibble
0AB3	ROR.B	AL,1 	;get hi nibble
0AB5	ROR.B	AL,1 
0AB7	ROR.B	AL,1 
0AB9	ROR.B	AL,1 
0ABB	CALL	whexnib	;do digit
0ABE	POP	AX	;get lo nibble
0ABFwhexnib	AND	AL,#$0F	;mask it
0AC1	ADD	AL,#$90	;convert to hex - tricky
0AC3	DAA	
0AC4	ADC	AL,#$40
0AC6	DAA	
0AC7	JMP	conput	;"now print it
0AC9limstind	OR.B	AH,AH	;limit string index
0ACB	JZ	limst1	;:ok
0ACD	STC		;hi <> 0: error
0ACE	MOV	AX,#$0000	;clear it
0AD1	JS	limst1	;negative:0
0AD3	DEC.B	AL	;+:255
0AD5limst1	RET		;"
	;Init Memory - with inline parms:
	;+ 0:mode flag
	;    1=direct mode;    2=no device checking;
	;    4=test for break; 8=set breakpoint interrupt
	;+ 2:CS for returning to Turbo
	;+ 4:DS for returning to Turbo
	;+ 6:CS size
	;+ 8:DS size
	;+ A:heap, stack size
	;+ C:max. heap, stack size
	;+ E:max. number of open files
	;+10:size of std input buffer
	;+12:size of std output buffer
0AD6initmem	CALL	readvers	;Init memory - with inline parms
0AD9	POP	SI	;ret addr
0ADA	MOV	AX,CS	;calculate segments
0ADC	CS:	
0ADD	ADD	AX,[SI]$06	;+CS size
0AE0	CS:	
0AE1	ADD	AX,[SI]$08	;+DS size
0AE4	CS:	
0AE5	ADD	AX,[SI]$0A	;+heap, stack size
0AE8	CS:	
0AE9	CMP	AX,availmem	;> available memory ?
0AED	JBE	memin1	;:no
0AEF	JMP	memerr	;'Not enough memory
0AF2memin1	MOV	BX,CS	;CS + CS size -> DS
0AF4	CS:	
0AF5	ADD	BX,[SI]$06
0AF8	MOV	DS,BX
0AFA	CS:		;DS + DS size -> beg of free mem
0AFB	ADD	BX,[SI]$08
0AFE	CS:	
0AFF	MOV	DX,availmem
0B03	SUB	DX,BX	;how much is left ?
0B05	CS:	
0B06	CMP	DX,[SI]$0C	;> max size ?
0B09	JB	memin2	;:no
0B0B	CS:	
0B0C	MOV	DX,[SI]$0C	;limit to max size
0B0Fmemin2	MOV	DI,DX	;DI: heap size
0B11	MOV	AX,#$FFFE	;value for full stack
0B14	SUB	DX,#$1000	;64 K free ?
0B18	JNB	memin3	;:yes
0B1A	MOV	AX,DX	;calculate stack size -> AX
0B1C	ADD	AX,#$1000
0B1F	MOV	CL,#$04
0B21	SHL	AX,CL
0B23	XOR	DX,DX	;at beg of heap segment
0B25memin3	ADD	DX,BX	;+ heap segment
0B27	MOV	SS,DX	;-> SS
0B29	MOV	SP,AX	;set SP
0B2B	MOV	spval,AX	;remember SP
0B2E	XOR	AX,AX	;clear heap:
0B30	MOV	hptop,AX	;ptrs to beg of free memory
0B33	MOV	hptop1,BX
0B37	MOV	hpstrt,AX
0B3A	MOV	hpstrt1,BX
0B3E	PUSH	DI	;save heap size
0B3F	LES	DI,hpstrt	;init heap:
0B43	MOV	CX,#$0004	;mark heap top
0B46	CLD	
0B47	REPZ	
0B48	STOS	
0B49	POP	DI	;restore heap size
0B4A	CS:		;return excess memory ?
0B4B	TEST	[SI],#$0001
0B4F	JNZ	memin4	;direct mode:no
0B51	MOV	AX,CS	;CS -> ES
0B53	MOV	ES,AX
0B55	ADD	BX,DI	;Heap pos + Heap size
0B57	SUB	BX,AX	;-> top of used memory
0B59	MOV	AH,#$4A	;change memory blocks
0B5B	CALL	dos	;do MS-DOS
0B5Ememin4	CS:		;set variables
0B5F	MOV	AX,[SI]$02	;CS for return
0B62	MOV	turbocs,AX
0B65	CS:	
0B66	MOV	AX,[SI]$04	;DS for return
0B69	MOV	turbods,AX
0B6C	CS:	
0B6D	MOV	AX,[SI]	;main flag
0B6F	CS:	
0B70	MOV	CX,[SI]$0E	;max file count
0B73	PUSH	CX
0B74	PUSH	SI
0B75	CALL	initiofl	;init files, I/O
0B78	POP	SI
0B79	POP	CX
0B7A	MOV	DI,#filetab	;get end addr
0B7D	ADD	DI,CX	;of file tab
0B7F	ADD	DI,CX
0B81	MOV	stdinof,DI	;buffer addr std input
0B85	CS:	
0B86	MOV	AX,[SI]$10	;set std in buffer
0B89	MOV	stdinsz,AX
0B8C	ADD	DI,AX
0B8E	OR	AX,AX
0B90	JZ	memin5	;:no std in file
0B92	MOV	stdin,#$0000	;set handle: std in
0B98	MOV.B	stdinfl,#$00	;clear flag
0B9Dmemin5	MOV	stdoutof,DI	;buffer addr std output
0BA1	CS:	
0BA2	MOV	AX,[SI]$12	;set std out buffer
0BA5	MOV	stdoutsz,AX
0BA8	OR	AX,AX
0BAA	JZ	memin6	;:no std out file
0BAC	MOV	stdout,#$0001	;set handle: std out
0BB2	MOV.B	stdoutfl,#$00	;clear flag:not open
0BB7memin6	ADD	SI,#$14	;set return addr
0BBA	PUSH	SI
0BBB	XOR	AX,AX	;0 -> ES
0BBD	MOV	ES,AX
0BBF	ES:		;save div / 0 interrupt
0BC0	MOV	AX,div0vec
0BC3	MOV	svintv,AX
0BC6	ES:	
0BC7	MOV	AX,availmem	;div0vec1
0BCA	MOV	svintv1,AX
0BCD	ES:		;now set own routine
0BCE	MOV	div0vec,#div0err
0BD4	ES:	
0BD5	MOV	availmem,CS	;div0vec1
0BD9	TEST	modeflg,#$0008	;set breakpoint int ?
0BDF	JZ	memin7	;:no
0BE1	ES:	
0BE2	MOV	int3vec,#brkint
0BE8	ES:	
0BE9	MOV	int3vec1,CS
0BEDmemin7	TEST	modeflg,#$0004	;test for ^C, ^S ?
0BF3	JZ	memin8	;:no
0BF5	MOV.B	cbreak,#$01	;set flag
0BFAmemin8	MOV	verror,#$10D0	;set error vec
0C00	XOR	AX,AX
0C02	MOV	errpos2,AX	;clear error pos
0C05	MOV	ovrpnbuf,AL	;clear ovrlay pathname
0C08	MOV	CX,stdinsz	;open std in for read
0C0C	PUSH	DS
0C0D	MOV	DI,#stdin
0C10	CALL	xresettx
0C13	MOV	CX,stdoutsz	;open std out for write
0C17	PUSH	DS
0C18	MOV	DI,#stdout
0C1B	CALL	xrewrttx
0C1E	MOV.B	errio,#$00	;clear flag
0C23	CALL	xcrtinit	;CrtInit
0C26	RET		;"
0C27readvers	MOV	AH,#$30	;Read Version Number
0C29	CALL	dos	;do MS-DOS
0C2C	OR.B	AL,AL	;Version 0 ?
0C2E	JZ	verserr	;yes:error
0C30	RET		;'
0C31verserr	MOV	DX,#msgdos
0C34	JMP.b	writerr	;'
0C36memerr	MOV	DX,#msgmem
0C39writerr	PUSH	CS	;CS -> DS
0C3A	POP	DS
0C3B	MOV	AH,#$09	;print string
0C3D	CALL	dos	;do MS-DOS
0C40	MOV	DX,#msgend
0C43	MOV	AH,#$09	;print string
0C45	CALL	dos	;MS-DOS
0C48	MOV	AH,#$00	;exit program
0C4A	CALL	dos	;"do MS-DOS
0C4Dmsgmem	B	"Not enough memory$"
0C5Fmsgdos	B	"Incorrect DOS version$"
0C75msgend	B	$0D,$0A,"Program aborted",$0D,$0A,"$"	;"
0C89progend	PUSH	AX	;End of program
0C8A	PUSH	DS	;AX=0:normal
0C8B	MOV	DI,#stdin	;close std input
0C8E	CALL	xclosetx
0C91	PUSH	DS
0C92	MOV	DI,#stdout	;close std output
0C95	CALL	xclosetx
0C98	XOR	AX,AX	;restore div / 0 int
0C9A	MOV	ES,AX
0C9C	MOV	AX,svintv
0C9F	ES:	
0CA0	MOV	div0vec,AX
0CA3	MOV	AX,svintv1
0CA6	ES:	
0CA7	MOV	availmem,AX	;div0int1
0CAA	POP	AX	;end flag
0CAB	TEST	modeflg,#$0001	;direct mode ?
0CB1	JNZ	turbort	;yes: return to Turbo
0CB3	MOV	AH,#$4C	;end process
0CB5	CALL	dos	;'return to MS-DOS
0CB8turbort	MOV	AH,#$80	;close all files
0CBA	CALL	dos
0CBD	PUSH	turbocs	;set return addr
0CC1	MOV	AX,#turboret
0CC4	PUSH	AX
0CC5	PUSH	DS	;DS -> ES
0CC6	POP	ES
0CC7	MOV	DS,turbods
0CCB	RETF		;"return to Turbo
	;Uncrunch program
	;This routine makes space for overlays, which are not stored
	;in the main code file. It makes use of an inline data structure:
	;+ 0:length of the block to move
	;+ 2:destination addr of this block
	;This makes a list which continues at the end of each block.
0CCCuncrunch	POP	BX	;return addr
0CCD	CS:	
0CCE	MOV	AX,[BX]	;get block length
0CD0	OR	AX,AX	;0 ?
0CD2	JZ	uncrdone	;yes:end of list
0CD4	PUSH	DS	;save DS
0CD5	PUSH	CS	;CS -> DS
0CD6	POP	DS
0CD7	PUSH	CS	;CS -> ES
0CD8	POP	ES	;push list on stack
0CD9	XOR	DX,DX	;count blocks
0CDBuncrlist	MOV	AX,[BX]	;get word
0CDD	OR	AX,AX	;end of list ?
0CDF	JZ	uncrstrt	;:yes
0CE1	PUSH	BX	;push offset
0CE2	ADD	BX,AX	;add offset
0CE4	INC	DX	;count entry
0CE5	JMP	uncrlist	;'continue
0CE7uncrstrt	MOV	CX,BX	;last ptr
0CE9	POP	BX	;get ptr from stack
0CEA	MOV	SI,BX	;+4 -> beginning of block
0CEC	ADD	SI,#$04
0CEF	MOV	DI,[BX]$02	;get destination addr
0CF2	CMP	SI,DI	;the same ?
0CF4	JZ	uncrno
0CF6	SUB	CX,SI	;block length
0CF8	ADD	SI,CX	;ptrs to last byte in block
0CFA	ADD	DI,CX
0CFC	DEC	SI
0CFD	DEC	DI
0CFE	STD		;move backwards
0CFF	REPZ	
0D00	MOVS.B	
0D01uncrno	DEC	DX	;another block ?
0D02	JNZ	uncrstrt	;:yes
0D04	MOV	[BX],#$0000	;clear the list: uncrunched
0D08	POP	DS	;restore DS
0D09uncrdone	ADD	BX,#$04	;skip inline data
0D0C	JMP	BX	;"return
	;Overlay header. Inline parameters:
	;+ 0:currently valid procedure (ptr into file)
	;+ 2:name of the overlay file
	;+ F:start of the procedure code
0D0Erdover	POP	SI	;get return addr
0D0F	CS:		;DX = file offset of proc wanted
0D10	CMP	DX,[SI]	;is it already there ?
0D12	JNZ	ovrread	;:no
0D14ovrcall	ADD	SI,#$0F	;skip filename
0D17	JMP	SI	;'jump into procedure
0D19ovrread	PUSH	AX	;AX = overlay length
0D1A	PUSH	DX	;save overlay pos
0D1B	PUSH	SI	;save dest addr
0D1C	MOV	DI,#ovrpnbuf	;scan overlay pathname
0D1F	XOR.B	AL,AL	;clear char buffer
0D21ovrscan	MOV.B	AH,AL	;buffer:last char
0D23	MOV.B	AL,[DI]	;get char
0D25	OR.B	AL,AL	;end of name ?
0D27	JZ	ovrpne	;:yes
0D29	INC	DI	;next char
0D2A	JMP	ovrscan	;'continue scanning
0D2Covrpne	PUSH	DI	;save end pos
0D2D	OR.B	AH,AH	;test last char
0D2F	JZ	ovrnob	;:no path specified
0D31	CMP.B	AH,#$3A	;: ?
0D34	JZ	ovrnob	;:yes
0D36	CMP.B	AH,#$5C	;\ ?
0D39	JZ	ovrnob	;:yes
0D3B	MOV.B	[DI],#$5C	;store a \ at the end
0D3E	INC	DI
0D3Fovrnob	INC	SI	;set to beg of filename
0D40	INC	SI
0D41ovrcopy	CS:		;get char from filename
0D42	MOV.B	AL,[SI]
0D44	MOV.B	[DI],AL	;store in pathname
0D46	INC	SI
0D47	INC	DI	;next char
0D48	OR.B	AL,AL	;end ?
0D4A	JNZ	ovrcopy	;no: continue
0D4C	MOV	AX,#$3D00	;open file
0D4F	MOV	DX,#ovrpnbuf	;pathname
0D52	PUSH	DS	;DS -> ES
0D53	POP	ES
0D54	CALL	dos	;do it
0D57	MOV	BX,AX	;file handle
0D59	POP	DI	;restore parms
0D5A	POP	SI
0D5B	POP	DX
0D5C	MOV.B	[DI],#$00	;restore overlay pathname
0D5F	JB	ovrerr	;:error
0D61	CS:		;store pos as current pos
0D62	MOV	[SI],DX	;in the overlay header
0D64	MOV	AX,#$4200	;seek absolute
0D67	XOR.B	CH,CH	;pos = DX*256
0D69	MOV.B	CL,DH
0D6B	MOV.B	DH,DL
0D6D	XOR.B	DL,DL
0D6F	CALL	dos	;do it
0D72	POP	CX	;restore length
0D73	JB	ovrerr	;:error
0D75	MOV	AH,#$3F	;read byte block
0D77	LEA	DX,[SI]$0F	;destination addr
0D7A	PUSH	DS	;save DS
0D7B	PUSH	CS	;CS -> DS
0D7C	POP	DS
0D7D	CALL	dos	;do it
0D80	POP	DS	;restore DS
0D81	JB	ovrerr	;:error
0D83	MOV	AH,#$3E	;close file
0D85	CALL	dos
0D88	JMP	ovrcall	;'jump into procedure
0D8Aovrerr	MOV	DL,#$F0	;error: Overlay not found
0D8C	PUSH	SI	;return addr
0D8D	JMP	runerrrt	;"
0D90xovrpath	POP	BX	;OvrPath
0D91	CALL	getpn	;convert string -> ASCIIZ
0D94	PUSH	BX	;restore ret
0D95	MOV	SI,#pnbuf	;copy into overlay pathname
0D98	MOV	DI,#ovrpnbuf
0D9B	PUSH	DS	;DS -> ES
0D9C	POP	ES
0D9D	MOV	CX,#$0020	;64 bytes
0DA0	CLD	
0DA1	REPZ	
0DA2	MOVS	
0DA3	RET		;"
0DA4xkeypres	DEC	SP	;KeyPressed
0DA5	CALL	[vkbdstat]	;check status
0DA9	RET		;"
0DAAxgotoxy	POP	BX	;GotoXY
0DAB	POP	CX	;column
0DAC	PUSH	BX	;restore ret
0DAD	MOV.B	DL,AL	;row-1
0DAF	MOV.B	DH,CL	;column-1
0DB1	DEC.B	DL	;(Turbo uses origin 1,1)
0DB3	DEC.B	DH
0DB5	JMP	setcpos	;"set position
0DB8xparmstr	MOV	DX,AX	;ParamStr: # wanted string
0DBA	OR	DX,DX	;0 ?
0DBC	JZ	prmstr1
0DBE	CALL	prmcnt1	;search in parm line
0DC1	XCHG	AX,BX	;string length -> AX
0DC2prmstr1	POP	BX	;return addr
0DC3	SUB	SP,AX	;allot space for string
0DC5	DEC	SP
0DC6	MOV	DI,SP	;string dest
0DC8	PUSH	DS	;save DS
0DC9	PUSH	CS	;CS -> DS
0DCA	POP	DS
0DCB	PUSH	SS	;SS -> ES
0DCC	POP	ES
0DCD	CLD		;move string
0DCE	STOS.B		;store length
0DCF	XCHG	AX,CX	;-> count
0DD0	REPZ		;move string
0DD1	MOVS.B	
0DD2	POP	DS	;restore DS
0DD3	JMP	BX	;"return
0DD5xparmcnt	XOR	DX,DX	;ParamCount: count string entries
0DD7prmcnt1	MOV	DI,#paramlin	;parameter line
0DDA	CS:	
0DDB	MOV.B	CL,[DI]	;length of param line
0DDD	XOR.B	CH,CH
0DDF	INC	DI	;beginning of string
0DE0	XOR	BX,BX	;clear parm cnt
0DE2prmcsep	JCXZ	prmcst	;:end of line
0DE4	CS:		;search char <> tab, space
0DE5	MOV.B	AL,[DI]	;read char
0DE7	CMP	AL,#$20	;space ?
0DE9	JZ	prmcsep2	;:continue
0DEB	CMP	AL,#$09	;tab ?
0DED	JNZ	prmcst	;no:start of parm
0DEFprmcsep2	INC	DI	;next char
0DF0	DEC	CX	;count length
0DF1	JMP	prmcsep	;'continue
0DF3prmcst	MOV	SI,DI	;start of parm string
0DF5prmcstl	JCXZ	prmcste	;end of line
0DF7	CS:		;search char = tab, space
0DF8	MOV.B	AL,[DI]	;get char
0DFA	CMP	AL,#$20	;space ?
0DFC	JZ	prmcste	;yes: end of parm
0DFE	CMP	AL,#$09	;tab ?
0E00	JZ	prmcste	;yes: end of parm
0E02	INC	DI	;next char
0E03	DEC	CX	;count length
0E04	JMP	prmcstl	;'continue searching
0E06prmcste	MOV	AX,DI	;end position - beg position
0E08	SUB	AX,SI
0E0A	JZ	prmcrt	;=0:forget it
0E0C	INC	BX	;count parm
0E0D	DEC	DX	;search another parm ?
0E0E	JNZ	prmcsep	;:yes
0E10prmcrt	XCHG	AX,BX	;return count, string length
0E11	RET		;"
0E12xstrint	MOV.B	fmtfield,CL	;Str(Integer): max length
0E16	MOV	fmtsdst,DI	;dest ofs
0E1A	POP	BX	;ret addr
0E1B	POP	fmtsdst1	;dest seg
0E1F	POP	CX	;format
0E20	POP	AX	;number
0E21	PUSH	BX	;restore ret
0E22	PUSH	CX	;save format
0E23	MOV	BX,#pnbuf	;dest buffer
0E26	CALL	intasc	;Integer -> ASCII
0E29	JMP.b	str1	;'store in string
0E2Bxstrreal	MOV.B	fmtfield,CL	;Str(Real): max length
0E2F	MOV	fmtsdst,DI	;dest ofs
0E33	POP	BX	;ret addr
0E34	POP	fmtsdst1	;dest seg
0E38	POP	DX	;format 2
0E39	POP	AX	;format 1
0E3A	MOV	DI,#recvbuf	;buffer for real number
0E3D	POP	[DI]	;pop real number
0E3F	POP	[DI]$02
0E42	POP	[DI]$04
0E45	PUSH	BX	;restore ret
0E46	PUSH	AX	;format 1
0E47	XCHG	AX,CX	;format 2 -> AX
0E48	MOV	BX,#pnbuf	;dest buffer
0E4B	CALL	fmtreal	;Real -> ASCII
0E4Estr1	POP	CX	;format
0E4F	LES	DI,fmtsdst	;ptr to dest string
0E53	PUSH	DI	;save begin pos
0E54	MOV.B	DL,fmtfield	;max. field size
0E58	XOR.B	DH,DH
0E5A	XCHG	AX,BX	;endposition - buffer pos
0E5B	SUB	AX,#pnbuf	;-> length
0E5E	SUB	CX,AX	;max len - len
0E60	JBE	strcpy0	;:too long
0E62strpad	INC	DI	;pad with spaces
0E63	ES:	
0E64	MOV.B	[DI],#$20
0E67	INC.B	DH	;count len
0E69	CMP.B	DH,DL	;= max len ?
0E6B	JZ	strdone	;yes:done
0E6D	LOOP	strpad	;continue padding
0E6Fstrcpy0	XCHG	AX,CX	;num len -> CX
0E70	MOV	BX,#pnbuf	;source ptr
0E73strcopy	MOV.B	AL,[BX]	;get char
0E75	INC	BX	;ptr to next
0E76	INC	DI
0E77	ES:	
0E78	MOV.B	[DI],AL	;store in string
0E7A	INC.B	DH	;pos = max len ?
0E7C	CMP.B	DH,DL
0E7E	JZ	strdone	;yes: end it
0E80	LOOP	strcopy	;continue
0E82strdone	POP	DI	;restore dest ptr
0E83	ES:	
0E84	MOV.B	[DI],DH	;store length
0E86	RET		;"
0E87xvalint	XOR.B	AL,AL	;Val(Integer)
0E89	JMP.b	val1	;'
0E8Bxvalreal	MOV	AL,#$01	;Val(Real)
0E8Dval1	MOV	fmttype,AL	;store type
0E90	MOV	fmtpdst,DI	;pos ofs
0E94	POP	BX	;ret addr
0E95	POP	fmtpdst1	;pos seg
0E99	POP	fmtvdst	;dest ofs
0E9D	POP	fmtvdst1	;dest seg
0EA1	CALL	getstz	;get string from stack
0EA4	PUSH	BX	;restore ret
0EA5	XOR	AX,AX	;no error
0EA7	MOV	BX,#pnbuf
0EAA	CMP.B	[BX],AL	;null string ?
0EAC	JZ	valrt	;:set pos, no change to dest
0EAE	CMP.B	fmttype,AL	;integer ?
0EB2	JNZ	val2	;:no
0EB4	CALL	ascint	;ASCIIZ -> Integer
0EB7	JB	valerr	;:error
0EB9	LES	DI,fmtvdst	;dest ptr
0EBD	ES:	
0EBE	MOV	[DI],AX	;store result
0EC0	JMP.b	valend	;'get error pos
0EC2val2	MOV	DI,#recvbuf	;real dest
0EC5	CALL	ascreal	;ASCIIZ -> Real
0EC8	JB	valerr	;:error
0ECA	MOV	SI,DI
0ECC	LES	DI,fmtvdst	;move real into
0ED0	CLD		;dest var
0ED1	MOVS	
0ED2	MOVS	
0ED3	MOVS	
0ED4valend	XOR	AX,AX	;no error
0ED6	CMP.B	[BX],AL	;end of buffer reached ?
0ED8	JZ	valrt	;:yes
0EDAvalerr	XCHG	AX,BX	;calculate error pos
0EDB	SUB	AX,#pnbuf0
0EDEvalrt	LES	DI,fmtpdst	;store error pos
0EE2	ES:	
0EE3	MOV	[DI],AX
0EE5	RET		;"
0EE6getpn	MOV	CX,#$0040	;get string from stack
0EE9	JMP.b	gstz1	;'max 64 chars
0EEBgetstz	MOV	CX,#$007F	;max 127 chars
0EEEgstz1	MOV	DI,#pnbuf	;dest buffer (redundant!)
0EF1	POP	AX	;ret addr
0EF2	MOV	SI,SP	;ptr to string
0EF4	SS:	
0EF5	MOV.B	DL,[SI]	;get length
0EF7	XOR.B	DH,DH
0EF9	CMP	CX,DX	;> max length ?
0EFB	JBE	gstz2	;yes, limit it
0EFD	MOV	CX,DX	;take this length
0EFFgstz2	INC	DX
0F00	INC	SI	;skip length
0F01	MOV	DI,#pnbuf	;dest ptr
0F04	PUSH	DS	;DS -> ES
0F05	POP	ES
0F06	PUSH	SS	;SS -> DS
0F07	POP	DS
0F08	CLD	
0F09	REPZ		;move string into buffer
0F0A	MOVS.B	
0F0B	PUSH	ES	;restore DS
0F0C	POP	DS
0F0D	MOV.B	[DI],#$00	;store a 0 at the end
0F10	ADD	SP,DX	;remove string from stack
0F12	JMP	AX	;"return
0F14xrndmize	MOV	AH,#$2C	;Randomize: Get time
0F16	CALL	dos
0F19	MOV	rndseed1,CX	;store as random seed
0F1D	MOV	rndseed,DX
0F21	RET		;"
0F22xmovevar	POP	BX	;Move var - CX = length
0F23	MOV	DX,DS	;save DS
0F25	MOV	SI,DI	;source ofs
0F27	POP	DS	;source seg
0F28	POP	DI	;dest ofs
0F29	POP	ES	;dest seg
0F2A	CLD		;move var
0F2B	REPZ	
0F2C	MOVS.B	
0F2D	MOV	DS,DX	;restore DS
0F2F	JMP	BX	;"return
0F31xblkparm	POP	BX	;Copy var -> stack
0F32	MOV	DX,DS	;save DS
0F34	MOV	SI,DI	;source ofs
0F36	POP	DS	;source seg
0F37	SUB	SP,CX	;make space - CX = len
0F39	MOV	DI,SP	;dest ptr
0F3B	PUSH	SS	;SS -> ES
0F3C	POP	ES
0F3D	CLD		;move it
0F3E	REPZ	
0F3F	MOVS.B	
0F40	MOV	DS,DX	;restore DS
0F42	JMP	BX	;"return
0F44xfillchr	POP	BX	;FillChar
0F45	POP	CX	;number of bytes
0F46	POP	DI	;array ofs
0F47	POP	ES	;array seg
0F48	CLD		;fill it - char in AL
0F49	REPZ	
0F4A	STOS.B	
0F4B	JMP	BX	;"return
0F4Dxmove	XCHG	AX,CX	;Move: Count -> CX
0F4E	MOV	DX,DS	;save DS
0F50	POP	BX	;ret addr
0F51	POP	DI	;dest ofs
0F52	POP	ES	;dest seg
0F53	POP	SI	;source ofs
0F54	POP	DS	;source seg
0F55	CLD		;forward move
0F56	CMP	SI,DI	;source > dest ?
0F58	JNB	domove	;yes: move forward
0F5A	ADD	SI,CX	;set ptr to end of block
0F5C	ADD	DI,CX
0F5E	DEC	SI
0F5F	DEC	DI
0F60	STD		;move backwards
0F61domove	REPZ		;do it
0F62	MOVS.B	
0F63	MOV	DS,DX	;restore DS
0F65	JMP	BX	;"return
0F67xsetregs	POP	BX	;Get parms for MsDos, Intr
0F68	POP	AX	;record seg
0F69	PUSH	BP	;save regs
0F6A	PUSH	DS
0F6B	PUSH	AX	;save record addr
0F6C	PUSH	DI
0F6D	PUSH	BX	;restore ret
0F6E	MOV	SI,DI	;pointer -> source
0F70	MOV	DS,AX	;source segment
0F72	CLD	
0F73	LODS		;AX value -> stack
0F74	PUSH	AX
0F75	LODS		;BX value
0F76	MOV	BX,AX
0F78	LODS		;CX value
0F79	MOV	CX,AX
0F7B	LODS		;DX value
0F7C	MOV	DX,AX
0F7E	LODS		;BP value
0F7F	MOV	BP,AX
0F81	LODS		;SI value -> stack
0F82	PUSH	AX
0F83	LODS		;DI value
0F84	MOV	DI,AX
0F86	LODS		;DS value
0F87	PUSH	AX
0F88	LODS		;ES value
0F89	MOV	ES,AX
0F8B	POP	DS	;get DS,SI,AX from stack
0F8C	POP	SI
0F8D	POP	AX
0F8E	RET		;"
0F8Fxgetregs	PUSHF		;store register values
0F90	PUSH	ES
0F91	PUSH	DI
0F92	PUSH	BP
0F93	MOV	BP,SP	;stack index
0F95	LES	DI,[BP]$0A	;get record ptr
0F98	CLD		;store AX
0F99	STOS	
0F9A	MOV	AX,BX	;store BX
0F9C	STOS	
0F9D	MOV	AX,CX	;store CX
0F9F	STOS	
0FA0	MOV	AX,DX	;store DX
0FA2	STOS	
0FA3	POP	AX	;store BP (from stack)
0FA4	STOS	
0FA5	MOV	AX,SI	;store SI
0FA7	STOS	
0FA8	POP	AX	;store DI (from stack)
0FA9	STOS	
0FAA	MOV	AX,DS	;store DS
0FAC	STOS	
0FAD	POP	AX	;store ES (from stack)
0FAE	STOS	
0FAF	POP	AX	;store flags (from stack)
0FB0	STOS	
0FB1	POP	BX	;return addr
0FB2	ADD	SP,#$04	;clear stack
0FB5	POP	DS	;restore DS,BP
0FB6	POP	BP
0FB7	JMP	BX	;"return
0FB9xindchk	CMP	AX,CX	;array index check
0FBB	JNB	chklim1	;AX>=limit CX:error
0FBD	RET		;'
0FBEchklim1	MOV	DL,#$90	;Index out of range
0FC0	JMP.b	runerrrt	;"
0FC2	NOP		;Range check CX<=AX<=DX
0FC3xrngchk	CMP	AX,CX
0FC5	JL	chkrng1	;not enough:error
0FC7	CMP	AX,DX
0FC9	JG	chkrng1	;too much:error
0FCB	RET		;'
0FCCchkrng1	MOV	DL,#$91	;Scalar or subrange
0FCE	JMP.b	runerrrt	;"out of range
0FD0	NOP		;Stack check
0FD1xchkstk	MOV	AX,SP	;CX=space required
0FD3	SUB	AX,CX	;SP-CX
0FD5	JB	chkstk1	;:error
0FD7	CMP	AX,#$0200	;getting tight ?
0FDA	JB	chkstk1	;:yes
0FDC	MOV	CL,#$04	;convert to segment
0FDE	SHR	AX,CL
0FE0	MOV	CX,SS
0FE2	ADD	AX,CX
0FE4	CMP	AX,hptop1	;compare with heap top
0FE8	JB	chkstk1	;below:error
0FEA	RET		;'
0FEBchkstk1	MOV	DL,#$FF	;heap / stack collision
0FED	JMP.b	runerrrt	;"
0FEF	NOP		;Breakpoint interrupt
0FF0brkint	POP	BX	;return addr
0FF1	POP	AX	;AX
0FF2	POPF		;Flags
0FF3	PUSH	BX	;restore ret
0FF4	OR.B	cbreak,#$02	;set flag: int test
0FF9	DEC	SP
0FFA	CALL	kbdstat	;Key pressed ?
0FFD	JZ	brkno	;:no
0FFF	DEC	SP
1000	CALL	kbdget	;get that key
1003brkno	AND.B	cbreak,#$01	;restore flag
1008	CMP	AL,#$03	;^C ?
100A	JZ	brkbrk	;:yes
100C	RET		;'
100Dbrkbrk	POP	errpos	;get return addr
1011	ADD	errpos,#$02	;adjust for length of INT3
1016brkmsg	MOV	DX,#$0001	;error: break
1019	JMP.b	error	;"
101Bxiores	XOR	AX,AX	;IOResult: clear AX
101D	XCHG.B	AL,errnum	;read error, clear it
1021	RET		;"
1022xiochk	CMP.B	errnum,#$00	;check for I/O-error
1027	JNZ	chkioerr
1029	RET		;'
102Achkioerr	MOV.B	DL,errnum	;get error number
102E	MOV	DH,#$01	;I/O-error
1030	JMP.b	error	;'display message
1032div0err	POP	BX	;Div/0 interrupt
1033	POP	AX	;take stuff from stack
1034	POPF	
1035	PUSH	BX	;restore ret
1036	MOV	DL,#$04	;div / 0
1038runerrrt	POP	errpos	;error pos: return addr
103Crunerr	MOV	DH,#$02	;runtime error
103Eerror	PUSH	DX	;save error number
103F	CALL	reinit1	;reinit files, I/O
1042	POP	DX	;error number
1043	MOV	AX,errpos
1046	SUB	AX,#$0003
1049	XCHG	AX,errpos2	;store pos of call
104D	OR	AX,AX	;break ?
104F	JNZ	errbrk	;:yes
1051	PUSH	DX	;save error number
1052	PUSH	DX
1053	PUSH	errpos2
1057	CALL	[verror]	;error handler
105B	POP	DX	;restore err number
105Cerrbrk	CMP.B	DH,#$01	;Break ?
105F	JNB	errrunio	;:no
1061	CALL	prints
1064	B	"^C",$0D,$0A,"User Break",$00
1073	JMP.b	errwpos	;'
1075errrunio	MOV.B	errio,#$FF	;set flag: real error
107A	JA	errrun	;:runtime error
107C	CALL	prints
107F	B	$0D,$0A,"I/O",$00
1085	JMP.b	errerr	;'
1087errrun	CALL	prints
108A	B	$0D,$0A,"Run-time",$00
1095errerr	CALL	prints
1098	B	" error ",$00
10A0	MOV.B	AL,DL	;write error number
10A2	CALL	whexbyte	;(hex)
10A5errwpos	CALL	prints
10A8	B	", PC=",$00
10AE	MOV	AX,errpos2	;display error pos
10B1	CALL	whexword
10B4	CALL	prints
10B7	B	$0D,$0A,"Program aborted",$0D,$0A,$00
10CB	MOV	AL,#$01	;Program end: error
10CD	JMP	progend	;"
10D0	RET	$0004	;"Error handler
10D3iabs	OR	AX,AX	;Abs(Integer):test sign
10D5	JNS	iabspos	;:positive, zero
10D7	NEG	AX	;negate it
10D9iabspos	RET		;"
10DAirandom	PUSH	AX	;Random(Integer):save limit
10DB	CALL	dorandom	;do random
10DE	POP	BX	;get limit
10DF	SHR	AX,1 	;div 2
10E1	CWD	
10E2	DIV	BX	;do modulo
10E4	XCHG	AX,DX	;remainder -> AX
10E5	RET		;"
10E6dorandom	MOV	BX,rndseed1	;do random
10EA	MOV	CX,rndseed	;get seed
10EE	PUSH	BX	;save it
10EF	PUSH	CX
10F0	MOV.B	AL,BH	;permutate it
10F2	MOV.B	BH,BL
10F4	MOV.B	BL,CH
10F6	MOV.B	CH,CL
10F8	XOR.B	CL,CL
10FA	RCR.B	AL,1 
10FC	RCR	BX,1 
10FE	RCR	CX,1 
1100	POP	AX	;old seed
1101	ADD	CX,AX	;add it
1103	POP	AX
1104	ADC	BX,AX
1106	MOV	AX,#$62E9	;add constant
1109	ADD	CX,AX
110B	MOV	AX,#$3619
110E	ADC	BX,AX
1110	MOV	rndseed1,BX	;new seed
1114	MOV	rndseed,CX
1118	MOV	AX,BX	;result
111A	RET		;"
111Bintasc	OR	AX,AX	;Integer -> ASCII
111D	JNS	iapos	;:positive number
111F	NEG	AX	;negate it
1121	MOV.B	[BX],#$2D	;store a -
1124	INC	BX
1125iapos	XOR.B	CH,CH	;flag for leading zeroes
1127	MOV	DX,#$2710	;digit 10000
112A	CALL	iadigit
112D	MOV	DX,#$03E8	;digit 1000
1130	CALL	iadigit
1133	MOV	DX,#$0064	;digit 100
1136	CALL	iadigit
1139	MOV	DL,#$0A	;digit 10
113B	CALL	iadigit
113E	MOV.B	CL,AL	;do it direct
1140	JMP.b	iadput	;'last digit
1142iadigit	XOR.B	CL,CL	;clear digit
1144iadsub	INC.B	CL	;do successive subtraction
1146	SUB	AX,DX	;(faster than DIV)
1148	JNB	iadsub	;:continue
114A	ADD	AX,DX	;restore remainder
114C	INC.B	CH	;flag:now print zeroes
114E	DEC.B	CL	;dec number
1150	JNZ	iadput	;:ok, non-zero
1152	DEC.B	CH	;clear flag
1154	JZ	iadnoput
1156iadput	ADD.B	CL,#$30	;convert to ASCII
1159	MOV.B	[BX],CL	;store
115B	INC	BX
115Ciadnoput	RET		;"
115Dasccard	XOR	AX,AX	;Read integer number:clear result
115F	CMP.B	[BX],#$24	;$ ?
1162	MOV	DX,#$000A	;base 10
1165	JNZ	acdec	;no:ok
1167	MOV	DL,#$10	;base 16
1169acloop	INC	BX	;go to next char
116Aacdec	PUSH	AX	;save previous result
116B	MOV.B	AL,[BX]	;get char
116D	CALL	upcase
1170	MOV.B	CL,AL	;save char
1172	POP	AX	;restore result
1173	SUB.B	CL,#$30	;digit < 0 ?
1176	JB	acend	;:yes, end of number
1178	CMP.B	CL,#$0A	;> 9 ?
117B	JB	acdigok	;no:ok
117D	CMP.B	DL,#$10	;base = 16 ?
1180	JNZ	acend	;no:end
1182	SUB.B	CL,#$07	;adjust hex
1185	CMP.B	CL,#$0A	;< A ?
1188	JB	acend	;:end
118A	CMP.B	CL,#$10	;> F ?
118D	JNB	acend	;:end
118Facdigok	PUSH	DX	;save base
1190	MUL	DX	;do multiplication
1192	POP	DX	;restore base
1193	JB	acret	;:overflow
1195	XOR.B	CH,CH	;clear hi byte
1197	ADD	AX,CX	;add digit to result
1199	JNB	acloop	;:no overflow, continue
119B	JMP.b	acret	;'end it - overflow
119Dacend	CMP.B	DL,#$10	;base 16 ?
11A0	JZ	acret	;:yes
11A2	MOV	CX,AX	;CX:=number*2
11A4	ADD	CX,CX
11A6acret	RET		;"
11A7ascint	MOV.B	CL,[BX]	;read integer:test sign
11A9	CMP.B	CL,#$2D	;- ?
11AC	JNZ	aipos	;:no
11AE	INC	BX	;go to next char
11AFaipos	PUSH	CX	;save sign
11B0	CALL	asccard	;read integer
11B3	POP	CX	;restore sign
11B4	JB	aichk	;:might be wrong
11B6	CMP.B	CL,#$2D	;- ?
11B9	JNZ	ainoneg	;:no
11BB	NEG	AX	;negate it
11BDainoneg	CLC		;no error
11BE	RET		;'
11BFaichk	CMP	AX,#$8000	;$8000 ?
11C2	JNZ	aierr	;no:really error
11C4	CMP.B	CL,#$2D	;negative ?
11C7	JNZ	aierr	;no:overflow
11C9	RET		;'yes:ok
11CAaierr	STC		;return error
11CB	RET		;"
11CCstrload	POP	BX	;get string var -> stack
11CD	POP	ES	;source seg
11CE	MOV	SI,DI	;source ofs
11D0	ES:		;get length
11D1	MOV.B	CL,[SI]
11D3	XOR.B	CH,CH	;-> count
11D5	INC	CX	;copy length, too
11D6	SUB	SP,CX	;make space on stack
11D8	MOV	DI,SP	;dest: new stack top
11DA	PUSH	DS	;save DS
11DB	PUSH	ES	;ES -> DS
11DC	POP	DS
11DD	PUSH	SS	;SS -> ES
11DE	POP	ES
11DF	CLD		;move string to stack
11E0	REPZ	
11E1	MOVS.B	
11E2	POP	DS	;restore DS
11E3	JMP	BX	;"return
11E5xstrcn	POP	SI	;inline string -> stack
11E6	CS:		;get length
11E7	MOV.B	CL,[SI]
11E9	XOR.B	CH,CH	;-> count
11EB	INC	CX	;copy length, too
11EC	SUB	SP,CX	;make space on stack
11EE	MOV	DI,SP	;dest: new stack top
11F0	PUSH	DS	;save DS
11F1	PUSH	CS	;CS -> DS
11F2	POP	DS
11F3	PUSH	SS	;SS -> ES
11F4	POP	ES
11F5	CLD		;move string to stack
11F6	REPZ		;puts SI to end of string
11F7	MOVS.B	
11F8	POP	DS	;restore DS
11F9	JMP	SI	;"return
11FBstrstore	POP	DX	;store string from stack
11FC	MOV.B	AL,CL	;max. length dest
11FE	MOV	BX,SP	;stack base
1200	SS:		;get length of source string
1201	MOV.B	CL,[BX]
1203	XOR.B	CH,CH
1205	ADD	BX,CX	;add to stack base
1207	INC	BX	;+1
1208	SS:	
1209	LES	DI,[BX]	;get dest ptr
120B	MOV	SI,SP	;source ptr:stack
120D	CMP.B	CL,AL	;too long ?
120F	JBE	stslenok	;:yes
1211	MOV.B	CL,AL	;take real length
1213	SS:	
1214	MOV.B	[SI],AL	;store length on stack
1216stslenok	INC	CX	;count
1217	PUSH	DS	;save DS
1218	PUSH	SS	;SS -> DS
1219	POP	DS
121A	CLD		;move string
121B	REPZ	
121C	MOVS.B	
121D	POP	DS	;restore DS
121E	LEA	SP,[BX]$04	;remove string, ptr
1221	JMP	DX	;"return
1223xldarrch	POP	BX	;store string on stack
1224	POP	ES	;source seg
1225	MOV	SI,DI	;source ofs
1227	XOR.B	CH,CH	;CL=length
1229	SUB	SP,CX	;make space on stack
122B	DEC	SP
122C	MOV	DI,SP	;dest addr
122E	SS:	
122F	MOV.B	[DI],CL	;store length
1231	INC	DI
1232	PUSH	DS	;save DS
1233	PUSH	ES	;ES -> DS
1234	POP	DS
1235	PUSH	SS	;SS -> ES
1236	POP	ES
1237	CLD		;move to stack
1238	REPZ	
1239	MOVS.B	
123A	POP	DS	;restore DS
123B	JMP	BX	;"return
123Dxstrparm	POP	BX	;String insert / delete
123E	XOR.B	CH,CH	;CL=length
1240	MOV	SI,SP	;string pos
1242	SS:	
1243	MOV.B	AL,[SI]	;get length
1245	XOR.B	AH,AH
1247	SUB	AX,CX	;compare length
1249	MOV	DI,SI	;dest ptr
124B	ADD	DI,AX	;+ difference
124D	OR	AX,AX	;test direction
124F	JZ	strret	;:same length
1251	JNS	strins	;:make it shorter
1253	MOV	SP,DI	;new stack top
1255	SS:		;insert - make string longer
1256	MOV.B	CL,[SI]	;get length
1258	INC	CX	;+1 -> count
1259	PUSH	DS	;save DS
125A	PUSH	SS	;SS -> DS
125B	POP	DS
125C	PUSH	SS	;SS -> ES
125D	POP	ES
125E	CLD		;move it
125F	REPZ	
1260	MOVS.B	
1261	POP	DS	;restore DS
1262	JMP.b	strret	;'return
1264strins	SS:		;delete - shorten string
1265	MOV.B	[SI],CL	;store new length
1267	ADD	DI,CX	;go to end of string
1269	ADD	SI,CX
126B	INC	CX	;count+1
126C	PUSH	DS	;save DS
126D	PUSH	SS	;SS -> DS
126E	POP	DS
126F	PUSH	SS	;SS -> ES
1270	POP	ES
1271	STD		;move it up
1272	REPZ	
1273	MOVS.B	
1274	POP	DS	;restore DS
1275	INC	DI	;beginning of string
1276	MOV	SP,DI	;= new stack top
1278strret	JMP	BX	;"return
127Acsteq	CALL	cmpstr	;Compare strings =
127D	MOV	AX,#$0001
1280	JZ	csteq1	;equal:true
1282	DEC	AX	;false
1283csteq1	OR	AX,AX	;set flags
1285	RET		;"
1286cstne	CALL	cmpstr	;Compare strings <>
1289	MOV	AX,#$0001
128C	JNZ	cstne1	;not equal:true
128E	DEC	AX
128Fcstne1	OR	AX,AX
1291	RET		;"
1292cstge	CALL	cmpstr	;Compare strings >=
1295	MOV	AX,#$0001
1298	JNB	cstge1	;larger or equal:true
129A	DEC	AX
129Bcstge1	OR	AX,AX
129D	RET		;"
129Ecstle	CALL	cmpstr	;Compare strings <=
12A1	MOV	AX,#$0001
12A4	JBE	cstle1	;less or equal:true
12A6	DEC	AX
12A7cstle1	OR	AX,AX
12A9	RET		;"
12AAcstg	CALL	cmpstr	;Compare strings >
12AD	MOV	AX,#$0001
12B0	JA	cstg1	;larger:true
12B2	DEC	AX
12B3cstg1	OR	AX,AX
12B5	RET		;"
12B6cstl	CALL	cmpstr	;Compare strings <
12B9	MOV	AX,#$0001
12BC	JB	cstl1	;less:true
12BE	DEC	AX
12BFcstl1	OR	AX,AX
12C1	RET		;"
12C2cmpstr	MOV	DI,SP	;Compare strings
12C4	ADD	DI,#$04	;ignore 2 ret addr
12C7	SS:	
12C8	MOV.B	CL,[DI]	;get len second string
12CA	XOR.B	CH,CH	;clr hi byte
12CC	INC	DI	;ptr to beg of string
12CD	MOV	SI,DI	;calc pos of first string
12CF	ADD	SI,CX	;add len
12D1	SS:	
12D2	MOV.B	DL,[SI]	;get len first string
12D4	XOR.B	DH,DH	;clr hi byte
12D6	INC	SI
12D7	MOV	BX,SI	;calc end pos of string
12D9	ADD	BX,DX	;for removing it
12DB	MOV.B	AL,CL	;second len
12DD	MOV.B	AH,DL	;first len
12DF	CMP	CX,DX	;compare them
12E1	JBE	csshrt	;:CX already shorter
12E3	XCHG	CX,DX	;shorter len -> CX
12E5csshrt	OR	CX,CX	;null string ?
12E7	JZ	csnull	;:yes
12E9	PUSH	DS	;save DS
12EA	PUSH	SS	;SS -> ES
12EB	POP	ES
12EC	PUSH	SS	;SS -> DS
12ED	POP	DS
12EE	CLD		;compare strings on stack
12EF	REPZ	
12F0	CMPS.B	
12F1	POP	DS	;restore DS
12F2	JNZ	csnoteq	;:not equal - flags are set
12F4csnull	CMP.B	AH,AL	;compare len
12F6csnoteq	POP	DX	;return addr
12F7	POP	CX	;return addr caller
12F8	MOV	SP,BX	;remove strings from stack
12FA	PUSH	CX	;restore ret caller
12FB	JMP	DX	;"return
12FDxconcat	POP	errpos	;Concat: get return addr
1301	MOV	DI,SP	;pos second string
1303	SS:	
1304	MOV.B	DL,[DI]	;len2
1306	XOR.B	DH,DH
1308	MOV	SI,DI	;go to start of first string
130A	INC	SI
130B	ADD	SI,DX
130D	SS:	
130E	MOV.B	CL,[SI]	;len1
1310	ADD.B	DL,CL	;len1+len2 too long ?
1312	JB	concerr	;yes:error
1314	SS:	
1315	MOV.B	[SI],DL	;store new len
1317	XOR.B	CH,CH	;put first string in front
1319	SUB	DI,CX	;of second
131B	MOV	SP,DI	;get space on stack
131D	INC	CX	;len1+1; len2 will be overwritten
131E	PUSH	DS	;save DS
131F	PUSH	SI	;save SI
1320	PUSH	SS	;SS -> ES
1321	POP	ES
1322	PUSH	SS	;SS -> DS
1323	POP	DS
1324	CLD		;move first string
1325	REPZ	
1326	MOVS.B	
1327	MOV	DI,SI	;end addr of string 1
1329	POP	SI	;end pos of concat string
132A	DEC	SI
132B	DEC	DI
132C	MOV	CX,DX	;resulting length + 1
132E	INC	CX
132F	STD	
1330	REPZ		;copy it up
1331	MOVS.B	
1332	POP	DS	;restore DS
1333	INC	DI
1334	MOV	SP,DI	;remove garbage from stack
1336	JMP	[errpos]	;'return
133Aconcerr	MOV	DL,#$10	;String too long
133C	JMP	runerr	;"
133Fxcopy	POP	errpos	;Copy: get return addr
1343	CALL	limstind	;limit index (length)
1346	MOV	CX,AX	;-> CX
1348	POP	AX	;string pos
1349	CALL	chkstind	;check string index
134C	DEC	AX	;pos in string
134D	MOV	SI,SP	;addr of string
134F	SS:	
1350	MOV.B	DL,[SI]	;get length
1352	XOR.B	DH,DH
1354	MOV	DI,SP	;pos of dest
1356	ADD	DI,DX	;+ length
1358	SUB	DX,AX	;length > pos ?
135A	JBE	copnull	;no - return null string
135C	ADD	SI,AX	;begin pos of substring
135E	CMP	DX,CX	;length > num ?
1360	JBE	copend	;:yes, sub goes to end
1362	ADD	SI,CX	;pos end of substring
1364	MOV	DX,CX	;new length
1366	PUSH	DS	;save DS
1367	PUSH	SS	;SS -> ES
1368	POP	ES
1369	PUSH	SS	;SS -> DS
136A	POP	DS
136B	STD		;move string
136C	REPZ	
136D	MOVS.B	
136E	POP	DS	;restore DS
136F	JMP.b	copmovd	;'return result
1371copnull	XOR	DX,DX	;length = 0
1373copmovd	XCHG	SI,DI	;point to beg of new string
1375copend	SS:	
1376	MOV.B	[SI],DL	;store length
1378	MOV	SP,SI	;remove the rest
137A	JMP	[errpos]	;"return
137Exlength	POP	BX	;Length
137F	MOV	DI,SP	;pos of string
1381	SS:	
1382	MOV.B	AL,[DI]	;get length
1384	XOR.B	AH,AH	;clr hi byte
1386	ADD	SP,AX	;remove string from stack
1388	INC	SP
1389	JMP	BX	;"return
138Bxpos	POP	errpos	;Pos (search substring)
138F	MOV	DI,SP	;pos of string
1391	SS:	
1392	MOV.B	DL,[DI]	;length of
1394	XOR.B	DH,DH
1396	INC	DI	;begin pos of string
1397	MOV	SI,DI	;DI:string scanned
1399	ADD	SI,DX	;go to beg of pattern str
139B	SS:	
139C	MOV.B	CL,[SI]	;get pattern len
139E	XOR.B	CH,CH
13A0	INC	SI	;SI:pattern string
13A1	MOV	BX,SI	;calc stack end pos
13A3	ADD	BX,CX	;to remove strings
13A5	XOR	AX,AX	;find position
13A7	SUB	DX,CX	;DX:length difference
13A9	JB	posend	;pattern too long: not found
13AB	INC	AX	;pos 1
13AC	OR	CX,CX	;pattern = null ?
13AE	JZ	posend	;yes: found
13B0	INC	DX	;number of compares
13B1	PUSH	DS	;save DS
13B2	PUSH	SS	;SS -> ES
13B3	POP	ES
13B4	PUSH	SS	;SS -> DS
13B5	POP	DS
13B6	CLD		;forward compare
13B7posloop	PUSH	CX	;save parms
13B8	PUSH	DI
13B9	PUSH	SI
13BA	REPZ		;compare it
13BB	CMPS.B	
13BC	POP	SI	;restore parms
13BD	POP	DI
13BE	POP	CX
13BF	JZ	posdone	;:found
13C1	INC	AX	;next pos
13C2	INC	DI
13C3	DEC	DX	;another search ?
13C4	JNZ	posloop	;:yes
13C6	XOR	AX,AX	;not found = 0
13C8posdone	POP	DS	;restore DS
13C9posend	MOV	SP,BX	;remove strings
13CB	JMP	[errpos]	;"return
13CFxinsert	MOV.B	strdstln,CL	;Insert: max. dest len
13D3	MOV	strpos,AX	;pos
13D6	POP	BX	;return addr
13D7	POP	strtrgt	;target string ptr
13DB	POP	strtrgt1
13DF	MOV	strobj,SP	;object string - on stack
13E3	MOV	strobj1,SS
13E7	PUSH	BX	;restore ret
13E8	LES	DI,strtrgt	;target string
13EC	PUSH	ES	;save ptr for storing result
13ED	PUSH	DI
13EE	PUSH	ES	;get target string
13EF	CALL	strload	;-> stack
13F2	MOV	AX,#$0001	;Copy(target,1,pos-1)
13F5	PUSH	AX
13F6	MOV	AX,strpos
13F9	DEC	AX
13FA	CALL	xcopy	;do it
13FD	LES	DI,strobj	;get obj string
1401	PUSH	ES
1402	CALL	strload	;-> stack
1405	CALL	xconcat	;concat strings
1408	LES	DI,strtrgt	;get target string
140C	PUSH	ES
140D	CALL	strload	;-> stack
1410	PUSH	strpos	;Copy(target,pos,255)
1414	MOV	AX,#$00FF
1417	CALL	xcopy	;do it
141A	CALL	xconcat	;concat strings
141D	MOV.B	CL,strdstln	;max. length
1421	CALL	strstore	;store string
1424	JMP	xlength	;"remove strings
1427xdelete	MOV	strnum,AX	;Delete: number of chars
142A	POP	BX	;ret addr
142B	POP	strpos	;pos in string
142F	POP	strtrgt	;target string
1433	POP	strtrgt1
1437	PUSH	BX	;restore ret
1438	LES	DI,strtrgt	;target string
143C	PUSH	ES	;save ptr for storing result
143D	PUSH	DI
143E	PUSH	ES	;get target
143F	CALL	strload	;-> stack
1442	MOV	AX,#$0001	;Copy(target,1,pos-1)
1445	PUSH	AX
1446	MOV	AX,strpos
1449	DEC	AX
144A	CALL	xcopy	;do it
144D	MOV	AX,strpos
1450	ADD	AX,strnum	;pos+num
1454	OR.B	AH,AH	;test it
1456	JNZ	delnorem	;too big: nothing left
1458	LES	DI,strtrgt	;get target
145C	PUSH	ES
145D	CALL	strload	;-> stack
1460	PUSH	AX	;Copy(target,pos+num,255)
1461	MOV	AX,#$00FF
1464	CALL	xcopy	;do it
1467	CALL	xconcat	;concat strings
146Adelnorem	MOV	CL,#$FF	;max len - never a problem
146C	CALL	strstore	;store string
146F	RET		;"
1470xstrch	POP	BX	;String -> char
1471	POP	AX	;get string
1472	DEC.B	AL	;test length
1474	JNZ	stcherr	;<> 1:error
1476	XCHG.B	AL,AH	;char -> AL
1478	JMP	BX	;'return
147Astcherr	MOV	errpos,BX	;store error position
147E	MOV	DL,#$10	;String too long
1480	JMP	runerr	;"
1483xchstr	MOV	SI,SP	;string -> substring
1485	SS:		;(1 char)
1486	MOV.B	BL,[SI]$02	;length of string
1489	XOR.B	BH,BH
148B	SS:	
148C	MOV	AX,[BX_SI]$03	;get char
148F	MOV.B	AH,AL	;char
1491	MOV	AL,#$01	;length = 1
1493	SS:	
1494	MOV	[BX_SI]$03,AX	;store in string
1497	RET		;"
1498	POP	BX	;return string as function result
1499	ADD	SP,DX	;forget DX bytes on stack
149B	MOV	SI,SP	;pos of string
149D	SS:	
149E	MOV.B	AL,[SI]	;get its length
14A0	CMP.B	AL,CL	;= CL (expected length) ?
14A2	JZ	retstrt	;yes: done
14A4	XOR.B	AH,AH
14A6	ADD	SI,AX	;ptr to end of string
14A8	MOV	DI,SP	;destination (must be longer)
14AA	XOR.B	CH,CH
14AC	ADD	DI,CX	;end of destination
14AE	XCHG	AX,CX	;real length -> count
14AF	INC	CX	;copy length, too
14B0	PUSH	DS	;save DS
14B1	PUSH	SS	;SS -> DS
14B2	POP	DS
14B3	PUSH	SS	;SS -> ES
14B4	POP	ES
14B5	STD		;move backwards
14B6	REPZ	
14B7	MOVS.B	
14B8	POP	DS	;restore DS
14B9	INC	DI
14BA	MOV	SP,DI	;new stack top
14BCretstrt	JMP	BX	;"return
14BEchkstind	OR.B	AH,AH	;Check string index
14C0	JNZ	stinderr	;> 255:error
14C2	OR.B	AL,AL
14C4	JZ	stinderr	;0:error
14C6	RET		;'
14C7stinderr	MOV	DL,#$11	;Invalid string index
14C9	JMP	runerr	;"
	;Get set. CL=bytes used, CH=bytes empty at beginning
14CCxldset	POP	BX	;ret addr
14CD	POP	DX	;source seg
14CE	MOV	SI,DI	;source ofs
14D0	SUB	SP,#$20	;make space on stack
14D3	MOV	DI,SP	;dest ptr
14D5	PUSH	CX	;save crunch byte
14D6	PUSH	SS	;SS -> ES
14D7	POP	ES
14D8	CLD		;forward
14D9	OR.B	CH,CH	;empty bytes at beginning
14DB	JZ	sld2	;:none
14DD	XOR.B	AL,AL	;store zeroes
14DFsldclr1	STOS.B	
14E0	DEC.B	CH
14E2	JNZ	sldclr1	;:another
14E4sld2	PUSH	DS	;save DS
14E5	MOV	DS,DX	;DX -> DS
14E7	REPZ	
14E8	MOVS.B		;move set
14E9	POP	DS	;restore DS
14EA	POP	CX	;restore crunch byte
14EB	MOV	AH,#$20	;calculate empty bytes
14ED	SUB.B	AH,CH	;at end
14EF	SUB.B	AH,CL
14F1	JZ	sld3	;:none
14F3	XOR.B	AL,AL	;store zeroes
14F5sldclr2	STOS.B	
14F6	DEC.B	AH
14F8	JNZ	sldclr2	;:another one
14FAsld3	JMP	BX	;"return
14FCsldempty	POP	BX	;Make empty set
14FD	SUB	SP,#$20	;32 bytes on stack
1500	MOV	DI,SP	;dest addr
1502	PUSH	SS	;SS -> ES
1503	POP	ES
1504	MOV	CX,#$0010	;do 32 bytes
1507	XOR	AX,AX	;fill with zeroes
1509	CLD	
150A	REPZ	
150B	STOS	
150C	JMP	BX	;"return
150Esetincl	CALL	setindex	;Include element: calc index
1511	SS:	
1512	OR.B	[BX],AL	;include it
1514	RET		;"
1515setinrng	XCHG	AX,CX	;Include range in set
1516	POP	BX	;ret addr
1517	POP	AX	;lower; upper is in CX
1518	PUSH	BX	;restore ret
1519	SUB.B	CL,AL	;upper < lower ?
151B	JB	srngnil
151D	XOR.B	CH,CH	;upper-lower -> count
151F	INC	CX
1520	MOV.B	AH,CL	;save count
1522	CALL	setindex	;calc set index (lower)
1525	MOV.B	CL,AH	;restore count
1527srngloop	SS:		;include element in set
1528	OR.B	[BX],AL
152A	SHL.B	AL,1 	;for next bit
152C	JNB	srngbit	;:ok
152E	INC	BX	;go to next byte
152F	MOV	AL,#$01
1531srngbit	LOOP	srngloop	;:another element
1533srngnil	RET		;"
1534setsto	MOV	SI,SP	;store set. CX as with load
1536	INC	SI
1537	INC	SI	;source addr
1538	SS:	
1539	MOV	DI,[SI]$20	;get dest ofs
153C	SS:	
153D	MOV	ES,[SI]$22	;dest seg
1540	MOV.B	DL,CH	;# empty bytes
1542	XOR.B	DH,DH
1544	ADD	SI,DX	;add to source addr
1546	XOR.B	CH,CH	;CL = # bytes used
1548	PUSH	DS	;save DS
1549	PUSH	SS	;SS -> DS
154A	POP	DS
154B	CLD		;move used bytes
154C	REPZ	
154D	MOVS.B	
154E	POP	DS	;restore DS
154F	RET	$0024	;"remove set, pointer
1552xsetparm	POP	BX	;Put set as procedure parm
1553	MOV.B	DL,CH	;bytes empty at beg
1555	XOR.B	DH,DH
1557	XOR.B	CH,CH	;bytes used
1559	MOV	SI,SP	;source addr
155B	ADD	SI,DX	;calc end pos
155D	ADD	SI,CX
155F	MOV	DI,SP	;dest addr
1561	ADD	DI,#$20
1564	CMP	SI,DI	;= end pos ?
1566	JZ	putsetrt
1568	DEC	SI	;go back one byte
1569	DEC	DI
156A	PUSH	DS	;save DS
156B	PUSH	SS	;SS -> ES
156C	POP	ES
156D	PUSH	SS	;SS -> DS
156E	POP	DS	;set is stored as compressed
156F	STD		;local var
1570	REPZ	
1571	MOVS.B		;do move it
1572	POP	DS	;restore DS
1573	INC	DI
1574	MOV	SP,DI	;remove empty space
1576putsetrt	JMP	BX	;"return
1578seteq	MOV	AX,#$0001	;Set comparison =
157B	JMP.b	setcmp	;'
157Dsetne	XOR	AX,AX	;Set comparison <>
157Fsetcmp	CALL	setptrs	;set parms
1582	REPZ		;compare sets
1583	CMPS	
1584	MOV	DS,DX	;restore DS
1586	JZ	setceq	;:equal
1588	XOR	AX,#$0001	;invert result
158Bsetceq	OR	AX,AX	;test result
158D	RET	$0040	;"remove sets from stack
1590setge	XOR	AX,AX	;Set comparison >=
1592	JMP.b	setcmp2	;'
1594setle	MOV	AX,#$0001	;Set comparison <=
1597setcmp2	CALL	setptrs	;set parms
159A	DEC	AX	;'test type of comparison
159B	JNZ	setc2l	;:<=
159D	XCHG	DI,SI	;swap set1, set2
159Fsetc2l	LODS		;get byte from set2
15A0	OR	AX,[DI]	;include set1
15A2	SCAS		;compare with set1
15A3	JNZ	setc2g	;:not the same
15A5	LOOP	setc2l	;:continue
15A7	MOV	AX,#$0001	;true
15AA	JMP.b	setc2rt	;'end it
15ACsetc2g	XOR	AX,AX	;false
15AEsetc2rt	MOV	DS,DX	;restore DS
15B0	OR	AX,AX	;test result
15B2	RET	$0040	;"remove sets from stack
15B5sunion	CALL	setptrs	;Set union: set parms
15B8sunion1	LODS		;get byte set 2
15B9	OR	AX,[DI]	;include set 1
15BB	STOS		;store in set 1
15BC	LOOP	sunion1	;:continue
15BE	MOV	DS,DX	;restore DS
15C0	RET	$0020	;"remove set 2 from stack
15C3sdiff	CALL	setptrs	;Set difference: set parms
15C6sdiff1	LODS		;get byte set 2
15C7	NOT	AX	;invert it
15C9	AND	AX,[DI]	;take it from set 1
15CB	STOS		;store in set 1
15CC	LOOP	sdiff1	;:continue
15CE	MOV	DS,DX	;restore DS
15D0	RET	$0020	;"remove set 2 from stack
15D3sinter	CALL	setptrs	;Set intersection: set parms
15D6sinter1	LODS		;get byte set 2
15D7	AND	AX,[DI]	;intersect set 1
15D9	STOS		;store in set 1
15DA	LOOP	sinter1	;:continue
15DC	MOV	DS,DX	;restore DS
15DE	RET	$0020	;"remove set 2 from stack
15E1xsetin	MOV	BX,SP	;Set IN operation
15E3	SS:		;pos of set
15E4	MOV	AX,[BX]$22	;get parm
15E7	OR.B	AH,AH	;> 255 ?
15E9	JZ	setintst	;no: ok
15EB	XOR	AX,AX	;false
15ED	JMP.b	setnotin	;'return result
15EFsetintst	CALL	setindex	;calc set index
15F2	SS:	
15F3	AND.B	AL,[BX]	;test set element
15F5	MOV	AX,#$0000	;false
15F8	JZ	setnotin	;not set: false
15FA	INC	AX	;true
15FBsetnotin	OR	AX,AX	;test result
15FD	RET	$0022	;"remove set, parm
1600setindex	MOV.B	BL,AL	;Calculate set index, mask
1602	XOR.B	BH,BH	;BX = bit number
1604	MOV	CL,#$03	;bit number DIV 8
1606	SHR	BX,CL
1608	ADD	BX,#$04	;+SP+4 -> set ptr
160B	ADD	BX,SP
160D	MOV.B	CL,AL	;bit number MOD 8
160F	AND.B	CL,#$07
1612	MOV	AL,#$01	;create bit mask
1614	SHL.B	AL,CL
1616	RET		;"
1617setptrs	MOV	SI,SP	;Set parms for set ops
1619	ADD	SI,#$04	;ptr set 2
161C	MOV	DI,SP	;skip two ret addrs
161E	ADD	DI,#$24	;ptr set 1
1621	MOV	DX,DS	;save DS
1623	PUSH	SS	;SS -> ES
1624	POP	ES
1625	PUSH	SS	;SS -> DS
1626	POP	DS
1627	MOV	CX,#$0010	;count: 32 bytes
162A	CLD	
162B	RET		;"
162Cptreq	CMP	AX,BX	;Compare pointers DX:AX = CX:BX
162E	MOV	AX,#$0000	;false
1631	JNZ	ptreqno	;:not equal
1633	CMP	DX,CX
1635	JNZ	ptreqno	;:not equal
1637	INC	AX	;true
1638ptreqno	OR	AX,AX	;set flags
163A	RET		;"
163Bptrne	CMP	AX,BX	;Compare pointers <>
163D	MOV	AX,#$0001	;true
1640	JNZ	ptrne1	;not equal: true
1642	CMP	DX,CX
1644	JNZ	ptrne1	;not equal: true
1646	DEC	AX	;false
1647ptrne1	OR	AX,AX	;set flags
1649	RET		;"
	;*** Real Operations ***
	;#1 #2 register usage
	;AX CX LSB, exponent
	;BX SI mantissa
	;DX DI MSB, sign
164Aresub	MOV	resign,#$8000	;Do real subtraction
1650	JMP.b	ra1	;'
1652readd	MOV	resign,#$0000	;Do real addition
1658ra1	OR.B	CL,CL	;second = 0 ?
165A	JZ	raret	;:yes, done
165C	XOR	DI,resign	;change sign2, if sub
1660	OR.B	AL,AL	;first = 0 ?
1662	JNZ	ranotriv	;:no
1664raretn2	MOV	AX,CX	;second -> result
1666	MOV	BX,SI
1668	MOV	DX,DI
166Araret	RET		;'
166Branotriv	CMP.B	AL,CL	;compare exponents
166D	JBE	ranoswap	;AL <= CL !
166F	XCHG	AX,CX	;otherwhise swap numbers
1670	XCHG	BX,SI
1672	XCHG	DX,DI
1674ranoswap	MOV.B	cvdecexp,CL	;save exp2
1678	SUB.B	CL,AL	;exponent difference
167A	CMP.B	CL,#$28	;first number too small ?
167D	JB	ranoundr	;:no
167F	MOV.B	CL,cvdecexp	;restore exp2
1683	JMP	raretn2	;'second -> result
1685ranoundr	MOV	resign,DI	;save MSB 2
1689	AND.B	resave,#$80	;mask out mantissa
168E	MOV	remant,DI	;save MSB 2
1692	XOR.B	remant1,DH
1696	OR	DI,#$8000	;remove sign
169A	OR.B	DH,#$80	;remove sign
169Draadj16l	CMP.B	CL,#$10	;shift first in 16-bit-steps
16A0	JB	raadj8	;:done
16A2	MOV.B	AH,BH	;do it.
16A4	MOV	BX,DX	;first num is shifted to make
16A6	XOR	DX,DX	;exp1 = exp2
16A8	SUB.B	CL,#$10
16AB	JMP	raadj16l	;'try again
16ADraadj8	CMP.B	CL,#$08	;shift first in 8-bit-steps
16B0	JB	raadj8l	;:done
16B2	MOV.B	AH,BL	;do it
16B4	MOV.B	BL,BH
16B6	MOV.B	BH,DL
16B8	MOV.B	DL,DH
16BA	XOR.B	DH,DH
16BC	SUB.B	CL,#$08	;count down difference
16BFraadj8l	OR.B	CL,CL	;test difference
16C1	JZ	raadjend	;:adjustment done
16C3raadj1l	SHR	DX,1 	;shift right in 1-bit-steps
16C5	RCR	BX,1 
16C7	RCR.B	AH,1 
16C9	DEC.B	CL
16CB	JNZ	raadj1l	;:continue
16CDraadjend	MOV	AL,cvdecexp	;get exp2
16D0	TEST.B	remant1,#$80	;test sign
16D5	JNZ	radosub	;:negative
16D7	ADD.B	AH,CH	;add mantissa
16D9	ADC	BX,SI
16DB	ADC	DX,DI
16DD	JNB	rasign	;:ok
16DF	RCR	DX,1 	;do normalization
16E1	RCR	BX,1 
16E3	RCR.B	AH,1 
16E5	INC.B	AL	;inc exponent
16E7	JNZ	rasign	;:ok
16E9	STC		;overflow error
16EA	RET		;'
16EBradosub	XCHG.B	AH,CH	;exchange numbers
16ED	XCHG	BX,SI
16EF	XCHG	DX,DI
16F1	SUB.B	AH,CH	;subtract numbers
16F3	SBB	BX,SI
16F5	SBB	DX,DI
16F7	JNB	ranoneg	;:no underflow
16F9	XOR.B	resave,#$80	;change sign
16FE	NOT.B	AH	;negate mantissa
1700	NOT	BX	;= inverted mantissa + 1
1702	NOT	DX
1704	ADD.B	AH,#$01
1707	ADC	BX,#$00
170A	ADC	DX,#$00
170Dranoneg	MOV	CL,#$05	;normalize number
170Franrm8l	OR.B	DH,DH	;upper byte empty ?
1711	JNZ	ranrm1l	;:no
1713	MOV.B	DH,DL	;shift left 8 bits
1715	MOV.B	DL,BH
1717	MOV.B	BH,BL
1719	MOV.B	BL,AH
171B	XOR.B	AH,AH
171D	SUB	AL,#$08	;sub 8 from exp
171F	JB	razero	;:underflow, return 0
1721	DEC.B	CL	;count down bytes
1723	JNZ	ranrm8l	;:another one
1725	JMP.b	razero	;'underflow
1727ranrm1l	TEST.B	DH,#$80	;Mantissa MSB must be 1
172A	JNZ	rasign	;:yes, done
172C	SHL.B	AH,1 	;shift left 1 bit
172E	RCL	BX,1 
1730	RCL	DX,1 
1732	DEC.B	AL	;sub 1 from exp
1734	JNZ	ranrm1l	;:ok
1736razero	XOR	AX,AX	;underflow, return zero
1738	XOR	BX,BX
173A	XOR	DX,DX
173C	RET		;'
173Drasign	AND.B	DH,#$7F	;clear MSB mantissa
1740	XOR.B	DH,resave	;set correct sign
1744	RET		;"
1745remult	OR.B	CL,CL	;Real multiplication: second=0 ?
1747	JZ	rmzero	;yes: return zero
1749	OR.B	AL,AL	;first=0 ?
174B	JZ	rmret	;yes: done
174D	ADD.B	AL,CL	;add exponents
174F	CALL	testexp	;test exponent
1752	MOV	remul11,AX	;save first number
1755	MOV	remul12,BX
1759	MOV	remul13,DX
175D	XOR.B	AH,AH	;clear result
175F	XOR	BX,BX
1761	XOR	DX,DX
1763	MOV	DI,#remul21	;ptr to second mantissa
1766	MOV	CL,#$05	;do 5 bytes
1768rmbyt	INC	DI	;get byte from second mantissa
1769	MOV.B	CH,[DI]
176B	OR.B	CH,CH	;0 ?
176D	JNZ	rmdomul	;no: do multiplication
176F	MOV.B	AH,BL	;just shift result
1771	MOV.B	BL,BH	;8 bits right
1773	MOV.B	BH,DL
1775	MOV.B	DL,DH
1777	XOR.B	DH,DH
1779	JMP.b	rmnxtbyt	;'next step
177Brmdomul	MOV	SI,#$0008	;do 8 bits
177Ermmul	RCR.B	CH,1 	;get bit
1780	JNB	rmbit0	;:not set
1782	ADD.B	AH,remul11a	;add mantissa 1 to result
1786	ADC	BX,remul12
178A	ADC	DX,remul13
178Ermbit0	RCR	DX,1 	;shift result 1 bit right
1790	RCR	BX,1 
1792	RCR.B	AH,1 
1794	DEC	SI	;another bit ?
1795	JNZ	rmmul	;:yes
1797rmnxtbyt	DEC.B	CL	;another byte ?
1799	JNZ	rmbyt	;:yes
179B	XCHG	AX,CX	;save AX, CL
179C	LAHF		;save flags
179D	TEST.B	DH,#$80	;already normalized ?
17A0	JNZ	rmnoadj	;:yes
17A2	SAHF		;restore flags
17A3	RCL.B	CH,1 	;shift 1 bit left
17A5	RCL	BX,1 
17A7	RCL	DX,1 
17A9	OR.B	CL,CL	;check exp
17AB	JZ	rmnoadj	;:underflow
17AD	DEC.B	CL	;sub 1 from exp
17AFrmnoadj	XCHG	AX,CX	;restore AX, CL
17B0	XOR.B	DH,resave	;set sign
17B4	OR.B	AL,AL	;test exponent
17B6	JNZ	rmret	;:ok
17B8rmzero	XOR	AX,AX	;return zero
17BA	XOR	BX,BX
17BC	XOR	DX,DX
17BErmret	RET		;"
17BFrediv	OR.B	AL,AL	;Real division
17C1	JZ	rmret	;first=0:done
17C3	SUB.B	AL,CL	;sub exponents
17C5	CMC	
17C6	CALL	testexp	;test exponent
17C9	MOV	remul11,AL	;save exponent
17CC	MOV	DI,#remul21b	;ptr to dest
17CF	MOV	CL,#$05	;5 bytes
17D1	MOV	SI,#$0008	;8 bits
17D4rdloop	CMP	DX,remul23	;compare with num2
17D8	JNZ	rdcmp
17DA	CMP	BX,remul22
17DE	JNZ	rdcmp
17E0	CMP.B	AH,remul21a
17E4rdcmp	JB	rdshft	;below:no subtraction
17E6	SUB.B	AH,remul21a	;do subtraction
17EA	SBB	BX,remul22
17EE	SBB	DX,remul23
17F2rdshft	CMC		;invert carry
17F3	RCL.B	CH,1 	;shift into result
17F5	DEC	SI	;another bit ?
17F6	JNZ	rdbit	;:yes
17F8	MOV.B	[DI],CH	;store result byte
17FA	DEC.B	CL	;another byte ?
17FC	JZ	rdlast	;:no
17FE	DEC	DI	;next one
17FF	MOV	SI,#$0008	;8 bits again
1802rdbit	SHL.B	AH,1 	;shift left mantissa
1804	RCL	BX,1 
1806	RCL	DX,1 
1808	JNB	rdloop	;:normal step
180A	SUB.B	AH,remul21a	;carry: no comparison necessary
180E	SBB	BX,remul22	;do subtraction
1812	SBB	DX,remul23
1816	CLC	
1817	JMP	rdshft	;'shift in result
1819rdlast	SHL.B	AH,1 	;do last shift
181B	RCL	BX,1 
181D	RCL	DX,1 
181F	JB	rdshft2	;:ok
1821	CMP	DX,remul23	;test last step
1825	JNZ	rdcmp2
1827	CMP	BX,remul22
182B	JNZ	rdcmp2
182D	CMP.B	AH,remul21a
1831rdcmp2	CMC	
1832rdshft2	MOV	CX,remul11	;get result
1836	MOV	BX,remul12
183A	MOV	DX,remul13
183E	LAHF		;save flags
183F	TEST.B	DH,#$80	;normalized ?
1842	JNZ	rdnrm	;:yes
1844	SAHF		;get flags
1845	RCL.B	CH,1 	;shift left mantissa
1847	RCL	BX,1 
1849	RCL	DX,1 
184B	JMP.b	rdok	;'get sign, test exponent
184Drdnrm	INC.B	CL	;inc exponent
184F	JNZ	rdok	;:ok
1851	STC		;overflow error
1852	RET		;'
1853rdok	JMP	rmnoadj	;"set sign, test exponent
1856testexp	JB	texovr	;test exponent: overflow ?
1858	ADD	AL,#$80	;set offset again
185A	JB	texok	;:ok
185C	POP	BX	;forget return addr
185D	XOR	AX,AX	;return zero: underflow
185F	XOR	BX,BX
1861	XOR	DX,DX
1863	RET		;'
1864texovr	ADD	AL,#$80	;set offset again
1866	JNB	texok	;:no error
1868	POP	BX	;forget return addr
1869	STC		;overflow error
186A	RET		;'
186Btexok	MOV	remul21,CX	;save LSB2
186F	MOV	CX,DX	;get sign
1871	XOR	CX,DI
1873	NOT.B	CH	;invert it
1875	AND.B	CH,#$80	;mask sign
1878	MOV.B	resave,CH	;save sign
187C	OR.B	DH,#$80	;set mantissa MSB
187F	OR	DI,#$8000
1883	MOV	remul22,SI	;store mantissa 2
1887	MOV	remul23,DI
188B	RET		;"
188Creadd2	PUSH	DI	;add, keep second number
188D	PUSH	SI
188E	PUSH	CX
188F	CALL	readd	;do addition
1892	POP	CX
1893	POP	SI
1894	POP	DI
1895	RET		;"
1896resub2	PUSH	DI	;subtract, keep second number
1897	PUSH	SI
1898	PUSH	CX
1899	CALL	resub	;do subtraction
189C	POP	CX
189D	POP	SI
189E	POP	DI
189F	RET		;"
18A0remult2	PUSH	DI	;multiply, keep second number
18A1	PUSH	SI
18A2	PUSH	CX
18A3	CALL	remult	;do multiplication
18A6	POP	CX
18A7	POP	SI
18A8	POP	DI
18A9	RET		;"
18AArediv2	PUSH	DI	;divide, keep second number
18AB	PUSH	SI
18AC	PUSH	CX
18AD	CALL	rediv	;do division
18B0	POP	CX
18B1	POP	SI
18B2	POP	DI
18B3	RET		;"
18B4recmp	PUSH	DX	;Real comparison
18B5	XOR	DX,DI	;compare signs
18B7	POP	DX	;restore
18B8	JNS	rcsign	;:signs are the same
18BA	PUSH	DX	;different signs: get flag
18BB	RCL	DX,1 
18BD	POP	DX
18BE	RET		;'
18BFrcsign	TEST.B	DH,#$80	;sign ?
18C2	JZ	rcnum	;:positive
18C4	CALL	rcnum	;compare
18C7	JZ	rcdiff	;equal: don't invert
18C9	CMC		;invert flags
18CA	RET		;'
18CBrcnum	CMP.B	AL,CL	;compare exponents
18CD	JNZ	rcdiff
18CF	OR.B	AL,AL	;zero ?
18D1	JZ	rcdiff	;yes:equal
18D3	CMP	DX,DI	;compare mantissa MSB
18D5	JNZ	rcdiff
18D7	CMP	BX,SI
18D9	JNZ	rcdiff
18DB	CMP.B	AH,CH	;compare mantissa LSB
18DDrcdiff	RET		;"
18DEintreal	OR	AX,AX	;Int(Integer) -> Real
18E0	JNZ	irnot0	;:not zero
18E2	XOR	BX,BX	;return zero
18E4	XOR	DX,DX
18E6	RET		;'
18E7irnot0	MOV.B	BH,AH	;put sign
18E9	MOV	DX,AX
18EB	OR	DX,DX	;test sign
18ED	JNS	irpos	;:positive
18EF	NEG	DX	;negate number
18F1irpos	MOV	AX,#$0090	;exp, cleared LSB mantissa
18F4	OR.B	DH,DH	;test high byte
18F6	JNZ	ir16bits	;:not zero
18F8	MOV	AL,#$88	;speed it up...
18FA	XCHG.B	DL,DH	;shift 8 bits
18FCir16bits	OR	DX,DX	;test mantissa MSB
18FE	JS	irdone	;:ok, normalized
1900irnrm	DEC.B	AL	;count down exponent
1902	SHL	DX,1 	;shift it left
1904	JNS	irnrm	;:continue
1906irdone	OR.B	BH,BH	;negative ?
1908	JS	irpos2	;:yes
190A	AND.B	DH,#$7F	;set positive flag
190Dirpos2	XOR	BX,BX	;clear rest of mantissa
190F	RET		;"
1910reint	CMP	AL,#$A8	;Int(Real) - inefficient !
1912	JNB	riret	;exponent too big - done
1914	MOV	CX,AX	;save number
1916	MOV	SI,BX
1918	MOV	DI,DX
191A	XOR.B	AH,AH	;clear mask
191C	XOR	BX,BX
191E	XOR	DX,DX
1920	SUB.B	CL,#$80	;exponent-offset
1923	JBE	rizero	;:underflow, return zero
1925rim16l	CMP.B	CL,#$10	;shift 16 bit ?
1928	JB	rim8	;:done
192A	MOV.B	AH,BH	;shift right 16 bit
192C	MOV	BX,DX
192E	MOV	DX,#$FFFF	;put into mask
1931	SUB.B	CL,#$10	;count down
1934	JMP	rim16l	;'try again
1936rim8	CMP.B	CL,#$08	;shift 8 bit ?
1939	JB	rim1	;:done
193B	MOV.B	AH,BL	;shift right 8 bit
193D	MOV.B	BL,BH
193F	MOV.B	BH,DL
1941	MOV.B	DL,DH
1943	MOV	DH,#$FF	;put into mask
1945	SUB.B	CL,#$08	;count down
1948rim1	OR.B	CL,CL	;shift single bits ?
194A	JZ	riand	;:done
194Crim1l	STC		;shift in a 1
194D	RCR	DX,1 	;shift right 1 bit
194F	RCR	BX,1 
1951	RCR.B	AH,1 
1953	DEC.B	CL	;count down
1955	JNZ	rim1l	;:continue shifting
1957riand	AND	DX,DI	;get result:
1959	AND	BX,SI	;mask away the fraction
195B	AND.B	AH,CH
195Driret	RET		;'
195Erizero	XOR.B	AL,AL	;return zero
1960	RET		;"
1961refrac	PUSH	DX	;Frac - inefficient !
1962	PUSH	BX	;save original number
1963	PUSH	AX
1964	CALL	reint	;Int
1967	MOV	CX,AX	;result -> second number
1969	MOV	SI,BX
196B	MOV	DI,DX
196D	POP	AX	;restore number
196E	POP	BX
196F	POP	DX
1970	JMP	resub	;"do subtraction
1973xldreal	POP	BX	;Load real number onto stack
1974	POP	ES	;ptr
1975	ES:	
1976	PUSH	[DI]$04	;push that number
1979	ES:	
197A	PUSH	[DI]$02
197D	ES:	
197E	PUSH	[DI]
1980	JMP	BX	;"return
1982xrealcn	POP	BX	;Get real constant (inline)
1983	CS:		;get return addr
1984	PUSH	[BX]$04	;push that number
1987	CS:	
1988	PUSH	[BX]$02
198B	CS:	
198C	PUSH	[BX]
198E	ADD	BX,#$06	;skip constant
1991	JMP	BX	;"return
1993xstoreal	POP	BX	;Store real number
1994	POP	AX	;get number
1995	POP	CX
1996	POP	DX
1997	POP	DI	;get dest ptr
1998	POP	ES
1999	ES:		;store number
199A	MOV	[DI],AX
199C	ES:	
199D	MOV	[DI]$02,CX
19A0	ES:	
19A1	MOV	[DI]$04,DX
19A4	JMP	BX	;"return
19A6xadd	POP	errpos	;Add real numbers
19AA	POP	CX	;second number
19AB	POP	SI
19AC	POP	DI
19AD	POP	AX	;first number
19AE	POP	BX
19AF	POP	DX
19B0	CALL	readd	;do addition
19B3retest	JB	reovrerr	;:error
19B5repush	PUSH	DX	;store result on stack
19B6	PUSH	BX
19B7	PUSH	AX
19B8	JMP	[errpos]	;'return
19BCreovrerr	MOV	DL,#$01	;Floating point overflow
19BE	JMP	runerr	;"
19C1xsub	POP	errpos	;Subtract real numbers
19C5	POP	CX	;second number
19C6	POP	SI
19C7	POP	DI
19C8	POP	AX	;first number
19C9	POP	BX
19CA	POP	DX
19CB	CALL	resub	;do subtraction
19CE	JMP	retest	;"put result, return
19D0xmul	POP	errpos	;Multiply real numbers
19D4	POP	CX	;second number
19D5	POP	SI
19D6	POP	DI
19D7	POP	AX	;first number
19D8	POP	BX
19D9	POP	DX
19DAxmul2	CALL	remult	;do multiplication
19DD	JMP	retest	;"put result, return
19DFxdiv	POP	errpos	;Divide real numbers
19E3	POP	CX	;second number
19E4	POP	SI
19E5	POP	DI
19E6	POP	AX	;first number
19E7	POP	BX
19E8	POP	DX
19E9	OR.B	CL,CL	;second = 0 ?
19EB	JZ	xdiverr	;yes: div / 0 error
19ED	CALL	rediv	;divide
19F0	JMP	retest	;'put result, return
19F2xdiverr	MOV	DL,#$02	;Division by zero attempted
19F4	JMP	runerr	;"
19F7xneg	MOV	BX,SP	;Neg real: get addr of number
19F9	SS:	
19FA	CMP.B	[BX]$02,#$00	;zero ?
19FE	JZ	xnegzer	;:don't negate
1A00	SS:	
1A01	XOR.B	[BX]$07,#$80	;invert sign
1A05xnegzer	RET		;"
1A06xabs	MOV	BX,SP	;Abs real: get addr of number
1A08	SS:	
1A09	AND.B	[BX]$07,#$7F	;make positive
1A0D	RET		;"
1A0Erealeq	POP	errpos	;Real =
1A12	POP	CX	;second number
1A13	POP	SI
1A14	POP	DI
1A15	POP	AX	;first number
1A16	POP	BX
1A17	POP	DX
1A18	CALL	recmp	;compare real
1A1B	PUSH	errpos	;restore ret
1A1F	MOV	AX,#$0001	;true
1A22	JZ	realeq1	;equal: true
1A24	DEC	AX	;false
1A25realeq1	OR	AX,AX	;set flags
1A27	RET		;"
1A28realne	POP	errpos	;Real <>
1A2C	POP	CX	;second number
1A2D	POP	SI
1A2E	POP	DI
1A2F	POP	AX	;first number
1A30	POP	BX
1A31	POP	DX
1A32	CALL	recmp	;compare real
1A35	PUSH	errpos	;restore ret
1A39	MOV	AX,#$0001	;true
1A3C	JNZ	realne1	;not equal: true
1A3E	DEC	AX	;false
1A3Frealne1	OR	AX,AX	;set flags
1A41	RET		;"
1A42realge	POP	errpos	;Real >=
1A46	POP	CX	;second number
1A47	POP	SI
1A48	POP	DI
1A49	POP	AX	;first number
1A4A	POP	BX
1A4B	POP	DX
1A4C	CALL	recmp	;compare real
1A4F	PUSH	errpos	;restore ret
1A53	MOV	AX,#$0001	;true
1A56	JNB	realge1	;larger or equal: true
1A58	DEC	AX	;false
1A59realge1	OR	AX,AX	;set flags
1A5B	RET		;"
1A5Crealle	POP	errpos	;Real <=
1A60	POP	CX	;second number
1A61	POP	SI
1A62	POP	DI
1A63	POP	AX	;first number
1A64	POP	BX
1A65	POP	DX
1A66	CALL	recmp	;compare real
1A69	PUSH	errpos	;restore ret
1A6D	MOV	AX,#$0001	;true
1A70	JBE	realle1	;smaller or equal: true
1A72	DEC	AX	;false
1A73realle1	OR	AX,AX	;set flags
1A75	RET		;"
1A76realg	POP	errpos	;Real >
1A7A	POP	CX	;second number
1A7B	POP	SI
1A7C	POP	DI
1A7D	POP	AX	;first number
1A7E	POP	BX
1A7F	POP	DX
1A80	CALL	recmp	;compare real
1A83	PUSH	errpos	;restore ret
1A87	MOV	AX,#$0001	;true
1A8A	JA	realg1	;larger: true
1A8C	DEC	AX	;false
1A8Drealg1	OR	AX,AX	;set flags
1A8F	RET		;"
1A90reall	POP	errpos	;Real <
1A94	POP	CX	;second number
1A95	POP	SI
1A96	POP	DI
1A97	POP	AX	;first number
1A98	POP	BX
1A99	POP	DX
1A9A	CALL	recmp	;compare real
1A9D	PUSH	errpos	;restore ret
1AA1	MOV	AX,#$0001	;true
1AA4	JB	reall1	;smaller: true
1AA6	DEC	AX	;false
1AA7reall1	OR	AX,AX	;set flags
1AA9	RET		;"
1AAAxsqr	POP	errpos	;Sqr real: save ret addr
1AAE	POP	AX	;get number
1AAF	POP	BX
1AB0	POP	DX
1AB1	MOV	CX,AX	;-> second number
1AB3	MOV	SI,BX
1AB5	MOV	DI,DX
1AB7	JMP	xmul2	;"do real multiplication
1ABAxint	POP	errpos	;Int real: save ret addr
1ABE	POP	AX	;get number
1ABF	POP	BX
1AC0	POP	DX
1AC1	CALL	reint	;do Int
1AC4	JMP	repush	;"push result
1AC7xfrac	POP	errpos	;Frac real: save ret addr
1ACB	POP	AX	;get number
1ACC	POP	BX
1ACD	POP	DX
1ACE	CALL	refrac	;do Frac
1AD1	JMP	repush	;"push result
1AD4xrandom	CALL	dorandom	;Random real
1AD7	MOV	DX,#$0080	;original exponent
1ADA	MOV	AL,#$20	;max. count
1ADCrrndnrm	TEST.B	BH,#$80	;normalized ?
1ADF	JNZ	rrndok	;:yes
1AE1	SHL	CX,1 	;shift left 1 bit
1AE3	RCL	BX,1 
1AE5	DEC.B	DL	;count down exponent
1AE7	DEC.B	AL	;another bit ?
1AE9	JNZ	rrndnrm	;:yes
1AEB	XOR.B	DL,DL	;return zero
1AEDrrndok	AND.B	BH,#$7F	;clear mantissa MSB
1AF0	POP	AX	;ret addr
1AF1	PUSH	BX	;push result
1AF2	PUSH	CX
1AF3	PUSH	DX
1AF4	JMP	AX	;"return
1AF6xround	MOV	CH,#$FF	;Round
1AF8	JMP.b	trunc1	;'
1AFAxtrunc	XOR.B	CH,CH	;Trunc
1AFCtrunc1	POP	BX	;ret addr
1AFD	POP	AX	;get number
1AFE	POP	DX
1AFF	POP	DX
1B00	PUSH	BX	;restore ret
1B01trunc2	XCHG	AX,DX	;put exp
1B02	MOV	CL,#$8F	;subtract exponent
1B04	SUB.B	CL,DL	;too big ?
1B06	JB	truncerr	;:overflow error
1B08	CMP.B	CL,#$0F	;too many shifts ?
1B0B	JA	trunczer	;yes: 0
1B0D	INC.B	CL
1B0F	MOV.B	BH,AH	;save sign
1B11	OR.B	AH,#$80	;set mantissa MSB
1B14	SHR	AX,CL	;shift right
1B16	JNB	trunc3	;:nothing to round
1B18	OR.B	CH,CH	;round up ?
1B1A	JZ	trunc3	;:no
1B1C	INC	AX	;round it up
1B1D	JS	truncerr	;overflow: error
1B1Ftrunc3	TEST.B	BH,#$80	;sign ?
1B22	JZ	truncrt	;:no
1B24	NEG	AX	;negate it
1B26truncrt	RET		;'
1B27trunczer	XOR	AX,AX	;return 0
1B29	RET		;'
1B2Atruncerr	MOV	DL,#$92	;Out of integer range
1B2C	JMP	runerrrt	;"
1B2Fxintreal	CALL	intreal	;Integer -> Real
1B32	POP	CX	;get ret
1B33	PUSH	DX	;push number
1B34	PUSH	BX
1B35	PUSH	AX
1B36	JMP	CX	;"return
1B38xintre2	POP	errpos	;Int -> Real
1B3C	POP	CX	;keep second number
1B3D	POP	SI
1B3E	POP	DI
1B3F	POP	AX	;integer number
1B40	CALL	intreal	;do conversion
1B43	PUSH	DX	;push result
1B44	PUSH	BX
1B45	PUSH	AX
1B46	PUSH	DI	;push second number
1B47	PUSH	SI
1B48	PUSH	CX
1B49	JMP	[errpos]	;"return
	;Square root. Algorithm: Newton
	;x[n+1]:=0.5*(x[n]+c/x[n]) -> Sqrt(c)
1B4Dxsqrt	POP	errpos	;Sqrt: save ret addr
1B51	POP	AX	;get number
1B52	POP	BX
1B53	POP	DX
1B54	MOV	CX,AX	;-> second number
1B56	MOV	SI,BX
1B58	MOV	DI,DX
1B5A	OR.B	AL,AL	;zero ?
1B5C	JZ	sqrtdone	;yes: return
1B5E	TEST.B	DH,#$80	;test sign
1B61	JNZ	sqrterr	;negative: error
1B63	MOV	retrc1,AX	;store number
1B66	MOV	retrc2,BX
1B6A	MOV	retrc3,DX
1B6E	ADD.B	CL,#$80	;make a guess for the
1B71	SAR.B	CL,1 	;exponent
1B73	ADD.B	CL,#$80
1B76	MOV.B	AL,CL
1B78	SUB	AL,#$14	;end condition: difference
1B7A	MOV	cvexpcnt,AL	;smaller than this
1B7Dsqrtloop	MOV	AX,retrc1	;get original number
1B80	MOV	BX,retrc2
1B84	MOV	DX,retrc3
1B88	CALL	rediv2	;real division /x[n]
1B8B	CALL	readd2	;real addition +x[n]
1B8E	DEC.B	AL	;* 0.5 = dec exponent
1B90	PUSH	DX	;save x[n+1]
1B91	PUSH	BX
1B92	PUSH	AX	;test: end reached ?
1B93	CALL	resub	;real subtraction
1B96	CMP.B	AL,cvexpcnt	;test exponent
1B9A	POP	CX	;restore x[n+1]
1B9B	POP	SI
1B9C	POP	DI
1B9D	JNB	sqrtloop	;:not yet done
1B9Fsqrtdone	PUSH	DI	;return result
1BA0	PUSH	SI
1BA1	PUSH	CX
1BA2	JMP	[errpos]	;'return
1BA6sqrterr	MOV	DL,#$03	;Sqrt argument error
1BA8	JMP	runerr	;"
	;*** Transcendental functions ***
	;The algorithms used can be looked up in any formulary (!!!)
1BABxcos	POP	errpos	;Cos: save ret addr
1BAF	POP	CX	;get number
1BB0	POP	SI
1BB1	POP	DI
1BB2	MOV	AX,#$2181	;-pi/2
1BB5	MOV	BX,#$DAA2
1BB8	MOV	DX,#$490F
1BBB	CALL	resub	;real subtraction
1BBE	JMP.b	sin1	;'
1BC0xsin	POP	errpos	;Sin: save ret addr
1BC4	POP	AX	;get number
1BC5	POP	BX
1BC6	POP	DX
1BC7sin1	CMP	AL,#$6C	;small number ?
1BC9	JB	sinpush	;yes: return immediately
1BCB	MOV	CX,#$2183	;2*pi
1BCE	MOV	SI,#$DAA2	;bring into range 0..2*pi
1BD1	MOV	DI,#$490F
1BD4	PUSH	DX	;save sign
1BD5	AND.B	DH,#$7F	;make positive
1BD8	CALL	recmp	;real comparison
1BDB	POP	DX	;restore sign
1BDC	JB	sinl2pi	;:ok
1BDE	CALL	rediv2	;real division, keep 2*pi
1BE1	PUSH	DI	;save 2*pi
1BE2	PUSH	SI
1BE3	PUSH	CX
1BE4	CALL	refrac	;Frac
1BE7	POP	CX	;restore 2*pi
1BE8	POP	SI
1BE9	POP	DI
1BEA	CALL	remult2	;real mult, keep 2*pi
1BEDsinl2pi	TEST.B	DH,#$80	;negative ?
1BF0	JZ	sinpos	;:no
1BF2	CALL	readd2	;add 2*pi
1BF5sinpos	DEC.B	CL	;change to pi
1BF7	CALL	recmp	;real comparison
1BFA	PUSHF		;save result
1BFB	JB	sinlpi	;:below
1BFD	CALL	resub2	;subtract pi
1C00sinlpi	DEC.B	CL	;change to pi/2
1C02	CALL	recmp	;real comparison
1C05	JB	sinlpi2	;:less
1C07	INC.B	CL
1C09	OR.B	DH,#$80	;add -pi
1C0C	CALL	readd
1C0Fsinlpi2	CMP	AL,#$6C	;small number ?
1C11	JB	sinsmall	;yes:return
1C13	MOV	DI,#fltsin	;pointer to constants
1C16	MOV	CX,#$0007	;7 numbers
1C19	CALL	poly1	;do polynome
1C1Csinsmall	POPF		;flag: >pi
1C1D	JB	sinpush	;:ok
1C1F	OR.B	AL,AL	;neg, if not zero
1C21	JZ	sinpush	;:zero
1C23	XOR.B	DH,#$80	;negate
1C26sinpush	JMP	repush	;"push result
1C29fltsin	W	$9D58,$9F39,$D73F	;-7.6471637318E-13	;-1/15! constants for sin,cos
1C2F	W	$4360,$309D,$3092	; 1.6059043837E-10	; 1/13!
1C35	W	$AA67,$283F,$D732	;-2.5052103056E-08	;-1/11!
1C3B	W	$B66E,$1D2A,$38EF	; 2.7557319224E-06	; 1/ 9!
1C41	W	$0D74,$00D0,$D00D	;-1.9841269841E-04	;-1/ 7!
1C47	W	$887A,$8888,$0888	; 8.3333333333E-03	; 1/ 5!
1C4D	W	$AB7E,$AAAA,$AAAA	;-1.6666666667E-01	;"-1/ 3!
1C53xln	POP	errpos	;Ln (Logarithm)
1C57	POP	AX	;get number
1C58	POP	BX
1C59	POP	DX
1C5A	OR.B	AL,AL	;zero ?
1C5C	JZ	lnerr	;yes:error
1C5E	TEST.B	DH,#$80	;negative ?
1C61	JZ	lnok	;:no
1C63lnerr	MOV	DL,#$04	;Ln argument error
1C65	JMP	runerr	;'
1C68lnok	MOV.B	CH,AH	;sign, LSB
1C6A	MOV	CL,#$81	;bring into range 1..2
1C6C	SUB.B	AL,CL	;modify exponent
1C6E	CBW	
1C6F	PUSH	AX	;integer: exponent
1C70	XCHG	AX,CX	;set new exponent
1C71	MOV	CX,#$FB80	;multiply *Sqrt(2)/2
1C74	MOV	SI,#$F333
1C77	MOV	DI,#$3504
1C7A	CALL	remult	;multiplication
1C7D	MOV	CX,AX	;first -> second number
1C7F	MOV	SI,BX
1C81	MOV	DI,DX
1C83	MOV	AX,#$0081	;first number = 1
1C86	XOR	BX,BX
1C88	XOR	DX,DX
1C8A	CALL	readd2	;addition +1
1C8D	PUSH	DX	;save result
1C8E	PUSH	BX
1C8F	PUSH	AX
1C90	MOV	AX,#$0081	;first = -1
1C93	XOR	BX,BX
1C95	MOV	DX,#$8000
1C98	CALL	readd	;addition -1
1C9B	POP	CX	;restore result
1C9C	POP	SI
1C9D	POP	DI
1C9E	CALL	rediv	;division (c-1)/(c+1)
1CA1	MOV	DI,#fltln	;pointer to constants
1CA4	MOV	CX,#$0006	;6 numbers
1CA7	CALL	poly1	;do polynome
1CAA	INC.B	AL	;result *2
1CAC	MOV	CX,#$D27F	;+ ln(sqrt(2))
1CAF	MOV	SI,#$17F7
1CB2	MOV	DI,#$3172
1CB5	CALL	readd	;addition
1CB8	POP	CX	;get int exponent
1CB9	PUSH	DX	;save result
1CBA	PUSH	BX
1CBB	PUSH	AX
1CBC	XCHG	AX,CX	;exponent
1CBD	CALL	intreal	;-> real
1CC0	MOV	CX,#$D280	;* ln(2)
1CC3	MOV	SI,#$17F7
1CC6	MOV	DI,#$3172
1CC9	CALL	remult	;multiplication
1CCC	POP	CX	;restore result
1CCD	POP	SI
1CCE	POP	DI
1CCF	CALL	readd	;add
1CD2	CMP	AL,#$67	;do a cosmetic round-off (!!!)
1CD4	JNB	lnround	;:no
1CD6	XOR	AX,AX	;return zero
1CD8	XOR	BX,BX
1CDA	XOR	DX,DX
1CDClnround	JMP	repush	;"push result
1CDFfltln	W	$8A7D,$D89D,$1D89	; 7.6923076923E-02	;1/13 Constants for Ln
1CE5	W	$E97D,$8BA2,$3A2E	; 9.0909090909E-02	;1/11
1CEB	W	$8E7D,$38E3,$638E	; 1.1111111111E-01	;1/ 9
1CF1	W	$497E,$2492,$1249	; 1.4285714286E-01	;1/ 7
1CF7	W	$CD7E,$CCCC,$4CCC	; 2.0000000000E-01	;1/ 5
1CFD	W	$AB7F,$AAAA,$2AAA	; 3.3333333333E-01	;"1/ 3
1D03xexp	POP	errpos	;Exp: get return addr
1D07	POP	AX	;get number
1D08	POP	BX
1D09	POP	DX
1D0A	TEST.B	DH,#$80	;negative ?
1D0D	PUSHF		;remember flag
1D0E	AND.B	DH,#$7F	;make it positive
1D11	MOV	CX,#$D280	;/ln(2)
1D14	MOV	SI,#$17F7
1D17	MOV	DI,#$3172	;(would be faster to use mult !)
1D1A	CALL	rediv	;division
1D1D	CMP	AL,#$88	;too much ?
1D1F	JNB	experr	;:yes, overflow
1D21	PUSH	DX	;save number
1D22	PUSH	BX
1D23	PUSH	AX
1D24	INC.B	AL	;* 2
1D26	MOV	CH,#$FF
1D28	CALL	trunc2	;do Round
1D2B	POP	CX	;restore number
1D2C	POP	SI
1D2D	POP	DI
1D2E	PUSH	AX	;save integer part
1D2F	CALL	intreal	;convert -> real
1D32	OR.B	AL,AL	;zero ?
1D34	JZ	expzer	;:yes
1D36	DEC.B	AL	;/ 2
1D38expzer	XCHG	AX,CX	;swap them
1D39	XCHG	BX,SI
1D3B	XCHG	DX,DI
1D3D	CALL	resub	;subtraction -> frac
1D40	MOV	DI,#fltexp	;ptr to constants
1D43	MOV	CX,#$0008	;8 numbers
1D46	CALL	poly2	;do polynome
1D49	POP	CX	;get exponent
1D4A	SHR	CX,1 	;/ 2
1D4C	JNB	expeven	;:even
1D4E	PUSH	CX	;save it
1D4F	MOV	CX,#$FB81	;* Sqrt(2)
1D52	MOV	SI,#$F333
1D55	MOV	DI,#$3504
1D58	CALL	remult	;multiplication
1D5B	POP	CX	;restore exponent
1D5Cexpeven	ADD.B	AL,CL	;add exponents
1D5E	JB	experr	;:overflow error
1D60	POPF		;restore sign
1D61	JZ	exppush	;pos: store result
1D63	MOV	CX,AX	;negative: do 1/x -> x
1D65	MOV	SI,BX	;first -> second
1D67	MOV	DI,DX
1D69	MOV	AX,#$0081	;first = 1
1D6C	XOR	BX,BX
1D6E	XOR	DX,DX
1D70	CALL	rediv	;division
1D73exppush	JMP	repush	;'push result
1D76experr	POP	AX	;clear stack
1D77	MOV	DL,#$01	;Floating point overflow
1D79	JMP	runerr	;"
1D7Cfltexp	W	$2E6D,$111D,$3160	; 1.3215486790E-06	;ln(2)**8/8! Constants for Exp
1D82	W	$4670,$FE2C,$7FE5	; 1.5252733804E-05	;ln(2)**7/7!
1D88	W	$3674,$897C,$2184	; 1.5403530393E-04	;ln(2)**6/6!
1D8E	W	$5377,$FF3C,$2EC3	; 1.3333558146E-03	;ln(2)**5/5!
1D94	W	$D27A,$5B7D,$1D95	; 9.6181291076E-03	;ln(2)**4/4!
1D9A	W	$257C,$46B8,$6358	; 5.5504108665E-02	;ln(2)**3/3!
1DA0	W	$167E,$EFFC,$75FD	; 2.4022650696E-01	;ln(2)**2/2!
1DA6	W	$D280,$17F7,$3172	; 6.9314718056E-01	;"ln(2)
1DACxarctan	POP	errpos	;ArcTan: get ret addr
1DB0	POP	AX	;get number
1DB1	POP	BX
1DB2	POP	DX
1DB3	OR.B	AL,AL	;zero ?
1DB5	JZ	exppush	;yes: return
1DB7	XOR	CX,CX	;clear neg flag
1DB9	TEST.B	DH,#$80	;negative ?
1DBC	JZ	atnpos	;:no
1DBE	INC	CX	;set neg flag
1DBF	AND.B	DH,#$7F	;make positive
1DC2atnpos	PUSH	CX	;save neg flag
1DC3	MOV	CX,#$0081	;second = 1
1DC6	XOR	SI,SI
1DC8	XOR	DI,DI
1DCA	CALL	recmp	;real comparison
1DCD	JB	atnsmall	;:x < 1
1DCF	XCHG	AX,CX	;swap numbers
1DD0	XCHG	BX,SI
1DD2	XCHG	DX,DI
1DD4	CALL	rediv	;division x -> 1/x
1DD7	POP	CX	;restore neg flag
1DD8	INC	CX	;set bits: large number
1DD9	INC	CX
1DDA	PUSH	CX	;push it again
1DDBatnsmall	MOV	CX,#$4A7E	;> 0.1371 ?
1DDE	MOV	SI,#$E98E
1DE1	MOV	DI,#$0C6F
1DE4	CALL	recmp	;real comparison
1DE7	JNB	atnrng	;:yes
1DE9	CALL	atnpoly	;do polynome
1DEC	JMP.b	atndone	;'complete result
1DEEatnrng	MOV	DI,#fltatnrg	;pointer into table
1DF1	MOV	CX,#$0002
1DF4atnrlp	PUSH	CX	;save index
1DF5	PUSH	DI	;save ptr
1DF6	CS:		;test different ranges
1DF7	MOV	CX,[DI]	;get table entry
1DF9	CS:	
1DFA	MOV	SI,[DI]$02
1DFD	CS:	
1DFE	MOV	DI,[DI]$04
1E01	CALL	recmp	;real comparison
1E04	POP	DI	;restore
1E05	POP	CX
1E06	JB	atnrfnd	;:smaller than that
1E08	ADD	DI,#$12	;go to next entry
1E0B	LOOP	atnrlp	;:another one
1E0D	SUB	DI,#$06	;save space in table
1E10atnrfnd	ADD	DI,#$06	;go to associated number
1E13	MOV	retrc1,AX	;save number
1E16	MOV	retrc2,BX
1E1A	MOV	retrc3,DX
1E1E	PUSH	DI	;save ptr
1E1F	CS:		;get number from table
1E20	MOV	CX,[DI]
1E22	CS:	
1E23	MOV	SI,[DI]$02
1E26	CS:	
1E27	MOV	DI,[DI]$04
1E2A	CALL	resub2	;subtraction x-t
1E2D	PUSH	DX	;save number
1E2E	PUSH	BX
1E2F	PUSH	AX
1E30	MOV	AX,retrc1	;restore x
1E33	MOV	BX,retrc2
1E37	MOV	DX,retrc3
1E3B	CALL	remult	;x*t
1E3E	MOV	CX,#$0081	;second = 1
1E41	XOR	SI,SI
1E43	XOR	DI,DI
1E45	CALL	readd	;addition
1E48	MOV	CX,AX	;first -> second
1E4A	MOV	SI,BX
1E4C	MOV	DI,DX
1E4E	POP	AX	;restore x-t
1E4F	POP	BX
1E50	POP	DX
1E51	CALL	rediv	;division -> (x-t)/(x*t+1)
1E54	CALL	atnpoly	;do polynome
1E57	POP	DI	;restore ptr
1E58	ADD	DI,#$06
1E5B	CS:	
1E5C	MOV	CX,[DI]	;get number
1E5E	CS:	
1E5F	MOV	SI,[DI]$02
1E62	CS:	
1E63	MOV	DI,[DI]$04
1E66	CALL	readd	;add it
1E69atndone	POP	CX	;get flag
1E6A	TEST.B	CL,#$02	;done 1/x ?
1E6D	JZ	atnnorcp	;:no
1E6F	PUSH	CX	;save flag
1E70	MOV	CX,AX	;first -> second
1E72	MOV	SI,BX
1E74	MOV	DI,DX
1E76	MOV	AX,#$2181	;first = pi/2
1E79	MOV	BX,#$DAA2
1E7C	MOV	DX,#$490F
1E7F	CALL	resub	;subtraction pi/2-y
1E82	POP	CX	;restore flag
1E83atnnorcp	TEST.B	CL,#$01	;negative ?
1E86	JZ	atnpos2	;:no
1E88	OR.B	DH,#$80	;set sign
1E8Batnpos2	JMP	repush	;"push result
1E8Efltatnrg	W	$E77F,$CCCF,$5413	; 4.1421356237E-01	;1. tan(22.5) range table
1E94	W	$F67F,$A2F4,$0930	; 2.6794919243E-01	;   tan(15)   for ArcTan
1E9A	W	$6A7F,$91C1,$060A	; 2.6179938780E-01	;   15
1EA0	W	$B580,$8A9E,$446F	; 7.6732698798E-01	;2. tan(37.5)
1EA6	W	$8280,$3A2C,$13CD	; 5.7735026919E-01	;   tan(30)
1EAC	W	$6A80,$91C1,$060A	; 5.2359877560E-01	;   30
1EB2	W	$0081,$0000,$0000	; 1.0000000000E+00	;3. tan(45)
1EB8	W	$2180,$DAA2,$490F	; 7.8539816340E-01	;"   45
1EBEfltatn	W	$E87D,$8BA2,$BA2E	;-9.0909090909E-02	;-1/11 constants for ArcTan
1EC4	W	$8E7D,$38E3,$638E	; 1.1111111111E-01	; 1/ 9
1ECA	W	$497E,$2492,$9249	;-1.4285714286E-01	;-1/ 7
1ED0	W	$CD7E,$CCCC,$4CCC	; 2.0000000000E-01	; 1/ 5
1ED6	W	$AB7F,$AAAA,$AAAA	;-3.3333333333E-01	;" 1/ 3
1EDCatnpoly	MOV	DI,#fltatn	;ptr to ArcTan constants
1EDF	MOV	CX,#$0005	;5 of them
1EE2poly1	PUSH	DX	;do polynome: store number
1EE3	PUSH	BX	;y:=x+c*x**3+b*x**5+a*x**7...
1EE4	PUSH	AX
1EE5	PUSH	CX	;save cnt
1EE6	PUSH	DI	;save ptr
1EE7	MOV	CX,AX	;first -> second
1EE9	MOV	SI,BX
1EEB	MOV	DI,DX
1EED	CALL	remult	;multiplication -> square
1EF0	POP	DI	;restore cnt,ptr
1EF1	POP	CX
1EF2	CALL	poly2	;do polynome 2
1EF5	POP	CX	;get number -> second
1EF6	POP	SI
1EF7	POP	DI
1EF8	JMP	remult	;"multiplication
1EFBpoly2	MOV	retrc1,AX	;do polynome 2: store number
1EFE	MOV	retrc2,BX	;y:=1+c*x+b*x**2+a*x**3...
1F02	MOV	retrc3,DX
1F06	CS:		;get number from table
1F07	MOV	AX,[DI]
1F09	CS:	
1F0A	MOV	BX,[DI]$02
1F0D	CS:	
1F0E	MOV	DX,[DI]$04
1F11	PUSH	CX	;save ptr, cnt
1F12	PUSH	DI
1F13	JMP.b	polystrt	;'start it
1F15polyloop	PUSH	CX	;save ptr, cnt
1F16	PUSH	DI
1F17	CS:	
1F18	MOV	CX,[DI]	;get number from table
1F1A	CS:	
1F1B	MOV	SI,[DI]$02
1F1E	CS:	
1F1F	MOV	DI,[DI]$04
1F22	CALL	readd	;add it
1F25polystrt	MOV	CX,retrc1	;get x -> second
1F29	MOV	SI,retrc2
1F2D	MOV	DI,retrc3
1F31	CALL	remult	;multiplication *x
1F34	POP	DI	;restore ptr, cnt
1F35	POP	CX
1F36	ADD	DI,#$06	;go to next number
1F39	LOOP	polyloop	;:another one
1F3B	MOV	CX,#$0081	;second = 1
1F3E	XOR	SI,SI
1F40	XOR	DI,DI
1F42	JMP	readd	;"add 1
1F45fmtreal	PUSH	BX	;Format real number
1F46	CMP	DX,#$19	;number of fraction chars
1F49	JB	frnolim2	;< 25:ok
1F4B	MOV	AX,CX	;field width
1F4D	CALL	limstind	;limit it
1F50	MOV	DL,#$07
1F52	TEST.B	[DI]$05,#$80	;negative (DI:ptr to num)
1F56	JZ	frpos	;:no
1F58	INC.B	DL	;one char more
1F5Afrpos	SUB.B	AL,DL
1F5C	JNB	frnound	;:no underflow
1F5E	XOR.B	AL,AL	;negative: make zero
1F60frnound	CMP	AL,#$09	;limit to 9
1F62	JB	frnolim
1F64	MOV	AL,#$09
1F66frnolim	INC.B	AL	;-> number of fraction chars
1F68	MOV.B	DL,AL
1F6A	MOV.B	DH,AL
1F6Cfrnolim2	PUSH	DX	;save # fraction chars
1F6D	CALL	realdec	;convert to decimal
1F70	POP	DX	;restore
1F71	MOV.B	AL,DL
1F73	INC.B	AL	;number of mantissa chars
1F75	OR.B	DH,DH
1F77	JNZ	frround
1F79	ADD.B	AL,CL
1F7B	JNS	frlimprc
1F7D	MOV.B	cvoutbuf,#$00	;mark end of buffer
1F82	JMP.b	frfmtit	;'
1F84frlimprc	CMP	AL,#$0C	;max 11 digits shown
1F86	JB	frround	;:ok
1F88	MOV	AL,#$0B	;limit it
1F8Afrround	CALL	decround	;round up number
1F8Dfrfmtit	POP	BX	;dest ptr
1F8E	MOV	SI,#cvoutbuf	;source: dec buffer
1F91	TEST.B	CH,#$80	;test sign
1F94	JZ	frpos2	;:no
1F96	MOV	AL,#$2D	;put a -
1F98	CALL	frdigsto
1F9Bfrpos2	MOV.B	CH,CL	;exponent: number of int digs
1F9D	OR.B	DH,DH	;size of number
1F9F	JZ	frzer	;:zero
1FA1	MOV	CH,#$00
1FA3frzer	OR.B	CH,CH	;neg exponent ?
1FA5	JNS	frint	;:no
1FA7	CALL	frdig0	;store 0 - no int part
1FAA	JMP.b	frfrac0	;'do fraction part
1FACfrint	CALL	frdig	;put char from source
1FAF	DEC.B	CH	;another one ?
1FB1	JNS	frint	;:yes
1FB3frfrac0	OR.B	DL,DL	;test fraction len
1FB5	JZ	frexp	;:nothing
1FB7	MOV	AL,#$2E	;put a .
1FB9	CALL	frdigsto
1FBCfrfill0	INC.B	CH	;put zeroes as necessary
1FBE	JZ	frfrac	;:exponent ok
1FC0	CALL	frdig0	;put a 0
1FC3	DEC.B	DL	;field filled ?
1FC5	JNZ	frfill0	;:no
1FC7frfrac	DEC.B	DL	;another fraction digit ?
1FC9	JS	frexp	;:no
1FCB	CALL	frdig	;do digit
1FCE	JMP	frfrac	;'next one
1FD0frexp	OR.B	DH,DH	;do exponent ?
1FD2	JNZ	frputexp	;:yes
1FD4	RET		;'
1FD5frputexp	MOV	AL,#$45	;put an E
1FD7	CALL	frdigsto
1FDA	MOV	AL,#$2B	;+
1FDC	OR.B	CL,CL	;test sign
1FDE	JNS	frposexp	;:positive
1FE0	NEG.B	CL	;negate exponent
1FE2	MOV	AL,#$2D	;-
1FE4frposexp	CALL	frdigsto	;store sign
1FE7	MOV	AL,#$2F	;do DIV 10 / MOD 10
1FE9frexpsub	INC.B	AL	;count up digit
1FEB	SUB.B	CL,#$0A	;successive subtraction
1FEE	JNB	frexpsub	;:continue
1FF0	CALL	frdigsto	;put digit
1FF3	ADD.B	CL,#$3A	;restore second digit
1FF6	MOV.B	AL,CL	;put digit
1FF8	JMP.b	frdigsto	;"
1FFAfrdig	MOV.B	AL,[SI]	;get digit from source
1FFC	OR.B	AL,AL	;end ?
1FFE	JZ	frdig0	;:yes
2000	INC	SI	;ptr to next char
2001	JMP.b	frdigsto	;'store digit
2003frdig0	MOV	AL,#$30	;store a 0
2005frdigsto	MOV.B	[BX],AL	;store digit
2007	INC	BX	;ptr to next dest char
2008	RET		;"
2009realdec	MOV	AX,[DI]	;Real -> Decimal
200B	MOV	BX,[DI]$02	;get real number (in CS !)
200E	MOV	DX,[DI]$04
2011	OR.B	AL,AL	;zero ?
2013	JNZ	rdno0	;:no
2015	MOV	SI,#cvoutbuf	;fill buffer with zeroes
2018rdfill	MOV	[SI],#$3030
201C	INC	SI
201D	INC	SI
201E	CMP	SI,#currfil	;end reached ?
2022	JNZ	rdfill	;:no
2024	MOV	CX,#$0000	;exponent 0
2027	RET		;'
2028rdno0	MOV.B	CH,DH	;get sign
202A	AND.B	DH,#$7F	;clear sign in mantissa
202D	PUSH	AX	;save exp
202E	PUSH	DX	;save mantissa
202F	SUB	AL,#$80	;exponent
2031	CBW	
2032	MOV	DX,#$004D	;* 77
2035	IMUL	DX	;77/256 is about ln(2)/ln(10) !
2037	ADD	AX,#$0005	;+5
203A	MOV.B	CL,AH	;this is approx. dec exponent
203C	POP	DX	;restore
203D	POP	AX
203E	CMP.B	CL,#$D9	;correct error
2041	JNZ	rdnocomp	;:ok
2043	INC.B	CL
2045rdnocomp	PUSH	CX	;save exponent, sign
2046	NEG.B	CL	;negate exponent
2048	CALL	realrang	;bring into range
204B	POP	CX	;restore
204C	CMP	AL,#$81	;exp ok ?
204E	JNB	rdnoadj	;:yes
2050	CALL	mult10	;mult * 10
2053	DEC.B	CL	;count down dec exp
2055rdnoadj	PUSH	CX	;save exp, sign
2056	OR.B	DH,#$80	;set mantissa MSB
2059	MOV	CL,#$84	;offset for exponent
205B	SUB.B	CL,AL
205D	MOV	AL,#$00	;LSB = 0
205F	JZ	rdnosh	;:no shift
2061rdshift	SHR	DX,1 	;convert to 6-byte-card
2063	RCR	BX,1 
2065	RCR	AX,1 
2067	DEC.B	CL	;shift again ?
2069	JNZ	rdshift	;:yes
206Brdnosh	MOV	SI,#cvoutbuf	;ptr to output buffer
206Erdconv	MOV.B	CH,DH	;get upper 4 bits
2070	MOV	CL,#$04
2072	SHR.B	CH,CL
2074	ADD.B	CH,#$30	;-> digit
2077	MOV.B	[SI],CH	;store digit
2079	AND.B	DH,#$0F	;clear that digit
207C	PUSH	DX	;card * 10 -> card
207D	PUSH	BX	;save number
207E	PUSH	AX
207F	SHL	AX,1 	;card * 4
2081	RCL	BX,1 
2083	RCL	DX,1 
2085	SHL	AX,1 
2087	RCL	BX,1 
2089	RCL	DX,1 
208B	POP	CX	;+ card
208C	ADD	AX,CX
208E	POP	CX
208F	ADC	BX,CX
2091	POP	CX
2092	ADC	DX,CX
2094	SHL	AX,1 	;* 2 = card * 10
2096	RCL	BX,1 
2098	RCL	DX,1 
209A	INC	SI	;next buffer pos
209B	CMP	SI,#currfil	;done ?
209F	JNZ	rdconv	;:no
20A1	POP	CX	;restore exp, sign
20A2	RET		;"
20A3decround	XOR.B	AH,AH	;Round up decimal number
20A5	MOV	BX,#cvoutbuf	;ptr to buffer
20A8	ADD	BX,AX	;add digit index
20AA	CMP.B	[BX],#$35	;5 ?
20AD	MOV.B	[BX],#$00	;store 0: end mark
20B0	JB	drdone	;below: no round up
20B2drloop	DEC.B	AL	;go back one digit
20B4	JS	drincexp	;:beg of buffer reached
20B6	DEC	BX	;go back one pos
20B7	INC.B	[BX]	;inc that digit
20B9	CMP.B	[BX],#$3A	;carry ?
20BC	JB	drdone	;no: done
20BE	MOV.B	[BX],#$00	;mark as end
20C1	JMP	drloop	;'continue
20C3drincexp	MOV.B	[BX],#$31	;store a 1
20C6	MOV.B	[BX]$01,#$00	;end mark
20CA	INC.B	CL	;inc exponent
20CCdrdone	RET		;"
20CDascreal	MOV.B	CL,[BX]	;String -> Real
20CF	CMP.B	CL,#$2D	;- ?
20D2	JNZ	arpos	;:no
20D4	INC	BX	;next char
20D5arpos	PUSH	CX	;save sign
20D6	CALL	ascreal2	;convert unsigned real
20D9	POP	CX	;restore sign
20DA	JB	arerr	;:error
20DC	CMP.B	CL,#$2D	;- ?
20DF	JNZ	arpos1	;:no
20E1	CMP.B	[DI],#$00	;result = 0 ?
20E4	JZ	arpos1
20E6	XOR.B	[DI]$05,#$80	;negate it
20EAarpos1	CLC		;no error
20EBarerr	RET		;"
20ECascreal2	MOV	SI,BX	;source ptr
20EE	XOR	AX,AX	;ASCII -> unsigned real
20F0	XOR	BX,BX	;clear result
20F2	XOR	DX,DX
20F4	XOR	CX,CX
20F6	MOV.B	cvexpcnt,#$00	;exponent
20FBarloop	MOV.B	CL,[SI]	;get char
20FD	CMP.B	CL,#$61	;lower case ?
2100	JB	arupc	;:no
2102	CMP.B	CL,#$7A
2105	JA	arupc	;:no
2107	SUB.B	CL,#$20	;convert to upper case
210Aarupc	CALL	ardigit2	;do a digit
210D	JB	arnodig	;:no digit
210F	CALL	mult10	;result * 10
2112	JB	arover	;:overflow
2114	PUSH	DI	;save ptrs
2115	PUSH	SI
2116	PUSH	CX
2117	PUSH	DX	;save result
2118	PUSH	BX
2119	PUSH	AX
211A	MOV.B	AL,CL	;get digit
211C	XOR.B	AH,AH	;clear hi byte
211E	CALL	intreal	;convert to real
2121	POP	CX	;restore result
2122	POP	SI
2123	POP	DI
2124	CALL	readd	;add digit to result
2127	POP	CX	;restore ptrs
2128	POP	SI
2129	POP	DI
212A	TEST.B	CH,#$40	;after decimal point ?
212D	JZ	arnext	;:yes
212F	DEC.B	cvexpcnt	;count down exponent
2133	JMP.b	arnext	;'next digit
2135arnodig	CMP.B	CL,#$2E	;decimal point ?
2138	JNZ	arexp	;:no, test exponent
213A	TEST.B	CH,#$40	;. already done ?
213D	STC		;error
213E	JNZ	arover	;yes: error
2140	OR.B	CH,#$40	;set flag
2143arnext	INC	SI	;next char
2144	JMP	arloop	;'continue
2146arover	MOV	BX,SI	;pointer: end pos
2148	RET		;'
2149arexp	CMP.B	CL,#$45	;E ?
214C	MOV.B	CL,cvexpcnt	;exponent
2150	JNZ	arexp3	;:no
2152	CALL	realrng	;bring into range
2155	JB	arover	;:error
2157	INC	SI	;go to next char
2158	MOV.B	CL,[SI]	;get it
215A	CMP.B	CL,#$2B	;+ ?
215D	JZ	arposexp	;:yes
215F	CMP.B	CL,#$2D	;- ?
2162	JNZ	arexp2	;no: digit
2164	OR.B	CH,#$20	;set flag: neg exponent
2167arposexp	INC	SI	;next char
2168arexp2	CALL	ardigit	;do digit
216B	JB	arover	;:error
216D	PUSH	AX	;save
216E	MOV.B	AL,CL	;first digit
2170	INC	SI	;next char
2171	CALL	ardigit	;do digit
2174	JB	aronedig	;:no second digit
2176	MOV.B	AH,AL	;AL*10 -> AL
2178	SHL.B	AL,1 
217A	SHL.B	AL,1 
217C	ADD.B	AL,AH
217E	SHL.B	AL,1 
2180	ADD.B	AL,CL
2182	INC	SI	;next char
2183aronedig	MOV.B	CL,AL	;new exponent
2185	POP	AX	;restore
2186	TEST.B	CH,#$20	;negative exponent ?
2189	JZ	arexp3	;:no
218B	NEG.B	CL	;negate it
218Darexp3	CALL	realrng	;real number*10**exp
2190	MOV	[DI],AX	;store the result
2192	MOV	[DI]$02,BX
2195	MOV	[DI]$04,DX
2198	JMP	arover	;"set pointer to end
219Arealrng	CMP.B	CL,#$DA	;outside a reasonable range ?
219D	JL	rrerr	;:yes
219F	CMP.B	CL,#$26
21A2	JG	rrerr	;:yes
21A4	PUSH	CX	;save pointers
21A5	PUSH	SI
21A6	PUSH	DI
21A7	CALL	realrang	;bring into range
21AA	POP	DI
21AB	POP	SI
21AC	POP	CX
21AD	RET		;'
21AErrerr	STC		;error
21AF	RET		;"
21B0ardigit	MOV.B	CL,[SI]	;get digit
21B2ardigit2	CMP.B	CL,#$30	;< 0 ?
21B5	JB	ardret	;:yes
21B7	CMP.B	CL,#$3A	;> 9 ?
21BA	CMC		;change to error flag
21BB	JB	ardret	;:yes
21BD	SUB.B	CL,#$30	;convert to number
21C0ardret	RET		;"
21C1realrang	PUSH	DX	;bring into range:
21C2	PUSH	BX	;number*10**CL
21C3	PUSH	AX	;save number
21C4	MOV.B	cvdecexp,CL	;save exponent
21C8	OR.B	CL,CL	;negative ?
21CA	JNS	rrpos	;:no
21CC	NEG.B	CL	;make it positive
21CErrpos	MOV.B	BL,CL	;(exponent DIV 4)*6
21D0	AND.B	BL,#$FC
21D3	MOV.B	BH,BL
21D5	SHR.B	BL,1 
21D7	ADD.B	BL,BH	;-> pointer into table
21D9	XOR.B	BH,BH	;clear hi
21DB	LEA	DI,[BX]fltdec	;factor table
21DF	CS:	
21E0	MOV	AX,[DI]	;get factor
21E2	CS:	
21E3	MOV	BX,[DI]$02
21E6	CS:	
21E7	MOV	DX,[DI]$04
21EA	AND.B	CL,#$03	;exponent MOD 4
21ED	JZ	rrdone	;:ok
21EFrrmul	CALL	mult10	;do successive multiplications
21F2	DEC.B	CL	;another ?
21F4	JNZ	rrmul	;:yes
21F6rrdone	MOV	CX,AX	;factor -> second
21F8	MOV	SI,BX
21FA	MOV	DI,DX
21FC	POP	AX	;restore number
21FD	POP	BX
21FE	POP	DX
21FF	TEST.B	cvdecexp,#$80	;positive exponent ?
2204	JNZ	rrdiv	;:no
2206	JMP	remult	;'multiply num*factor
2209rrdiv	JMP	rediv	;"divide num/factor
220Cfltdec	W	$0081,$0000,$0000	; 1.0000000000E+00	;decimal factor table
2212	W	$008E,$0000,$1C40	; 1.0000000000E+04
2218	W	$009B,$2000,$3EBC	; 1.0000000000E+08
221E	W	$00A8,$A510,$68D4	; 1.0000000000E+12
2224	W	$04B6,$C9BF,$0E1B	; 1.0000000000E+16
222A	W	$ACC3,$EBC5,$2D78	; 1.0000000000E+20
2230	W	$CDD0,$1BCE,$53C2	; 1.0000000000E+24
2236	W	$F9DE,$3978,$013F	; 1.0000000000E+28
223C	W	$2BEB,$ADA8,$1DC5	; 1.0000000000E+32
2242	W	$C9F8,$CE7B,$4097	; 1.0000000000E+36	;"
2248mult10	OR.B	AL,AL	;Real multiplication * 10
224A	JNZ	m10not0	;:not zero
224C	RET		;'zero - return
224Dm10not0	OR.B	DH,#$80	;set mantissa MSB
2250	PUSH	CX	;save CX
2251	PUSH	DX	;save number
2252	PUSH	BX
2253	PUSH	AX
2254	SHR	DX,1 	;mantissa / 4
2256	RCR	BX,1 
2258	RCR.B	AH,1 
225A	SHR	DX,1 
225C	RCR	BX,1 
225E	RCR.B	AH,1 
2260	POP	CX	;add mantissa
2261	ADD.B	AH,CH	;why no ADC (rounding !) ?
2263	POP	CX
2264	ADC	BX,CX
2266	POP	CX
2267	ADC	DX,CX
2269	POP	CX	;restore CX
226A	JNB	m10nrm
226C	RCR	DX,1 	;shift right
226E	RCR	BX,1 
2270	RCR.B	AH,1 
2272	INC.B	AL	;exponent+1
2274	JNZ	m10nrm	;:ok
2276	STC		;overflow...
2277	RET		;'
2278m10nrm	AND.B	DH,#$7F	;make positive
227B	ADD	AL,#$03	;exponent+3
227D	RET		;"
227Erealcard	POP	SI	;Real -> long cardinal
227F	POP	DI	;2 ret addrs
2280	POP	DX	;get real
2281	POP	CX
2282	POP	BX
2283	PUSH	DI	;restore rets
2284	PUSH	SI
2285	TEST.B	BH,#$80	;negative ?
2288	JNZ	rczero	;yes:return zero
228A	OR.B	BH,#$80	;set mantissa MSB
228D	MOV	AL,#$A0	;exponent offset
228F	SUB.B	AL,DL	;calc number of shifts
2291	JB	rcover	;:too much
2293	CMP	AL,#$20	;too small ?
2295	JNB	rczero	;:return zero
2297rcdenorm	OR.B	AL,AL	;another shift ?
2299	JZ	rcdone	;:done
229B	SHR	BX,1 	;shift right: denormalize
229D	RCR	CX,1 
229F	DEC.B	AL
22A1	JMP	rcdenorm	;'next one
22A3rcdone	MOV	AX,CX	;return number in DX:AX
22A5	MOV	DX,BX
22A7	RET		;'
22A8rczero	XOR	AX,AX	;return zero
22AA	XOR	DX,DX
22AC	RET		;'
22ADrcover	MOV	AX,#$FFFF	;return maxcard
22B0	MOV	DX,#$FFFF
22B3	RET		;"
22B4cardreal	MOV	BX,DX	;long cardinal -> real
22B6	MOV	CX,AX
22B8	OR	AX,DX	;0 ?
22BA	JZ	crzero	;yes: return 0
22BC	MOV	DX,#$00A0	;exponent, LSB mantissa
22BFcrnorm	TEST.B	BH,#$80	;normalized ?
22C2	JNZ	crstore	;:yes
22C4	SHL	CX,1 	;shift left
22C6	RCL	BX,1 
22C8	DEC.B	DL	;count down exponent
22CA	JMP	crnorm	;'continue
22CCcrstore	AND.B	BH,#$7F	;make positive
22CFcrzero	POP	AX	;return addr
22D0	PUSH	BX	;push result
22D1	PUSH	CX
22D2	PUSH	DX
22D3	JMP	AX	;"return
22D5xassgntx	MOV	AL,#$01	;text file
22D7doassign	MOV	filfunc,AL	;do assign: store func code
22DA	POP	BX	;ret addr
22DB	CALL	getpn	;string -> ASCIIZ
22DE	POP	DI	;ptr to file var
22DF	POP	ES
22E0	PUSH	BX	;restore ret
22E1	MOV	AX,ES	;file var in DS ?
22E3	MOV	DX,DS
22E5	CMP	AX,DX
22E7	JNZ	asnostd
22E9	CMP	DI,#stdout	;std in / out file ?
22ED	JBE	asgnerr	;:yes, error
22EFasnostd	PUSH	DI	;save var ofs
22F0	MOV	SI,#pnbuf	;path name buffer
22F3	LEA	DI,[DI]$0C	;path name in file var
22F6	MOV	CX,#$0020	;copy 64 chars
22F9	CLD	
22FA	REPZ	
22FB	MOVS		;do it
22FC	POP	DI	;restore file var ofs
22FD	CALL	devtest	;test if device
2300	JNB	asnodev	;:yes
2302	MOV	AL,#$00	;flag: not open
2304	MOV	BX,#$FFFF	;no handle
2307asnodev	ES:	
2308	MOV	[DI],BX	;store file handle
230A	CMP.B	filfunc,#$00	;text file ?
230F	JZ	asnotxt	;:no
2311	ES:	
2312	MOV.B	[DI]$02,AL	;set file flag
2315	LEA	AX,[DI]$4C	;set buffer ofs
2318	ES:	
2319	MOV	[DI]$04,AX	;store in file var
231C	RET		;'
231Dasnotxt	ES:		;set file var:
231E	MOV	[DI]$02,#$0000	;record length
2323	RET		;'
2324asgnerr	MOV.B	errnum,#$22	;Assign to std files
2329	RET		;"not allowed
232Axresettx	XOR.B	AL,AL	;Reset text file
232C	JMP.b	opentxt	;'
232Exrewrttx	MOV	AL,#$01	;Rewrite text file
2330	JMP.b	opentxt	;'
2332xappndtx	MOV	AL,#$02	;Append text file
2334opentxt	MOV	filfunc,AL	;store function code
2337	POP	errpos	;get ret addr
233B	POP	ES	;file var ptr
233C	PUSH	errpos	;restore ret
2340	ES:	
2341	MOV.B	AL,[DI]$02	;test flag
2344	AND	AL,#$0F	;device ?
2346	JZ	otnodev	;:no
2348	ES:	
2349	AND.B	[DI]$02,#$DF	;clear flag: char preread
234Dotret	RET		;'
234Eotnodev	ES:	
234F	MOV	[DI]$06,CX	;store buffer size
2352	CALL	close1	;close file
2355	CMP.B	errnum,#$00	;error ?
235A	JNZ	otret	;yes:ret
235C	CALL	openfile	;do open file
235F	CMP.B	errnum,#$00	;error ?
2364	JNZ	otret	;yes:ret
2366	TEST	modeflg,#$0002	;do device checking ?
236C	JZ	otnodev2	;:no
236E	MOV	AX,#$4400	;test device status
2371	ES:	
2372	MOV	BX,[DI]	;get file handle
2374	CALL	dos	;do it
2377	TEST	DX,#$0080	;device ?
237B	JZ	otnodev2	;:no
237D	ES:	
237E	MOV	[DI]$06,#$0001	;buffer len: 1 char
2383otnodev2	CMP.B	filfunc,#$01	;read ?
2388	JNB	otappend	;:no
238A	ES:	
238B	MOV.B	[DI]$02,#$80	;open for input
238F	ES:	
2390	MOV	BX,[DI]$04	;buffer pos
2393	ES:	
2394	MOV	[DI]$08,BX	;-> buffer ptr
2397	ES:	
2398	MOV	[DI]$0A,BX	;-> buffer end
239B	RET		;'
239Cotappend	JZ	prepout	;write: prepare for output
239E	MOV	AX,#$4202	;seek relative to EOF
23A1	ES:	
23A2	MOV	BX,[DI]	;file handle
23A4	XOR	CX,CX	;offset 0
23A6	XOR	DX,DX
23A8	CALL	dos	;do it: get file length
23AB	ES:	
23AC	MOV	CX,[DI]$06	;buffer size
23AF	CMP	CX,#$0080	;< 128 ?
23B3	JB	otsmall	;yes: ok
23B5	MOV	CX,#$0080	;go back up to 128 bytes
23B8otsmall	SUB	AX,CX	;sub from file pos
23BA	SBB	DX,#$00
23BD	JNB	otnotbeg	;:ok
23BF	ADD	AX,CX	;beyond beg of file -
23C1	MOV	CX,AX	;go to beg of file
23C3	XOR	AX,AX
23C5	XOR	DX,DX
23C7otnotbeg	PUSH	CX	;save char count
23C8	MOV	CX,DX	;dest pos
23CA	MOV	DX,AX
23CC	MOV	AX,#$4200	;seek absolute
23CF	ES:	
23D0	MOV	BX,[DI]	;file handle
23D2	CALL	dos	;do seek
23D5	CALL	gbrdbuf	;read from buffer
23D8	POP	DX	;counter
23D9	NEG	DX
23DB	ES:	
23DC	MOV	SI,[DI]$08	;buffer ptr
23DFotsearch	ES:	
23E0	CMP.B	[SI],#$1A	;search ^Z
23E3	JZ	oteof	;:found
23E5	INC	SI	;next char
23E6	INC	DX
23E7	JNZ	otsearch	;:continue
23E9	JMP.b	prepout	;'EOF not found
23EBoteof	MOV	AX,#$4202	;seek from end
23EE	ES:		;DX = offset from end
23EF	MOV	BX,[DI]	;file handle
23F1	MOV	CX,#$FFFF	;backwards
23F4	CALL	dos	;do seek
23F7prepout	ES:		;prepare for subsequent output
23F8	MOV.B	[DI]$02,#$40	;open for output
23FC	ES:	
23FD	MOV	AX,[DI]$04	;buffer offset
2400	ES:	
2401	MOV	[DI]$08,AX	;-> buffer ptr
2404	ES:	
2405	ADD	AX,[DI]$06	;+ buffer size
2408	ES:	
2409	MOV	[DI]$0A,AX	;-> buffer end
240Cporet	RET		;"
240Dxtrunctx	POP	errpos	;Truncate text file
2411	POP	ES	;file var ptr
2412	PUSH	errpos	;restore ret
2416	ES:	
2417	CMP.B	[DI]$02,#$80	;open for input ?
241B	JNZ	poret	;:no - ret
241D	ES:	
241E	MOV	DX,[DI]$08	;buffer ptr
2421	ES:	
2422	SUB	DX,[DI]$0A	;- buffer end
2425	JZ	trend	;equal: ok
2427	MOV	AX,#$4201	;seek relative
242A	ES:	
242B	MOV	BX,[DI]	;file handle
242D	MOV	CX,#$FFFF	;backwards
2430	CALL	dos	;do it
2433trend	MOV	AH,#$40	;write
2435	ES:	
2436	MOV	BX,[DI]	;file handle
2438	XOR	CX,CX	;len = 0 -> truncate
243A	CALL	dos	;do it
243D	JMP	prepout	;"prepare for output
243Fxflush	POP	errpos	;Flush
2443	POP	ES	;file var ptr
2444	PUSH	errpos	;restore ret
2448flush	ES:	
2449	CMP.B	[DI]$02,#$40	;output file ?
244D	JNZ	flushret	;no: ret
244F	JMP	pbflush	;'flush buffer
2452flushret	RET		;"
2453xclosetx	POP	errpos	;Close text file
2457	POP	ES	;get file var pt
2458	PUSH	errpos	;restore ret
245Cclose1	ES:	
245D	MOV.B	AL,[DI]$02	;get flags
2460	AND	AL,#$0F	;device ?
2462	JNZ	closeret	;yes: ret
2464	CALL	flush	;flush the buffer
2467	ES:	
2468	MOV.B	[DI]$02,#$00	;clear flag
246Cclose2	ES:	
246D	MOV	BX,[DI]	;file handle
246F	CMP	BX,#$02	;standard file ?
2472	JBE	closeret	;:ret
2474	CMP	BX,#-$01	;not open ?
2477	JZ	closeret	;yes:ret
2479	ES:	
247A	MOV	[DI],#$FFFF	;clear file handle
247E	MOV	AH,#$3E	;close file
2480	CALL	dos	;do it
2483	JNB	closeret	;:ok, no error
2485	MOV.B	errnum,#$FF	;file disappeared
248Acloseret	RET		;"
248Bdevtest	MOV	CX,#$0009	;Test filename for device
248E	MOV	BX,#devtable
2491devloop	PUSH	CX	;save cnt, ptr
2492	PUSH	BX
2493	MOV	SI,#pnbuf	;file name
2496	MOV	CX,#$0003	;3 chars
2499devcloop	MOV.B	AL,[SI]	;get char
249B	CALL	upcase	;ignore upper / lower
249E	CS:	
249F	CMP.B	AL,[BX]	;compare
24A1	JZ	devnextc	;:ok
24A3	POP	BX	;restore cnt, ptr
24A4	POP	CX
24A5	ADD	BX,#$06	;next device
24A8	LOOP	devloop	;another one ?
24AAdevnone	STC		;not found
24AB	RET		;'
24ACdevnextc	INC	SI	;next char
24AD	INC	BX
24AE	LOOP	devcloop	;:another char
24B0	POP	CX	;remove
24B1	POP	CX
24B2	CMP.B	[SI],#$3A	;next char = : ?
24B5	JNZ	devnone	;:no device
24B7	CS:	
24B8	MOV.B	AL,[BX]	;get flag
24BA	CS:	
24BB	MOV	BX,[BX]$01	;get file handle
24BE	RET		;"
24BFdevtable	B	"CON"	;Device table
24C2	B	$C1,$FF,$FF	;input, output, dev 1
24C5	B	"TRM"
24C8	B	$C1,$FF,$FF	;input, output, dev 1
24CB	B	"KBD"
24CE	B	$82,$FF,$FF	;input, dev 2
24D1	B	"LST"
24D4	B	$43,$FF,$FF	;output, dev 3
24D7	B	"AUX"
24DA	B	$C4,$FF,$FF	;input, output, dev 4
24DD	B	"USR"
24E0	B	$C5,$FF,$FF	;input, output, dev 5
24E3	B	"INP"	;std MS-DOS input-file
24E6	B	$00,$00,$00	;not open, handle 0
24E9	B	"OUT"	;std MS-DOS output-file
24EC	B	$00,$01,$00	;not open, handle 1
24EF	B	"ERR"	;std MS-DOS error file
24F2	B	$00,$02,$00	;"not open, handle 2
24F5openfile	ES:		;do open file
24F6	CMP	[DI],#-$01	;handle <> $ffff ?
24F9	JNZ	opret	;yes: already open
24FB	MOV	AX,#$3D02	;open for input / output
24FE	MOV	DL,#$01	;error number
2500	TEST.B	filfunc,#$01	;create file ?
2505	JZ	opnotnew	;:no
2507	MOV	AH,#$3C	;create
2509	XOR	CX,CX	;clear attribute
250B	MOV	DL,#$F1	;error (dir full)
250Dopnotnew	PUSH	DX	;save error number
250E	LEA	DX,[DI]$0C	;ptr to path name
2511	CALL	dos	;do it
2514	POP	DX	;restore error number
2515	JB	operr	;:error
2517	ES:	
2518	MOV	[DI],AX	;store file handle
251A	RET		;'
251Boperr	MOV.B	errnum,DL	;store error number
251F	CMP	AL,#$04	;too many open files ?
2521	JNZ	opret	;:no
2523	MOV.B	errnum,#$F3	;set that error
2528opret	RET		;"
2529xstdin	POP	errpos	;Set standard input
252D	MOV	currfil,#stdin	;ptr to file var
2533	MOV	currfil1,DS
2537	JMP	[errpos]	;"return - error pos set
253Bxrdfil	POP	errpos	;prepare for read
253F	POP	ES	;get file var ptr
2540	MOV	currfil,DI	;-> current file
2544	MOV	currfil1,ES
2548	ES:	
2549	TEST.B	[DI]$02,#$80	;open for input ?
254D	JNZ	prret	;:yes
254F	MOV.B	errnum,#$02	;error: not open for input
2554prret	JMP	[errpos]	;"return
2558xstdout	POP	errpos	;Set standard output
255C	MOV	currfil,#stdout	;ptr to file var
2562	MOV	currfil1,DS
2566	JMP	[errpos]	;"return
256Axwrfil	POP	errpos	;prepare for write
256E	POP	ES	;get file var ptr
256F	MOV	currfil,DI	;-> current file
2573	MOV	currfil1,ES
2577	ES:	
2578	TEST.B	[DI]$02,#$40	;open for output ?
257C	JNZ	pwret	;:no
257E	MOV.B	errnum,#$03	;error: not open for output
2583pwret	JMP	[errpos]	;"return
2587xrd	MOV	AL,#$FF	;Readln string
2589	JMP.b	readst	;'
258Bxrdln	XOR.B	AL,AL	;Read string
258Dreadst	POP	errpos	;get ret addr
2591	MOV	currfil,#stdin	;from std input
2597	MOV	currfil1,DS
259B	AND.B	stdinfl,#$DF	;clear flag: char read
25A0	PUSH	ES	;save dest var ptr
25A1	PUSH	DI
25A2	PUSH	AX	;save flag
25A3	CALL	rdedit	;read with editing
25A6	POP	AX	;restore flag
25A7	OR.B	AL,AL	;readln ?
25A9	JZ	readst2	;:no
25AB	CALL	xwriteln	;do WriteLn
25AEreadst2	POP	DI	;restore dest var ptr
25AF	POP	ES
25B0	JMP	[errpos]	;"return
25B4rdedit	XOR.B	DH,DH	;Read line with editing: clr flag
25B6rdedit2	MOV.B	CH,conbufln	;buffer length
25BA	CMP.B	CH,#$7E	;too big ?
25BD	JB	relimlen	;:no
25BF	MOV	CH,#$7E	;limit to 127 chars
25C1relimlen	MOV.B	conbufln,#$7E	;127 chars again
25C6	MOV	BX,#coninbuf
25C9	MOV	conbufpt,BX	;set input ptr
25CDrezero	XOR.B	CL,CL	;ptr into line
25CFreloop	CALL	keyget	;get char
25D2	MOV	DL,#$01	;flag: one char
25D4	CMP	AL,#$08	;BS ?
25D6	JZ	rebs	;:yes
25D8	CMP	AL,#$7F	;Delete ?
25DA	JZ	rebs	;:yes
25DC	CMP	AL,#$04	;^D ?
25DE	JZ	recall	;yes, recall char from buffer
25E0	DEC.B	DL	;flag: all chars
25E2	CMP	AL,#$18	;^X ?
25E4	JZ	rebs	;yes:erase input line
25E6	CMP	AL,#$1B	;ESC ?
25E8	JZ	rebs	;yes:erase input line
25EA	CMP	AL,#$12	;^R ?
25EC	JZ	recall	;yes:recall last input line
25EE	CMP	AL,#$1A	;^Z ?
25F0	JZ	reeof	;:yes
25F2	CMP	AL,#$0D	;CR ?
25F4	JZ	recr	;:yes
25F6	CMP	AL,#$20	;other control char ?
25F8	JB	reloop	;yes: ignore
25FA	CMP.B	CL,CH	;end of buffer reached ?
25FC	JZ	reloop
25FE	MOV.B	AH,[BX]	;get old char
2600	MOV.B	[BX],AL	;store new char
2602	INC.B	CL	;new pos
2604	INC	BX
2605	CMP.B	AH,#$20	;was it old end of buffer ?
2608	JNB	renotend	;:no
260A	MOV.B	[BX],AH	;mark it again
260Crenotend	CALL	xputch	;display new char
260F	JMP	reloop	;'next key
2611rebs	DEC.B	CL	;go back one char
2613	JS	rezero	;:beg of line
2615	CALL	prints	;go back one char
2618	B	$08," ",$08,$00
261C	DEC	BX	;go back
261D	DEC.B	DL	;another char ?
261F	JNZ	rebs	;:yes
2621	JMP	reloop	;'next key
2623recall	MOV.B	AL,[BX]	;recall from buffer
2625	CMP	AL,#$20	;end of buffer
2627	JB	reloop	;:yes
2629	CALL	xputch	;display that char
262C	INC.B	CL	;next one
262E	INC	BX
262F	DEC.B	DL	;another one ?
2631	JNZ	recall	;:yes
2633	JMP	reloop	;'next key
2635reeof	OR.B	DH,DH	;test flag
2637	JZ	reloop	;:no EOF allowed
2639	JMP.b	resto	;'store it
263Brecr	OR.B	DH,DH	;test flag
263D	JNZ	reend	;:no ^Z needed
263Fresto	MOV.B	[BX],#$1A	;store ^Z
2642	JMP.b	reend2	;'end it
2644reend	CALL	xwriteln	;WriteLn
2647	MOV	[BX],#$0A0D	;store CR,LF at end
264B	INC	BX	;2 chars added
264Creend2	INC	BX	;1 char added
264D	MOV	conbfend,BX	;store end pointer
2651	RET		;"
2652xputch	MOV.B	AH,cbreak	;Put char: save break flag
2656	MOV.B	cbreak,#$00	;break allowed
265B	PUSH	AX	;save flag
265C	CALL	conput	;print char
265F	POP	AX	;restore flag
2660	MOV.B	cbreak,AH
2664	RET		;"
2665getbyte	LES	DI,currfil	;Get byte from current file
2669getbyte2	CMP.B	errnum,#$00	;error ?
266E	JNZ	gbeof	;yes: return ^Z
2670	ES:	
2671	MOV.B	AL,[DI]$02	;test flags:
2674	TEST	AL,#$20	;char pre-read ?
2676	JNZ	gbfrbuf	;yes: return it
2678	AND	AL,#$0F	;device ?
267A	JNZ	gbdev	;:yes
267C	ES:	
267D	MOV	BX,[DI]$08	;buffer pointer
2680	ES:	
2681	CMP	BX,[DI]$0A	;= buffer end ?
2684	JB	gbnotend	;:no
2686	CALL	gbrdbuf	;read buffer
2689	ES:	
268A	MOV	BX,[DI]$08	;buffer ptr
268Dgbnotend	ES:	
268E	MOV.B	AL,[BX]	;get byte
2690	INC	BX	;advance ptr
2691	ES:	
2692	MOV	[DI]$08,BX	;store ptr
2695	JMP.b	gbbuf2	;'remember that char
2697gbdev	PUSH	ES	;save file ptr
2698	PUSH	DI	;test devices
2699	CMP	AL,#$01	;CON ?
269B	JNZ	gbkbd	;:no
269D	MOV	BX,conbufpt	;get from CON input buffer
26A1	CMP	BX,conbfend	;end of buffer reached ?
26A5	JB	gbget	;no: return char
26A7	MOV.B	DH,AL	;^Z allowed
26A9	CALL	rdedit2	;read line
26AC	MOV	BX,conbufpt	;ptr to char
26B0gbget	MOV.B	AL,[BX]	;get char
26B2	INC	BX	;advance ptr
26B3	MOV	conbufpt,BX	;update ptr
26B7	JMP.b	gbbuf	;'done
26B9gbkbd	CMP	AL,#$02	;KBD ?
26BB	JNZ	gbaux	;:no
26BD	DEC	SP	;(function:char)
26BE	CALL	[vkbdget]	;get char
26C2	JMP.b	gbbuf	;'return it
26C4gbaux	CMP	AL,#$04	;AUX ?
26C6	JNZ	gbusr	;:no
26C8	DEC	SP
26C9	CALL	[vauxget]	;get char
26CD	JMP.b	gbbuf	;'return it
26CFgbusr	DEC	SP	;USR
26D0	CALL	[vusrget]	;get char
26D4gbbuf	POP	DI	;restore file var ptr
26D5	POP	ES
26D6gbbuf2	ES:	
26D7	MOV.B	[DI]$03,AL	;store char in buffer
26DA	ES:	
26DB	OR.B	[DI]$02,#$20	;set flag: char pre-read
26DF	RET		;'
26E0gbfrbuf	ES:	
26E1	MOV.B	AL,[DI]$03	;get char from buffer
26E4	RET		;'
26E5gbeof	MOV	AL,#$1A	;return ^Z = EOF
26E7	RET		;'
26E8gbrdbuf	MOV	AH,#$3F	;read buffer
26EA	ES:	
26EB	MOV	BX,[DI]	;file handle
26ED	ES:	
26EE	MOV	CX,[DI]$06	;buffer size
26F1	ES:	
26F2	MOV	DX,[DI]$04	;buffer offset
26F5	PUSH	DS	;save DS
26F6	PUSH	ES	;ES -> DS
26F7	POP	DS
26F8	CALL	dos	;do it
26FB	POP	DS	;restore DS
26FC	JNB	gbnoerr	;:no error
26FE	XOR	AX,AX	;nothing read
2700gbnoerr	ES:	
2701	MOV	BX,[DI]$04	;buffer offset
2704	OR	AX,AX	;anything read ?
2706	JNZ	gbmakeof	;:yes
2708	ES:	
2709	MOV.B	[BX],#$1A	;store a ^Z
270C	INC	AX	;1 char read
270Dgbmakeof	ES:	
270E	MOV	[DI]$08,BX	;-> buffer pointer
2711	ADD	BX,AX	;+ number chars read
2713	ES:	
2714	MOV	[DI]$0A,BX	;-> buffer end
2717	RET		;"
2718readnum	PUSH	ES	;Read number
2719	PUSH	DI	;save ptr
271A	MOV	BX,#pnbuf	;buffer ptr
271Drnspace	PUSH	BX	;save
271E	CALL	getbyte	;get char
2721	POP	BX	;restore ptr
2722	CMP	AL,#$1A	;^Z ?
2724	JZ	rnend	;yes: end
2726	ES:	
2727	AND.B	[DI]$02,#$DF	;clear flag: char pre-read
272B	CMP	AL,#$20	;space / control ?
272D	JBE	rnspace	;yes: ignore
272Frndig	MOV.B	[BX],AL	;store that char
2731	INC	BX	;advance ptr
2732	CMP	BX,#pnbufend	;end reached ?
2736	JZ	rnend	;:yes
2738	PUSH	BX	;save ptr
2739	CALL	getbyte	;get char
273C	POP	BX	;restore ptr
273D	CMP	AL,#$20	;space / control ?
273F	JBE	rnend	;yes: end
2741	ES:	
2742	AND.B	[DI]$02,#$DF	;clear flag: char pre-read
2746	JMP	rndig	;'next digit
2748rnend	MOV.B	[BX],#$00	;store a 0 at the end
274B	MOV	BX,#pnbuf	;nothing entered ?
274E	CMP.B	[BX],#$00
2751	POP	DI	;restore ptr
2752	POP	ES
2753	RET		;"
2754chknum	JB	cnerr	;Check numeric format
2756	CMP.B	[BX],#$00	;end reached ?
2759	JZ	cnret	;yes: ok
275Bcnerr	MOV.B	errnum,#$10	;Error in numeric format
2760	STC	
2761cnret	RET		;"
2762xrdchar	PUSH	DI	;Read char: save ptr
2763	CALL	getbyte	;get char
2766	ES:	
2767	AND.B	[DI]$02,#$DF	;clear flag: char pre-read
276B	POP	DI	;var ofs
276C	POP	BX	;ret addr
276D	POP	ES	;var seg
276E	ES:	
276F	MOV.B	[DI],AL	;store char
2771	JMP	BX	;"return
2773xrdbyte	CLC		;Read byte
2774	JMP.b	rdi1	;'
2776xrdint	STC		;Read integer
2777rdi1	POP	BX	;ret addr
2778	POP	ES	;dest seg
2779	PUSH	BX	;restore ret
277A	PUSHF		;save flag
277B	CALL	readnum	;read number.
277E	JZ	rdierr	;:nothing entered
2780	CALL	ascint	;convert to integer
2783	CALL	chknum	;check numeric format
2786	JB	rdierr	;:error
2788	POPF		;restore flag
2789	JNB	rdibyt	;:byte
278B	ES:	
278C	MOV	[DI],AX	;store integer
278E	RET		;'
278Frdibyt	ES:	
2790	MOV.B	[DI],AL	;store byte
2792	RET		;'
2793rdierr	POPF		;remove flag
2794	RET		;"error - don't change var
2795xrdreal	POP	BX	;Read real
2796	POP	ES	;dest seg
2797	PUSH	BX	;restore ret
2798	CALL	readnum	;read number
279B	JZ	rdrret	;:nothing entered
279D	PUSH	DI	;save dest ptr
279E	PUSH	ES
279F	MOV	DI,#prnum	;dest var
27A2	CALL	ascreal	;convert to real
27A5	MOV	SI,DI	;-> source ptr
27A7	POP	ES	;restore dest ptr
27A8	POP	DI
27A9	CALL	chknum	;check numeric format
27AC	JB	rdrret	;:error
27AE	CLD		;store real number
27AF	MOVS	
27B0	MOVS	
27B1	MOVS	
27B2rdrret	RET		;"
27B3xrdstr	POP	BX	;Read string var
27B4	POP	ES	;dest seg
27B5	PUSH	BX	;restore ret
27B6	XOR	BX,BX	;clear length of string
27B8	XOR.B	CH,CH	;count. CL=max len
27BArdsloop	PUSH	ES	;save dest ptr
27BB	PUSH	DI
27BC	PUSH	BX	;save len, cnt
27BD	PUSH	CX
27BE	CALL	getbyte	;get char
27C1	POP	CX	;restore
27C2	POP	BX
27C3	CMP	AL,#$0D	;CR ?
27C5	JZ	rdsend	;:end
27C7	CMP	AL,#$1A	;^Z ?
27C9	JZ	rdsend	;:end
27CB	ES:	
27CC	AND.B	[DI]$02,#$DF	;clear flag: char pre-read
27D0	POP	DI	;restore dest ptr
27D1	POP	ES
27D2	INC	BX	;count len
27D3	ES:	
27D4	MOV.B	[BX_DI],AL	;store char
27D6	LOOP	rdsloop	;:another char
27D8	JMP.b	rdslen	;'store length
27DArdsend	POP	DI	;restore dest ptr
27DB	POP	ES
27DCrdslen	ES:	
27DD	MOV.B	[DI],BL	;store length
27DF	RET		;"
27E0xrdarrch	POP	BX	;Read array of char
27E1	POP	ES	;dest ptr
27E2	PUSH	BX	;restore ret
27E3	XOR.B	CH,CH	;CL=max len
27E5rdacloop	PUSH	ES	;save dest ptr
27E6	PUSH	DI
27E7	PUSH	CX	;save cnt
27E8	CALL	getbyte	;get a char
27EB	POP	CX	;restore cnt
27EC	CLD	
27ED	CMP	AL,#$0D	;CR ?
27EF	JZ	rdacend	;yes: end
27F1	CMP	AL,#$1A	;^Z ?
27F3	JZ	rdacend	;:yes
27F5	ES:	
27F6	AND.B	[DI]$02,#$DF	;clear flag: char pre-read
27FA	POP	DI	;restore dest ptr
27FB	POP	ES
27FC	STOS.B		;store char
27FD	LOOP	rdacloop	;:another char
27FF	RET		;'
2800rdacend	POP	DI	;restore dest ptr
2801	POP	ES
2802	MOV	AL,#$20	;pad with spaces
2804	REPZ	
2805	STOS.B	
2806	RET		;"
2807xreadln	CALL	getbyte	;Readln: get char
280A	CMP	AL,#$1A	;^Z ?
280C	JZ	rdlnret	;yes: done
280E	ES:	
280F	AND.B	[DI]$02,#$DF	;clear flag: char pre-read
2813	CMP	AL,#$0A	;LF ?
2815	JZ	rdlnret	;yes: done
2817	CMP	AL,#$0D	;CR ?
2819	JNZ	xreadln	;no: continue
281B	CALL	getbyte	;get next char
281E	CMP	AL,#$0A	;LF ?
2820	JNZ	rdlnret	;no: forget it
2822	ES:	
2823	AND.B	[DI]$02,#$DF	;clear flag: char pre-read
2827rdlnret	RET		;"
2828putbyte	LES	DI,currfil	;put char to current file
282C	CMP.B	errnum,#$00	;error ?
2831	JNZ	pbret	;yes: no output
2833	ES:	
2834	MOV.B	CL,[DI]$02	;get flag
2837	AND.B	CL,#$0F	;device ?
283A	JNZ	pbdev	;:yes
283C	ES:	
283D	MOV	BX,[DI]$08	;get buffer pointer
2840	ES:	
2841	MOV.B	[BX],AL	;store char
2843	INC	BX	;advance pointer
2844	ES:	
2845	MOV	[DI]$08,BX	;update pointer
2848	ES:	
2849	CMP	BX,[DI]$0A	;= buffer end ?
284C	JZ	pbflush	;yes: do flush
284E	RET		;'
284Fpbdev	PUSH	AX	;put char as parameter
2850	CMP.B	CL,#$01	;CON ?
2853	JZ	pbcon	;:yes
2855	CMP.B	CL,#$03	;LST ?
2858	JZ	pblst	;:yes
285A	CMP.B	CL,#$04	;AUX ?
285D	JZ	pbaux	;:yes
285F	CALL	[vusrput]	;USR out
2863	RET		;'
2864pbcon	CALL	[vconput]	;CON out
2868	RET		;'
2869pblst	CALL	[vprnput]	;LST out
286D	RET		;'
286Epbaux	CALL	[vauxput]	;AUX out
2872pbret	RET		;'
2873pbflush	ES:		;flush output buffer
2874	MOV	CX,[DI]$08	;count=pointer-offset
2877	ES:	
2878	SUB	CX,[DI]$04
287B	JZ	pbok	;:nothing to write
287D	MOV	AH,#$40	;write byte block
287F	ES:	
2880	MOV	BX,[DI]	;file handle
2882	ES:	
2883	MOV	DX,[DI]$04	;buffer offset
2886	ES:	
2887	MOV	[DI]$08,DX	;reset buffer pointer
288A	PUSH	DS	;save DS
288B	PUSH	ES	;ES -> DS
288C	POP	DS
288D	CALL	dos	;do it
2890	POP	DS	;restore DS
2891	JB	pberr	;:error
2893	CMP	AX,CX	;length = expected ?
2895	JZ	pbok	;:yes
2897pberr	MOV.B	errnum,#$F0	;Disk write error
289Cpbok	RET		;"
289Dxwrchar	OR	AX,AX	;Write char
289F	JZ	wchdoit	;AX=formatting parm: nothing
28A1	CALL	limstind	;limit it
28A4	CMP	AL,#$01	;<= 1 char ?
28A6	JBE	wchdoit
28A8	XCHG	AX,CX	;-> count
28A9	DEC	CX	;-1 for char itself
28AAwchpad	MOV	AL,#$20	;put spaces
28AC	PUSH	CX	;save count
28AD	CALL	putbyte	;put it
28B0	POP	CX	;restore count
28B1	LOOP	wchpad	;:continue
28B3wchdoit	POP	BX	;ret addr
28B4	POP	AX	;get char
28B5	PUSH	BX	;restore ret
28B6	JMP	putbyte	;"put that char
28B9xwrint	XCHG	AX,CX	;Write integer: format parm
28BA	POP	BX	;return addr
28BB	POP	AX	;get number
28BC	PUSH	BX	;restore ret
28BD	PUSH	CX	;save format parm
28BE	MOV	BX,#pnbuf	;dest buffer
28C1	CALL	intasc	;Integer -> ASCII
28C4wintbuf	POP	AX	;restore format parm
28C5	CALL	limstind	;limit it
28C8	SUB	BX,#pnbuf	;calc length
28CC	SUB	AX,BX	;length of spaces ?
28CE	JBE	wintdoit	;:no space left
28D0	XCHG	AX,CX	;-> count
28D1	PUSH	BX	;save number length
28D2wintpad	MOV	AL,#$20	;put spaces
28D4	PUSH	CX	;save count
28D5	CALL	putbyte	;put it
28D8	POP	CX	;restore count
28D9	LOOP	wintpad	;:another space
28DB	POP	BX	;restore number length
28DCwintdoit	MOV	CX,BX	;-> count
28DE	MOV	BX,#pnbuf	;buffer ptr
28E1wintloop	MOV.B	AL,[BX]	;get char
28E3	PUSH	BX	;save ptr, cnt
28E4	PUSH	CX
28E5	CALL	putbyte	;put it
28E8	POP	CX	;restore
28E9	POP	BX
28EA	INC	BX	;next char
28EB	LOOP	wintloop	;:again
28ED	RET		;"
28EExwrreal	XCHG	AX,DX	;Write real: second format parm
28EF	POP	BX	;ret addr
28F0	POP	CX	;first format parm
28F1	MOV	DI,#prnum	;get number from stack
28F4	POP	[DI]
28F6	POP	[DI]$02
28F9	POP	[DI]$04
28FC	PUSH	BX	;restore ret
28FD	PUSH	CX	;push format parm
28FE	MOV	BX,#pnbuf	;dest buffer
2901	CALL	fmtreal	;Real -> ASCII
2904	JMP	wintbuf	;"write buffer
2906xwrbool	POP	BX	;write boolean
2907	POP	CX	;get boolean
2908	PUSH	BX	;restore ret
2909	MOV	DI,#sttrue	;(true)
290C	OR	CX,CX	;test boolean
290E	JNZ	wbotrue	;:true
2910	MOV	DI,#stfalse	;(false)
2913wbotrue	PUSH	CS	;str segment
2914	CALL	strload	;load string
2917	CALL	xwrtstr	;write string
291A	RET		;"
291Bsttrue	B	$04,"TRUE"
2920stfalse	B	$05,"FALSE"	;"
2926xwrtstr	CALL	limstind	;Write string: format parm
2929	MOV	BX,SP	;pos of string
292B	INC	BX	;skip ret addr
292C	INC	BX
292D	SS:	
292E	SUB.B	AL,[BX]	;field len - string len
2930	JBE	wstdoit	;:too much - no padding
2932	MOV.B	CL,AL	;-> count
2934	XOR.B	CH,CH
2936	PUSH	BX	;save string pos
2937wstpad	MOV	AL,#$20	;put spaces
2939	PUSH	CX	;save count
293A	CALL	putbyte	;put it
293D	POP	CX	;restore count
293E	LOOP	wstpad	;:another space
2940	POP	BX	;restore string pos
2941wstdoit	SS:	
2942	MOV.B	CL,[BX]	;get length
2944	XOR.B	CH,CH	;-> count
2946	INC	BX	;point to first char
2947	OR	CX,CX	;nothing to write ?
2949	JZ	wstnil	;:yes
294Bwstloop	SS:	
294C	MOV.B	AL,[BX]	;get char
294E	PUSH	BX	;save ptr, cnt
294F	PUSH	CX
2950	CALL	putbyte	;put char
2953	POP	CX	;restore
2954	POP	BX
2955	INC	BX	;next char
2956	LOOP	wstloop	;:another
2958wstnil	POP	DX	;ret addr
2959	MOV	SP,BX	;remove string from stack
295B	JMP	DX	;"return
295Dxwrtinl	POP	BX	;Write inline string
295E	CS:	
295F	MOV.B	CL,[BX]	;get length
2961	XOR.B	CH,CH	;-> count
2963	INC	BX	;point to first char
2964	JCXZ	wstinil	;:null string
2966wstiloop	CS:	
2967	MOV.B	AL,[BX]	;get char
2969	PUSH	BX	;save
296A	PUSH	CX
296B	CALL	putbyte	;put char
296E	POP	CX
296F	POP	BX	;restore
2970	INC	BX	;next char
2971	LOOP	wstiloop	;:another
2973wstinil	JMP	BX	;"return - text skipped
2975xwrln	MOV	AL,#$0D	;WriteLn
2977	CALL	putbyte	;put CR
297A	MOV	AL,#$0A
297C	JMP	putbyte	;"put LF
297Fxseekeol	MOV	DX,#$010D	;SeekEOLN
2982	JMP.b	seox1	;'
2984xeoln	MOV	DX,#$000D	;EOLN
2987	JMP.b	seox1	;'
2989xseekeof	MOV	DX,#$011A	;SEEKEOF
298C	JMP.b	seox1	;'
298Exeoftx	MOV	DX,#$001A	;EOF
2991seox1	POP	errpos	;get return addr
2995	POP	ES	;file var seg
2996	PUSH	errpos	;restore ret
299A	ES:	
299B	TEST.B	[DI]$02,#$80	;open for input ?
299F	JZ	sefalse	;no: false
29A1seloop	PUSH	DX	;save flag
29A2	CALL	getbyte2	;get char from file
29A5	POP	DX	;restore flag
29A6	CMP.B	AL,DL	;= char searched ?
29A8	JZ	setrue	;yes: true
29AA	CMP	AL,#$1A	;EOF ?
29AC	JZ	setrue	;yes: true
29AE	CMP	AL,#$20	;space / control ?
29B0	JA	sefalse	;no: false
29B2	OR.B	DH,DH	;seek it ?
29B4	JZ	sefalse	;:no, false
29B6	ES:	
29B7	AND.B	[DI]$02,#$DF	;clear flag: char pre-read
29BB	JMP	seloop	;'search it
29BDsetrue	XOR	AX,AX	;return true
29BF	INC	AX	;setting flags
29C0	RET		;'
29C1sefalse	XOR	AX,AX	;return false
29C3	RET		;"
29C4xassign	XOR.B	AL,AL	;Assign: set function code
29C6	JMP	doassign	;"do assign
29C9xresetty	XOR.B	AL,AL	;Reset typed
29CB	JMP.b	openty1	;'
29CDxrewrtty	MOV	AL,#$01	;Rewrite typed
29CFopenty1	MOV	filfunc,AL	;store function code
29D2	POP	errpos	;get return addr
29D6	POP	ES	;file var ptr
29D7	PUSH	errpos	;restore ret
29DB	PUSH	CX	;save record length
29DC	CALL	closty1	;clear record len, close file
29DF	POP	CX	;remove for error exit
29E0	CMP.B	errnum,#$00	;error ?
29E5	JNZ	openty2	;:yes
29E7	PUSH	CX
29E8	CALL	openfile	;open that file
29EB	POP	CX	;record len
29EC	CMP.B	errnum,#$00	;error ?
29F1	JNZ	openty2	;:yes
29F3	ES:	
29F4	MOV	[DI]$02,CX	;store record length
29F7openty2	RET		;"
29F8xtruncat	POP	errpos	;Truncate typed, untyped
29FC	POP	ES	;file var ptr
29FD	PUSH	errpos	;restore ret
2A01	MOV	AH,#$40	;write
2A03	ES:	
2A04	MOV	BX,[DI]	;file handle
2A06	XOR	CX,CX	;length = 0 -> truncate
2A08	JMP	dos	;"do it
2A0Bxflushty	RET	$0002	;"Flush typed, untyped
2A0Exclosety	POP	errpos	;Close typed, untyped
2A12	POP	ES	;file var ptr
2A13	PUSH	errpos	;restore ret
2A17closty1	ES:	
2A18	MOV	[DI]$02,#$0000	;record len = 0
2A1D	JMP	close2	;"close it
2A20xfilsel	POP	errpos	;Select file
2A24	POP	ES	;file var ptr
2A25	MOV	currfil,DI	;-> current file
2A29	MOV	currfil1,ES
2A2D	ES:	
2A2E	CMP	[DI]$02,#$00	;record len = 0 ?
2A32	JNZ	selret	;no: ok
2A34	MOV.B	errnum,#$04	;File not open
2A39selret	JMP	[errpos]	;"ret
2A3Dxrdvar	MOV	filfunc,#$993F	;Read from typed file
2A43	JMP.b	filrw	;'read, unexpected EOF
2A45xwrvar	MOV	filfunc,#$F040	;Write to typed file
2A4Bfilrw	POP	BX	;write, disk write error
2A4C	POP	SI	;var seg
2A4D	PUSH	BX	;restore ret
2A4E	CMP.B	errnum,#$00	;error ?
2A53	JNZ	filrwret	;yes: no operation
2A55	MOV	DX,DI	;save DI
2A57	LES	DI,currfil	;current file var
2A5B	MOV.B	AH,filfunc	;save function, error code
2A5F	ES:	
2A60	MOV	BX,[DI]	;file handle
2A62	ES:	
2A63	MOV	CX,[DI]$02	;record length
2A66	PUSH	DS	;save DS
2A67	MOV	DS,SI	;ptr var
2A69	CALL	dos	;do it
2A6C	POP	DS	;restore DS
2A6D	JB	filrwerr	;:error
2A6F	CMP	AX,CX	;length = expected ?
2A71	JZ	filrwret	;:yes
2A73	CMP.B	filfunc,#$3F	;read ?
2A78	JNZ	filrwerr	;no: error
2A7A	OR	AX,AX	;test count
2A7C	JZ	filrwerr	;nothing done: error
2A7E	ES:	
2A7F	MOV	CX,[DI]$02	;record length
2A82	MOV	DI,DX	;restore dest ofs
2A84	ADD	DI,AX	;add count read
2A86	MOV	ES,SI	;dest seg
2A88	SUB	CX,AX	;count to fill
2A8A	XOR	AX,AX	;pad with zeroes
2A8C	CLD	
2A8D	REPZ		;do fill
2A8E	STOS.B	
2A8F	RET		;'
2A90filrwerr	MOV	AL,filerr	;error code -> error
2A93	MOV	errnum,AL
2A96filrwret	RET		;"
2A97xseek	XOR	DX,DX	;Seek: clear high word
2A99seek1	POP	errpos	;set error pos
2A9D	POP	DI	;get file var ptr
2A9E	POP	ES
2A9F	PUSH	errpos	;restore ret
2AA3	ES:	
2AA4	MOV	CX,[DI]$02	;get record length
2AA7	CALL	cardmul	;* pos -> DX:AX
2AAA	MOV	CX,DX	;-> CX:DX
2AAC	MOV	DX,AX
2AAE	MOV	AX,#$4200	;seek absolute
2AB1	ES:	
2AB2	MOV	BX,[DI]	;file handle
2AB4	PUSH	CX	;save pos wanted
2AB5	PUSH	DX
2AB6	CALL	dos	;do it
2AB9	POP	CX	;restore pos wanted
2ABA	POP	BX
2ABB	JB	seekerr	;:error
2ABD	CMP	AX,CX	;pos = expected ?
2ABF	JNZ	seekerr	;:no
2AC1	CMP	DX,BX
2AC3	JZ	seekret	;:yes
2AC5seekerr	MOV.B	errnum,#$91	;Seek beyond EOF
2ACAseekret	RET		;"
2ACBxlngseek	CALL	realcard	;LongSeek: convert real
2ACE	JMP	seek1	;"do it
2AD0xeofty	POP	BX	;EOF typed, untyped
2AD1	POP	ES	;get file var ptr
2AD2	PUSH	BX	;restore ret
2AD3	MOV	AX,#$4406	;get unit status
2AD6	ES:	
2AD7	MOV	BX,[DI]	;file handle
2AD9	CALL	dos	;do it
2ADC	OR.B	AL,AL	;test result
2ADE	MOV	AX,#$0000	;false
2AE1	JNZ	eoffalse	;:ok
2AE3	INC	AX	;true
2AE4eoffalse	OR	AX,AX	;set flags
2AE6	RET		;"
2AE7xfilepos	POP	BX	;FilePos: ret addr
2AE8	POP	ES	;file var ptr
2AE9	PUSH	BX	;restore ret
2AEAfilpos1	MOV	AX,#$4201	;seek relative
2AED	ES:	
2AEE	MOV	BX,[DI]	;file handle
2AF0	XOR	CX,CX	;no offset
2AF2	XOR	DX,DX
2AF4	CALL	dos	;get position
2AF7filpos2	ES:	
2AF8	MOV	CX,[DI]$02	;record length
2AFB	JMP.b	carddiv	;"pos / reclen -> filepos
2AFD	NOP		;LongFilePos
2AFExlfilpos	POP	BX	;return addr
2AFF	POP	ES	;file var ptr
2B00	PUSH	BX	;restore ret
2B01	CALL	filpos1	;do it
2B04	JMP	cardreal	;"result -> real
2B07xfilesiz	POP	BX	;FileSize: ret addr
2B08	POP	ES	;file var ptr
2B09	PUSH	BX	;restore ret
2B0Afilsiz1	MOV	AX,#$4201	;seek relative
2B0D	ES:	
2B0E	MOV	BX,[DI]	;file handle
2B10	XOR	CX,CX	;no offset
2B12	XOR	DX,DX
2B14	CALL	dos	;get current pos
2B17	PUSH	AX	;save it
2B18	PUSH	DX
2B19	MOV	AX,#$4202	;seek from end
2B1C	ES:	
2B1D	MOV	BX,[DI]	;file handle
2B1F	XOR	CX,CX	;no offset
2B21	XOR	DX,DX
2B23	CALL	dos	;get end position
2B26	POP	CX	;restore current pos
2B27	POP	BX
2B28	PUSH	AX	;save end pos
2B29	PUSH	DX
2B2A	MOV	DX,BX	;restore file pos
2B2C	MOV	AX,#$4200	;seek absolute
2B2F	ES:	
2B30	MOV	BX,[DI]	;file handle
2B32	CALL	dos	;go back to old pos
2B35	POP	DX	;end position
2B36	POP	AX
2B37	ES:	
2B38	MOV	CX,[DI]$02	;(pos+reclen-1)
2B3B	DEC	CX
2B3C	ADD	AX,CX
2B3E	ADC	DX,#$00
2B41	JMP	filpos2	;"/ reclen -> position
2B43xlfilsiz	POP	BX	;LongFileSize: ret addr
2B44	POP	ES	;file var ptr
2B45	PUSH	BX	;restore ret
2B46	CALL	filsiz1	;do it
2B49	JMP	cardreal	;"result -> real
2B4Ccarddiv	CMP	CX,#$01	;long cardinal division
2B4F	JZ	cdret	;/ 1: done
2B51	MOV	SI,CX	;DX:AX / CX -> DX:AX
2B53	XOR	BX,BX	;clear result
2B55	MOV	CX,#$0021	;32 bits
2B58cdloop	RCL	BX,1 	;shift in result
2B5A	SBB	BX,SI	;try subtraction
2B5C	JNB	cdbit1	;:ok
2B5E	ADD	BX,SI	;restore it
2B60	STC	
2B61cdbit1	CMC		;make flag to shift in
2B62	RCL	AX,1 	;shift in result
2B64	RCL	DX,1 
2B66	LOOP	cdloop	;:another bit
2B68cdret	RET		;"
2B69cardmul	MOV	BX,AX	;long card mul
2B6B	MOV	AX,DX	;DX:AX * CX -> DX:AX
2B6D	MUL	CX	;higher word
2B6F	XCHG	AX,BX	;save it
2B70	MUL	CX	;lower word
2B72	ADD	DX,BX	;add higher result
2B74	RET		;"
2B75xresetun	XCHG	AX,CX	;Reset untyped: record length
2B76	POP	BX	;ret addr
2B77	POP	DI	;file var ofs
2B78	PUSH	BX	;restore ret
2B79	JMP	xresetty	;"now like typed file
2B7Cxrewrtun	XCHG	AX,CX	;Rewrite untyped: record length
2B7D	POP	BX	;ret addr
2B7E	POP	DI	;file var ofs
2B7F	PUSH	BX	;restore ret
2B80	JMP	xrewrtty	;"now like typed file
2B83xblkrd	MOV	filfunc,#$993F	;BlockRead
2B89	JMP.b	blrw1	;'read, unexpected EOF
2B8Bxblkwr	MOV	filfunc,#$F040	;BlockWrite
2B91blrw1	POP	errpos	;write, disk write error
2B95	POP	DX	;var seg
2B96	POP	SI	;var ofs
2B97	POP	DI	;file var ptr
2B98	POP	ES
2B99	PUSH	AX	;save length
2B9A	CALL	blrw	;do it
2B9D	POP	CX	;restore len
2B9E	CMP.B	errnum,#$00	;error ?
2BA3	JNZ	blrw1ok	;yes: return
2BA5	CMP	AX,CX	;length = expected
2BA7	JZ	blrw1ok	;:yes
2BA9	MOV	AL,filerr	;error code -> error
2BAC	MOV	errnum,AL
2BAFblrw1ok	JMP	[errpos]	;"return
2BB3xblkrdrd	MOV	filfunc,#$993F	;BlockRead with result var
2BB9	JMP.b	blrwres	;'
2BBBxblkwrrs	MOV	filfunc,#$F040	;BlockWrite with result var
2BC1blrwres	POP	errpos	;get error pos
2BC5	MOV	CX,DI	;result var ptr
2BC7	POP	BX
2BC8	POP	AX	;length
2BC9	POP	DX	;var seg
2BCA	POP	SI	;var ofs
2BCB	POP	DI	;file var ptr
2BCC	POP	ES
2BCD	PUSH	BX	;save result var ptr
2BCE	PUSH	CX
2BCF	CALL	blrw	;do it
2BD2	POP	DI	;restore result var ptr
2BD3	POP	ES
2BD4	ES:	
2BD5	MOV	[DI],AX	;store record count
2BD7	JMP	[errpos]	;"return
2BDBblrw	ES:		;do Block-R/W
2BDC	CMP	[DI]$02,#$00	;record length = 0 ?
2BE0	JZ	blrwerr	;yes: file not open
2BE2	ES:	
2BE3	CMP	[DI]$02,#$01	;record len = 1 ?
2BE7	JZ	blrwbyt	;:no calculation
2BE9	PUSH	DX	;save
2BEA	ES:	
2BEB	MUL	[DI]$02	;count * record length
2BEE	POP	DX	;restore
2BEFblrwbyt	XCHG	AX,CX	;length -> CX
2BF0	MOV.B	AH,filfunc	;function code
2BF4	ES:	
2BF5	MOV	BX,[DI]	;file handle
2BF7	PUSH	DS	;save DS
2BF8	MOV	DS,SI	;var seg
2BFA	CALL	dos	;do file operation
2BFD	POP	DS	;restore DS
2BFE	JNB	blrwok	;:ok
2C00	MOV	AL,filerr	;error code -> error
2C03	MOV	errnum,AL
2C06	XOR	AX,AX	;nothing read / written
2C08blrwok	ES:	
2C09	MOV	CX,[DI]$02	;record length
2C0C	CMP	CX,#$01	;= 1 ?
2C0F	JZ	blrwret	;yes: no division
2C11	MOV	DI,DX	;offset + count done
2C13	ADD	DI,AX
2C15	XOR	DX,DX	;clear hi
2C17	DIV	CX	;count done / record len
2C19	OR	DX,DX	;test remainder
2C1B	JZ	blrwret	;:ok
2C1D	CMP.B	filfunc,#$3F	;read ?
2C22	JNZ	blrwret	;no: end it
2C24	PUSH	AX	;save count done
2C25	SUB	CX,DX	;fill up the rest
2C27	MOV	ES,SI	;var seg
2C29	XOR	AX,AX	;with zeroes
2C2B	CLD	
2C2C	REPZ		;do it
2C2D	STOS.B	
2C2E	POP	AX	;restore result
2C2F	INC	AX	;+1
2C30blrwret	RET		;'
2C31blrwerr	MOV.B	errnum,#$04	;File not open
2C36	RET		;"
2C37xerase	POP	errpos	;Erase
2C3B	POP	ES	;file var ptr
2C3C	PUSH	errpos	;restore ret
2C40	MOV	AH,#$41	;delete file
2C42	LEA	DX,[DI]$0C	;ptr to filename
2C45	PUSH	DS	;save DS
2C46	PUSH	ES	;ES -> DS
2C47	POP	DS
2C48	CALL	dos	;do it
2C4B	POP	DS	;restore DS
2C4C	JNB	eraret	;:no error
2C4Eeraerr	MOV.B	errnum,#$01	;file not found
2C53eraret	RET		;"
2C54xrename	POP	errpos	;Rename
2C58	CALL	getpn	;convert string -> ASCIIZ
2C5B	POP	DI	;file var ptr
2C5C	POP	ES
2C5D	PUSH	errpos	;restore ret
2C61	MOV	AH,#$56	;Rename file
2C63	LEA	DX,[DI]$0C	;current file name
2C66	PUSH	DI	;save addr
2C67	MOV	DI,#pnbuf	;filename ptr
2C6A	PUSH	DS	;ES <-> DS
2C6B	PUSH	ES
2C6C	POP	DS
2C6D	POP	ES
2C6E	CALL	dos	;do rename
2C71	PUSH	DS	;ES <-> DS
2C72	PUSH	ES
2C73	POP	DS
2C74	POP	ES
2C75	POP	DI	;restore addr
2C76	JB	eraerr	;:error
2C78	MOV	SI,#pnbuf	;copy new name into file var
2C7B	LEA	DI,[DI]$0C	;file var offset
2C7E	MOV	CX,#$0020	;64 bytes
2C81	CLD	
2C82	REPZ	
2C83	MOVS		;copy it
2C84	RET		;"
2C85xchdir	POP	errpos	;ChDir: get error pos
2C89	CALL	getpn	;get path name
2C8C	PUSH	errpos	;restore ret
2C90	MOV	AX,pnbuf	;get drive #
2C93	OR.B	AL,AL	;end of name ?
2C95	JZ	chdirret	;yes: return
2C97	CMP.B	AH,#$3A	;: ?
2C9A	JNZ	chdir1	;no: no drive specified
2C9C	CALL	upcase	;upcase drive number
2C9F	SUB	AL,#$41	;- A
2CA1	JB	eraerr	;<:error
2CA3	CMP	AL,#$0F	;max. O
2CA5	JNB	eraerr	;:error.
	;Please note that MS-DOS now allows more drives !!!
2CA7	MOV	AH,#$0E	;set default drive
2CA9	MOV.B	DL,AL	;drive number
2CAB	CALL	dos	;set it
2CAE	CMP.B	pnbuf2,#$00	;pathname ?
2CB3	JZ	chdirret	;:none given
2CB5chdir1	MOV	AH,#$3B	;change dir
2CB7chdir2	MOV	DX,#pnbuf	;pointer to pathname
2CBA	CALL	dos	;set it
2CBD	JB	eraerr	;:error
2CBFchdirret	RET		;"
2CC0xmkdir	MOV	BH,#$39	;MkDir
2CC2	JMP.b	rmdir1	;'
2CC4xrmdir	MOV	BH,#$3A	;RmDir
2CC6rmdir1	POP	errpos	;return addr -> error pos
2CCA	CALL	getpn	;get path name
2CCD	PUSH	errpos	;restore ret
2CD1	MOV.B	AH,BH	;get function code
2CD3	JMP	chdir2	;"do it
2CD5xgetdir	POP	errpos	;GetDir: CL=max. string len
2CD9	POP	ES	;dest string
2CDA	POP	AX	;drive number
2CDB	PUSH	errpos	;restore ret
2CDF	OR.B	AL,AL	;default drive ?
2CE1	JNZ	gdnotdef	;:no
2CE3	MOV	AH,#$19	;get default drive number
2CE5	CALL	dos
2CE8	INC.B	AL	;+1
2CEAgdnotdef	MOV.B	DL,AL	;drive number
2CEC	ADD	AL,#$40	;-> drive name
2CEE	MOV	pnbuf,AL	;store in buffer
2CF1	MOV	pnbuf1,#$5C3A	;store :\
2CF7	MOV	AH,#$47	;read current access path
2CF9	MOV	SI,#pnbuf3	;dest ptr
2CFC	CALL	dos	;do it
2CFF	JNB	gddone	;:ok
2D01	MOV.B	[SI],#$00	;no path - mark end
2D04gddone	MOV	SI,#pnbuf	;pointer to path name
2D07	XOR	BX,BX	;clear len counter
2D09gdloop	MOV.B	AL,[SI]	;get char
2D0B	OR.B	AL,AL	;end ?
2D0D	JZ	gdend	;:yes
2D0F	INC	SI	;next char
2D10	INC	BX	;count length
2D11	ES:	
2D12	MOV.B	[BX_DI],AL	;store in dest string
2D14	DEC.B	CL	;space available ?
2D16	JNZ	gdloop	;:yes
2D18gdend	ES:		;store length
2D19	MOV.B	[DI],BL
2D1B	RET		;"
2D1Cxexecute	MOV	BX,#$2C7C	;Execute
2D1F	JMP.b	chain1
2D21xchain	XOR	BX,BX	;Chain: load all of it
2D23chain1	POP	errpos	;get ret addr
2D27	POP	ES	;file var ptr
2D28	PUSH	errpos	;restore ret
2D2C	TEST	modeflg,#$0001	;direct mode ?
2D32	JNZ	cherr2	;yes: error
2D34	PUSH	BX	;save begin offset
2D35	MOV	AX,#$3D00	;open file
2D38	LEA	DX,[DI]$0C	;ptr to filename
2D3B	CALL	dos	;do it
2D3E	POP	DX	;begin offset
2D3F	JB	cherr1	;:error
2D41	MOV	BX,AX
2D43	MOV	AX,#$4200	;seek absolute
2D46	XOR	CX,CX	;clr hi word
2D48	CALL	dos	;do seek
2D4B	JB	cherr1	;:error
2D4D	PUSH	DS	;save DS
2D4E	PUSH	CS	;CS -> DS
2D4F	POP	DS
2D50	MOV	AH,#$3F	;read byte block
2D52	MOV	CX,#$FFFF	;as much as possible
2D55	MOV	DX,#start	;destination
2D58	CALL	dos	;do it
2D5B	POP	DS	;restore DS
2D5C	MOV	AH,#$3E	;close file
2D5E	CALL	dos
2D61	MOV	SP,spval	;restore SP
2D65	CALL	reinit2	;reinit files, I/O
2D68	MOV	verror,#$10D0	;set break vector
2D6E	JMP	start2	;'start - no memory init
2D71cherr1	MOV	DL,#$01	;File not found
2D73	JMP	operr	;'
2D76cherr2	MOV.B	errnum,#$21	;Not allowed in direct mode
2D7B	RET		;"
2D7Cstart	JMP.b	kstart	;'skip message
2D7E	B	"Licensed Material. Program Property of B"
2DA6	B	"ORLAND."	;'
2DADkstart	CALL	readvers	;read version number
2DB0	MOV	AX,#$9C06	;(program size+15)/16
2DB3	MOV	CL,#$04
2DB5	SHR	AX,CL
2DB7	MOV	DX,CS	;+CS -> DS
2DB9	ADD	DX,AX
2DBB	MOV	DS,DX
2DBD	CS:	
2DBE	MOV	AX,availmem	;top of memory
2DC1	SUB	AX,DX
2DC3	MOV	freemem,AX	;max memory size
2DC6	MOV	BX,#$FFFE	;stack pointer
2DC9	SUB	AX,#$1000	;mem - 64K
2DCC	JNB	kmembig	;:ok
2DCE	MOV	BX,freemem	;max memory size
2DD2	MOV	CL,#$04	;small memory: SS at end of DS
2DD4	SHL	BX,CL	;calc SP
2DD6	XOR	AX,AX	;no segment offset
2DD8kmembig	ADD	AX,DX	;add to DS
2DDA	MOV	stackseg,AX	;-> stack segment
2DDD	MOV	stackpt,BX	;-> stack pointer
2DE1	MOV	AX,freemem	;max memory size
2DE4	SUB	AX,#$0040	;- 64 paragraphs
2DE7	CMP	AX,#$1000	;= 64K ?
2DEA	JB	kmemlim	;:less
2DEC	MOV	AX,#$1000	;limit to 64K
2DEFkmemlim	MOV	CL,#$04
2DF1	SHL	AX,CL
2DF3	DEC	AX
2DF4	MOV	txmemend,AX	;store -> end of text space
2DF7	XOR	AX,AX
2DF9kmeminit	MOV	SS,stackseg	;set stack segment
2DFD	MOV	SP,stackpt	;set stack pointer
2E01	PUSH	AX	;save flag
2E02	MOV	CX,#$0010	;16 files
2E05	CALL	initio	;init files, I/O
2E08	POP	AX	;get flag
2E09	OR	AX,AX	;test it
2E0B	PUSH	AX	;save it again
2E0C	JNZ	kcrtinit	;:set
2E0E	CALL	xcrtinit	;CrtInit
2E11kcrtinit	CALL	klowvid	;LowVideo
2E14	CALL	knrmvid	;NormVideo
2E17	POP	AX	;get flag
2E18	OR	AX,AX	;test it
2E1A	JZ	kinitvar	;:init
2E1C	JMP	kmainlp	;'go to main loop
2E1Fkinitvar	MOV	AX,#txstrt	;init vars
2E22	MOV	txbeg,AX	;beg of text
2E25	MOV	txend,AX	;end of text
2E28	XOR	AX,AX	;clear vars
2E2A	MOV	mincssz,AX	;min CS-size = 0
2E2D	MOV	mindssz,AX	;min DS-size = 0
2E30	MOV	minhpsz,#$0400	;min free heap =  16K
2E36	MOV	maxhpsz,#$A000	;max free heap = 640K
2E3C	MOV	workpn,AL	;clear work filename
2E3F	MOV	mainpn,AL	;clear main filename
2E42	MOV	parmlin,AL	;clear param line
2E45	MOV	errio,AL	;clear error
2E48	MOV.B	codedest,#$01	;code destination: memory
2E4D	CALL	inited	;init variables
2E50	MOV	AH,#$19	;get default drive
2E52	CALL	dos
2E55	MOV	defdrv,AL	;store it
2E58	CALL	xclrscr	;ClrScr
2E5B	CALL	prints	;write string
2E5E	B	"---------------------------------------",$0D
2E86	B	$0A,"TURBO Pascal system       ",$00
2EA2	CALL	klowvid	;do LowVideo
2EA5	CALL	prints	;write string
2EA8	B	"Version 3.01A",$00
2EB6	CALL	knrmvid	;do HighVideo
2EB9	CALL	prints	;write string
2EBC	B	$0D,$0A,"                                 ",$00
2EE0	CALL	klowvid
2EE3	CALL	prints
2EE6	B	"PC-DOS",$00
2EED	CALL	knrmvid
2EF0	CALL	prints
2EF3	B	$0D,$0A,$0A,$00
2EF7	CALL	klowvid
2EFA	CALL	prints
2EFD	B	"Copyright (C) 1983,84,85",$00
2F16	CALL	knrmvid
2F19	CALL	prints
2F1C	B	"   BORLAND Inc.",$0D,$0A,"-----------------------"
2F44	B	"----------------",$0D,$0A,$0A,$00
2F58	MOV	BX,#displstr	;write display type
2F5B	CALL	putstr
2F5E	CALL	prints
2F61	B	$0D,$0A,$0A,$0A,$0A,"Include error messages",$00
2F7D	CALL	yornln	;Y or N ?
2F80	MOV	msgflg,AL	;store flag
2F83	JZ	kclr	;:no
2F85	CALL	kreaderr	;read error messages
2F88kclr	CALL	kclrtxt	;clear text
2F8B	CALL	kmenu	;write menu
2F8Ekmainlp	MOV	SP,stackpt	;main loop: restore SP
2F92	MOV	BX,#kmainlp	;set a return addr
2F95	PUSH	BX
2F96	CMP.B	errio,#$00	;error ?
2F9B	JZ	kgetcmd	;:no
2F9D	JMP	kdofind	;'search error
2FA0kgetcmd	CALL	printatt	;write string with attributes
2FA3	B	$8D,$8A,$BE,$00	;CR,LF,>
2FA7	CALL	knrmvid
2FAA	CALL	keyget	;get command
2FAD	CALL	upcase	;convert to upper case
2FB0	PUSH	AX	;save it
2FB1	CALL	xwriteln	;WriteLn
2FB4	POP	AX	;restore command
2FB5	MOV	SI,#kcmdtab	;ptr to command table
2FB8	CALL	srchcmd	;search command
2FBB	JB	kmenu	;not found: write menu
2FBD	CS:	
2FBE	JMP	[SI]$01	;"execute command
2FC1kreaddef	CLD		;Transfer string into CON buffer
2FC2	MOV	DI,#coninbuf	;dest ptr
2FC5	PUSH	DS	;DS -> ES
2FC6	POP	ES
2FC7kreaddl	LODS.B		;SI: source ptr
2FC8	STOS.B		;copy string
2FC9	OR.B	AL,AL	;test for end
2FCB	JNZ	kreaddl	;:no
2FCDkreadln	CALL	prints	;Readln: write string
2FD0	B	": ",$00
2FD3	CALL	rdedit	;read with editing
2FD6	MOV	BX,#coninbuf	;buffer ptr
2FD9	CALL	xwriteln	;WriteLn
2FDCkrdln1	MOV.B	AL,[BX]	;get char from buffer
2FDE	CMP	AL,#$1A	;^Z ?
2FE0	JZ	krdlnret	;yes - end
2FE2	CMP	AL,#$20	;space ?
2FE4	JNZ	krdlnret	;:no, ret
2FE6	INC	BX	;skip spaces
2FE7	JMP	krdln1	;'continue scanning
2FE9krdlnret	RET		;"BX now points into buffer
2FEAkrdend	CMP.B	[BX],#$1A	;Test end of line
2FED	RET		;"
2FEEkmenu	CALL	knrmvid	;Write menu
2FF1	CALL	xclrscr	;ClrScr
2FF4	CALL	printatt
2FF7	B	$CC,"ogged drive: ",$80,$00
3007	MOV	AH,#$19	;get default drive
3009	CALL	dos
300C	ADD	AL,#$41	;convert to ASCII
300E	CALL	conput	;write its name
3011	CALL	printatt
3014	B	$0D,$0A,$C1,"ctive directory: ",$DC,$00
302A	MOV	AH,#$47	;get active directory
302C	XOR.B	DL,DL	;default drive
302E	MOV	SI,#pnbuf	;dest buffer
3031	CALL	dos	;do it: get pathname
3034	CALL	printpn	;write that pathname
3037	CALL	printatt
303A	B	$0D,$0A,$0A,$D7,"ork file: ",$80,$00
304A	CALL	kwworkpn	;write current filename
304D	CALL	printatt
3050	B	$0D,$0A,$CD,"ain file: ",$80,$00
305F	MOV	SI,#mainpn	;main filename
3062	CALL	printpn	;write it
3065	CALL	printatt	;write command menu
3068	B	$0D,$0A,$0A,$C5,"dit     ",$C3,"ompile  ",$D2,"un   ",$D3
3084	B	"ave",$0D,$0A,$0A,$C4,"ir      ",$D1,"uit  compiler ",$CF
30A3	B	"ptions",$0D,$0A,$0A,"Text: ",$00
30B3	MOV	AX,txend	;end of text
30B6	SUB	AX,txbeg	;- beg of text
30BA	CALL	kbytes	;print number
30BD	CALL	prints
30C0	B	"Free: ",$00
30C7	MOV	AX,txmemend	;top of text space
30CA	SUB	AX,txend	;- end of text
30CEkbytes	CALL	knumax	;print number
30D1	CALL	prints
30D4	B	" bytes",$0D,$0A,$00
30DD	RET		;"
30DEkcdest	DEC.B	AL	;show code direction: this one ?
30E0	JNZ	kcdestno	;count it down: no
30E2	CALL	printatt
30E5	B	"compile -> ",$00
30F1	RET		;'
30F2kcdestno	CALL	printatt	;clear field
30F5	B	"           ",$00
3101	RET		;"
3102optmenu	MOV	AX,#optmenu	;Option-menu
3105	PUSH	AX	;put return addr
3106optmenu2	CALL	xclrscr	;ClrScr
3109	MOV	AL,codedest	;code destination
310C	CALL	kcdest	;show it
310F	CALL	printatt
3112	B	$CD,"emory",$0D,$0A,$00
311B	CALL	kcdest	;show it
311E	CALL	printatt
3121	B	$C3,"om-file",$0D,$0A,$00
312C	CALL	kcdest	;show it
312F	CALL	printatt
3132	B	"c",$C8,"n-file",$0D,$0A,$0A,$0A,$00
313F	CMP.B	codedest,#$02	;to COM-file ?
3144	JZ	optmcom	;:yes
3146	JMP	optmparm	;'
3149optmcom	CALL	printatt	;display memory information
314C	B	"minimum c",$CF,"de segment size:   ",$00
316A	CALL	knrmvid
316D	MOV	AX,mincssz	;min CS size
3170	CALL	whexword	;write hex
3173	CALL	printatt
3176	B	" (max ",$00
317D	MOV	AX,#$2D8B	;-(runtime size+15)/16
3180	MOV	CL,#$04
3182	SHR	AX,CL
3184	NEG	AX
3186	ADD	AX,#$1000	;+ 64K
3189	CALL	kpara	;write paragraphs
318C	CALL	printatt
318F	B	")",$0D,$0A,"minimum ",$C4,"ata segment size:   ",$00
31B0	CALL	knrmvid
31B3	MOV	AX,mindssz	;min DS size
31B6	CALL	whexword	;write hex
31B9	CALL	printatt
31BC	B	" (max ",$00
31C3	MOV	AX,#$024F	;-(min vars used+15)/16
31C6	MOV	CL,#$04
31C8	SHR	AX,CL
31CA	NEG	AX
31CC	ADD	AX,#$1000	;+ 64K
31CF	CALL	kpara	;write paragraphs
31D2	CALL	printatt
31D5	B	")",$0D,$0A,"m",$C9,"nimum free dynamic memory: ",$00
31F6	CALL	knrmvid
31F9	MOV	AX,minhpsz	;min free heap
31FC	CALL	whexword	;write hex
31FF	CALL	klowvid
3202	CALL	kparastr	;write paragraphs
3205	CALL	printatt
3208	B	$0D,$0A,"m",$C1,"ximum free dynamic memory: ",$00
3228	CALL	knrmvid
322B	MOV	AX,maxhpsz	;max free heap
322E	CALL	whexword	;write hex
3231	CALL	klowvid
3234	CALL	kparastr	;write paragraphs
3237	JMP.b	optmget
3239optmparm	CALL	printatt
323C	B	"command line ",$D0,"arameters: ",$00
3256	CALL	knrmvid
3259	MOV	SI,#parmlin	;display command line
325C	CALL	kwstrsi
325Foptmget	CALL	printatt
3262	B	$0D,$0A,$0A,$0A,$C6,"ind run-time error  ",$D1,"uit",$0D
3280	B	$0A,$0A,$BE,$00
3284	CALL	knrmvid
3287	CALL	keyget	;get command
328A	CALL	upcase	;convert to upper case
328D	PUSH	AX	;save it
328E	CALL	xwriteln	;WriteLn
3291	POP	AX	;restore cmd
3292	MOV	SI,#ocmdtab	;ptr to command table
3295	CALL	srchcmd	;search command
3298	JNB	optexe	;:ok
329A	JMP	optmenu2	;'not found - repeat
329Doptexe	CS:	
329E	JMP	[SI]$01	;"execute command
32A1yornln	CALL	yorn	;Y or N ?
32A4	PUSHF		;save result
32A5	PUSH	AX
32A6	CALL	xwriteln	;WriteLn
32A9	POP	AX	;restore result
32AA	POPF	
32AB	RET		;"
32ACyorn	CALL	prints	;Y or N ?
32AF	B	" (Y/N)? ",$00
32B8yornlp	CALL	keyget	;get char
32BB	CALL	upcase	;convert to upper
32BE	CMP	AL,#$59	;Y ?
32C0	JZ	yornok	;:yes
32C2	CMP	AL,#$4E	;N ?
32C4	JNZ	yornlp	;no: loop back
32C6yornok	PUSH	AX	;save key
32C7	CALL	conput	;display choice
32CA	POP	AX	;restore it
32CB	SUB	AL,#$4E	;set flags:
32CD	RET		;"0=no
32CEwaitesc	CALL	prints	;Wait for ESC
32D1	B	". Press <ESC>",$00
32DFwaitescl	CALL	keyget	;get char
32E2	CMP	AL,#$1B	;ESC ?
32E4	JNZ	waitescl	;:no, wait
32E6	RET		;"
32E7srchcmd	CS:		;Search command in table
32E8	CMP.B	AL,[SI]	;compare it
32EA	JZ	srcmdfnd	;:found
32EC	ADD	SI,#$03	;go to next entry
32EF	CS:	
32F0	CMP.B	[SI],#$00	;end of table ?
32F3	JNZ	srchcmd	;:no
32F5	STC		;not found !
32F6srcmdfnd	RET		;"
32F7kcmdtab	B	"L"	;main command table
32F8	W	klogged
32FA	B	"A"
32FB	W	kactdir
32FD	B	"W"
32FE	W	kwork
3300	B	"M"
3301	W	kmain
3303	B	"E"
3304	W	editor
3306	B	"C"
3307	W	kcomp
3309	B	"R"
330A	W	krun
330C	B	"S"
330D	W	ksave
330F	B	"D"
3310	W	kdir
3312	B	"O"
3313	W	optmenu
3315	B	"Q"
3316	W	kquit
3318	B	$00	;"end of table
3319	B	"M"	;option command table
331A	W	kmem
331C	B	"C"
331D	W	kcom
331F	B	"H"
3320	W	kchn
3322	B	"O"
3323	W	kcs
3325	B	"D"
3326	W	kds
3328	B	"I"
3329	W	kss
332B	B	"A"
332C	W	kmss
332E	B	"P"
332F	W	kparm
3331	B	"F"
3332	W	kfind
3334	B	"Q"
3335	W	optquit
3337	B	$00	;"end of table
3338optquit	POP	AX	;Quit submenu
3339	JMP	kmenu	;"jump to main menu
	;pathname of message file (installed by TINST)
333Cerrpath	B	"TURBO.MSG",$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
3350	B	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00	;"
335Cextpas	B	$04,".PAS"	;table of file extensions
3361extcom	B	$04,".COM"
3366extbak	B	$04,".BAK"
336Bextchn	B	$04,".CHN"	;"
3370fnpath	B	$04,"\*.*"	;search parameters
3375fnany	B	$03,"*.*"	;"
3379kmain	CALL	prints	;M:Main file name
337C	B	$0D,$0A,"Main file name",$00
338D	CALL	knocode	;flag: text not compiled
3390	MOV	SI,#mainpn	;pointer to pathname
3393	CALL	kreaddef	;Enter new name
3396	MOV.B	mainpn,#$00	;mark end
339B	JZ	kmret	;:nothing read
339D	CALL	kpasext	;parse filename
33A0	MOV	DI,#mainpn	;dest buffer
33A3	CALL	fnscdi	;copy to main file name
33A6kmret	RET		;"
	;W:Work file name
33A7kwork	MOV	vnewfil,#flnew	;set error vec: new file
33AD	CALL	ksvchng	;save, if changed
33B0	CALL	prints
33B3	B	$0D,$0A,"Work file name",$00
33C4	MOV	SI,#workpn	;ptr work file name
33C7	CALL	kreaddef	;Enter new name
33CA	MOV.B	workpn,#$00	;mark end
33CF	JNZ	kwok	;:something read
33D1	CALL	kclrtxt	;clear text
33D4	JMP	kmainlp	;'back to main menu
33D7kwok	CALL	kpasext	;parse filename
33DA	MOV	DI,#workpn	;copy to work file name
33DD	CALL	fnscdi
33E0	JMP.b	kw2	;'now load it
33E2kwload	MOV	vnewfil,#flescclr	;set error vec: not found
33E8kw2	MOV	vfilbig,#flbigclr	;set error vec: too big
33EE	CALL	kclrtxt	;clear text
33F1	MOV	SI,#workpn	;work file name
33F4kwload2	MOV	BX,txbeg	;beg of text
33F8	PUSH	BX	;save parms
33F9	PUSH	SI
33FA	CALL	clred	;clear editor vars
33FD	POP	SI
33FE	POP	BX	;restore
33FF	MOV	DX,BX	;begin addr
3401	MOV	CX,txmemend	;end of space
3405	CALL	kload	;load file
3408	INC	BX
3409	MOV	txend,BX	;set end of text
340D	RET		;"
340Ekload	PUSH	DX	;Load file: save start pos
340F	PUSH	CX	;save end pos
3410	CALL	fnsisc	;copy pathname[SI]
3413	CALL	prints
3416	B	$0D,$0A,"Loading ",$00
3421	CALL	kwscrpn	;write pathname
3424	MOV	AX,#$3D00	;open file
3427	MOV	DX,#scrpn	;current pathname
342A	PUSH	DS	;DS -> ES
342B	POP	ES
342C	CALL	dos	;do it
342F	MOV	BX,AX	;file handle
3431	POP	CX	;restore parms
3432	POP	DX
3433	JB	flntfnd	;:error
3435kload2	SUB	CX,DX	;calc max length
3437	MOV	AH,#$3F	;read byte block
3439	CALL	dos	;do it
343C	JB	flntfnd	;:error
343E	CMP	AX,CX	;length = expected ?
3440	JZ	fltoobig	;yes: too big !
3442	XCHG	AX,CX	;get length done
3443	MOV	DI,DX	;end addr
3445	PUSH	DS	;DS -> ES
3446	POP	ES
3447	MOV	AL,#$1A	;search ^Z in the block
3449	CLD	
344A	REPNZ	
344B	SCAS.B	
344C	JNZ	klnoeof	;:not found
344E	DEC	DI	;go back one byte
344Fklnoeof	MOV	AH,#$3E	;close file
3451	CALL	dos
3454	DEC	DI
3455	MOV	BX,DI	;end pos of text read
3457	RET		;"
3458fltoobig	CALL	klnoeof	;file too large: close file
345B	MOV	BX,DX	;end of text space
345D	INC	BX	;+1
345E	JMP	[vfilbig]	;"handle error
3462flntfnd	MOV	BX,DX	;file not found
3464	DEC	BX	;end addr
3465	JMP	[vnewfil]	;"handle error
3469flesc	CALL	xwriteln	;File not found - ESC
346C	CALL	vidattr3	;attribute #3
346F	CALL	prints
3472	B	"File not found",$00
3481flesc2	CALL	waitesc	;wait for ESC
3484	JMP	knrmvid	;"HighVideo
3487flescclr	CALL	flesc	;file not found - ESC
348A	JMP.b	flclr	;"clear work file name
348Cflnew	CMP	AL,#$03	;New file: test error code
348E	JZ	fldir	;:invalid dir
3490	CALL	xwriteln	;WriteLn
3493	CALL	vidattr2	;attribute #2
3496	CALL	prints
3499	B	"New File",$00
34A2	CALL	knrmvid
34A5	PUSH	BX	;save end pos
34A6	MOV	BX,#$07D0	;wait 2 s
34A9	CALL	delaybx
34AC	POP	BX	;restore
34AD	RET		;'
34AEfldir	CALL	xwriteln	;WriteLn
34B1	CALL	vidattr3	;Attribute #3
34B4	CALL	prints
34B7	B	"Invalid directory",$00
34C9	JMP.b	flclr	;"clear work file name
34CBflbig	CALL	xwriteln	;File too big
34CE	CALL	vidattr3
34D1	CALL	prints
34D4	B	"File too big",$00
34E1	MOV	BX,txend	;end of text-1 -> BX
34E5	DEC	BX
34E6	JMP	flesc2	;"wait for ESC
34E8flbigclr	CALL	flbig	;file too big
34EBflclr	MOV.B	workpn,#$00	;clear work file name
34F0	JMP	kmainlp	;"main loop
34F3ksvchng	XOR	AX,AX	;Save if modified
34F5	INC	AX	;set flag
34F6	JMP.b	ksv2	;'
34F8ksvnoask	XOR	AX,AX
34FAksv2	CMP.B	txchg,#$00	;text changed ?
34FF	JZ	ksvret	;:no - ret
3501	OR	AX,AX	;test flag
3503	JZ	ksave
3505	CALL	prints
3508	B	"Workfile ",$00
3512	CALL	kwworkpn	;write path name
3515	CALL	prints
3518	B	" not saved. Save",$00
3529	MOV.B	txchg,#$00	;clear change flag
352E	CALL	yornln	;Y or N ?
3531	JNZ	ksave	;:yes
3533ksvret	RET		;'
3534ksave	CALL	kgetfn	;S:Save file - get filename
3537	MOV.B	txchg,#$00	;clear change flag
353C	MOV	SI,#workpn	;ptr work file name
353F	CALL	fnsisc	;copy it
3542	CALL	prints
3545	B	$0D,$0A,"Saving ",$00
354F	CALL	kwworkpn	;write path name
3552	MOV	DI,#pnbuf
3555	CALL	fnscdi	;copy filename into buffer
3558	MOV	SI,#extbak	;extension .BAK
355B	CALL	kext	;modify file name
355E	MOV	AH,#$41	;delete old .BAK file
3560	MOV	DX,#scrpn	;scratch file name
3563	CALL	dos	;do it
3566	MOV	AH,#$56	;rename file
3568	MOV	DX,#pnbuf	;current filename
356B	MOV	DI,#scrpn	;new filename
356E	CALL	dos	;do it: rename to .BAK
3571	MOV	AH,#$3C	;create new file
3573	XOR	CX,CX	;no attribute
3575	MOV	DX,#pnbuf	;current filename
3578	PUSH	DS	;DS -> ES
3579	POP	ES
357A	CALL	dos	;do create
357D	JB	ksren	;:error
357F	XCHG	AX,BX	;file handle
3580	MOV	DX,txbeg	;beg -> offset
3584	MOV	CX,txend	;end of text
3588	MOV	DI,CX
358A	MOV.B	[DI],#$1A	;store ^Z at the end
358D	SUB	CX,DX	;calc length
358F	INC	CX	;+1
3590	MOV	AH,#$40	;write byte block
3592	CALL	dos	;do it
3595	JB	kserr	;:error
3597	CMP	AX,CX	;length = expected ?
3599	JNZ	kserr	;:no
359B	JMP	klnoeof	;'close that file
359Ekserr	MOV.B	txchg,#$FF	;set changed flag
35A3	CALL	klnoeof	;close that file
35A6	MOV	AH,#$41	;erase new file
35A8	MOV	DX,#pnbuf
35AB	CALL	dos
35AEksren	MOV	AH,#$56	;rename it back to .PAS
35B0	MOV	DX,#scrpn	;.BAK
35B3	MOV	DI,#pnbuf	;-> .PAS
35B6	CALL	dos	;do it
35B9	CALL	xwriteln	;WriteLn
35BC	CALL	ksfull	;write message
35BF	JMP	kmainlp	;"return to main menu
35C2ksfull	CALL	vidattr3	;File not saved
35C5	CALL	prints
35C8	B	"Disk full or invalid directory path",$00
35EC	CALL	waitesc	;wait for ESC
35EF	JMP	knrmvid	;"
35F2kdir	CALL	prints	;D:Directory
35F5	B	"Dir mask",$00
35FE	CALL	kreadln	;enter dir mask
3601	MOV	CX,#$000D	;*, ? allowed
3604	CALL	kparse2	;parse filename
3607	CALL	krdend	;line end ?
360A	MOV	AH,#$1A	;set DMA transfer addr
360C	MOV	DX,#pnbuf	;buffer
360F	CALL	dos
3612	MOV	SI,#scrpn	;test pathname
3615kdtest	MOV.B	AL,[SI]	;get char
3617	INC	SI	;go to next
3618	CMP	AL,#$2A	;* ?
361A	JZ	kddoit	;:yes
361C	CMP	AL,#$3F	;?
361E	JZ	kddoit	;:yes
3620	OR.B	AL,AL	;end of string ?
3622	JNZ	kdtest	;:no
3624	MOV.B	AL,[SI]-$02	;get last char
3627	MOV	SI,#fnany	;ptr to *.*
362A	CMP	AL,#$3A	;: ?
362C	JZ	kdwrit	;:yes
362E	CMP	AL,#$5C	;\ ?
3630	JZ	kdwrit	;:yes
3632	MOV	AH,#$4E	;search first dir entry
3634	MOV	CX,#$0010	;attribute
3637	MOV	DX,#scrpn	;pathname
363A	CALL	dos	;do it
363D	JB	kddoit	;:error
363F	TEST.B	pndiratt,#$10	;attribute ok ?
3644	JZ	kddoit	;yes, take it
3646	MOV	SI,#fnpath	;ptr to \*.*
3649kdwrit	CALL	kext2
364Ckddoit	CALL	prints
364F	B	"Directory of ",$00
365D	CALL	kwscrpn	;write path name
3660	CALL	xwriteln	;WriteLn
3663	MOV	AH,#$4E	;get first entry
3665	MOV	CX,#$0010	;attribute
3668	MOV	DX,#scrpn	;path name
366B	CALL	dos	;do it
366E	JB	kderr	;:error
3670	XOR.B	DL,DL	;clear flag
3672kddis	OR.B	DL,DL	;test flag
3674	JNZ	kdnocr	;:not first entry in line
3676	CS:	
3677	MOV	AL,txwinx2	;line length / 16
367A	XOR.B	AH,AH
367C	MOV	DL,#$10
367E	DIV.B	DL
3680	MOV.B	DL,AL
3682kdnocr	MOV	SI,#pndirnm	;ptr to filename
3685	TEST.B	[SI]-$09,#$10	;test attribute
3689	JZ	kdnodir	;:ok
368B	CMP.B	[SI],#$2E	;directory ?
368E	JZ	kdnext
3690	CALL	klowvid	;LowVideo
3693kdnodir	CALL	printpn	;write name
3696	CALL	knrmvid	;NormVideo
3699	DEC.B	DL	;another one in this line ?
369B	JZ	kdnextln	;:no
369D	MOV	CX,#pndirpad	;end for padding
36A0	SUB	CX,SI	;calc length
36A2kdpad	MOV	AL,#$20	;pad with spaces
36A4	CALL	conput	;write space
36A7	LOOP	kdpad	;:another one
36A9	JMP.b	kdnext	;'next dir entry
36ABkdnextln	CALL	xwriteln	;WriteLn
36AEkdnext	MOV	AH,#$4F	;get next entry
36B0	PUSH	DX	;save tab
36B1	CALL	dos	;get it
36B4	POP	DX	;restore tab
36B5	JNB	kddis	;:ok, write it
36B7	OR.B	DL,DL	;(redundant !)
36B9	JMP.b	kdend	;'end it
36BBkderr	CALL	xwriteln	;WriteLn
36BE	CALL	vidattr2
36C1	CALL	prints
36C4	B	"No files",$00
36CD	CALL	knrmvid
36D0	MOV	DL,#$01	;do CR
36D2kdend	OR.B	DL,DL	;test tab flag
36D4	JZ	kdend2	;:no CR
36D6	CALL	xwriteln	;WriteLn
36D9kdend2	CALL	xwriteln	;WriteLn
36DC	MOV.B	DL,scrpn	;get drive number
36E0	SUB.B	DL,#$40	;convert
36E3	MOV	AH,#$36	;get disk free space
36E5	CALL	dos
36E8	CMP	AX,#$FFFF	;invalid drive ?
36EB	JZ	kdret	;:yes
36ED	MUL	CX	;calc bytes/block
36EF	OR	DX,DX	;many ?
36F1	JNZ	kdret	;:yes
36F3	MUL	BX	;* number free blocks
36F5	MOV	CL,#$0A	;DIV 1024
36F7	SHR	AX,CL
36F9	MOV	CL,#$06
36FB	SHL	DX,CL
36FD	ADD	AX,DX
36FF	CALL	knum1	;write number
3702	CALL	prints
3705	B	"k bytes free",$00
3712kdret	RET		;"
3713klogged	CALL	prints	;L:Logged drive
3716	B	"New drive",$00
3720	CALL	kreadln	;Read line
3723	MOV.B	AL,[BX]	;get char from buffer
3725	CMP	AL,#$1A	;EOF ?
3727	JNZ	kldef	;:no
3729	MOV	AH,#$19	;get default drive
372B	CALL	dos
372E	JMP.b	kldef2	;'ok
3730kldef	CALL	upcase	;convert it
3733	SUB	AL,#$41	;< A ?
3735	JB	klret	;:wrong
3737	CMP	AL,#$0F	;> O ?
3739	JA	klret	;:wrong
373Bkldef2	PUSH	AX	;save it
373C	MOV	AH,#$0D	;reset disk system
373E	CALL	dos
3741	POP	DX	;restore drive
3742	MOV	AH,#$0E	;set default drive
3744	CALL	dos
3747klret	RET		;"
3748kactdir	CALL	prints	;A:Active directory
374B	B	"New directory",$00
3759	CALL	kreadln	;read string
375C	JZ	karet	;nothing: ret
375E	MOV	SI,BX	;source
3760	MOV	DX,#pnbuf	;dest: std pathname
3763	MOV	DI,DX
3765	MOV	CX,#$0040	;64 bytes
3768	PUSH	DS	;DS -> ES
3769	POP	ES
376A	CLD		;copy it
376B	REPZ	
376C	MOVS.B	
376D	MOV	DI,DX	;restore ptr to beg
376F	MOV	AL,#$1A	;search ^Z
3771	MOV	CX,#$0040
3774	REPNZ	
3775	SCAS.B	
3776	JNZ	kaerr	;not found: invalid
3778	MOV.B	[DI]-$01,#$00	;mark end with 0
377C	MOV	AH,#$3B	;change directory
377E	CALL	dos
3781	OR.B	AL,AL	;error ?
3783	JZ	karet	;:no
3785kaerr	MOV	AL,#$07	;Bell
3787	CALL	conput	;write it
378Akaret	RET		;"
378Bkspace	CALL	prints	;Display space information
378E	B	"Code:       ",$00
379B	MOV	BX,#$2D8B	;(code size-runtime length)/16
379E	MOV	CL,#$04
37A0	SHR	BX,CL
37A2	MOV	AX,codesize	;(already in paras)
37A5	SUB	AX,BX
37A7	AND	AX,#$0FFF
37AA	CALL	ksize	;write number
37AD	CALL	prints
37B0	B	", ",$00
37B3	MOV	AX,#$1000	;(64K-code size)/16
37B6	SUB	AX,codesize
37BA	AND	AX,#$0FFF
37BD	CALL	kpara	;write para
37C0	CALL	prints
37C3	B	" free",$0D,$0A,"Data:       ",$00
37D7	MOV	BX,#$024F	;(Data size-std vars)/16
37DA	MOV	CL,#$04
37DC	SHR	BX,CL
37DE	MOV	AX,datasize	;(already paras)
37E1	SUB	AX,BX
37E3	AND	AX,#$0FFF
37E6	CALL	ksize	;write number
37E9	CALL	prints
37EC	B	", ",$00
37EF	MOV	AX,#$1000	;(64K-data size)/16
37F2	SUB	AX,datasize
37F6	AND	AX,#$0FFF
37F9	CALL	kpara	;write para
37FC	CALL	prints
37FF	B	" free",$0D,$0A,$00
3807	CMP.B	codedest,#$01	;code destination ?
380C	JZ	kspmem	;:memory
380E	CMP.B	codedest,#$02
3813	JZ	kspcom	;:COM-File
3815	RET		;'
3816kspmem	CALL	prints
3819	B	"Stack/Heap: ",$00
3826	MOV	AX,minstksz	;display min stack size
3829	CALL	ksize	;write number
382C	JMP	xwriteln	;'WriteLn
382Fkspcom	CALL	prints
3832	B	"Stack/Heap: ",$00
383F	MOV	AX,minhpsz	;min heap/stack size
3842	CALL	ksize	;write number
3845	CALL	prints
3848	B	" (minimum)",$0D,$0A,"            ",$00
3861	MOV	AX,maxhpsz	;max heap/stack size
3864	CALL	ksize	;write number
3867	CALL	prints
386A	B	" (maximum)",$0D,$0A,$00
3877	RET		;"
3878ksize	PUSH	AX	;write number hex and dec
3879	CALL	kpara	;write para
387C	CALL	prints
387F	B	" (",$00
3882	POP	AX	;restore number
3883	XOR	DX,DX	;clear hi
3885	MOV	CX,#$0004
3888ksize2	SHL	AX,1 	;* 16
388A	RCL	DX,1 
388C	LOOP	ksize2	;:another shift
388E	MOV	BX,AX	;number
3890	MOV	CX,#$0006	;field length
3893	CALL	knum	;write DX:BX
3896	CALL	prints
3899	B	" bytes)",$00
38A1	RET		;"
38A2kpara	CALL	whexword	;Write para: hex number
38A5kparastr	CALL	prints
38A8	B	" paragraphs",$00
38B4	RET		;"
38B5	CALL	kpara	;WriteLn para
38B8	JMP	xwriteln	;"
38BBkrdhex	XOR	AX,AX	;Read hex
38BDkrxlp	PUSH	AX	;save number
38BE	MOV.B	AL,[BX]	;get char
38C0	CALL	upcase	;UpCase
38C3	MOV.B	CH,AL	;-> CH
38C5	POP	AX	;restore number
38C6	SUB.B	CH,#$30	;ASCII-translation
38C9	JB	krxend	;:< 0 - end
38CB	CMP.B	CH,#$0A	;> 9 ?
38CE	JB	krxok	;no: ok
38D0	SUB.B	CH,#$07	;A..F
38D3	CMP.B	CH,#$0A	;< A ?
38D6	JB	krxend	;yes: end
38D8	CMP.B	CH,#$10	;> F ?
38DB	JNB	krxend	;yes: end
38DDkrxok	MOV	CL,#$04	;number * 16
38DF	SHL	AX,CL
38E1	OR.B	AL,CH	;add digit
38E3	INC	BX	;next char
38E4	JMP	krxlp	;'continue
38E6krxend	RET		;"
38E7kfind	CALL	prints	;F:Find Error
38EA	B	"Enter PC",$00
38F3	CALL	kreadln	;ReadLn
38F6	JNZ	kfind2	;:ok
38F8	RET		;'nothing entered
38F9kfind2	CALL	krdhex	;read hex
38FC	MOV	errpos2,AX	;store error position
38FF	CALL	knocode	;set flag: not compiled
3902kdofind	CALL	kgetfile	;get file, if necessary
3905	MOV.B	cpmode,#$01	;set flag: searching
390A	CALL	prints
390D	B	$0D,$0A,"Searching",$00
3919	JMP.b	kcnofile	;"do it...
391Bkcomp	CALL	kgetfile	;C:Compile - get file
391E	CALL	kdestfil	;set dest file
3921	CALL	prints
3924	B	$0D,$0A,"Compiling",$00
3930	CMP.B	cpmode,#$00	;to memory ?
3935	JZ	kcnofile	;:yes
3937	CALL	prints
393A	B	" --> ",$00
3940	MOV	SI,#scrpn	;display dest path name
3943	CALL	printpn
3946kcnofile	CALL	xwriteln	;WriteLn
3949	CALL	turbo	;Call compiler
394C	CMP.B	cpmode,#$02	;COM/CHN produced ?
3951	JB	kcnoerr	;:no
3953	CMP.B	cperr,#$00	;error ?
3958	JZ	kcnoerr	;:no
395A	CALL	kdestfil	;set dest file
395D	MOV	AH,#$41	;delete it
395F	MOV	DX,#destpn
3962	CALL	dos
3965kcnoerr	CMP.B	cperr,#$CA	;Compilation aborted ?
396A	JNZ	kcnoabrt	;:no
396C	CALL	xwriteln	;WriteLn
396F	CALL	xwriteln	;WriteLn
3972	CALL	vidattr2
3975	CALL	prints
3978	B	"Compilation aborted",$00
398C	JMP	kmainlp	;'return to main menu
398Fkcnoabrt	CALL	prints
3992	B	" lines",$0D,$0A,$0A,$00
399C	CMP.B	cperr,#$00	;error ?
39A1	JNZ	kctest	;:yes
39A3	CMP.B	cpmode,#$01	;find error pos ?
39A8	JZ	kcnotfnd	;:yes
39AA	CALL	kspace	;display space info
39AD	RET		;'
39AEkcnotfnd	CALL	vidattr3	;error pos not found
39B1	CALL	prints
39B4	B	"Run-time error position not found",$00
39D6	CALL	knrmvid
39D9	JMP.b	kwlnret	;'return to main
39DBkctest	CMP.B	cperr,#$C9	;I/O-error ?
39E0	JNZ	kcfound	;:no
39E2	CALL	ksfull	;write message
39E5kwlnret	CALL	xwriteln	;WriteLn
39E8	JMP	kmainlp	;'return to main menu
39EBkcfound	CMP.B	cperr,#$C8	;Error pos found ?
39F0	JNZ	kcerror	;:no
39F2	CALL	prints
39F5	B	"Run-time error position found",$00
3A13	JMP	kcwend	;'jump to this position
3A16kcerror	CALL	vidattr3	;Error message
3A19	CALL	prints
3A1C	B	"Error ",$00
3A23	XOR	AX,AX	;get error number
3A25	MOV	AL,cperr
3A28	CALL	knum1	;write it
3A2B	TEST.B	msgflg,#$FF	;error msgs included ?
3A30	JZ	kcwend	;:no
3A32	MOV	BX,#txstrt	;pointer to messages
3A35kcmsr	MOV.B	AL,[BX]	;get char
3A37	CMP	AL,#$1A	;^Z ?
3A39	JZ	kcwend	;yes: not found
3A3B	CMP	AL,#$20	;control char ?
3A3D	JB	kcmsr2	;:yes
3A3F	SUB	AL,#$30	;get digit
3A41	MOV.B	AH,AL	;* 10
3A43	ADD.B	AL,AL
3A45	ADD.B	AL,AL
3A47	ADD.B	AL,AH
3A49	ADD.B	AL,AL
3A4B	INC	BX
3A4C	ADD.B	AL,[BX]	;get second digit
3A4E	SUB	AL,#$30	;convert
3A50	INC	BX	;next char
3A51	CMP.B	AL,cperr	;= error number ?
3A55	JZ	kcwmsg	;:yes
3A57kcmsr2	MOV.B	AL,[BX]	;get char
3A59	INC	BX	;next one
3A5A	CMP	AL,#$0D	;end of line ?
3A5C	JNZ	kcmsr2	;no: search it
3A5E	INC	BX	;next char: skip LF
3A5F	JMP	kcmsr	;'continue searching
3A61kcwmsg	CALL	prints	;Display error message
3A64	B	": ",$00
3A67kcwlp	MOV.B	AL,[BX]	;get char
3A69	CMP	AL,#$0D	;CR ?
3A6B	JZ	kcwend	;yes: done
3A6D	CMP	AL,#$20	;control char ?
3A6F	JNB	kcwchar	;:no - write it
3A71	CMP	AL,#$1A	;^Z ?
3A73	JZ	kcwend	;yes: done
3A75	MOV	SI,#txstrt	;pointer to messages
3A78kcsubsr	MOV.B	AL,[SI]	;get char
3A7A	INC	SI	;go to next
3A7B	CMP	AL,#$20	;control char ?
3A7D	JNB	kcwsub	;no: search end of line
3A7F	CMP.B	AL,[BX]	;is it the right one ?
3A81	JNZ	kcwsub	;:no, next line
3A83kcsubsr2	MOV.B	AL,[SI]	;get char - write sub-message
3A85	CMP	AL,#$0D	;CR ?
3A87	JZ	kcwnext	;:end
3A89	CALL	conput	;write it
3A8C	INC	SI	;next one
3A8D	JMP	kcsubsr2	;'continue
3A8Fkcwsub	MOV.B	AL,[SI]	;search end of line
3A91	INC	SI	;next char
3A92	CMP	AL,#$0D	;CR ?
3A94	JNZ	kcwsub	;:no
3A96	INC	SI	;skip LF
3A97	JMP	kcsubsr	;'continue searching
3A99kcwchar	CALL	conput	;display char
3A9Ckcwnext	INC	BX	;go to next
3A9D	JMP	kcwlp	;'continue
3A9Fkcwend	MOV.B	mainflg,#$00	;work file used
3AA4	CMP.B	inclflg,#$00	;error in include file ?
3AA9	JZ	kcnoincl	;:no
3AAB	MOV	AL,#$2E
3AAD	CALL	conput	;write char
3AB0	CALL	knrmvid
3AB3	CALL	ksvnoask
3AB6	MOV	SI,#inclpn	;copy include file name
3AB9	MOV	DI,#workpn	;into work file name
3ABC	CALL	fncopy	;do it
3ABF	CALL	kwload	;load that file
3AC2	CALL	xwriteln	;WriteLn
3AC5	CALL	vidattr3
3AC8	CALL	prints
3ACB	B	"Error found in above include file",$00
3AED	JMP.b	kcwait	;'go into editor
3AEFkcnoincl	CMP.B	mainpn,#$00	;main file exists ?
3AF4	JZ	kcwait	;:no
3AF6	MOV	SI,#mainpn	;copy main into
3AF9	MOV	DI,#workpn	;work file name
3AFC	CALL	fncopy	;do it
3AFFkcwait	CALL	waitesc	;wait for ESC
3B02	MOV	BX,txerrpos	;get error pos in text
3B06	DEC	BX
3B07	JMP	editor2	;"jump into editor
3B0Akmem	MOV.B	codedest,#$01	;M:memory
3B0F	RET		;"set flag
3B10kcom	MOV.B	codedest,#$02	;C:COM file
3B15	RET		;"set flag
3B16kchn	MOV.B	codedest,#$03	;H:CHN file
3B1B	RET		;"set flag
3B1Ckcs	CALL	prints	;O:CS size
3B1F	B	"Minimum Code Segment size",$00
3B39	CALL	kreadln	;read it
3B3C	MOV	AX,#$0000	;default
3B3F	JZ	kcsdef	;:nothing entered
3B41	CALL	krdhex	;read hex
3B44	MOV	BX,#$2D8B	;add runtime size
3B47	MOV	CL,#$04	;convert to paras
3B49	SHR	BX,CL
3B4B	ADD	AX,BX
3B4Dkcsdef	MOV	mincssz,AX	;store min CS
3B50	RET		;"
3B51kds	CALL	prints	;D:DS size
3B54	B	"Minimum Data Segment size",$00
3B6E	CALL	kreadln	;read it
3B71	MOV	AX,#$0000	;default
3B74	JZ	kdsdef	;nothing entered: set it
3B76	CALL	krdhex	;read hex
3B79	MOV	BX,#$024F	;add std vars size
3B7C	MOV	CL,#$04
3B7E	SHR	BX,CL	;convert to paras
3B80	ADD	AX,BX
3B82kdsdef	MOV	mindssz,AX	;store min DS
3B85	RET		;"
3B86kss	CALL	prints	;S:SS size
3B89	B	"Minimum Stack Segment size",$00
3BA4	CALL	kreadln	;read it
3BA7	MOV	AX,#$0400	;default: 16K
3BAA	JZ	kssdef	;nothing entered: set it
3BAC	CALL	krdhex	;read hex
3BAFkssdef	MOV	minhpsz,AX	;store min SS
3BB2	RET		;"
3BB3kmss	CALL	prints	;A:Max. SS size
3BB6	B	"Maximum Stack Segment size",$00
3BD1	CALL	kreadln	;read it
3BD4	MOV	AX,#$A000	;default: 640K
3BD7	JZ	kmssdef	;nothing entered: set it
3BD9	CALL	krdhex	;read hex
3BDCkmssdef	MOV	maxhpsz,AX	;store max SS
3BDF	RET		;"
3BE0kparm	CALL	prints	;P:Parameter line
3BE3	B	"Parameters",$00
3BEE	MOV	SI,#parmlin	;ptr to buffer
3BF1	CALL	kreaddef	;Read line with default
3BF4	MOV	DI,#parmlin	;copy it
3BF7	MOV	CX,#$003B	;count
3BFAkparml	MOV.B	AL,[BX]	;get char
3BFC	CMP	AL,#$1A	;^Z ?
3BFE	JZ	kparme	;yes: end
3C00	MOV.B	[DI],AL	;store in buffer
3C02	INC	BX	;next char
3C03	INC	DI
3C04	LOOP	kparml	;:another char
3C06kparme	MOV.B	[DI],#$00	;mark end of param line
3C09	RET		;"
3C0Akgetfile	CMP.B	workpn,#$00	;load file, if necessary
3C0F	JNZ	kget1	;:work file defined
3C11	CALL	kgetfn	;get work file name
3C14kget1	CMP.B	mainpn,#$00	;main file ?
3C19kget2	MOV	SI,#workpn
3C1C	JNZ	kget3	;:work file exists
3C1E	CALL	kgetfn	;copy work -> main file name
3C21	MOV	AL,#$00	;use work file
3C23	JMP.b	kget4	;'
3C25kget3	CALL	kcmpfn	;work = main ?
3C28	JZ	kget2	;:yes
3C2A	CALL	ksvnoask	;save without question
3C2D	MOV	vfilbig,#flbigclr	;set error vectors
3C33	MOV	vnewfil,#flescclr
3C39	MOV	SI,#mainpn	;main file
3C3C	CALL	kwload2	;load it
3C3F	MOV	AL,#$FF	;set flag: main file
3C41kget4	MOV	mainflg,AL	;store flag
3C44	MOV.B	errio,#$00	;clear error flag
3C49	RET		;"
3C4Akdestfil	MOV	SI,#mainpn	;Set dest file name
3C4D	CMP.B	[SI],#$00	;main file name ok ?
3C50	JNZ	kdsmain	;not null - ok
3C52	MOV	SI,#workpn	;use work file name
3C55kdsmain	CALL	fnsisc	;copy to scratch file name
3C58	MOV	SI,#extcom	;set extension .COM
3C5B	MOV	AL,codedest
3C5E	MOV.B	cpmode,#$00	;set flag: memory
3C63	DEC.B	AL	;memory ?
3C65	JZ	kdsmem	;:yes
3C67	MOV.B	cpmode,#$02	;flag: file
3C6C	DEC.B	AL	;COM ?
3C6E	JZ	kdsmem	;:yes
3C70	MOV.B	cpmode,#$03	;flag: CHN
3C75	MOV	SI,#extchn	;set extension .CHN
3C78kdsmem	CALL	kext	;modify file name
3C7B	MOV	DI,#destpn	;-> dest file name
3C7E	CALL	fnscdi	;copy it
3C81	RET		;"
3C82krun	CMP.B	txcomp,#$00	;R:Run
3C87	JNZ	krok	;:already compiled
3C89	CALL	kcomp	;compile it
3C8Ckrok	CMP.B	codedest,#$01	;memory: ok
3C91	JZ	krmem	;yes: do it
3C93	CMP.B	codedest,#$02	;COM-file ?
3C98	JNZ	krchn
3C9A	CALL	xwriteln	;WriteLn
3C9D	CALL	vidattr2
3CA0	CALL	prints
3CA3	B	"Please Quit TURBO to run .COM file",$00
3CC6krchn	JMP	kmainlp	;'return to menu
3CC9krmem	MOV	SI,#parmlin	;copy command line
3CCC	MOV	DI,#paramlin	;to start of CS
3CCF	MOV	ES,destseg	;seg of compiled program
3CD3	XOR	BX,BX	;clear offset
3CD5krparml	MOV.B	AL,[SI]	;get char
3CD7	CMP	AL,#$00	;end ?
3CD9	JZ	krparme	;:yes
3CDB	INC	SI	;next char
3CDC	INC	BX
3CDD	ES:	
3CDE	MOV.B	[BX_DI],AL	;store that char
3CE0	JMP	krparml	;'continue
3CE2krparme	ES:	
3CE3	MOV.B	[BX_DI]$01,#$0D	;store CR at the end
3CE7	ES:	
3CE8	MOV.B	[DI],BL	;store length
3CEA	CALL	prints
3CED	B	$0D,$0A,"Running",$0D,$0A,$00
3CF9	PUSH	destseg	;CS of program
3CFD	MOV	AX,#$0100	;start of program
3D00	PUSH	AX
3D01	RETF		;'start program
3D02turboret	ES:		;return point from program
3D03	MOV	AL,errio	;error ?
3D06	MOV	errio,AL
3D09	ES:	
3D0A	MOV	AX,errpos2	;get error position
3D0D	MOV	errpos2,AX
3D10	MOV	AX,#$FFFF	;flag
3D13	JMP	kmeminit	;"reinit
3D16kclrtxt	MOV	BX,txbeg	;Clear text
3D1A	MOV	txend,BX	;text beg -> text end
3D1E	MOV.B	txchg,#$00	;text not changed
3D23	MOV.B	mainflg,#$00	;work file
3D28knocode	MOV.B	txcomp,#$00	;text not compiled
3D2D	RET		;"
3D2Ekquit	CALL	ksvchng	;Q:Quit - save changes
3D31	CALL	xcrtexit	;CrtExit
3D34	MOV	AH,#$4C	;end of process
3D36	JMP	dos	;"return to MS-DOS
3D39kgetfn	CMP.B	workpn,#$00	;Get current file name
3D3E	JNZ	kgf2	;:work file
3D40	CMP.B	mainpn,#$00	;main file ?
3D45	JNZ	kgfmain	;:yes
3D47	CALL	kwork	;set work file name
3D4A	JMP.b	kgf2	;'
3D4Ckgfmain	MOV	SI,#mainpn	;main -> work file name
3D4F	MOV	DI,#workpn
3D52	CALL	fncopy
3D55	MOV.B	mainflg,#$FF	;flag: main file
3D5A	CALL	kgetfn	;get filename
3D5Dkgf2	CMP.B	mainflg,#$00	;main file ?
3D62	JZ	kgfret	;:no
3D64	CALL	ksvnoask	;save without question
3D67	CALL	kwload	;load that file
3D6Akgfret	RET		;"
3D6Bkcmpfn	MOV	SI,#workpn	;main = work file ?
3D6E	MOV	DI,#mainpn
3D71kcmpl	MOV.B	AL,[SI]	;get char
3D73	CMP.B	AL,[DI]	;compare it
3D75	JNZ	kcmpnoeq	;:not equal
3D77	OR.B	AL,AL	;end ?
3D79	JZ	kcmpret	;:yes
3D7B	INC	SI	;next char
3D7C	INC	DI
3D7D	JMP	kcmpl	;'continue
3D7Fkcmpnoeq	MOV	AL,#$01	;set flag: false
3D81kcmpret	RET		;"
3D82kreaderr	MOV	AX,#txstrt	;Read error message file
3D85	MOV	txbeg,AX	;set text beg
3D88	MOV	vnewfil,#flesc	;set error vectors
3D8E	MOV	vfilbig,#flbig
3D94	MOV	SI,#errpath	;ptr to pathname
3D97	MOV	DI,#scrpn	;scratch pathname
3D9A	PUSH	DI	;save ptr
3D9B	PUSH	DS	;DS -> ES
3D9C	POP	ES
3D9D	PUSH	CS	;CS -> DS
3D9E	POP	DS
3D9F	CALL	fncopy1	;copy filename
3DA2	PUSH	ES	;ES -> DS
3DA3	POP	DS
3DA4	POP	SI	;restore ptr
3DA5	CALL	kwload2	;load file
3DA8	MOV	BX,txend	;store its end position
3DAC	MOV.B	[BX],#$1A	;store ^Z at the end
3DAF	INC	BX	;next char
3DB0	MOV	txbeg,BX	;-> new text beg
3DB4	RET		;"
3DB5kwstrsi	PUSH	BX	;write string [SI]
3DB6	MOV	BX,#prpnret	;no change
3DB9	JMP.b	prpn2	;'
3DBBprintpn	PUSH	BX	;write pathname: save BX
3DBC	MOV	BX,#upcase	;vector: UpCase
3DBFprpn2	CLD	
3DC0	LODS.B		;get char
3DC1	OR.B	AL,AL	;end ?
3DC3	JZ	prpne	;:no
3DC5	CALL	BX	;modify char
3DC7	CALL	conput	;write it
3DCA	JMP	prpn2	;'continue
3DCCprpne	POP	BX	;restore
3DCDprpnret	RET		;"
3DCEknum1	XOR	CX,CX	;write number - unformatted
3DD0	CALL	knum2	;do it
3DD3	RET		;"
3DD4knumax	MOV	CX,#$0005	;write number - 5 digits
3DD7	XOR	DX,DX	;clear hi word
3DD9	JMP.b	knum2	;'
3DDBknum2	XOR	DX,DX	;write number DX:BX
3DDDknum	PUSH	SI	;save regs
3DDE	PUSH	DI
3DDF	PUSH	ES
3DE0	PUSH	DS	;DS -> ES
3DE1	POP	ES
3DE2	PUSH	CS	;CS -> DS
3DE3	POP	DS
3DE4	MOV	DI,#knumbuf	;dest buffer
3DE7	MOV	BX,AX	;number to write
3DE9	PUSH	CX	;save field size
3DEA	CLD	
3DEB	XOR	CX,CX	;format flag (leading zeroes)
3DED	MOV	SI,#kndectab	;ptr decimal table
3DF0	MOV	AH,#$07	;7 digits
3DF2kndig	XOR.B	AL,AL	;clear digit
3DF4kndiglp	INC.B	AL	;count up
3DF6	SUB	BX,[SI]	;do successive subtraction
3DF8	SBB	DX,[SI]$02
3DFB	JNB	kndiglp	;:continue
3DFD	ADD	BX,[SI]	;restore number
3DFF	ADC	DX,[SI]$02
3E02	ADD	SI,#$04	;next table entry
3E05	DEC.B	AL	;restore digit
3E07	JNZ	knnot0	;:not zero
3E09	OR	CX,CX	;test flag
3E0B	JZ	knnoput
3E0Dknnot0	ADD	AL,#$30	;convert to ASCII
3E0F	STOS.B		;store in dest buffer
3E10	INC	CX	;set flag
3E11knnoput	DEC.B	AH	;another digit ?
3E13	JNZ	kndig	;:yes
3E15	OR	CX,CX	;digits done ?
3E17	JNZ	knnot00	;:yes
3E19	MOV	AL,#$30	;put a 0
3E1B	STOS.B	
3E1C	INC	CX	;digit count
3E1Dknnot00	XOR	AX,AX	;write a zero at the end
3E1F	STOS.B	
3E20	POP	AX	;restore field size
3E21	PUSH	ES	;ES -> DS
3E22	POP	DS
3E23	SUB	AX,CX	;fill up with spaces ?
3E25	JBE	knnopad	;:no
3E27	INC	CX	;space count
3E28	DEC	DI
3E29	MOV	SI,DI	;make space in buffer
3E2B	ADD	DI,AX
3E2D	STD	
3E2E	REPZ		;move it up
3E2F	MOVS.B	
3E30	MOV	CX,AX	;now fill with spaces
3E32	MOV	AL,#$20
3E34	REPZ	
3E35	STOS.B	
3E36knnopad	MOV	SI,#knumbuf	;buffer ptr
3E39	CALL	kwstrsi	;write string
3E3C	POP	ES	;restore regs
3E3D	POP	DI
3E3E	POP	SI
3E3F	RET		;"
3E40kndectab	W	$4240,$000F	;1000000 decimal table
3E44	W	$86A0,$0001	; 100000
3E48	W	$2710,$0000	;  10000
3E4C	W	$03E8,$0000	;   1000
3E50	W	$0064,$0000	;    100
3E54	W	$000A,$0000	;     10
3E58	W	$0001,$0000	;"      1
3E5Ckparse	MOV	CX,#$000F	;parse filename: no wildcards allowed
3E5Fkparse2	MOV	DI,#scrpn	;dest: scratch file name
3E62	MOV	AX,[BX]	;get 2 chars: drive spec
3E64	CALL	upcase	;UpCase
3E67	CMP	AL,#$20	;control char ?
3E69	JB	kpdefdrv	;:yes
3E6B	CMP.B	AH,#$3A	;: ?
3E6E	JNZ	kpdefdrv	;:no
3E70	INC	BX	;next char
3E71	INC	BX
3E72	JMP.b	kpdrv	;'set drive
3E74kpdefdrv	MOV	AH,#$19	;get default drive
3E76	CALL	dos
3E79	ADD	AL,#$41	;-> ASCII
3E7B	MOV	AH,#$3A
3E7Dkpdrv	MOV	[DI],AX	;store drive spec
3E7F	INC	DI
3E80	INC	DI
3E81	OR.B	CH,CH	;test path ?
3E83	JNZ	kpendpn2	;:no
3E85	CMP.B	[BX],#$5C	;\ ?
3E88	JZ	kpendpn2	;:yes
3E8A	MOV.B	[DI],#$5C	;store \
3E8D	INC	DI
3E8E	MOV	AH,#$47	;get current path
3E90	MOV.B	DL,AL	;drive number
3E92	SUB.B	DL,#$40
3E95	MOV	SI,DI	;destination
3E97	CALL	dos	;do it
3E9A	JB	kpendpn2	;:error
3E9C	CMP.B	[DI],#$00	;search end of path
3E9F	JZ	kpendpn2	;:found
3EA1kpendsr	MOV.B	AL,[DI]	;get char
3EA3	OR.B	AL,AL	;end ?
3EA5	JZ	kpendpn	;:found
3EA7	INC	DI	;next char
3EA8	CMP	DI,#scrpnend	;end of buffer ?
3EAC	JB	kpendsr	;:not yet
3EAE	JMP.b	kpend	;'end it
3EB0kpendpn	MOV.B	[DI],#$5C	;store \
3EB3	INC	DI	;next char
3EB4	CMP	DI,#scrpnend	;end of buffer ?
	;:yes
3EB8	JZ	kpend
3EBAkpendpn2	XOR.B	CH,CH	;clear flag
3EBC	PUSH	CS	;CS -> ES
3EBD	POP	ES
3EBE	CLD	
3EBFkpchklp	MOV.B	AL,[BX]	;get char
3EC1	CMP	AL,#$20	;control / space ?
3EC3	JBE	kpend	;:yes
3EC5	PUSH	CX	;save cnt, dest ptr
3EC6	PUSH	DI
3EC7	MOV	DI,#kpinval	;test: illegal char ?
3ECA	REPNZ		;CL is count for this search
3ECB	SCAS.B		;search char in table
3ECC	POP	DI	;restore
3ECD	POP	CX
3ECE	JZ	kpend	;found: end it
3ED0	INC	BX	;next char
3ED1	MOV.B	[DI],AL	;store it
3ED3	INC	DI	;next char in dest
3ED4	CMP	DI,#scrpnend	;end of buffer ?
3ED8	JB	kpchklp	;:no
3EDAkpend	MOV.B	[DI],#$00	;mark end
3EDD	RET		;"
3EDEkpinval	B	$22,"+,/;<=>[]{|}*?"	;"table of illegal chars
3EEDkpasext	MOV	SI,#extpas	;pointer: .PAS
3EF0kextdef	PUSH	SI	;save extension ptr
3EF1	CALL	kparse	;parse filename
3EF4	POP	SI	;restore ext ptr
3EF5	MOV	DL,#$01	;only set if no ext
3EF7	JMP.b	kx1	;'do it
3EF9kext2	MOV	DL,#$02
3EFB	JMP.b	kx1	;'
3EFDkext	XOR.B	DL,DL	;set file extension
3EFFkx1	MOV	DI,#insline2	;ptr scratch file name
3F02	XOR	CX,CX	;clr dot pos
3F04kxsrdot	MOV.B	AL,[DI]	;get char
3F06	OR.B	AL,AL	;end ?
3F08	JZ	kxend	;:yes
3F0A	INC	DI	;next one
3F0B	CMP.B	DL,#$02	;search dot ?
3F0E	JZ	kxsrdot	;:no
3F10	CMP	AL,#$2E
3F12	JNZ	kxnodot	;:no
3F14	MOV	CX,DI	;store pos of dot
3F16kxnodot	CMP	AL,#$5C	;\ ?
3F18	JNZ	kxsrdot	;:no
3F1A	XOR	CX,CX	;clear dot pos
3F1C	JMP	kxsrdot	;'continue
3F1Ekxend	OR	CX,CX	;test dot pos
3F20	JZ	kxnodotf	;:not set
3F22	OR.B	DL,DL	;set extension ?
3F24	JNZ	kxret	;:no
3F26	MOV	DI,CX	;dot position
3F28	DEC	DI	;go back
3F29kxnodotf	CS:		;set extension
3F2A	MOV.B	CL,[SI]	;length of extension
3F2C	XOR.B	CH,CH	;-> count
3F2E	JCXZ	kxexte	;:nothing to do
3F30kxextl	CMP	DI,#scrpnend	;buffer end ?
3F34	JZ	kxexte	;:yes
3F36	INC	SI	;next pos
3F37	CS:	
3F38	MOV.B	AL,[SI]	;get ext char
3F3A	MOV.B	[DI],AL	;store it
3F3C	INC	DI	;next one
3F3D	LOOP	kxextl	;:another char
3F3Fkxexte	MOV.B	[DI],#$00	;mark end
3F42kxret	RET		;"
3F43fnscdi	MOV	SI,#scrpn	;copy scratch -> [DI]
3F46	JMP.b	fncopy	;'
3F48fnsisc	MOV	DI,#scrpn	;copy [SI] -> scratch
3F4Bfncopy	PUSH	DS	;DS -> ES
3F4C	POP	ES
3F4Dfncopy1	MOV	CX,#$0020	;copy 64 bytes
3F50	CLD	
3F51	REPZ	
3F52	MOVS		;do it
3F53	RET		;"
3F54kwscrpn	MOV	SI,#scrpn	;write scratch file name
3F57	JMP	printpn	;"
3F5Akwworkpn	MOV	SI,#workpn	;write work file name
3F5D	JMP	printpn	;"
3F60kdworkfn	MOV	SI,#workpn	;Display work file name
3F63	PUSH	DS	;DS -> ES
3F64	POP	ES
3F65	CLD	
3F66	LODS.B		;get char
3F67	CALL	upcase	;UpCase
3F6A	CALL	conput	;write it (drive)
3F6D	LODS.B		;get char
3F6E	CALL	conput	;write it (:)
3F71	MOV	DI,SI	;search end of filename
3F73	XOR.B	AL,AL
3F75	MOV	CX,#$FFFF	;any length
3F78	CLD	
3F79	REPNZ	
3F7A	SCAS.B		;search it
3F7B	STD		;backward search !
3F7C	MOV	AL,#$5C	;now search \
3F7E	MOV	CX,#$FFFF	;any length
3F81	DEC	DI
3F82	REPNZ	
3F83	SCAS.B		;do it
3F84	MOV	SI,DI	;position of file name
3F86	INC	SI	;without dir path
3F87	INC	SI
3F88	JMP	printpn	;"write it
3F8Bprintatt	PUSH	BP	;Print string with highlighting
3F8C	MOV	BP,SP	;string: inline, 0=end
3F8E	XCHG	BX,[BP]$02	;get return addr
3F91	PUSH	AX	;save
3F92	PUSHF	
3F93pralp	CS:		;get char
3F94	MOV.B	AL,[BX]
3F96	INC	BX	;go to next
3F97	OR.B	AL,AL	;end ?
3F99	JZ	praend	;:yes
3F9B	CMP	AL,#$80	;highlighted ?
3F9D	JNB	prahi	;:yes
3F9F	CALL	klowvid	;LowVideo
3FA2	JMP.b	pralo	;'write it
3FA4prahi	CALL	knrmvid	;NormVideo
3FA7	AND	AL,#$7F	;mask out bit 7
3FA9	JZ	pralp	;zero: end
3FABpralo	CALL	conput	;write it
3FAE	JMP	pralp	;'next char
3FB0praend	POPF		;restore
3FB1	POP	AX
3FB2	XCHG	BX,[BP]$02	;restore ret
3FB5	POP	BP
3FB6	RET		;"
3FB7knrmvid	CMP.B	curatt,#$00	;NormVideo
3FBC	JZ	knrmret	;already set: ret
3FBE	MOV.B	curatt,#$00	;set flag
3FC3	JMP	xnormvid	;'do it
3FC6knrmret	RET		;"
3FC7klowvid	CMP.B	curatt,#$01	;LowVideo
3FCC	JZ	knrmret	;:already set
3FCE	MOV.B	curatt,#$01	;set it
3FD3	JMP	xlowvid	;"
3FD6vidattr3	CMP.B	curatt,#$03	;Attribute #3
3FDB	JZ	knrmret	;:already set
3FDD	MOV.B	curatt,#$03	;set it
3FE2	PUSH	AX	;save
3FE3	MOV	AL,att3	;set that attribute
3FE6	MOV	attcur,AL
3FE9	POP	AX	;restore
3FEA	RET		;"
3FEBvidattr2	CMP.B	curatt,#$02	;Attribute #2
3FF0	JZ	knrmret	;:already set
3FF2	MOV.B	curatt,#$02	;set it
3FF7	PUSH	AX	;save
3FF8	MOV	AL,att2	;set that attribute
3FFB	MOV	attcur,AL
3FFE	POP	AX	;restore
3FFF	RET		;"
4000movebk	MOV	SI,BX	;Block transfer [BX]->[DX]
4002	MOV	DI,DX	;forward = delete
4004	PUSH	DS	;DS -> ES
4005	POP	ES
4006	CLD	
4007	REPZ		;CX=count
4008	MOVS.B		;do it
4009	MOV	BX,SI	;point to block end
400B	MOV	DX,DI
400D	RET		;"
400Emovebkb	MOV	SI,BX	;Block transfer [BX]->[DX]
4010	MOV	DI,DX	;backward = insert
4012	PUSH	DS	;DS -> ES
4013	POP	ES	;BX,DX point to block END !
4014	STD	
4015	REPZ	
4016	MOVS.B		;do it
4017	CLD		;reset dir flag
4018	MOV	BX,SI	;point to block beg
401A	MOV	DX,DI
401C	RET		;"
401Dinited	XOR	AX,AX	;Init editor vars
401F	MOV	editflg,AL
4022	MOV	DI,#srend	;390..3B0:=0
4025	MOV	CX,#$0021
4028	PUSH	DS	;DS -> ES
4029	POP	ES
402A	CLD		;fill
402B	REPZ	
402C	STOS.B	
402D	INC	AX	;3B1..3B2:=1
402E	MOV	DI,#oldlen	;old len, redisplay from
4031	MOV	CX,#$0002
4034	REPZ	
4035	STOS.B	
4036	INC	AX	;Words 3BA..3BD:=2
4037	MOV	DI,#bkbegl	;block pos in buffer
403A	MOV	CX,#$0002
403D	REPZ	
403E	STOS	
403F	MOV	AX,#$FFFF	;3B3..3B8:=FF
4042	MOV	DI,#overflg	;set flags:
4045	MOV	CX,#$0006	;insert, indent, display
4048	REPZ		;redisplay
4049	STOS.B	
404A	MOV	AX,#line	;Words 3BE..3C8:=046C
404D	MOV	DI,#edpos	;current pos, pos in line buffer
4050	MOV	CX,#$0006	;pos FIFO = beg of line buffer
4053	REPZ	
4054	STOS	
4055	MOV	AL,#$00	;3CA..45F:=0
4057	MOV	DI,#cmdbuf	;command entry buffer, search,
405A	MOV	CX,#$0096	;replace, option, filename
405D	REPZ	
405E	STOS.B	
405F	MOV.B	cmdbuf,#$03	;command buf:  3 chars
4064	MOV.B	srword,#$1E	;search word: 30 chars
4069	MOV.B	srrepl,#$1E	;replce word: 30 chars
406E	MOV.B	stopt,#$0A	;option word: 10 chars
4073	MOV.B	fnbuf,#$40	;file name:   64 chars
4078	MOV.B	fnbufend,#$1A	;end file name buffer
407D	MOV	lineend,#$0A0D	;end line input buffer
4083	MOV	AL,#$00	;no flicker
4085	MOV	DX,#$B000	;mono screen segment
4088	CMP.B	scrmod,#$07	;mode = 7 ?
408D	JZ	inited1	;yes: mono
408F	CS:	
4090	MOV	AL,scrflick	;get flicker flag
4093	MOV	DH,#$B8	;set segment
4095inited1	MOV	scrbad,AL	;store flicker flag
4098	MOV	scrseg,DX	;store segment
409C	RET		;"
409Dclred	MOV	bkbeg,BX	;Clear editor vars
40A1	MOV	bkend,BX	;set to beg of text = BX
40A5	MOV	edpos,BX
40A9	MOV	posfifo,BX
40AD	MOV	qppos,BX
40B1	MOV	disbeg,BX
40B5	RET		;"
40B6ekd	CALL	eflush	;flush changes
40B9	CS:	
40BA	MOV.B	DL,txwiny2	;bottom-1
40BE	DEC.B	DL
40C0	MOV	DH,#$00
40C2	CALL	setcpos	;set cursor pos
40C5	CALL	knrmvid	;NormVideo
40C8	DEC	txend	;end of text
40CC	MOV	BX,txend
40D0	MOV.B	[BX],#$1A	;store ^Z at the end
40D3	JMP	kmainlp	;"return to main menu
40D6editor	CALL	kgetfn	;E:Editor - get file name
40D9	MOV	BX,#$FFFF	;position flag
40DCeditor2	PUSH	BX	;save pos
40DD	MOV	BX,txend	;end of text
40E1	MOV	[BX],#$0A0D	;store CR,LF there
40E5	INC	txend
40E9	MOV.B	statobs,#$00	;status line obsolete
40EE	MOV.B	dislin,#$01	;redisplay all
40F3	MOV	sepptr,#eseptab	;pos of word separator tab
40F9	CALL	knrmvid	;NormVideo
40FC	CALL	xclrscr	;ClrScr
40FF	POP	BX	;relative text pos
4100	ADD	BX,txbeg	;+text beg+1
4104	INC	BX
4105	CALL	efsetpos	;set new pos
4108edmain	CALL	eredispl	;redisplay
410B	MOV.B	CL,statera	;clear status line
410F	OR.B	CL,CL	;anything to erase ?
4111	JZ	ednoera	;:no
4113	MOV	BX,#$0000	;cursor pos: home
4116	CALL	esetcur
4119	CALL	esetlow	;LowVideo
411C	MOV	AL,#$20	;space
411Eedera	CALL	ewritch	;write char
4121	DEC.B	CL	;another ?
4123	JNZ	edera	;:yes
4125	MOV.B	statera,CL	;clear erase flag
4129ednoera	CALL	estat	;display status line
412C	CALL	edproc	;get command
412F	JNB	edchg	;:no command - enter char
4131	JZ	edmain	;:not found
4133	CMP.B	DH,#$7F	;MSB vector = 1 ?
4136	JB	ednochg	;:no
4138	MOV.B	txchg,#$FF	;set flag: text changed
413D	MOV.B	txcomp,#$00	;code invalid
4142	AND.B	DH,#$7F	;mask vector
4145ednochg	MOV	BX,#edmain	;store return addr
4148	PUSH	BX	;-> main loop
4149	PUSH	DX
414A	MOV	BX,#pfifosrc	;do position FIFO
414D	MOV	DX,#pfifodst
4150	MOV	CX,#$0008	;8 bytes
4153	JMP	movebkb	;'move back, jump to command
4156eprefix	CALL	eddiscmd	;^P:Control char prefix - display
4159	CALL	keyget	;get char
415C	JMP.b	edput	;'enter this char
415Eedchg	MOV	txchg,AL	;flag: text changed
4161	MOV.B	txcomp,#$00	;code invalid
4166edput	MOV	BX,lnpos	;pos in line
416A	CMP	BX,#lineend0	;line full ?
416E	JNB	edmain	;yes: ignore char
4170	CMP.B	overflg,#$00	;overwrite ?
4175	JZ	edover	;:yes
4177	PUSH	AX	;save it
4178	CALL	einsch	;make space for char
417B	POP	AX	;restore it
417Cedover	MOV.B	[BX],AL	;store char
417E	INC	BX	;cursor right
417F	PUSH	BX
4180	CALL	eredlin	;redisplay line
4183	POP	BX
4184	MOV	lnpos,BX	;new pos in line buffer
4188	CALL	erepos	;reposition in line
418B	JMP	edmain	;"main loop
418Eedproc	CALL	keyget	;Get command: get key
4191	CMP	AL,#$7F	;Delete ?
4193	JZ	edpdel	;:yes
4195	CMP	AL,#$20	;control char ?
4197	JNB	edpret	;no: no command
4199edpdel	MOV	BX,#cmdbuf	;pointer to cmd buf
419C	MOV.B	[BX],#$01	;store length
419F	INC	BX
41A0	MOV.B	[BX],AL	;store char
41A2edploop	PUSH	BX	;save pos in buf
41A3	MOV	BX,#cmdbuf	;ptr cmd buf
41A6	MOV	SI,#ecmd1	;ptr first cmd table
41A9	MOV	CH,#$FF	;must be equal
41AB	CALL	edsrcmd	;search in table
41AE	POP	BX	;restore pos
41AF	OR.B	AL,AL	;test result
41B1	JNZ	edpfnd	;:found
41B3	PUSH	BX	;save again
41B4	MOV	BX,#cmdbuf	;ptr cmd buf
41B7	MOV	SI,#ecmd2	;ptr second cmd table
41BA	MOV	CH,#$1F	;second char without ctrl ok
41BC	CALL	edsrcmd	;search in table
41BF	POP	BX	;restore pos
41C0	OR.B	AL,AL	;test result
41C2	STC	
41C3	JZ	edpret	;:not found
41C5edpfnd	DEC.B	AL
41C7	JZ	edpcont	;:need another key
41C9	MOV	BX,#ejmptab	;ptr jump table
41CC	ADD	BX,CX	;+2*cmd number
41CE	ADD	BX,CX
41D0	CS:	
41D1	MOV	DX,[BX]	;get jump addr
41D3	STC		;ok
41D4edpret	RET		;'
41D5edpcont	CALL	eddiscmd	;display command char
41D8	PUSHF		;save stat
41D9	CALL	keyget	;get key
41DC	INC.B	cmdbuf	;inc lenght cmd buf
41E0	INC	BX	;next pos
41E1	MOV.B	[BX],AL	;store char
41E3	POPF		;restore stat: function key ?
41E4	JNZ	edploop	;:continue
41E6	CALL	eddiscmd	;display
41E9	JMP	edploop	;"try it again
41EBeddiscmd	CALL	ekbdstat	;display command sequence
41EE	JNZ	edpret	;late - ret
41F0	PUSH	BX	;save pos
41F1	XOR	BX,BX	;clear char count
41F3	MOV.B	statera,BL	;number of chars to erase
41F7	CALL	esetcur	;set position: home
41FA	MOV	BX,#cmdbuf	;ptr cmd buf
41FD	MOV.B	AL,[BX]	;get cmd length
41FFeddislp	PUSH	AX	;save len
4200	INC	BX	;next char
4201	MOV.B	AL,[BX]	;get char
4203	ADD.B	statera,#$02	;2 chars to erase
4208	CALL	edcntput	;put char
420B	POP	AX	;restore len
420C	DEC.B	AL	;another char ?
420E	JNZ	eddislp	;:yes
4210	POP	BX	;restore
4211	RET		;"
4212edcntput	PUSH	AX	;Display control code - save char
4213	CALL	esetnrm	;set attribute
4216	POP	AX	;restore char
4217	CMP	AL,#$20	;control ?
4219	JB	edcntl	;:yes
421B	JMP	ewritch	;'write char
421Eedcntl	PUSH	AX	;save char
421F	PUSH	AX
4220	MOV	AL,#$5E	;write ^
4222	CALL	ewritch
4225	POP	AX	;restore char
4226	ADD	AL,#$40	;-> normal char
4228	CALL	ewritch	;write it
422B	POP	AX	;restore char
422C	RET		;"
422Dedsrcmd	MOV	CL,#$FF	;Search command in table
422F	PUSH	CX	;save cmd comparison mask
4230	PUSH	BX	;command buf ptr
4231edsclp	POP	BX	;restore
4232	POP	CX
4233	CS:	
4234	MOV.B	AL,[SI]	;get char from table
4236	INC	SI	;next pos
4237	OR.B	AL,AL	;end of table ?
4239	JZ	edscret	;:yes
423B	INC.B	CL	;command number
423D	PUSH	CX	;save
423E	PUSH	BX
423F	MOV.B	CL,[BX]	;get command len
4241	INC	BX	;go to first char
4242	SUB.B	AL,CL	;>= table len ?
4244	JNB	edsc1	;:yes
4246	ADD.B	CL,AL	;skip this entry
4248	JMP.b	edscnxt1	;'try next one
424Aedsc1	LAHF		;save flags
424B	PUSH	AX	;save table entry length
424Cedsccmp	CS:	
424D	MOV.B	AL,[SI]	;char from table
424F	SUB.B	AL,[BX]	;compare them
4251	AND.B	AL,CH	;mask difference
4253	JNZ	edscnext	;:not equal - next one
4255	INC	SI	;next char
4256	INC	BX
4257	DEC.B	CL	;= length of cmd ?
4259	JNZ	edsccmp	;no: compare
425B	POP	AX	;restore flag, table entry length
425C	SAHF	
425D	POP	BX	;restore
425E	POP	CX
425F	MOV	CH,#$00	;mode: none
4261	MOV	AL,#$FF	;found
4263	JZ	edscret	;:found
4265	MOV	AL,#$01	;need another char
4267edscret	RET		;'
4268edscnext	POP	AX	;restore length
4269	ADD.B	AL,CL	;skip entry
426B	MOV.B	CL,AL
426Dedscnxt1	MOV	CH,#$00	;clr hi
426F	ADD	SI,CX	;add to ptr
4271	JMP	edsclp	;"try next one
4273estat	CALL	ekbdstat	;Display status line: Get KBD stat
4276	JNZ	edscret	;late: ret
4278	CALL	klowvid	;LowVideo
427B	CMP.B	statobs,#$FF	;obsolete ?
4280	JZ	estnrm	;no:just display pos
4282	MOV.B	statobs,#$FF	;clear flag
4287	MOV	BX,#$0000	;screen position
428A	MOV	oldpos,BX	;remember cursor pos
428E	MOV.B	edcol,BL	;column
4292	CALL	esetcur	;set cursor pos
4295	CALL	eclrlin	;clear line
4298	CS:	
4299	CMP.B	txwinx2,#$38	;screen width sufficient ?
429E	JB	estshrt	;:no
42A0	MOV	BX,#$2A00	;set cursor pos
42A3	CALL	esetcur
42A6	CALL	kdworkfn	;display filename
42A9estshrt	MOV	BX,#$0600	;cursor pos
42AC	CALL	ewritpos	;put string
42AF	B	"Line ",$00
42B5	MOV	BX,#$1000	;cursor pos
42B8	CALL	ewritpos	;put string
42BB	B	"Col ",$00
42C0	MOV	BX,#$1800	;cursor pos
42C3	CMP.B	overflg,#$00	;Overwrite ?
42C8	JZ	estover	;:yes
42CA	CALL	ewritpos	;put string
42CD	B	"Insert    ",$00
42D8	JMP.b	estins	;'
42DA	NOP	
42DBestover	CALL	ewritpos	;put string
42DE	B	"Overwrite ",$00
42E9estins	CMP.B	indntflg,#$00	;Indent ?
42EE	JZ	estnrm	;:no
42F0	CALL	ewrits	;put string
42F3	B	"Indent",$00
42FAestnrm	MOV	AL,horscr	;calc column
42FD	ADD.B	AL,phcol
4301	INC.B	AL
4303	CMP.B	AL,edcol	;= old col ?
4307	JZ	estnocol
4309	MOV	edcol,AL	;set that column
430C	MOV	BX,#$1400	;cursor pos
430F	CALL	esetcur	;set it
4312	CALL	klowvid	;LowVideo
4315	MOV.B	BL,AL	;number -> BX
4317	MOV	BH,#$00	;clr hi
4319	MOV	AL,#$03	;3 chars
431B	CALL	ednum	;display number
431Eestnocol	MOV	BX,edpos	;current pos = old pos ?
4322	CMP	BX,oldpos
4326	JNZ	estrow	;no: display line number
4328	JMP	eposcur	;'restore cursor pos
432Bestrow	CALL	eposcur	;restore cursor pos
432E	CALL	ekbdstat	;Get KBD stat
4331	JNZ	estend
4333	MOV	DI,txbeg	;beg of text
4337	MOV	CX,edpos
433B	MOV	DX,#$0001	;line number
433E	SUB	CX,DI	;calc count
4340	JZ	estrow2	;:done
4342estcnt	CLD		;forward search
4343	PUSH	DS	;DS -> ES
4344	POP	ES
4345estlf	MOV	AL,#$0A	;search LF
4347	REPNZ	
4348	SCAS.B	
4349	JNZ	estrow2	;:not found, done
434B	INC	DX	;count it
434C	OR.B	DL,DL	;256 lines counted ?
434E	JNZ	estlf	;:no, continue
4350	CALL	ekbdstat	;Get KBD stat
4353	JZ	estcnt	;:nothing entered
4355	JMP.b	estend
4357estrow2	MOV	BX,#$0B00	;cursor pos
435A	PUSH	DX	;save line number
435B	CALL	esetcur	;set cursor pos
435E	CALL	klowvid	;LowVideo
4361	POP	BX	;restore number
4362	MOV	AL,#$05	;5 digits
4364	CALL	ednum	;write it
4367	MOV	BX,edpos	;current pos -> old pos
436B	MOV	oldpos,BX
436Festend	JMP	eposcur	;"restore cursor pos
4372ednum	PUSH	AX	;Write number: save field length
4373	MOV	CH,#$00	;clear flag
4375	CALL	edcvt	;convert number
4378	POP	AX	;restore length
4379	ADD.B	AL,CH	;counter
437B	JZ	ednret	;:done
	;counter
437D	MOV.B	CH,AL
437F	MOV	AL,#$20	;pad with spaces
4381ednpad	CALL	ewritch	;put it
4384	DEC.B	CH	;another ?
4386	JNZ	ednpad	;:yes
4388ednret	RET		;"
4389edcvt	CMP	BX,#$00	;number -> decimal
438C	MOV	AL,#$30
438E	JZ	edcvno0	;0: store a 0
4390	MOV	DX,#$2710	;digit 10000
4393	CALL	edcvdig
4396	MOV	DX,#$03E8	;digit  1000
4399	CALL	edcvdig
439C	MOV	DX,#$0064	;digit   100
439F	CALL	edcvdig
43A2	MOV	DX,#$000A	;digit    10
43A5	CALL	edcvdig
43A8	MOV	DX,#$0001	;digit     1
43ABedcvdig	XOR.B	AL,AL	;clear digit
43ADedcvdlp	SUB	BX,DX	;do successive subtraction
43AF	JB	edcvput	;:done
43B1	INC.B	AL	;count digit
43B3	JMP	edcvdlp	;'
43B5edcvput	ADD	BX,DX	;restore number
43B7	ADD	AL,#$30	;convert to ASCII
43B9	CMP	AL,#$30	;0 ?
43BB	JNZ	edcvno0	;:no
43BD	OR.B	CH,CH	;is it a leading zero ?
43BF	JZ	ednret
43C1edcvno0	DEC.B	CH	;set flag
43C3	JMP	ewritch	;"write char
43C6edreadst	CALL	prints	;Input from status line
43C9	B	": ",$00
43CC	MOV	BX,DX	;destination ptr
43CE	MOV	SI,DX
43D0	INC	BX	;point to string
43D1	MOV.B	DH,[BX]	;get old length
43D3	MOV.B	[BX],#$00	;clr old length
43D6	INC	BX	;go to string
43D7erloop	MOV.B	disflg,#$00	;flag: editing stat line
43DC	PUSH	DX	;save regs
43DD	PUSH	BX
43DE	PUSH	SI
43DF	CALL	edproc	;process key
43E2	POP	SI
43E3	POP	BX
43E4	POP	DX
43E5	MOV.B	disflg,#$FF	;restore flag
43EA	JNB	erput	;no command: put char
43EC	JNZ	ercr	;:valid command
43EE	MOV	AL,cmdbuf1	;get command
43F1	CALL	etstint	;test for interrupt
43F4	JMP	erloop	;'loop back
43F6ercr	MOV.B	AL,CL	;command code
43F8	CMP	AL,#$00	;CR ?
43FA	JNZ	errt	;:no
43FC	MOV.B	[BX],#$1A	;store ^Z at the end
43FF	RET		;'return
4400errt	CMP	AL,#$03	;Character right ?
4402	JNZ	errecall	;:no
4404	MOV.B	AL,[SI]$01	;get length
4407	CMP.B	AL,DH	;= pos ?
4409	JNB	erloop
440B	INC.B	[SI]$01	;go right
440E	JMP.b	errest	;'get char from old value
4410errecall	CMP	AL,#$05	;word right ?
4412	JNZ	erclr	;:no
4414errec1	MOV.B	AL,[SI]$01	;length = old len ?
4417	CMP.B	AL,DH
4419	JZ	erloop	;yes: loop
441B	MOV.B	AL,[BX]	;get char
441D	CALL	edcntput	;write it
4420	INC	BX	;next one
4421	INC.B	[SI]$01	;inc len
4424	JMP	errec1	;'until end
4426erclr	CMP	AL,#$04	;Word left ?
4428	JNZ	erprefix	;:no
442Aerclrl	CALL	erdelc	;delete char
442D	JNZ	erclrl	;:ok, continue
442F	JMP	erloop	;'end reached, loop
4431erprefix	CMP	AL,#$2D	;Control char prefix ?
4433	JNZ	erdel	;:no
4435	CALL	keyget	;get a key
4438	JMP.b	erput	;'put it
443Aerdel	CMP	AL,#$1B	;Test delete codes
443C	JZ	erdel1	;:delete left
443E	CMP	AL,#$1C
4440	JZ	erdel1	;:del left
4442	CMP	AL,#$01
4444	JZ	erdel1	;:char left
4446	CMP	AL,#$02
4448	JNZ	erinv	;:no delete
444Aerdel1	CALL	erdelc	;delete char
444D	JMP	erloop	;'loop back
444Ferinv	CMP.B	cmdbuf1,#$12	;word right ?
4454	JZ	errec1	;:yes
4456	JMP	erloop	;'loop back
4459erput	MOV.B	DL,AL	;save char
445B	MOV.B	AL,[SI]$01	;current len
445E	CMP.B	AL,[SI]	;< max len ?
4460	JB	erput2	;:ok
4462	JMP	erloop	;'loop back
4465erput2	INC.B	[SI]$01	;inc length
4468	MOV.B	[BX],DL	;store char
446Aerrest	MOV.B	AL,[BX]	;get char
446C	INC	BX	;go to next
446D	CALL	edcntput	;display it
4470	MOV.B	AL,[SI]$01	;get current len
4473	CMP.B	AL,DH	;= old len ?
4475	JNB	ergend	;:no
4477	JMP	erloop	;'loop back
447Aergend	MOV.B	DH,[SI]$01	;get pos
447D	JMP	erloop	;'loop back
4480erdelc	MOV.B	AL,[SI]$01	;Delete char: get len
4483	OR.B	AL,AL	;0 ?
4485	JZ	erdelret	;yes: nothing to delete
4487	DEC.B	[SI]$01	;dec length
448A	DEC	BX	;go back one char
448B	CMP.B	[BX],#$20	;was it a control char ?
448E	JNB	erdelcc	;:no
4490	CALL	erdelcc	;delete two chars
4493erdelcc	CALL	prints	;delete one char
4496	B	$08," ",$08,$00
449A	MOV	AL,#$FF	;set flag
449C	OR.B	AL,AL
449Eerdelret	RET		;"
449Fefind	MOV.B	srmode,#$00	;^QF:Find - set mode flag
44A4	CALL	eqffind	;get find word
44A7	CALL	eqfopt	;get option string
44AA	JMP.b	efnd1	;"do it
44ACeqffind	CALL	eclrstat	;Get find word: clear stat line
44AF	CALL	ewrits	;write string
44B2	B	"Find",$00
44B7	MOV	DX,#srword	;dest: find word
44BA	JMP	edreadst	;"read string
44BDeqfrepl	CALL	eclrs2	;Get repl word: clear stat line
44C0	CALL	ewrits	;write string
44C3	B	"Replace with",$00
44D0	MOV	DX,#srrepl	;dest var
44D3	JMP	edreadst	;"read string
44D6eqfopt	CALL	eclrs2	;Get Options: clear stat line
44D9	CALL	ewrits	;write string
44DC	B	"Options",$00
44E4	MOV	DX,#stopt	;dest var
44E7	CALL	edreadst	;read string
44EA	CS:	
44EB	MOV.B	BH,txwinx2	;end of screen
44EF	DEC.B	BH
44F1	MOV	BL,#$00	;beg of line
44F3	JMP	esetcur	;"set cursor pos
44F6ereplace	MOV.B	srmode,#$FF	;^QA:Search & Replace
44FB	CALL	eqffind	;get find word
44FE	CALL	eqfrepl	;get replacement word
4501	CALL	eqfopt	;get option string
4504	JMP.b	efnd1	;"do it
4506erepeat	CALL	eddiscmd	;^L:Repeat last find
4509efnd1	CALL	eflush	;write back current line
450C	CALL	esrcend	;end of line buffer
450F	INC	BX	;+1
4510	MOV	DX,lnpos	;or current pos in line
4514	CALL	emin
4517	MOV	DX,#line	;- beg of buffer
451A	SUB	BX,DX
451C	MOV	DX,edpos	;+ current pos
4520	ADD	BX,DX
4522	MOV	srpos,BX	;-> search pos
4526	MOV	srcnt,#$0000	;line count
452C	MOV	CX,txend	;text end-1
4530	DEC	CX
4531	MOV	srend,CX	;-> search end
4535	MOV	CX,txbeg	;text beg -> search beg
4539	MOV	srbeg,CX
453D	MOV	BX,#sropt1	;ptr option string
4540	MOV.B	CH,[BX]	;get length
4542	MOV.B	sropt,#$00	;clear option flag
4547	OR.B	CH,CH	;empty ?
4549	JNZ	efndcnt	;:no
454B	JMP.b	efndopte	;'no options set
454D	NOP		;Process option line
454Eefndcnt	INC	BX	;next char
454F	MOV.B	AL,[BX]	;get char
4551	CMP	AL,#$30	;valid digit ?
4553	JB	efndopt	;:no
4555	CMP	AL,#$3A	;> 9 ?
4557	JNB	efndopt	;:no digit
4559	SUB	AL,#$30	;-> number. Get line count
455B	CBW	
455C	PUSH	AX	;save digit
455D	MOV	AL,#$0A	;current count * 10
455F	IMUL	srcnt
4563	POP	DX	;+ digit
4564	ADD	AX,DX
4566	MOV	srcnt,AX	;-> line count
4569	JMP.b	efndo2	;'continue
456Befndopt	CALL	upcase	;UpCase
456E	CMP	AL,#$57	;W ?
4570	JNZ	efndu	;:no
4572	OR.B	sropt,#$01	;flag: whole words
4577efndu	CMP	AL,#$55	;U ?
4579	JNZ	efndn	;:no
457B	OR.B	sropt,#$04	;flag: ignore upper/lower
4580efndn	CMP	AL,#$4E	;N ?
4582	JNZ	efndg	;:no
4584	OR.B	sropt,#$02	;flag: replace without asking
4589efndg	CMP	AL,#$47	;G ?
458B	JNZ	efndb	;:no
458D	OR.B	sropt,#$08	;flag: global
4592efndb	CMP	AL,#$42	;B ?
4594	JNZ	efndl	;:no
4596	OR.B	sropt,#$10	;flag: backwards
459Befndl	CMP	AL,#$4C	;L ?
459D	JNZ	efndo2	;:no
459F	OR.B	sropt,#$20	;flag: search block
45A4	AND.B	sropt,#$F7	;clear global
45A9	MOV	CX,bkend	;search block, only
45AD	MOV	srend,CX	;block end -> search end
45B1	MOV	CX,bkbeg	;block beg -> search beg
45B5	MOV	srbeg,CX
45B9efndo2	DEC.B	CH	;another option char ?
45BB	JNZ	efndcnt	;:yes
45BDefndopte	CMP	srcnt,#$01	;at least one line to do
45C2	JA	efndcnok	;:ok
45C4	MOV	srcnt,#$0001
45CAefndcnok	MOV	BX,srbeg	;begin limit
45CE	MOV	AL,sropt	;option
45D1	TEST	AL,#$10	;backwards ?
45D3	JZ	efndfwd	;:no
45D5	MOV	BX,srend	;end limit
45D9efndfwd	TEST	AL,#$28	;block & global ?
45DB	JNZ	efndrep	;:no
45DD	MOV	BX,srpos	;current pos
45E1efndrep	MOV	srpos,BX	;store search pos
45E5	TEST.B	sropt,#$10	;backwards ?
45EA	JNZ	efndbkw	;:yes
45EC	CMP	BX,srend	;= search limit ?
45F0	JB	efndsrc	;:no, continue
45F2	JMP	efndexit	;'done
45F5efndbkw	DEC	BX	;go back
45F6	CMP	BX,srbeg	;= search limit ?
45FA	JNB	efndsrc	;:no
45FC	JMP	efndexit	;'end it
45FFefndsrc	MOV	DX,#srword2	;ptr searched word
4602	MOV	AL,srword1	;get length
4605	MOV.B	CH,AL
4607	TEST.B	sropt,#$10	;backwards ?
460C	JZ	efndfw2	;:no
460E	DEC.B	AL	;go to its end
4610	ADD.B	AL,DL
4612	MOV.B	DL,AL
4614	JNB	efndfw2
4616	INC.B	DH
4618efndfw2	TEST.B	sropt,#$01	;whole words ?
461D	JZ	efndall1	;:no
461F	PUSH	DX	;save
4620	PUSH	BX
4621	CALL	edbeg	;at the beginning ?
4624	MOV.B	AL,[BX]	;get char
4626	POP	BX	;restore
4627	POP	DX
4628	JB	efndall1	;:at beg
462A	CALL	edfnchar	;is it alphanum ?
462D	JB	efndpos	;:yes - continue searching
462Fefndall1	OR.B	CH,CH	;length = 0 ?
4631	JZ	efndnil	;:found
4633efndcmp	CALL	edcmp	;compare chars
4636	JNZ	efndpos	;:not the same
4638	DEC.B	CH	;another char ?
463A	JNZ	efndnch	;:yes
463Cefndnil	TEST.B	sropt,#$01	;whole words ?
4641	JZ	efndall2	;:no
4643	PUSH	BX	;save
4644	CALL	edend	;end ?
4647	MOV.B	AL,[BX]	;get char
4649	POP	BX	;restore
464A	JB	efndall2	;:at the end
464C	CALL	edfnchar	;alphanum ?
464F	JB	efndpos	;yes: not valid
4651efndall2	TEST.B	sropt,#$10	;backwards ?
4656	JNZ	efndbw2	;:yes
4658	INC	BX	;end of text ?
4659	CMP	BX,txend
465Defndbw2	CMP.B	srmode,#$00	;search mode ?
4662	JZ	efndfnd	;:find
4664	CALL	edoreplc	;replace it
4667efndfnd	TEST.B	sropt,#$28	;block global ?
466C	JZ	efndnxt	;:yes
466E	JMP	efndrep	;'continue
4671efndnxt	DEC	srcnt	;another line to process ?
4675	JZ	efndend	;:no
4677	JMP	efndrep	;'continue
467Aefndend	JMP.b	efsetpos	;'set new pos
467C	NOP	
467Defndnch	PUSH	DX	;save pos
467E	CALL	edend	;at the end ?
4681	POP	DX	;restore
4682	JB	efndexit	;:yes
4684	TEST.B	sropt,#$10	;backwards ?
4689	JZ	efndfw3	;:no
468B	DEC	DX	;go back
468C	JMP	efndcmp	;'
468Eefndfw3	INC	DX	;next char
468F	JMP	efndcmp	;'continue
4691efndpos	MOV	BX,srpos	;get current search pos
4695	CALL	edend	;at the end ?
4698	JB	efndexit	;:yes
469A	JMP	efndrep	;'continue
469Defndexit	CALL	edrange	;end search: limit new pos
46A0	CALL	efsetpos	;set pos
46A3	TEST.B	sropt,#$28	;global block ?
46A8	JNZ	espret	;:no
46AA	CALL	eclrstat	;clear status line
46AD	CALL	ewriterr	;write string
46B0	B	"Search string not found",$00
46C8	JMP	waitesc	;"wait for ESC
46CBefsetpos	CALL	esetpos	;set position
46CE	JMP	erstlin	;"restore line
46D1esetpos	MOV	DX,txend	;Set pos
46D5	DEC	DX	;text end - 1
46D6	CMP	BX,DX	;= current ?
46D8	JB	esp2	;:below
46DA	XCHG	BX,DX	;limit it
46DCesp2	PUSH	BX	;save
46DD	PUSH	BX
46DE	CALL	esrcbeg	;search beg of that line
46E1	MOV	edpos,BX	;-> current pos
46E5	XCHG	BX,DX	;-> DX
46E7	POP	BX	;restore
46E8	SUB	BX,DX	;calc pos in line
46EA	MOV	DX,#line	;+ buffer offset
46ED	ADD	BX,DX
46EF	MOV	lnpos,BX	;-> pos in line buffer
46F3	CALL	erepos	;reposition in current line
46F6	CALL	eseldisp	;do selective rewrite
46F9	POP	BX	;restore pos
46FAespret	RET		;"
46FBedrange	MOV	DX,txbeg	;bring BX into range:
46FF	CALL	emin	;>= text beg,
4702	MOV	BX,txend
4706	DEC	BX
4707	JMP	emin	;"< text end
470Aedfnchar	CMP	AL,#$30	;char in alphanum ?
470C	JB	edfnch2	;<0: no
470E	CMP	AL,#$3A
4710	JB	edfnchrt	;0..9: yes
4712	CMP	AL,#$41
4714	JB	edfnch2	;<A: no
4716	CMP	AL,#$5B
4718	JB	edfnchrt	;A..Z: yes
471A	CMP	AL,#$61
471C	JB	edfnch2	;<a: no
471E	CMP	AL,#$7B
4720	JB	edfnchrt	;a..z: yes
4722edfnch2	OR.B	AL,AL	;test flag
4724	RET		;"
4725edbeg	TEST.B	sropt,#$10	;At the beginning ?
472A	JZ	edend2	;:forward
472Cedbeg2	INC	BX
472D	CMP	BX,srend	;= search limit end ?
4731	CMC	
4732edfnchrt	RET		;'
4733edend	TEST.B	sropt,#$10	;end reached ?
4738	JZ	edbeg2	;:forward
473Aedend2	DEC	BX
473B	CMP	BX,srbeg	;= search limit beg ?
473F	RET		;"
4740edcmp	XCHG	DX,BX	;Compare chars
4742	MOV.B	AL,[BX]	;get char in search string
4744	XCHG	DX,BX
4746	CMP	AL,#$01	;wild card ?
4748	JZ	edfnchrt	;yes: ok
474A	CMP.B	AL,[BX]	;compare it
474C	JZ	edfnchrt	;yes: ok
474E	TEST.B	sropt,#$04	;ignore upper/lower ?
4753	JZ	edcmp2	;:no, just compare
4755	CALL	edfnchar	;is it a valid char ?
4758	JNB	edcmp2	;:no
475A	XOR.B	AL,[BX]	;mask different bits
475C	AND	AL,#$DF
475E	RET		;'
475Fedcmp2	CMP.B	AL,[BX]	;compare it
4761	RET		;"
4762edoreplc	PUSH	BX	;Do replace
4763	CALL	ekbdstat	;get KBD stat
4766	JZ	erpdis	;nothing: display it
4768	TEST.B	sropt,#$02	;replace without asking ?
476D	JNZ	erpdoit	;:yes
476Ferpdis	CALL	efsetpos	;set new position
4772	CALL	eredispl	;redisplay
4775	TEST.B	sropt,#$02	;replace without asking ?
477A	JNZ	erpdoit	;:yes
477C	CALL	eclrs2	;clear status line
477F	CALL	printatt	;write string
4782	B	"Replace (",$D9,"/",$CE,"): ",$00
4792erpblnk	MOV.B	BL,phrow	;Blink cursor: alternate
4796	MOV.B	BH,phcol	;status line / cursor pos
479A	CALL	esetcur	;set cursor pos
479D	MOV	CX,#$0004	;do 4 times
47A0erpbw1	CALL	ekbdstat	;get KBD stat
47A3	JNZ	erpbw2	;:key pressed
47A5	MOV	BX,#$0064	;wait 100 ms
47A8	PUSH	CX	;save count
47A9	CALL	delaybx	;Delay
47AC	POP	CX	;restore
47AD	LOOP	erpbw1	;:another
47AF	MOV	BX,#$0F00	;pos:status line
47B2	CALL	esetcur	;set cursor pos
47B5	MOV	CX,#$0004	;4 times
47B8erpblnk2	CALL	ekbdstat	;get KBD stat
47BB	JNZ	erpbw2	;:key pressed
47BD	MOV	BX,#$0064	;wait 100 ms
47C0	PUSH	CX	;save cnt
47C1	CALL	delaybx	;Delay
47C4	POP	CX	;restore cnt
47C5	LOOP	erpblnk2	;:another
47C7	JMP	erpblnk	;'blink again
47C9erpbw2	CALL	keyget	;get char
47CC	CALL	etstint	;test interrupt
47CF	CALL	upcase	;UpCase
47D2	CMP	AL,#$59	;Y ?
47D4	JZ	erpdoit	;:yes, do it
47D6	CMP	AL,#$19	;^Y ?
47D8	JNZ	erpbk
47DAerpdoit	MOV.B	txchg,#$FF	;set flags: text changed
47DF	MOV.B	txcomp,#$00	;code invalid
47E4	MOV.B	CL,srrepl1	;length of replacement
47E8	MOV	CH,#$00
47EA	POP	BX	;restore pos
47EB	PUSH	BX
47EC	PUSH	CX	;save
47ED	MOV	AL,srword1	;length of word found
47F0	SUB.B	AL,CL	;- length of replacement
47F2	MOV.B	CL,AL	;-> CL
47F4	LAHF		;save flags
47F5	PUSH	AX
47F6	JNB	erp2	;do sign extension
47F8	DEC.B	CH
47FAerp2	TEST.B	sropt,#$10	;backwards ?
47FF	JNZ	erpbw	;:yes
4801	MOV	BX,srpos	;beg of that word
4805erpbw	POP	AX	;flag
4806	SAHF	
4807	PUSH	BX
4808	JZ	erpsame	;: no difference
480A	CALL	echgsize	;change len
480Derpsame	POP	DX	;restore
480E	POP	CX
480F	MOV.B	AL,CH	;length = 0 ?
4811	OR.B	AL,CL
4813	JZ	erpnil
4815	MOV	BX,#srrepl2	;move in replacement word
4818	CALL	movebk
481Berpnil	CALL	ekbdstat	;get KBD stat
481E	JZ	erpok	;:nothing
4820	CALL	eredall	;redisplay all
4823	JMP.b	erpchg	;'
4825erpok	PUSH	DX	;save pos
4826	CALL	erstlin	;restore line
4829	CALL	eredall	;flag: redisplay
482C	POP	DX	;restore pos
482Derpchg	TEST.B	sropt,#$10	;backwards ?
4832	JNZ	erpbk	;:yes
4834	POP	BX	;remove
4835	XCHG	DX,BX	;set to end of word
4837	RET		;'
4838erpbk	POP	BX	;restore beg of word
4839erpret	RET		;"
483Aekw	CMP.B	bkhide,#$FF	;^KW:Write block to disk
483F	JZ	erpret	;block hidden: ret
4841	CALL	eflush	;rewrite line
4844	CALL	erstlin	;restore line
4847	MOV	AX,bkbeg	;block begin > block end ?
484A	CMP	AX,bkend
484E	JNB	erpret	;yes: ret
4850	CALL	etstblk	;test block
4853	CALL	erstlin	;restore line
4856ekwlp	CALL	eclrstat	;clr status line
4859	CALL	ewrits	;write string
485C	B	"Write block to file",$00
4870	CALL	ekwfile	;get filename
4873	JZ	erpret	;nothing entered: ret
4875	CALL	kpasext	;default extension .PAS
4878	MOV	AX,#$3D00	;open file
487B	MOV	DX,#scrpn	;name ptr
487E	PUSH	DS	;DS -> ES
487F	POP	ES
4880	CALL	dos
4883	MOV	BX,AX	;file handle
4885	JB	ekwnew
4887	MOV	AH,#$3E	;close file
4889	CALL	dos
488C	CALL	eclrs2	;clr status line
488F	CALL	ewrits
4892	B	"Overwrite old ",$00
48A1	MOV	SI,#scrpn	;write filename
48A4	CALL	printpn
48A7	CALL	yorn	;Y or N ?
48AA	JZ	ekwlp	;no: get new filename
48ACekwnew	MOV	AH,#$3C	;create file
48AE	MOV	DX,#scrpn	;name ptr
48B1	XOR	CX,CX	;no attribute
48B3	PUSH	DS	;DS -> ES
48B4	POP	ES
48B5	CALL	dos
48B8	JNB	ekwopen	;:ok
48BA	CALL	eclrs2	;clr status line
48BD	CALL	ewriterr	;write message
48C0	B	"Unable to create ",$00
48D2	MOV	SI,#scrpn	;write filename
48D5	CALL	printpn
48D8	CALL	waitesc	;wait for ESC
48DB	JMP	ekwlp	;'get new filename
48DEekwopen	PUSH	AX	;save file handle
48DF	CALL	eclrs2	;clr status line
48E2	POP	BX	;restore
48E3	MOV	DX,bkbeg	;block begin
48E7	MOV	SI,bkend	;block end
48EB	MOV.B	AL,[SI]	;get char at block end
48ED	PUSH	AX	;save it
48EE	PUSH	SI	;save its addr
48EF	MOV.B	[SI],#$1A	;store a ^Z there
48F2	MOV	CX,SI	;count = block end - block beg
48F4	SUB	CX,DX
48F6	CMP	BX,#$04	;write to device ?
48F9	JBE	ekwdev	;:yes
48FB	INC	CX	;file: write ^Z, too
48FCekwdev	MOV	AH,#$40	;write byte block
48FE	CALL	dos
4901	JB	ekwfull	;:error
4903	SUB	CX,AX	;length = expected ?
4905	JZ	ekwdone	;:yes
4907	DEC	CX	;1 byte difference ?
4908	JNZ	ekwfull	;no: error
490Aekwdone	CALL	ekwclose	;close file
490D	JNB	ekwok	;:ok
490F	CALL	ewriterr	;write message
4912	B	"Error closing file",$00
4925	CALL	waitesc	;wait for ESC
4928ekwok	POP	SI	;restore char at block end
4929	POP	AX
492A	MOV.B	[SI],AL
492C	RET		;'
492Dekwfull	CALL	ekwclose	;close file
4930	MOV	AH,#$41	;delete it
4932	MOV	DX,#scrpn	;name ptr
4935	CALL	dos
4938	CALL	ewriterr	;write message
493B	B	"Disk full",$00
4945	CALL	waitesc	;wait for ESC
4948	JMP	ekwok	;'restore block end
494Aekwclose	MOV	AH,#$3E	;close file
494C	JMP	dos	;"
494Fekwfile	MOV	DX,#fnbuf	;get filename
4952	CALL	edreadst	;read it
4955	MOV	BX,#fnbuf2	;first char
4958	CMP.B	[BX],#$1A	;= ^Z ?
495Bekrret	RET		;"yes: nothing entered
495Cekr	CALL	eclrstat	;^KR:Read block from disk
495F	CALL	ewrits	;write string
4962	B	"Read block from file",$00
4977	CALL	ekwfile	;get file name
497A	JZ	ekrret	;nothing entered: ret
497C	CALL	kpasext	;default extension .PAS
497F	MOV	AX,#$3D00	;open file
4982	MOV	DX,#scrpn	;name ptr
4985	PUSH	DS	;DS -> ES
4986	POP	ES
4987	CALL	dos	;do it
498A	XCHG	AX,BX	;file handle
498B	JNB	ekrfound	;:ok
498D	CALL	eclrs2	;clr status line
4990	CALL	ewriterr	;write message
4993	B	"File ",$00
4999	MOV	SI,#scrpn	;write filename
499C	CALL	printpn
499F	CALL	prints	;write string
49A2	B	" not found",$00
49AD	CALL	waitesc	;wait for ESC
49B0	JMP	ekr	;'get another filename
49B2ekrfound	PUSH	BX	;save file handle
49B3	MOV.B	bkhide,#$00	;flag: block not hidden
49B8	CALL	etstblk	;test block
49BB	MOV	BX,txend	;text end
49BF	MOV	DX,txmemend	;text space end
49C3	MOV	CX,#$00FE	;+ some space free
49C6	ADD	BX,CX
49C8	SUB	BX,DX
49CA	PUSH	BX	;save free space
49CB	MOV	CX,BX
49CD	MOV	BX,nbkbeg	;new block beg
49D1	STC	
49D2	CALL	echgsize	;make space
49D5	POP	AX	;restore free space
49D6	POP	BX	;restore file handle
49D7	MOV	DX,nbkbeg	;new block beg
49DB	MOV	CX,DX	;-> offset
49DD	SUB	CX,AX
49DF	MOV	explen,CX	;save end free space
49E3	MOV	vfilbig,#ebigfil	;set error vec
49E9	CALL	kload2	;load block
49EC	INC	BX	;end of block read
49ED	MOV	bkend,BX	;store as new block end
49F1	XCHG	DX,BX	;-> DX
49F3	MOV	BX,nbkbeg	;new block beg
49F7	MOV	bkbeg,BX	;-> block beg
49FBekrremov	MOV	BX,explen	;end free space
49FF	SUB	BX,DX	;-block end
4A01	MOV	CX,BX	;-> count
4A03	JMP.b	ekvremov	;'remove unneeded space
4A05	MOV	DX,nbkbeg	;File too big:
4A09	CALL	ekrremov	;remove space made free
4A0C	JMP	etsterr	;"error: out of space
4A0Feblkmov	CALL	etstblk	;^KV:Move block - test block
4A12	JNB	ekvrest
4A14	CALL	ecopyblk	;copy it
4A17	MOV	BX,nbkbeg	;new block beg
4A1B	MOV	DX,bkbeg	;-> block beg
4A1F	MOV	bkbeg,BX
4A23	ADD	BX,CX	;+ count
4A25	MOV	bkend,BX	;-> block end
4A29ekvremov	XCHG	BX,DX	;old block beg -> BX
4A2B	CLC	
4A2C	CALL	echgsize	;remove old block
4A2F	MOV	BX,bkbeg	;block begin
4A33	CALL	efsetpos	;set position
4A36	JMP	erewrall	;'rewrite all
4A39ekvrest	JMP	erstlin	;"restore line
4A3Ceblkcpy	CALL	etstblk	;^KC:Copy block - test block
4A3F	JNB	ekvrest
4A41	CALL	ecopyblk	;do copy it
4A44	MOV	BX,nbkbeg	;new block beg
4A48	MOV	bkbeg,BX	;-> block beg
4A4C	ADD	BX,CX	;+ count
4A4E	MOV	bkend,BX	;-> block end
4A52	CALL	eseldisp	;selective redisplay
4A55	CALL	erstlin	;restore line
4A58	JMP	erewrall	;"rewrite all
4A5Betstblk	CMP.B	bkhide,#$00	;Test block
4A60	JZ	etb2	;:block not hidden
4A62	CLC	
4A63	RET		;'
4A64etb2	CALL	esrcend	;search end of input line
4A67	INC	BX	;+1
4A68	MOV	DX,lnpos	;pos in input line
4A6C	PUSH	DX	;save it
4A6D	CALL	emin	;take smaller of them
4A70	XCHG	BX,DX	;-> BX
4A72	CALL	efl2	;write back to memory
4A75	POP	BX	;restore pos in input line
4A76	MOV	DX,#line	;calc relative pos in input line
4A79	SUB	BX,DX
4A7B	MOV	DX,edpos	;+pos of current line
4A7F	ADD	BX,DX
4A81	MOV	nbkbeg,BX	;-> new block beg
4A85	PUSH	BX	;save
4A86	MOV	DX,bkbeg	;block beg+1
4A8A	INC	DX
4A8B	CMP	BX,DX	;destination inside block ?
4A8D	MOV	DX,bkend	;block end
4A91	JB	etbbeg	;:no
4A93	CMP	BX,DX
4A95	JNB	etbbeg	;:no
4A97	OR.B	AL,AL	;dest is in old block...
4A99	JMP.b	etb3	;'end it
4A9Betbbeg	MOV	BX,bkbeg	;block beg
4A9F	SUB	BX,DX	;-block end
4AA1	MOV	nbk,BX	;-> - block len
4AA5	MOV	CX,BX	;-> count
4AA7etb3	POP	BX	;restore destination
4AA8	RET		;"
4AA9ecopyblk	CALL	echgsize	;Copy block: make space for it
4AAC	MOV	CX,nbk	;get count
4AB0	NEG	CX	;(is - block len)
4AB2	MOV	DX,nbkbeg	;block destination
4AB6	MOV	BX,bkbeg	;block source
4ABA	PUSH	CX	;save count
4ABB	CALL	movebk	;move it
4ABE	POP	CX	;restore count
4ABF	RET		;"
4AC0eblkdel	CALL	eflush	;^KY:Delete block - rewrite line
4AC3	CMP.B	bkhide,#$00	;block hidden ?
4AC8	JNZ	ekyrest
4ACA	MOV	BX,bkbeg	;block beg
4ACE	CALL	esrcbeg	;search beg of line
4AD1	MOV	edpos,BX	;-> current pos
4AD5	MOV	BX,posfifo	;update pos FIFO
4AD9	MOV	DX,bkbeg	;inside block ?
4ADD	INC	DX
4ADE	CMP	BX,DX
4AE0	JB	ekynochg	;:no
4AE2	MOV	DX,bkend
4AE6	CMP	BX,DX
4AE8	JNB	ekynochg	;:no
4AEA	MOV	BX,edpos	;current pos
4AEE	MOV	posfifo,BX	;-> FIFO
4AF2ekynochg	MOV	BX,bkend	;block end-block beg
4AF6	MOV	DX,bkbeg
4AFA	SUB	BX,DX	;calc count
4AFC	JNB	ekyblkok	;:ok
4AFEekyrest	JMP	erstlin	;'restore line
4B01ekyblkok	MOV	CX,BX	;-> count
4B03	XCHG	BX,DX	;swap addrs
4B05	PUSH	BX	;save them
4B06	PUSH	CX
4B07	PUSHF	
4B08	CALL	eseldisp	;do selective rewrite
4B0B	POPF	
4B0C	POP	CX	;restore
4B0D	POP	BX
4B0E	CALL	echgsize	;delete block
4B11	MOV	BX,edpos	;current pos
4B15	MOV	bkbeg,BX	;-> block beg
4B19	MOV	bkend,BX	;-> block end
4B1D	CALL	erstlin	;restore line
4B20	JMP.b	erewrall	;"rewrite all
4B22	NOP		;^KH:hide / unhide block
4B23ekh	NOT.B	bkhide	;toggle flag: block hidden
4B27	JMP.b	erewrall	;"rewrite all
4B29	NOP		;Mark block end
4B2Aemarkend	MOV	BX,lnpos	;pos in line
4B2E	MOV	bkendl,BX	;-> block end in buffer
4B32	MOV	BX,edpos	;line pos
4B36	MOV	bkend,BX	;-> block end
4B3A	TEST.B	attflg,#$02	;block marked in this line ?
4B3F	LAHF	
4B40	OR.B	attflg,#$02	;set that flag
4B45emrend2	CMP.B	bkhide,#$FF	;block hidden ?
4B4A	MOV.B	bkhide,#$00	;make it visible
4B4F	JZ	erewrall	;hidden: rewrite all
4B51	SAHF	
4B52	JZ	erewrall	;no block marked in line: all
4B54	JMP.b	erewrlin	;"rewrite line, only
4B56	NOP		;Mark block beg
4B57emarkbeg	MOV	BX,lnpos	;get pos in line
4B5B	MOV	bkbegl,BX	;-> block beg in line buffer
4B5F	MOV	BX,edpos	;current pos
4B63	MOV	bkbeg,BX	;-> block beg
4B67	TEST.B	attflg,#$01	;block beg in this line ?
4B6C	LAHF	
4B6D	OR.B	attflg,#$01	;set flag
4B72	JMP	emrend2	;"as above
4B74ejbkbeg	CALL	eflush	;^QB:to beginning of block
4B77	MOV	BX,bkbeg	;block beg
4B7B	JMP	efsetpos	;"set new position
4B7Eejbkend	CALL	eflush	;^QK:to end of block
4B81	MOV	BX,bkend	;block end
4B85	JMP	efsetpos	;"set new position
4B88erewrlin	MOV	BH,#$00	;Rewrite line
4B8A	CALL	eposrow	;pos cursor to beg of line
4B8D	MOV	BX,#line	;pos of current line
4B90	MOV.B	attchg,#$FF	;critical line
4B95	CALL	edmalin	;display it
4B98	MOV.B	attchg,#$00	;normal again
4B9D	RET		;"
4B9Eerewrall	CALL	erewrlin	;rewrite line
4BA1	JMP	eredall	;"then rewrite all
4BA4ejtxend	CALL	eflush	;^QC:to end of text
4BA7	MOV	BX,txend	;text end
4BAB	JMP	efsetpos	;"set new position
4BAEejlnbeg	MOV	BX,#line	;^QS:to beg of line
4BB1	MOV	lnpos,BX	;buffer beg -> pos in line
4BB5	JMP	erepos	;"reposition in line
4BB8ejlnend	CALL	esrcend	;^QD:to end of line
4BBB	INC	BX	;search end of line+1
4BBC	MOV	DX,#lineend	;too much ?
4BBF	CMP	BX,DX
4BC1	JB	ele2	;:no
4BC3	MOV	BX,#lineend1	;limit it
4BC6ele2	MOV	lnpos,BX	;set new pos in line
4BCA	JMP	erepos	;"reposition in line
4BCDetogovr	MOV.B	statobs,#$00	;^V:insert mode on/off
4BD2	NOT.B	overflg	;toggle flag
4BD6	RET		;"status line obsolete
4BD7etogind	MOV.B	statobs,#$00	;^QI:indent mode on/off
4BDC	NOT.B	indntflg	;toggle flag
4BE0ednrt	RET		;"status line obsolete
4BE1eposcur	MOV.B	BH,phcol	;put cursor to current pos
4BE5eposrow	MOV.B	BL,phrow
4BE9	JMP	esetcur	;"set cursor pos
4BECedn	MOV	BX,edpos	;^X:line down
4BF0	CALL	elindn	;go down one line
4BF3	JB	ednrt
4BF5	CALL	eflush	;rewrite line
4BF8	MOV	BX,edpos	;now really go down
4BFC	CALL	elindn
4BFFedn2	MOV	edpos,BX	;store new pos
4C03	MOV.B	scrfl2,#$00	;flag: short update
4C08	MOV.B	scrfl1,#$FF
4C0D	CALL	eseldisp	;do selective redisplay
4C10	MOV.B	scrfl1,#$00	;clear flag
4C15	JMP	erstlin	;"restore line
4C18eup	MOV	BX,edpos	;^E:line up
4C1C	CALL	elinup	;go up one line
4C1F	JB	ednrt
4C21	PUSH	BX	;save pos
4C22	CALL	eflush	;rewrite line
4C25	POP	BX	;now go there
4C26	JMP	edn2	;"set it
4C28escrup	MOV	AX,disbeg	;^W:scroll up
4C2B	CMP	AX,txbeg	;display beg = text beg ?
4C2F	JZ	eptret	;yes: ret
4C31	CALL	eflush	;rewrite line
4C34	XOR	CX,CX	;count pos on screen
4C36	MOV	BX,edpos	;current pos
4C3Aesulp	CMP	BX,disbeg	;= display beg ?
4C3E	JZ	esu2	;yes: do it
4C40	CALL	elinup	;go up one line
4C43	INC	CX	;count it
4C44	JMP	esulp	;'
4C46esu2	XCHG	BX,edpos	;current pos = top of screen
4C4A	CS:	
4C4B	MOV	AL,txwiny2	;line count - 3
4C4E	SUB	AL,#$03
4C50	CMP.B	CL,AL	;= count ?
4C52	JNZ	esu3	;no: ok
4C54	CALL	elinup	;go up one line
4C57esu3	PUSH	BX	;save current pos
4C58	MOV	BX,edpos	;display beg
4C5C	CALL	elinup	;go up one line
4C5F	CALL	edn2	;display it
4C62	POP	BX	;restore current pos
4C63esu4	JMP	edn2	;"set new pos
4C65escrdn	CALL	eflush	;^Z:scroll down
4C68	PUSH	edpos	;save current pos
4C6C	MOV	BX,disbeg	;start from display beg
4C70	XOR	CX,CX
4C72	CS:	
4C73	MOV.B	CL,txwiny2	;line count-2 -> CX
4C77	SUB.B	CL,#$02
4C7Aesdlp	CALL	elindn	;go down one line
4C7D	LOOP	esdlp	;do it again
4C7F	PUSHF	
4C80	CALL	edn2	;set new pos
4C83	POPF	
4C84	POP	BX	;restore old pos
4C85	JB	esu4	;:set new pos
4C87	CMP	BX,disbeg	;>= display beg ?
4C8B	JNB	esu4	;:set new pos
4C8D	CALL	elindn	;go down one line
4C90	JMP	esu4	;'set new pos
4C92eptret	RET		;"
4C93epagtop	MOV	BX,disbeg	;^QE:to page top
4C97	CMP	BX,edpos	;display beg = current line ?
4C9B	JZ	eptret	;yes: done
4C9D	PUSH	BX	;save this pos
4C9E	CALL	eflush	;rewrite line
4CA1	POP	BX	;display beg -> new pos
4CA2	JMP	esu4	;"set that pos
4CA4epagbot	CALL	eflush	;^QX:to bottom of page
4CA7	MOV	BX,disbeg	;display beg
4CAB	XOR	CX,CX	;line count-3 -> CX
4CAD	CS:	
4CAE	MOV.B	CL,txwiny2
4CB2	SUB.B	CL,#$03
4CB5epblp	CALL	elindn	;go down one line
4CB8	LOOP	epblp	;:again
4CBA	JMP	esu4	;"set new pos
4CBCepagdn	CALL	eflush	;^C:page down - rewrite line
4CBF	CS:	
4CC0	MOV	AL,txwiny2	;line count - 2
4CC3	SUB	AL,#$02
4CC5	MOV.B	CH,AL	;-> CL, CH
4CC7	MOV.B	CL,AL
4CC9	MOV	BX,disbeg	;display beg
4CCDepdlp	CALL	elindn	;go down one line
4CD0	DEC.B	CH
4CD2	JNZ	epdlp	;:another one
4CD4	MOV	disbeg,BX	;store new display beg
4CD8	MOV	BX,edpos	;current pos
4CDCepdl2	CALL	elindn	;go down one line
4CDF	LOOP	epdl2	;:again
4CE1epd2	MOV	edpos,BX	;set new pos
4CE5	CALL	eseldisp	;redisplay
4CE8	CALL	eredall	;redisplay all
4CEB	JMP	erstlin	;"restore line
4CEEepagup	CALL	eflush	;^R:page up - rewrite line
4CF1	CS:	
4CF2	MOV	AL,txwiny2	;line count - 2
4CF5	SUB	AL,#$02
4CF7	MOV.B	CH,AL	;-> CL, CH
4CF9	MOV.B	CL,AL
4CFB	MOV	BX,disbeg	;display beg
4CFFepulp	CALL	elinup	;go up one line
4D02	DEC.B	CH
4D04	JNZ	epulp	;:another
4D06	MOV	disbeg,BX	;store new display beg
4D0A	MOV	BX,edpos	;current pos
4D0Eepul2	CALL	elinup	;go up one line
4D11	LOOP	epul2	;:another
4D13	JMP	epd2	;"set new pos, redisplay
4D15etxtbeg	MOV	BX,disbeg	;^QR:to beg of text
4D19	MOV	DX,txbeg	;text beg = display beg ?
4D1D	CMP	BX,DX
4D1F	JZ	etsb2	;:yes
4D21	CALL	eredall	;no:redisplay all
4D24etsb2	CALL	eflush	;rewrite line
4D27	MOV	BX,txbeg	;text beg
4D2B	MOV	edpos,BX	;-> current pos
4D2F	MOV	disbeg,BX	;-> display beg
4D33	CALL	eseldisp	;do selective redisplay
4D36	CALL	erstlin	;restore line
4D39	MOV	BX,#line	;go to beg of line
4D3C	MOV	lnpos,BX	;pos in line
4D40	JMP	erepos	;"reposition in line
4D43ecr	CMP.B	overflg,#$00	;CR:carriage return
4D48	JNZ	ecrins	;:insert mode
4D4A	CALL	edn	;go down one line
4D4D	JMP	ejlnbeg	;'go to beg of line
4D50ecrins	MOV.B	txchg,#$FF	;set flags: text changed
4D55	MOV.B	txcomp,#$00
4D5A	MOV	BX,phrow	;current cursor pos
4D5E	INC.B	BL
4D60	CALL	esetcur	;set cursor to beg of line
4D63	CALL	elinbrk	;insert line break
4D66	MOV	BX,edpos
4D6A	PUSH	BX	;save current pos
4D6B	CALL	erstlin	;restore line
4D6E	CALL	eflush	;rewrite line
4D71	POP	BX	;restore current pos
4D72	CALL	elindn	;go down one line
4D75	MOV	edpos,BX	;-> current pos
4D79	MOV	BX,#line	;go to beg of line
4D7C	CALL	eredisp	;redisplay
4D7F	CALL	eposcur	;set new position
4D82	CMP.B	indntflg,#$00	;indent ?
4D87	JZ	elftret	;:no
4D89	CALL	etabup	;up one line from curr pos
4D8C	JB	elftret	;:no
4D8E	MOV	SI,#esepspc	;separator: spaces only
4D91	CALL	etslp	;'go word right
4D94	JNB	elftret
4D96	JMP	etab	;"do tab
4D99eredisp	MOV	lnpos,BX	;store pos in buffer
4D9D	CALL	erepos	;reposition in line
4DA0	CALL	eseldisp	;selective redisplay
4DA3	JMP	erstlin	;"restore line
4DA6elinins	CALL	elinbrk	;^N:insert line - insert line break
4DA9	MOV.B	BL,phrow	;row + 1
4DAD	INC.B	BL
4DAF	XOR.B	BH,BH	;col = 0
4DB1	CALL	esetcur	;set cursor pos
4DB4	MOV	BX,edpos	;current pos
4DB8	CALL	elindn	;go down one line
4DBB	CALL	edmalin	;display line
4DBE	JMP	erstlin	;"restore line
4DC1elinbrk	CALL	eflush	;Insert line break: rewrite line
4DC4	CALL	xinsline	;InsLine
4DC7	CALL	esrcend	;search end of line + 1
4DCA	INC	BX
4DCB	MOV	DX,lnpos	;pos in buffer
4DCF	CALL	emin
4DD2	MOV	DX,#line	;relative pos in line
4DD5	SUB	BX,DX
4DD7elb2	XCHG	BX,DX	;-> DX
4DD9	MOV	BX,edpos	;current pos
4DDD	ADD	BX,DX	;+ relative pos
4DDF	PUSH	BX	;save pos of line break
4DE0	STC		;insert two bytes
4DE1	MOV	CX,#$FFFE
4DE4	CALL	echgsize	;do it
4DE7	POP	BX	;restore pos
4DE8	MOV	[BX],#$0A0D	;store CR, LF there
4DEC	INC	BX
4DEDelftret	RET		;"
4DEEeleft	MOV	BX,lnpos	;^S, ^H:character left
4DF2	DEC	BX	;pos in line - 1
4DF3	CMP	BX,#line	;already at the beg ?
4DF7	JB	elftret
4DF9eleft2	MOV	lnpos,BX	;set new pos
4DFD	JMP	erepos	;"reposition in line
4E00eright	MOV	BX,lnpos	;^D:character right
4E04	INC	BX	;pos in line + 1
4E05	CMP	BX,#lineend0	;= end of buffer ?
4E09	JB	eleft2	;below: ok, set it
4E0B	RET		;"
4E0Celstpos	CALL	eflush	;^QP:to last position
4E0F	MOV	BX,qppos	;get pos from FIFO
4E13	CALL	esrcbeg	;search beg of line
4E16	MOV	edpos,BX	;-> current pos
4E1A	MOV	BX,qppos1	;get display beg from FIFO
4E1E	JMP	eredisp	;"redisplay
4E21emrkwrd	CALL	ewrdrt	;^T:mark word - word right
4E24	CALL	ewrdlft	;word left
4E27	MOV	BX,lnpos	;pos in line buffer
4E2Bemwlp	CALL	etstsep	;char = separator ?
4E2E	JB	emwend	;yes: word end found
4E30	INC	BX	;next char
4E31	CMP	BX,#lineend0	;end of line ?
4E35	JB	emwlp	;:no, continue
4E37emwend	MOV	lnpos,BX	;-> current pos
4E3B	CALL	emarkend	;mark block end
4E3E	CALL	ewrdlft	;go left one word
4E41	JMP	emarkbeg	;"mark block beg
4E44ewlup	MOV	BX,edpos	;get current pos
4E48	CALL	elinup	;go up one line
4E4B	JB	ewloldp
4E4D	PUSH	BX	;save pos
4E4E	CALL	eflush	;rewrite line
4E51	POP	BX
4E52	MOV	edpos,BX	;set new pos
4E56	MOV.B	scrfl2,#$00	;set flag: short updating
4E5B	CALL	eseldisp	;selective redisplay
4E5E	CALL	erstlin	;restore line
4E61	CALL	esrcend	;search end of line
4E64	JMP.b	ewlle	;'store position
4E66ewrdlft	MOV	BX,lnpos	;^A:word left
4E6Aewllp	DEC	BX	;pos in buffer-1:search char<>sep
4E6B	CMP	BX,#line	;= line beg ?
4E6F	JB	ewlup	;yes: go up one line
4E71	CALL	etstsep	;char = separator ?
4E74	JB	ewllp	;yes: continue searching
4E76ewll2	DEC	BX	;go back: search separator
4E77	CMP	BX,#$046C	;= line beg ?
4E7B	JB	ewlle	;yes: end it
4E7D	CALL	etstsep	;char = separator ?
4E80	JNB	ewll2	;:no
4E82ewlle	INC	BX	;go to left of word
4E83ewlpos	MOV	lnpos,BX	;store pos in line
4E87ewloldp	MOV	BX,lnpos	;get pos
4E8B	JMP	erepos	;"reposition in line
4E8Eewrdrt	CALL	esrcend	;^F:word right
4E91	MOV	AX,BX	;end of line -> AX
4E93	MOV	BX,lnpos	;pos in line
4E97	SUB	AX,BX	;calc count
4E99	MOV	AL,#$00
4E9B	JNB	ewr1	;:ok
4E9D	INC.B	AL
4E9Fewr1	MOV	curpast,AL	;flag: cursor past end of line
4EA2ewrlp	DEC	BX
4EA3ewrl2	INC	BX	;next char
4EA4	CMP	BX,#lineend0	;end of line ?
4EA8	JB	ewrtst	;:no
4EAAewrl3	MOV	BX,edpos	;current pos
4EAE	CALL	elindn	;go down one line
4EB1	JB	etabret
4EB3	CALL	eflush	;rewrite line
4EB6	MOV	BX,edpos	;current pos
4EBA	CALL	elindn	;go down
4EBD	MOV	edpos,BX	;new pos
4EC1	MOV.B	scrfl2,#$00	;short update
4EC6	CALL	eseldisp	;redisplay
4EC9	CALL	erstlin	;restore line
4ECC	MOV	BX,#$046C	;go to beg of line
4ECF	MOV	lnpos,BX
4ED3	CALL	etstsep	;char = separator ?
4ED6	JB	ewrlp	;:yes
4ED8	JMP	erepos	;'set that pos
4EDBewrtst	CALL	etstsep	;char = separator ?
4EDE	JNB	ewrl2	;:no
4EE0ewrlp2	INC	BX	;next char
4EE1	CMP	BX,#lineend0	;end of line ?
4EE5	JB	ewrtst2	;:no
4EE7	CMP.B	curpast,#$00	;cursor past end of line ?
4EEC	JNZ	ewrl3	;:yes
4EEE	CALL	esrcend	;search end of line + 1
4EF1	INC	BX
4EF2	JMP	ewlpos	;'set that pos
4EF4ewrtst2	CALL	etstsep	;char = separator ?
4EF7	JB	ewrlp2	;:yes
4EF9	JMP	ewlpos	;"set that pos
4EFBetabup	MOV	BX,edpos	;current pos
4EFF	CALL	elinup	;go up one line
4F02etabret	RET		;"
4F03etab	CALL	etabup	;^I:Tab - go up one line
4F06	JB	etabret
4F08	MOV	AL,phrow	;save phys row
4F0B	PUSH	AX
4F0C	MOV	BX,lnpos	;pos in line
4F10	MOV	lnupper,BX	;store pos of upper line
4F14	MOV.B	disflg,#$00	;normal mode
4F19	CALL	eflush	;rewrite line
4F1C	MOV	BX,edpos	;current pos
4F20	PUSH	BX	;save it
4F21	CALL	elinup	;go up one line
4F24	MOV	edpos,BX	;store pos
4F28	CALL	erstlin	;restore line
4F2B	PUSH	sepptr	;save ptr
4F2F	MOV	sepptr,#esepspc	;set sep ptr: spaces only
4F35	CALL	ewrdrt	;word right
4F38	POP	sepptr	;restore sep ptr
4F3C	POP	edpos	;restore current pos
4F40	POP	AX
4F41	MOV	phrow,AL	;restore phys row
4F44	CALL	erstlin	;restore line
4F47	MOV.B	disflg,#$FF	;flag: short update
4F4C	CMP.B	overflg,#$FF	;insert ?
4F51	JZ	etabins	;:yes
4F53	JMP	erewrlin	;'rewrite line
4F56etabins	MOV	BX,lnpos	;pos in line
4F5A	MOV	DX,lnupper	;pos in upper line
4F5E	SBB	BX,DX	;difference
4F60	JBE	etabret	;not found: ret
4F62	XCHG	BX,DX	;-> count
4F64etabinsl	PUSH	DX	;save count
4F65	CALL	einsch	;insert a char
4F68	MOV.B	[BX],#$20	;space
4F6B	POP	DX	;restore count
4F6C	DEC.B	DL	;another ?
4F6E	JNZ	etabinsl	;:yes
4F70	JMP	erewrlin	;"rewrite line
4F73edeleol	MOV	BX,lnpos	;^QY:delete to end of line
4F77	PUSH	BX	;save pos in line
4F78	CALL	etstbk	;test block markers in line
4F7B	POP	BX	;restore pos
4F7C	PUSH	BX
4F7D	MOV	DX,#lineend1	;end position
4F80edelp	MOV.B	[BX],#$20	;fill up with spaces
4F83	CMP	BX,DX	;end reached ?
4F85	JZ	edeend	;:yes
4F87	INC	BX	;next char
4F88	JMP	edelp	;'
4F8Aedeend	POP	BX	;restore pos in line
4F8B	JMP	eredlin	;"redisplay line
4F8Eedellin	MOV	BX,#line	;^Y:delete line
4F91	MOV	lnpos,BX	;to line beg
4F95	CALL	erepos	;reposition in line
4F98	CALL	edeleol	;delete to end of line
4F9B	CALL	eflush	;rewrite line
4F9E	MOV	BX,edpos	;current pos
4FA2	PUSH	BX	;save it
4FA3	PUSH	BX
4FA4	CALL	elindn	;go down one line
4FA7	POP	DX	;old pos
4FA8	JB	edlend
4FAA	SUB	BX,DX	;difference
4FAC	MOV	CX,BX	;-> count
4FAE	POP	BX	;restore current pos
4FAF	JNZ	edb3	;:erase the rest
4FB1	RET		;'
4FB2edlend	POP	BX	;remove from stack
4FB3	JMP	erstlin	;"restore line
4FB6edlinbrk	CALL	efl2	;del line break: rewrite to BX
4FB9	MOV	BX,edpos	;current pos
4FBD	CALL	elindn	;go down one line
4FC0	JNB	edb2	;:ok
4FC2	JMP	erstlin	;'restore line
4FC5edb2	DEC	BX	;go back two bytes
4FC6	DEC	BX
4FC7	MOV	CX,#$0002	;delete 2 bytes
4FCA	OR.B	AL,AL	;clear carry
4FCCedb3	CALL	echgsize	;do it
4FCF	CALL	xdelline	;DelLine
4FD2	CS:	
4FD3	MOV	AL,txwiny2	;get line cnt - 1
4FD6	DEC.B	AL
4FD8	CALL	edsplin	;redisplay last line
4FDB	JMP	erstlin	;"restore line
4FDEedelwrd	CALL	esrcend	;^T:delete right word
4FE1	MOV	DX,lnpos	;pos in buffer
4FE5	CMP	BX,DX	;> end ?
4FE7	XCHG	BX,DX
4FE9	JB	edlinbrk	;:delete line break
4FEB	MOV.B	AL,[BX]	;get char
4FED	CMP	AL,#$20	;space ?
4FEF	JZ	edelspc	;:delete spaces
4FF1	CALL	etstsep	;separator ?
4FF4	JB	edel2	;:end it
4FF6edwlp	CALL	edelch	;delete char
4FF9	CALL	etstsep	;separator ?
4FFC	JB	edrest	;:yes, end
4FFE	JMP	edwlp	;"another char
5000edwend	MOV	BX,edpos	;current pos
5004	CALL	elinup	;up one line
5007	JB	edwret
5009	CALL	eup	;line up
500C	CALL	ejlnend	;go to line end
500F	JMP	edelwrd	;'delete word
5011edwret	RET		;'
5012edelrt	MOV	BX,lnpos	;^G:delete right
5016	JMP.b	edel2	;'
5018edellft	MOV	BX,lnpos	;DEL:delete left
501C	DEC	BX	;go back one char
501D	CMP	BX,#line	;beg of line ?
5021	JB	edwend	;yes: go to line above
5023	MOV	lnpos,BX	;store new pos
5027edel2	CALL	edelch	;delete char
502Aedrest	CALL	erepos	;reposition on line
502D	JMP	eredlin	;"redisplay line
5030edelspc	CALL	edelch	;Delete spaces
5033	MOV.B	AL,[BX]	;get char
5035	CMP	AL,#$20	;space ?
5037	JZ	edelspc	;:delete it
5039	JMP	edrest	;"redisplay
503Beredispl	CALL	eposcur	;Redisplay: set cursor pos
503E	CALL	edisbdn	;go down from display beg
5041edisp1	CALL	ekbdstat	;get KBD stat
5044	JNZ	edisp2
5046	CALL	edsp2	;redisplay
5049	JNB	edisp1	;:continue
504Bedisp2	JMP	eposcur	;"set cursor pos
504Eedodispl	CALL	eposcur	;Redisplay: set cursor pos
5051	CALL	edisbdn	;go down from display beg
5054eddlp	CALL	edsp2	;redisplay
5057	JNB	eddlp	;:continue
5059	JMP	eposcur	;"set cursor pos
505Cedisbdn	MOV.B	CL,dislin	;go down from display beg
5060edisbdn2	XOR.B	CH,CH	;count: first line to display
5062	MOV	BX,disbeg	;display beg
5066	DEC	CX	;count down
5067	JZ	eddnil	;:end it
5069eddn	CALL	elindn	;go down one line
506C	JB	eddend
506E	LOOP	eddn	;:another line
5070eddnil	RET		;'
5071eddend	MOV	BX,txend	;go to text end
5075	RET		;"
5076edodisp	CALL	elindn	;do redisplay: go down
5079	JNB	edsp2	;:ok
507B	MOV	BX,txend	;go to text beg
507Fedsp2	MOV	AL,dislin	;display from where ?
5082	CS:	
5083	CMP.B	AL,txwiny2	;= line cnt ?
5087	JNB	edspret
5089	INC.B	dislin	;go down one more line
508D	CMP.B	AL,phrow	;= phys row ?
5091	JZ	edodisp	;yes: go down
5093edsp3	MOV	scrrow,AL	;current line
5096	CMP	BX,txend	;text end reached ?
509A	JNB	edsp4	;:yes
509C	CALL	edmalin	;display line
509F	CLC		;not yet end
50A0	RET		;'
50A1edsp4	CALL	esetnrm	;NormVideo
50A4	CALL	eclrlin	;clear line
50A7	CLC		;not yet end
50A8	RET		;'
50A9edspret	STC		;end it
50AA	RET		;"
50ABedsplin	PUSH	AX	;redisplay one line
50AC	MOV.B	CL,AL	;line number
50AE	CALL	edisbdn2	;go down to this line
50B1	POP	AX	;restore
50B2	JMP	edsp3	;"redisplay that line
50B4esrcbeg	MOV	AL,#$0A	;search beg of line: LF
50B6esblp	DEC	BX	;go back
50B7	CMP	BX,txbeg	;text beg ?
50BB	JZ	esbend	;yes: end it
50BD	JB	esb1	;below: next char
50BF	CMP.B	AL,[BX]	;test char: LF ?
50C1	JNZ	esblp	;no: continue searching
50C3esb1	INC	BX	;next char
50C4esbend	RET		;"
50C5eskipcr	CMP	AL,#$0D	;Skip CR
50C7	JNZ	escret	;no: ret
50C9	MOV.B	AL,[BX]	;get char
50CB	INC	BX	;next char
50CC	CMP	BX,txend	;text end ?
50D0	JB	eskipcr	;no: continue
50D2escret	RET		;"
50D3eclrlin	CS:		;Clear line
50D4	MOV.B	CH,txwinx2	;col count-1
50D8	DEC.B	CH
50DA	JMP	eclrln	;"clear line
50DDescrdma	PUSH	DS	;Prepare screen DMA
50DE	POP	ES	;DS -> ES
50DF	MOV	DI,#dmabuf	;ptr to DMA buffer
50E2	CLD	
50E3	XOR.B	AH,AH	;AL -> CX = pos in line
50E5	MOV	CX,AX
50E7	MOV	SI,AX	;AL*2 -> SI
50E9	ADD	SI,SI
50EB	CS:	
50EC	MOV	AL,txwinx2	;column count * 2
50EF	ADD	AX,AX
50F1	MOV	BP,AX	;-> BP
50F3	SUB	BP,SI	;- horizontal offset
50F5	MUL.B	scrrow	;line length * current row
50F9	ADD	BP,AX	;+ row position
50FB	RET		;"
50FCescrdma2	INC.B	AL	;column + 1
50FE	CALL	escrdma	;prepare DMA
5101	DEC	CX	;char cnt-1
5102	JMP.b	edlcrit	;"do it
5104edmalin	CS:		;Display line
5105	MOV	AL,txwinx2	;column count
5108	CALL	escrdma	;prepare screen DMA
510B	DEC	CX	;count down
510C	MOV.B	AH,horscr	;horizontal scroll
5110	OR.B	AH,AH	;=0 ?
5112	JZ	edlcrit
5114edl1	CALL	esetatt	;set attribute
5117	MOV.B	AL,[BX]	;get char
5119	INC	BX	;next char
511A	CMP	BX,txend	;text end ?
511E	JNB	edletx	;:yes
5120	CALL	eskipcr	;skip CR
5123	CMP	AL,#$0A	;LF ?
5125	JZ	edletx	;:yes
5127	DEC.B	AH	;another char ?
5129	JNZ	edl1	;:yes
512Bedlcrit	CMP.B	attchg,#$00	;critical line
5130	JZ	edlatt	;:no
5132	PUSH	BX	;save pos
5133	CALL	esrcend	;search end of line
5136	MOV	AX,lnpos	;pos in line = end of line ?
5139	CMP	AX,BX
513B	JBE	edllim	;:ok
513D	MOV	BX,AX	;limit it
513Fedllim	INC	BX
5140	MOV	eolpos,BX	;pos: end of line
5144	POP	BX	;restore pos
5145	CALL	esetatt	;set attribute
5148	CMP	BX,eolpos	;= pos EOL ?
514C	JNB	edletx	;:yes
514Eedlatt	CALL	esetatt	;set attribute
5151	CMP	BX,eolpos	;end of line ?
5155	JZ	edletx	;yes: end
5157	MOV.B	AL,[BX]	;get char
5159	INC	BX	;next
515A	CMP	BX,txend	;text end ?
515E	JA	edletx	;yes: end
5160	CMP	AL,#$0D	;CR ?
5162	JZ	edllp	;yes: forget it
5164	CMP	AL,#$20	;control char ?
5166	JNB	edlnrm	;:no, normal
5168	ADD	AL,#$40	;convert to normal
516A	PUSH	AX	;save it
516B	CALL	etogatt	;set attribute
516E	POP	AX	;restore
516Fedlnrm	MOV.B	AH,attcur	;current attribute
5173	STOS		;store in buffer
5174	LOOP	edlatt	;:another char
5176edllp	MOV.B	AL,[BX]	;get char
5178	INC	BX
5179	CMP	BX,txend	;text end ?
517D	JA	edletx	;:yes
517F	CMP	AL,#$0A	;LF ?
5181	JNZ	edllp	;:not yet
5183edletx	INC	CX	;one more byte
5184	MOV	AL,#$20	;fill up with spaces
5186	MOV.B	AH,attcur	;current attribute
518A	REPZ	
518B	STOS	
518C	CMP.B	disflg,#$00	;display it ?
5191	JZ	edlret	;:no
5193	MOV	CX,SI	;byte number / 2 -> words
5195	SHR	CX,1 
5197	MOV	DI,BP	;destination ofs
5199	MOV	ES,scrseg	;screen segment
519D	MOV	SI,#dmabuf	;buffer addr
51A0	CMP.B	scrbad,#$FF
51A5	JZ	edlbad	;:yes
51A7	REPZ		;just move it into screen memory
51A8	MOVS	
51A9edlret	RET		;'
51AAedlbad	MOV	DX,#$03DA	;test port
51ADedlblp	LODS		;get word
51AE	MOV	BP,AX	;save it
51B0edlbw1	IN	AL,DX	;get status
51B1	RCR.B	AL,1 
51B3	JB	edlbw1	;:wait
51B5	CLI		;no INT allowed
51B6edlbw2	IN	AL,DX	;get status
51B7	RCR.B	AL,1 
51B9	JNB	edlbw2	;:wait
51BB	XCHG	AX,BP	;restore char
51BC	STOS		;store it
51BD	STI		;clear interrupt
51BE	LOOP	edlblp	;:another char
51C0edlbret	RET		;"
51C1esetatt	CMP.B	bkhide,#$FF	;Set attribute
51C6	JZ	esetnrm	;:block hidden
51C8	CMP.B	attchg,#$FF	;block beg/end in this line ?
51CD	JZ	esetblk	;:no
51CF	CMP	BX,bkbeg	;block begin ?
51D3	JB	esetnrm	;:no, normal
51D5	CMP	BX,bkend	;block end ?
51D9	JNB	esetnrm	;above: normal
51DB	JMP.b	eset2	;'in block !
51DDesetblk	CMP	BX,bkbegl	;= pos block beg in buffer ?
51E1	JB	esetnrm	;:no, normal
51E3	CMP	BX,bkendl	;> pos block end in buffer ?
51E7	JNB	esetnrm	;yes: normal
51E9eset2	CMP.B	disflg,#$00	;display it ?
51EE	JZ	edlbret	;:no
51F0	JMP	vidattr2	;'Attribute #2
51F3esetnrm	CMP.B	disflg,#$00	;display it ?
51F8	JZ	edlbret	;:no
51FA	JMP	knrmvid	;"NormVideo
51FDesetlow	CMP.B	disflg,#$00	;display it ?
5202	JZ	edlbret	;:no
5204	JMP	klowvid	;"LowVideo
5207etogatt	CMP.B	curatt,#$01	;low set ?
520C	JZ	esetnrm	;yes:NormVideo
520E	JMP	esetlow	;"LowVideo
5210eclrln	CMP.B	disflg,#$00	;Clear line
5215	JZ	edlbret
5217	PUSH	AX	;save
5218	PUSH	DX
5219	MOV.B	AL,CH	;line number+1
521B	INC.B	AL
521D	CALL	escrdma	;prepare screen DMA
5220	DEC	CX	;length-1
5221	CALL	edletx	;erase to end of line
5224	POP	DX	;restore
5225	POP	AX
5226	RET		;"
5227escrolup	MOV	BX,#$0001	;Scroll up
522A	CALL	esetcur	;set cursor pos: top line
522D	JMP	xdelline	;"DelLine
5230erstlin	MOV	BX,edpos	;^QL:restore line
5234	MOV	DX,#$0000	;clear block pos in buf:
5237	MOV	bkbegl,DX	;block beg
523B	MOV	bkendl,DX	;block end
523F	MOV	CH,#$7F	;up to 127 chars
5241	MOV	SI,#line	;dest: line buffer
5244	MOV.B	attflg,#$00	;flag: no block beg / end
5249erllp	MOV.B	AL,[BX]	;get char
524B	CMP	BX,bkbeg	;block beg ?
524F	JNZ	erlnbeg	;:no
5251	MOV	bkbegl,SI	;pos block beg in line
5255	OR.B	attflg,#$01	;block beg in this line
525Aerlnbeg	CMP	BX,bkend	;block end ?
525E	JNZ	erlnend	;:no
5260	MOV	bkendl,SI	;pos block end in line
5264	OR.B	attflg,#$02	;block end in this line
5269erlnend	CMP	AL,#$0D	;CR ?
526B	JNZ	erlnext	;no:next char
526D	MOV.B	[SI],#$20	;store a space
5270	INC	SI	;next
5271	DEC.B	CH	;count down
5273	JZ	elonglin	;:line too long
5275	INC	BX	;next char
5276	CMP	BX,txend	;end of text ?
527A	JNB	erllp	;:no, continue
527Cerlend	CMP	BX,bkend	;block active in this line ?
5280	JNB	erlbeg	;:no
5282	PUSH	BX	;save pos
5283	MOV	BX,#$FFFF	;flag: block ends after
5286	MOV	bkendl,BX	;this line
528A	POP	BX
528Berlbeg	CMP	BX,bkbeg	;block beg ?
528F	JNB	erllen
5291	MOV	BX,#$FFFF	;flag: block starts before this
5294	MOV	bkbegl,BX	;line
5298erllen	MOV	AL,#$7F	;test line length
529A	SUB.B	AL,CH
529C	MOV	oldlen,AL	;store old length
529Ferlpad	MOV.B	[SI],#$20	;fill up with spaces
52A2	INC	SI
52A3	DEC.B	CH
52A5	JNZ	erlpad	;:again
52A7	MOV	BX,lnpos	;pos in buffer
52AB	CALL	erepos	;reposition in line
52AE	CMP.B	scrfl2,#$00	;small move only ?
52B3	MOV.B	scrfl2,#$FF	;reset flag
52B8	JZ	erldisp	;:yes
52BA	JMP	erewrlin	;'redisplay line
52BDerldisp	MOV	AL,dislin	;redisplay from ...
52C0	DEC.B	AL
52C2	CMP.B	AL,phrow	;= phys row ?
52C6	JNB	eseret	;above: ret
52C8	JMP	erewrlin	;'rewrite line
52CBerlnext	CMP	AL,#$0A	;LF ?
52CD	JZ	erlend	;yes: end it
52CF	MOV.B	[SI],AL	;store char
52D1	INC	SI	;go to next
52D2	DEC.B	CH	;too much ?
52D4	JNZ	erletx	;:no
52D6	JMP.b	elonglin	;'error: long line
52D8erletx	INC	BX	;end of text ?
52D9	CMP	BX,txend
52DD	JNB	erlend	;yes: end it
52DF	JMP	erllp	;"continue
52E2elonglin	CALL	eclrstat	;Insert line break - line too long
52E5	CALL	ewriterr	;write message
52E8	B	"Line too long - CR inserted",$00
5304	CALL	waitesc	;wait for ESC
5307	MOV	BX,#$007D	;offset
530A	CALL	elb2	;insert line break
530D	CALL	erstlin	;restore line
5310	JMP	erewrall	;"rewrite all
5313eclrstat	CALL	edodispl	;Clear status line
5316eclrs2	MOV.B	statobs,#$00	;status line destroyes
531B	MOV	BX,#$0000	;set cursor pos
531E	CALL	esetcur
5321	CALL	knrmvid	;NormVideo
5324	CALL	eclrlin	;clear line
5327	MOV	BX,#$0000	;set cursor pos
532A	CALL	esetcur
532D	JMP	klowvid	;"LowVideo
5330esrcend	MOV	AL,#$20	;Search end of input line
5332	MOV	BX,#lineend1	;end pos
5335	MOV	DX,#line0	;start pos
5338eselp	CMP.B	AL,[BX]	;space ?
533A	JNZ	eseret	;no: end found
533C	DEC	BX	;search backwards
533D	CMP	BX,DX	;beg reached ?
533F	JNZ	eselp	;no:continue
5341eseret	RET		;"
5342elimpos	MOV	DX,#lineend	;BX>end of line ?
5345	CMP	BX,DX
5347	JNB	eseret	;:ret
5349	MOV	DX,CX
534B	JMP	emin	;"min(BX,DX)->BX
534Eeflush	CALL	esrcend
5351	INC	BX	;search end of line + 1
5352efl2	MOV	CX,BX	;end position
5354	MOV	BX,bkbegl	;pos block beg in buf
5358	CALL	elimpos	;limit to end position
535B	MOV	bkbegl,BX
535F	MOV	BX,bkendl	;pos block beg in buf
5363	CALL	elimpos	;limit to end position
5366	MOV	bkendl,BX
536A	MOV	BX,CX	;restore end position
536C	INC	BX	;+1
536D	MOV	DX,#line	;- beg position
5370	SUB	BX,DX
5372	PUSH	BX	;-> length
5373	MOV	AL,oldlen	;old length - new length
5376	SUB.B	AL,BL
5378	MOV.B	CL,AL	;-> count
537A	MOV	CH,#$00
537C	JNB	eflpos	;:ok
537E	MOV	CH,#$FF	;negative
5380eflpos	MOV	BX,edpos	;current pos
5384	JZ	eflsame	;:no size change
5386	CALL	echgsize	;expand / shrink text
5389eflsame	POP	CX	;restore length
538A	MOV	SI,edpos	;destination pos
538E	MOV	BX,#line	;buffer pos
5391	MOV.B	CH,CL	;count
5393	OR.B	CH,CH	;test it
5395	JZ	eflend	;0:nothing to do
5397efllp	MOV.B	AL,[BX]	;get char
5399	CMP	BX,bkbegl	;= block beg ?
539D	JNZ	eflnbeg	;:no
539F	MOV	bkbeg,SI	;set block beg
53A3eflnbeg	CMP	BX,bkendl	;= block end ?
53A7	JNZ	eflnend	;:no
53A9	MOV	bkend,SI	;set block end
53ADeflnend	MOV.B	[SI],AL	;store char
53AF	INC	BX	;next char
53B0	INC	SI
53B1	DEC.B	CH	;another ?
53B3	JNZ	efllp	;:yes
53B5	DEC	SI	;go back one char
53B6eflend	MOV.B	[SI],#$0D	;store CR at end
53B9	RET		;"
53BAetstmem	MOV	BX,txmemend	;Test if memory full
53BE	SUB	BX,DX	;end text space - new text end
53C0	JB	etsterr	;:error
53C2	MOV	CX,#$00FE	;254 bytes left ?
53C5	SUB	BX,CX
53C7	JNB	etstret	;or more: ret
53C9	ADD	BX,CX	;restore
53CB	PUSH	BX
53CC	CALL	eclrs2	;clear status line
53CF	POP	BX	;number free bytes
53D0	MOV	CH,#$00
53D2	CALL	ewriterr	;write message
53D5	B	"WARNING: ",$00
53DF	CALL	edcvt	;display number
53E2	CALL	ewriterr	;write message
53E5	B	" byte(s) left",$00
53F3	CALL	waitesc	;wait for ESC
53F6etstret	RET		;'
53F7etsterr	CALL	eclrstat	;clear status line
53FA	CALL	ewriterr	;write message
53FD	B	"ERROR: Out of space",$00
5411	CALL	waitesc	;wait for ESC
5414	JMP	edmain	;"return to main loop
5417etstint	CMP	AL,#$15	;Test for interrupt
5419	JNZ	etstret	;:not ^U - ret
541B	CALL	eclrstat	;clear status line
541E	CALL	ewriterr	;write message
5421	B	"*** INTERRUPTED",$00
5431	CALL	waitesc	;wait for ESC
5434	JMP	edmain	;"go to main loop
5437echgsize	PUSH	BX	;Shrink or expand text
5438	PUSH	CX	;save pos,cnt
5439	JB	edinsert	;:insert, negative count
543B	JMP	edshrink	;'delete, positive count
543Eedinsert	MOV	DX,txend	;save text end
5442	PUSH	DX
5443	PUSH	DX
5444	XCHG	DX,BX	;text end - pos
5446	SUB	BX,DX
5448	MOV	BP,BX	;-> BP
544A	POP	BX	;text end
544B	PUSH	BP	;save (text end - pos)
544C	SUB	BX,CX	;text end - count
544E	JNB	etsterr	;:error - out of space
5450	MOV	DX,BX	;-> BX
5452	PUSH	DX	;save new text end
5453	CALL	etstmem	;test space free
5456	POP	DX	;restore new text end
5457	POP	CX	;restore count+1
5458	INC	CX
5459	POP	BX	;text end
545A	MOV	txend,DX	;set new text end
545E	OR	CX,CX	;test count
5460	JZ	edins2	;0:no move to do
5462	CALL	movebkb	;move block backwards
5465edins2	POP	CX	;restore difference
5466	POP	BX	;pos
5467	XCHG	BX,DX
5469	MOV	BX,bkbeg	;update pointers:
546D	CALL	edupdate	;block beg
5470	MOV	bkbeg,BX
5474	MOV	BX,bkend
5478	CALL	edupdate	;block end
547B	MOV	bkend,BX
547F	MOV	BX,disbeg
5483	CALL	edupdate	;display beg
5486	MOV	disbeg,BX
548A	MOV	BX,edpos
548E	CALL	edupdate	;pos current line
5491	MOV	edpos,BX
5495	MOV	BX,posfifo
5499	CALL	edupdate	;position FIFO
549C	MOV	posfifo,BX
54A0	MOV	BX,qppos
54A4	CALL	edupdate	;pos FIFO 2
54A7	MOV	qppos,BX
54AB	MOV	BX,srend
54AF	CALL	edupdate	;search limit end
54B2	MOV	srend,BX
54B6	MOV	BX,srbeg
54BA	CALL	edupdate	;search limit beg
54BD	MOV	srbeg,BX
54C1	RET		;"
54C2edupdate	CMP	BX,DX	;update pointer: >pos of change ?
54C4	JBE	edupret	;below/equal: no change
54C6	SUB	BX,CX	;change it
54C8edupret	RET		;"
54C9edshrink	PUSH	BX	;Shrink text: save pos
54CA	ADD	BX,CX	;+ count
54CC	PUSH	BX	;save
54CD	MOV	DX,txend	;text end+1
54D1	INC	DX
54D2	XCHG	DX,BX	;-pos-count
54D4	SUB	BX,DX
54D6	MOV	CX,BX	;-> move count
54D8	POP	BX	;restore source
54D9	POP	DX	;restore dest
54DA	OR	CX,CX	;test counter
54DC	JZ	edshnil	;:nothing to move
54DE	CALL	movebk	;move it - delete
54E1	DEC	DX	;end pos-1
54E2edshnil	MOV	txend,DX	;set new end pos
54E6	JMP	edins2	;"update pointers
54E9etstbk	PUSH	BX	;Test block markers in line buffer
54EA	MOV	DX,bkbegl	;pos block beg in buffer
54EE	CALL	emin	;min(BX,DX)->BX
54F1	TEST.B	attflg,#$01	;block beg in this line ?
54F6	JZ	etbnbeg	;:no
54F8	MOV	bkbegl,BX	;set it
54FCetbnbeg	POP	BX	;restore
54FD	TEST.B	attflg,#$02	;block end in this line ?
5502	JZ	etbnend	;:no
5504	MOV	DX,bkendl	;update it
5508	CALL	emin
550B	MOV	bkendl,BX
550Fetbnend	RET		;"
5510erepos	MOV	DX,#line	;Reposition in current line
5513	CS:		;ptr line beg
5514	MOV	AL,txwinx2	;column count - 1 -> CL
5517	DEC.B	AL
5519	MOV.B	CL,AL
551B	SUB	BX,DX	;relative pos -> BX
551D	MOV.B	AL,BL
551F	SUB.B	AL,horscr	;pos < hor scroll ?
5523	JB	erephscr	;yes: underflow
5525	CMP.B	AL,CL	;outside displayed window ?
5527	JB	erepcol	;no: ok
5529	SUB.B	AL,CL	;calc diff+1 (overflow)
552B	INC.B	AL
552D	ADD.B	AL,horscr	;add to horizontal scroll
5531	MOV	horscr,AL
5534	CS:	
5535	MOV	AL,txwinx2	;col cnt-2 -> phys col
5538	DEC.B	AL
553A	DEC.B	AL
553C	MOV	phcol,AL
553F	JMP	erewrall	;'redisplay all
5542erepcol	MOV	phcol,AL	;store phys col
5545erepret	RET		;'
5546erephscr	ADD.B	AL,horscr	;add to horizontal scroll
554A	MOV	horscr,AL
554D	MOV.B	phcol,#$00	;phys col 0
5552	JMP	erewrall	;"rewrite all
5555eseldisp	CMP.B	disflg,#$00	;Do selective rewrite
555A	JZ	erepret
555C	MOV	BX,disbeg	;display beg
5560	MOV	AX,txbeg	;text beg
5563	CMP	AX,BX	;the same ?
5565	JBE	esd2	;:yes
5567	MOV	disbeg,AX	;store to display beg
556A	MOV	BX,AX
556Cesd2	MOV	CX,#$0001	;line cnt
556F	MOV	DX,edpos	;current pos
5573	CMP	BX,DX	;= display beg ?
5575	JNZ	esd3	;:no
5577	JMP	esd9	;'yes: done
557Aesd3	JB	esddn	;below: search down
557Cesd4	MOV	DX,edpos	;current pos
5580	CMP	BX,DX	;= ?
5582	JZ	esd5
5584	CALL	elinup	;go up one line
5587	INC	CX	;count it
5588	JMP	esd4	;'
558Aesd5	MOV	disbeg,BX	;store display beg
558E	MOV.B	phrow,#$01	;phys row
5593	MOV.B	scrfl2,#$FF	;set flag
5598	XOR	AX,AX
559A	CS:	
559B	MOV	AL,txwiny2	;row cnt - 1
559E	SUB	AX,#$0001
55A1	CMP	AX,CX	;= line ?
55A3	JB	esdredsp	;below: ok
55A5	DEC	CX	;go back one line
55A6	MOV	BX,#$0001	;set cursor pos:
55A9	CALL	esetcur	;below status line
55AC	DEC	CX	;test it
55AD	PUSHF	
55AE	INC	CX	;restore
55AFesdinsl	CALL	xinsline	;InsLine
55B2	LOOP	esdinsl	;:again
55B4	POPF		;one only ?
55B5	JNZ	esdredsp	;no: do redisplay
55B7	RET		;'
55B8esdredsp	JMP	eredall	;'redisplay all
55BBesddn	CMP	BX,edpos	;>= current pos
55BF	JNB	esd6	;:not yet
55C1	CALL	elindn	;go down one line
55C4	INC	CX	;count
55C5	JMP	esddn	;'
55C7esd6	OR.B	CH,CH	;clear count
55C9	JNZ	esd10	;:much
55CB	CS:	
55CC	MOV	AL,txwiny2	;line count-1 -> DL
55CF	DEC.B	AL
55D1	MOV.B	DL,AL
55D3	MOV.B	AL,CL	;counter-line cnt+1 -> DH
55D5	SUB.B	AL,DL
55D7	MOV.B	DH,AL
55D9	INC.B	DH
55DB	JB	esd9	;:ok
55DD	DEC.B	DH	;test it
55DF	JNZ	esd7
55E1	CMP.B	scrfl1,#$FF	;test flag
55E6	JNZ	esd7	;:normal
55E8	JMP.b	esd11	;'keep it short
55EA	NOP	
55EBesd7	INC.B	DH
55ED	SUB.B	AL,DL
55EF	JNB	esd10
55F1	MOV	AL,dislin	;redisplay from
55F4	SUB.B	AL,DH
55F6	JBE	esd10
55F8	MOV	dislin,AL	;set it
55FB	MOV	BX,disbeg	;display beg
55FF	MOV.B	CH,DH
5601	PUSH	DX
5602esdscrl	CALL	elindn	;go down one line
5605	PUSH	BX	;save pos
5606	CALL	escrolup	;scroll up
5609	POP	BX	;restore
560A	DEC.B	CH	;count down
560C	JNZ	esdscrl	;:another
560E	MOV	disbeg,BX	;store display beg
5612	POP	DX
5613esd8	DEC.B	DL
5615	MOV.B	phrow,DL	;phys row
5619	RET		;'
561Aesd9	MOV.B	phrow,CL
561E	RET		;'
561Fesd10	MOV	BX,disbeg
5623	DEC	CX
5624	CS:		;line cnt - 3 -> DL
5625	MOV	AL,txwiny2
5628	SUB	AL,#$03
562A	MOV.B	DL,AL
562C	MOV.B	AL,CL
562E	SUB.B	AL,DL
5630	MOV.B	CL,AL
5632	JNB	esddn2
5634	DEC.B	CH
5636esddn2	CALL	elindn	;go down one line
5639	LOOP	esddn2	;:again
563B	MOV	disbeg,BX	;store display beg
563F	CALL	eredall	;redisplay all
5642	MOV.B	scrfl2,#$FF	;set flag: long update
5647	JMP	eseldisp	;'do it again
564Aesd11	CALL	esd8	;set phys row
564D	MOV	AL,dislin	;redisplay from
5650	CS:	
5651	CMP.B	AL,txwiny2	;= line cnt ?
5655	JZ	esd12	;:yes
5657	DEC.B	AL
5659	JZ	esd12
565B	MOV	dislin,AL	;set: redisplay from
565Eesd12	MOV	BX,disbeg	;display beg
5662	CALL	elindn	;go down one line
5665	MOV	disbeg,BX	;-> new display beg
5669	CALL	escrolup	;scroll up
566C	CS:	
566D	MOV	AL,txwiny2	;line cnt - 1
5670	DEC.B	AL
5672	JMP	edsplin	;"redisplay one line
5675etstsep	MOV	SI,sepptr	;Char = separator ?
5679etslp	CS:		;get ptr to table
567A	MOV.B	AL,[SI]	;get char from table
567C	OR.B	AL,AL	;table end ?
567E	JZ	etsno	;:yes
5680	CMP.B	AL,[BX]	;= text char ?
5682	JZ	etsyes	;:yes
5684	INC	SI	;try next char
5685	JMP	etslp	;'
5687etsyes	STC		;found it !
5688etsno	MOV	DX,SI	;DX=pos in table
568A	RET		;"
568B	LAHF		;redisplay current line
568C	PUSH	AX	;save
568D	MOV	AL,phrow	;phys row
5690	CMP.B	AL,dislin	;>= redisplay from ?
5694	JNB	erc2	;:ok
5696	MOV	dislin,AL	;redisplay current line, too !
5699erc2	POP	AX	;restore
569A	SAHF	
569B	RET		;"
569Ceredall	MOV.B	dislin,#$01	;set flag: redisplay all
56A1	RET		;"
56A2eblkupdt	XCHG	BX,DX	;Update blocks
56A4	TEST.B	attflg,#$01	;block beg in this line ?
56A9	JZ	ebunobk	;:no
56AB	MOV	BX,bkbegl	;pos block in buffer
56AF	CMP	BX,DX	;< BX ?
56B1	JB	ebunobk	;:ok
56B3	ADD	BX,CX	;add count
56B5	MOV	bkbegl,BX	;-> update
56B9ebunobk	TEST.B	attflg,#$02	;block end in this line ?
56BE	JZ	ebunochg	;:no
56C0	MOV	BX,bkendl	;pos block end in buffer
56C4	CMP	BX,DX	;< BX ?
56C6	JB	ebunochg	;:ok
56C8	ADD	BX,CX	;add count
56CA	MOV	bkendl,BX	;-> update
56CEebunochg	XCHG	BX,DX	;restore BX
56D0	RET		;"
56D1edelch	PUSH	BX	;delete char: save pos
56D2	MOV	CX,#$FFFF	;1 char back
56D5	CALL	eblkupdt	;update blocks
56D8	XCHG	BX,DX	;pos -> DX
56DA	MOV	BX,#lineend1	;buffer end
56DD	SUB	BX,DX	;calculate count
56DF	JZ	edelcnil	;:nothing to move
56E1	MOV	CX,BX	;count -> CX
56E3	MOV	BX,DX	;pos -> BX
56E5	INC	BX	;source: +1
56E6	CALL	movebk	;move it
56E9edelcnil	MOV	BX,#lineend1	;store a space at the end
56EC	MOV.B	[BX],#$20
56EF	POP	BX	;restore pos
56F0	RET		;"
56F1emin	CMP	BX,DX	;min(BX,DX) -> BX
56F3	JB	emin2	;max(BX,DX) -> DX
56F5	XCHG	BX,DX
56F7emin2	RET		;"
56F8eredlin	CALL	eposcur	;redisplay line: set cursor pos
56FB	CS:	
56FC	MOV	AL,txwinx2	;col cnt - 1
56FF	DEC.B	AL
5701	SUB.B	AL,phcol	;- phys col
5705	MOV	BX,lnpos	;pos in line buffer
5709	MOV.B	attchg,#$FF	;attribute change in this line
570E	CALL	escrdma2	;redisplay this line
5711	MOV.B	attchg,#$00	;clear attribute flag
5716	RET		;"
5717elindn	MOV	BP,CX	;go down one line
5719	MOV	CX,txend	;text end
571D	MOV	DI,BX	;current pos
571F	SUB	CX,DI	;text end-pos -> count
5721	JBE	eld2	;:too much
5723	MOV	AX,DS	;DS -> ES
5725	MOV	ES,AX
5727	CLD		;search LF
5728	MOV	AL,#$0A
572A	REPNZ	
572B	SCAS.B	
572C	JNZ	eld2	;:not found
572E	MOV	CX,BP	;restore CX
5730	MOV	BX,DI	;pos of line break
5732	RET		;'
5733eld2	MOV	CX,BP	;restore CX
5735	STC		;flag: not done
5736	RET		;"
5737elinup	MOV	BP,BX	;go up one line
5739	MOV	AL,#$0A	;search LF
573B	MOV	DI,txbeg	;text beg = limit
573F	DEC	BX	;go back one char
5740elulp	DEC	BX	;go back
5741	CMP	BX,DI	;= end ?
5743	JBE	eluend	;:yes
5745	CMP.B	[BX],AL	;LF ?
5747	JNZ	elulp	;:no, try again
5749	INC	BX	;go to beg of line
574Aeluend	JB	eluerr	;:not found
574C	RET		;'
574Deluerr	MOV	BX,BP	;restore pos
574F	RET		;"
5750einsch	PUSH	BX	;insert char in line
5751	MOV	CX,#$0001	;1 char
5754	CALL	eblkupdt	;update blocks
5757	MOV	DX,#lineend1	;buffer end
575A	XCHG	BX,DX	;calc count
575C	SUB	BX,DX
575E	DEC	BX
575F	MOV	CX,BX
5761	MOV	DX,#lineend0	;buffer end
5764	MOV	BX,DX
5766	DEC	BX
5767	MOV.B	AL,CL	;test length
5769	OR.B	AL,CH	;did they translate this automatically
576B	JZ	einscnil	;from Z80-code ??!!
576D	PUSH	DX	;save pos
576E	CALL	movebkb	;insert
5771	POP	BX	;restore pos
5772	MOV.B	[BX],#$20	;store a space
5775einscnil	POP	BX	;restore pos
5776	RET		;"
5777ewritpos	CALL	esetcur	;Write string + pos cursor
577Aewrits	CALL	klowvid	;LowVideo
577D	JMP	prints	;"write string
5780ewriterr	CALL	vidattr3	;Attribute #3
5783	JMP	prints	;"write string: error message
5786ewritch	CMP.B	disflg,#$FF	;editing status
578B	JNZ	ewritret	;:ret
578D	JMP	conput	;"write it
5790ekbdstat	PUSH	AX	;Get KBD stat
5791	PUSH	BX
5792	PUSH	CX
5793	PUSH	DX
5794	DEC	SP
5795	CALL	[vkbdstat]	;do it
5799	POP	DX
579A	POP	CX
579B	POP	BX
579C	POP	AX
579Dewritret	RET		;"
579Eesetcur	CMP.B	disflg,#$00	;set cursor pos
57A3	JZ	escrt
57A5	MOV.B	scrrow,BL	;line
57A9	XCHG	BX,DX
57AB	CALL	setcpos	;set it
57AE	XCHG	BX,DX	;restore
57B0escrt	RET		;"
	;first command table (installed with TINST)
57B1ecmd1	B	$01,$0D,$02,$1B,$4B,$01,$FF,$02,$1B,$4D,$02,$1B,$73,$02
57BF	B	$1B,$74,$02,$1B,$48,$02,$1B,$50,$01,$FF,$01,$FF,$02,$1B
57CD	B	$49,$02,$1B,$51,$02,$1B,$47,$02,$1B,$4F,$02,$1B,$77,$02
57DB	B	$1B,$75,$02,$1B,$84,$02,$1B,$76,$01,$FF,$01,$FF,$01,$FF
57E9	B	$02,$1B,$52,$01,$FF,$01,$FF,$01,$FF,$01,$FF,$02,$1B,$53
57F7	B	$01,$08,$01,$FF,$02,$1B,$41,$02,$1B,$42,$01,$FF,$01,$FF
5805	B	$01,$FF,$01,$FF,$01,$FF,$01,$FF,$01,$FF,$01,$FF,$01,$FF
5813	B	$01,$FF,$01,$FF,$01,$FF,$01,$FF,$01,$FF,$01,$FF,$00,$00
5821	B	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
582F	B	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
583D	B	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
584B	B	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
5859	B	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
5867	B	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
5875	B	$00,$00,$00,$00	;"
	;second command line (preinstalled)
5879ecmd2	B	$01,$0D,$01,$13,$01,$08,$01,$04,$01,$01,$01,$06,$01,$05
5887	B	$01,$18,$01,$17,$01,$1A,$01,$12,$01,$03,$02,$11,$13,$02
5895	B	$11,$04,$02,$11,$05,$02,$11,$18,$02,$11,$12,$02,$11,$03
58A3	B	$02,$11,$02,$02,$11,$0B,$02,$11,$10,$01,$16,$01,$0E,$01
58B1	B	$19,$02,$11,$19,$01,$14,$01,$07,$01,$7F,$01,$FF,$02,$0B
58BF	B	$02,$02,$0B,$0B,$02,$0B,$14,$02,$0B,$08,$02,$0B,$03,$02
58CD	B	$0B,$16,$02,$0B,$19,$02,$0B,$12,$02,$0B,$17,$02,$0B,$04
58DB	B	$01,$09,$02,$11,$09,$02,$11,$0C,$02,$11,$06,$02,$11,$01
58E9	B	$01,$0C,$01,$10,$00	;"
58EEeseptab	B	"<>,[].*+-/$:=(){}^#\'"
5903esepspc	B	" ",$00	;"
	;Jump table for editor commands
	;Labels ending with 2 have the MSB set. On these commands
	;the text is marked as changed. The commands are in the order
	;given in the chapter "Editing Command Installation" of the
	;Turbo manual.
5905ejmptab	W	ecr,eleft,eleft,eright,ewrdlft,ewrdrt,eup,edn,escrup,escrdn
5919	W	epagup,epagdn,ejlnbeg,ejlnend,epagtop,epagbot,etxtbeg
5927	W	ejtxend,ejbkbeg,ejbkend,elstpos,etogovr,elinins2,edellin2
5935	W	edeleol2,edelwrd2,edelrt2,edellft2,edellft2,emarkbeg,emarkend
5943	W	emrkwrd,ekh,eblkcpy2,eblkmov2,eblkdel2,eblkrd2,ekw,ekd
5953	W	etab2,etogind,erstlin2,efind,ereplace,erepeat,eprefix2	;"
	;*** Compiler ***
5961turbo	MOV	spsav,SP	;save stack pointer
5965	CMP.B	cpmode,#$02	;to COM or CHN ?
596A	JB	turmem	;:no
596C	CMP.B	txcomp,#$00	;is it already compiled ?
5971	JZ	turmem	;:no
5973	CMP.B	cdinval,#$00	;is it invalid ?
5978	JNZ	turmem	;:yes
597A	CALL	opendest	;open dest file
597D	CALL	cvmemdsk	;change to disk code
5980	JMP.b	turret	;'no error
5982turmem	CALL	inittur	;init variables
5985	CMP.B	cpmode,#$00	;to memory ?
598A	JNZ	turfil	;:no
598C	CALL	copyrt	;make space, copy run-time lib
598F	JMP.b	turmem2	;'
5991turfil	CMP.B	cpmode,#$02	;COM / CHN ?
5996	JB	turmem2	;:no
5998	CALL	opendest	;open dest file
599Bturmem2	CALL	compile	;compile program
599E	CMP.B	cpmode,#$00	;memory ?
59A3	JNZ	turfil2	;:no
59A5	MOV.B	txcomp,#$FF	;set flag: compiled
59AA	JMP.b	turret	;'
59ACturfil2	CMP.B	cpmode,#$02	;COM / CHN ?
59B1	JB	turret	;:no
59B3	CALL	codflush	;flush code buffer
59B6turret	XOR.B	AL,AL
59B8	JMP	errexit	;"return: no error
59BBinittur	MOV.B	txcomp,#$00	;Init variables: not compiled
59C0	MOV.B	cdinval,#$00	;code invalid
59C5	MOV	BX,txend	;store ^Z at source end
59C9	MOV.B	[BX],#$1A
59CC	MOV	CL,#$04	;(size/16)+1+DS
59CE	SHR	BX,CL
59D0	INC	BX
59D1	MOV	AX,DS
59D3	ADD	AX,BX
59D5	MOV	destseg,AX	;-> code dest segment
59D8	MOV	AX,freemem	;free memory - size
59DB	SUB	AX,BX
59DD	MOV	minstksz,AX	;-> minimum stack size
59E0	MOV	DI,stackpt	;stack pointer - 1024
59E4	SUB	DI,#$0400
59E8	MOV	ptcend,DI	;-> end of patch list space
59EC	SUB	DI,#$0400	;- 1024
59F0	MOV	ptctop,DI	;-> top of patch list
59F4	MOV	ptcbeg,DI	;-> beg of patch list
59F8	DEC	DI	;destination for var table
59F9	MOV	SI,#stdvars	;copy std vars into symbol table
59FC	MOV	CX,SS	;SS -> ES
59FE	MOV	ES,CX
5A00	PUSH	DS	;save DS
5A01	MOV	CX,CS	;CS -> DS
5A03	MOV	DS,CX
5A05	MOV	CX,#$036A	;count
5A08	STD	
5A09	REPZ	
5A0A	MOVS.B	
5A0B	POP	DS	;restore DS
5A0C	INC	DI
5A0D	MOV	symtop,DI	;-> top of symtab
5A11	MOV	symtop2,DI
5A15	MOV	fence,DI	;-> current var fence
5A19	MOV	BX,#varpatch	;patch in ptrs to type defs
5A1C	MOV	CX,#$0019
5A1Fitpatch	CS:	
5A20	MOV	BP,[BX]	;pointer
5A22	ADD	[BP_DI],DI	;+ offset
5A24	INC	BX
5A25	INC	BX	;next one
5A26	LOOP	itpatch	;:another one
5A28	MOV	AX,txbeg	;text beg
5A2B	MOV	srcptr,AX	;-> src ptr
5A2E	MOV	DI,#pnbuf	;line buffer
5A31	MOV	chptr,DI	;-> char ptr
5A35	MOV.B	[DI],#$00	;clear line
5A38	XOR	AX,AX	;clear vars:
5A3A	MOV	recnum,AL	;record nesting
5A3D	MOV	reccnt,AL
5A40	MOV	lexnest,AL	;lexical nesting
5A43	MOV	srcend,AL	;not end of source
5A46	MOV	flgpshax,AL	;no PUSH AX
5A49	MOV	flgpshes,AL	;no PUSH ES
5A4C	MOV	flgpshdi,AL	;no PUSH DI
5A4F	MOV	usrint,AL	;user int not used
5A52	MOV	ovrcnt,AL	;no overlays used
5A55	MOV	inclflg,AL	;no include
5A58	MOV	cdptr,AX	;code ptr
5A5B	MOV	cdbufpt,AX	;code pos in buffer
5A5E	MOV	cdbegpt,AX	;beg of code buffer
5A61	MOV	cdfoff,AX	;current file offset
5A64	MOV	cdfoff1,AX
5A67	MOV	lincnt,AX	;line counter
5A6A	MOV	cinpsize,AX	;std in buffer size
5A6D	MOV	coutsize,AX	;std out buffer size
5A70	MOV	cmaxfil,#$0010	;max 16 open files
5A76	MOV.B	scalcnt,#$0D	;counter for scalar types
5A7B	MOV	direct,#$00ED	;set compiler directive
5A81	CALL	disline	;display line, test brk
5A84	MOV	pc,#$2D7C	;PC: start of code
5A8A	MOV	dc,#$0240	;DC: start of file list
5A90	CMP.B	cpmode,#$02	;COM ?
5A95	JZ	itcom	;:yes
5A97	JA	itret	;CHN:ret
5A99	MOV	cdptr,#$2D7C	;code pos of buffer
5A9F	RET		;'
5AA0itcom	MOV	cdptr,#$2C7C	;code ptr
5AA6	MOV	cdbufpt,#$2C7C	;code pos of buffer
5AACitret	RET		;"
5AADcopyrt	MOV	AX,#start	;Test for memory overflow
5AB0	MOV	cdptr,AX
5AB3	MOV	CL,#$04	;(../16)+1
5AB5	SHR	AX,CL
5AB7	INC	AX
5AB8	ADD	AX,destseg	;+ dest segment
5ABC	MOV	BX,symtop	;(symtop/16)+SS
5AC0	SHR	BX,CL
5AC2	MOV	CX,SS
5AC4	ADD	BX,CX
5AC6	CMP	AX,BX	;compare them
5AC8	CALL	errnb	;99:compiler overflow
5ACB	B	$63
5ACC	XOR	SI,SI	;clear addr
5ACE	XOR	DI,DI
5AD0	MOV	ES,destseg	;dest seg
5AD4	PUSH	DS	;save DS
5AD5	PUSH	CS	;CS -> DS
5AD6	POP	DS
5AD7	MOV	CX,#start	;copy runtime library into code
5ADA	CLD	
5ADB	REPZ	
5ADC	MOVS.B	
5ADD	POP	DS	;restore DS
5ADE	RET		;"
5ADFopendest	MOV	AH,#$3C	;Open dest file
5AE1	XOR	CX,CX	;no attribute
5AE3	MOV	DX,#destpn	;dest name ptr
5AE6	PUSH	DS	;DS -> ES
5AE7	POP	ES
5AE8	CALL	dos	;create it
5AEB	CALL	errb
5AEE	B	$C9
5AEF	MOV	dstfile,AX	;store file handle
5AF2	CMP.B	cpmode,#$02	;COM file ?
5AF7	JNZ	odret	;:no
5AF9	MOV	BX,AX	;file handle
5AFB	MOV	AH,#$40	;write byte block
5AFD	MOV	CX,#$2C7C	;size of runtime code
5B00	MOV	DX,#$0100	;offset
5B03	PUSH	DS	;save DS
5B04	PUSH	CS	;CS -> DS
5B05	POP	DS
5B06	CALL	dos	;write runtime library
5B09	POP	DS	;restore DS
5B0A	JB	oderr	;:error
5B0C	CMP	AX,CX	;length = expected ?
5B0E	JNZ	oderr	;no: error
5B10odret	RET		;'
5B11oderr	CALL	err	;C9:dest file not written
5B14	B	$C9	;"
5B15cvmemdsk	PUSH	DS	;Change mem code to disk code
5B16	PUSH	DS	;save DS
5B17	POP	ES	;DS -> ES
5B18	MOV	DS,destseg	;code dest segment
5B1C	MOV	SI,#memparm	;ptr to memory parameters
5B1F	MOV	DI,#pnbuf	;dest: buffer
5B22	MOV	CX,#$0007	;7 words
5B25	CLD	
5B26	REPZ	
5B27	MOVS		;move it into buffer
5B28	PUSH	DS	;DS -> ES
5B29	POP	ES
5B2A	POP	DS	;restore DS
5B2B	MOV	DI,#memparm	;ptr to memory parameters
5B2E	ES:	
5B2F	AND	[DI],#$FFFE	;clear direct mode
5B33	MOV	AX,codesize	;code size > min CS size ?
5B36	CMP	AX,mincssz
5B3A	JNB	cvdcs	;:ok
5B3C	MOV	AX,mincssz	;at least min CS size
5B3Fcvdcs	ES:	
5B40	MOV	[DI]$06,AX	;store CS size
5B43	MOV	AX,datasize	;data size > min DS size ?
5B46	CMP	AX,mindssz
5B4A	JNB	cvdds	;:ok
5B4C	MOV	AX,mindssz	;at least min DS size
5B4Fcvdds	ES:	
5B50	MOV	[DI]$08,AX	;store DS size
5B53	MOV	AX,minhpsz	;min free heap
5B56	ES:	
5B57	MOV	[DI]$0A,AX	;-> heap, stack size
5B5A	CMP	AX,maxhpsz	;> max free heap ?
5B5E	JNB	cvdhp	;:yes
5B60	MOV	AX,maxhpsz	;take that size
5B63cvdhp	ES:	
5B64	MOV	[DI]$0C,AX	;store max heap,stack size
5B67	MOV	AH,#$40	;Write code to disk
5B69	MOV	BX,dstfile	;dest file handle
5B6D	MOV	CX,cdptr	;code end
5B71	MOV	DX,#start	;offset: end of run-time
5B74	SUB	CX,DX	;calc length
5B76	PUSH	DS	;save DS
5B77	PUSH	ES	;ES -> DS
5B78	POP	DS
5B79	CALL	dos	;write it
5B7C	POP	DS	;restore DS
5B7D	PUSH	AX	;save results
5B7E	PUSH	CX
5B7F	PUSHF	
5B80	MOV	SI,#pnbuf	;restore memory code
5B83	MOV	DI,#memparm
5B86	MOV	ES,destseg
5B8A	MOV	CX,#$0007	;7 words
5B8D	CLD	
5B8E	REPZ		;do it
5B8F	MOVS	
5B90	POPF		;restore results
5B91	POP	CX
5B92	POP	AX
5B93	JB	cvderr	;:error
5B95	CMP	AX,CX	;length = expected ?
5B97	JNZ	cvderr	;:no
5B99	RET		;'
5B9Acvderr	CALL	err	;C9:file error
5B9D	B	$C9	;"
5B9Ecompile	CALL	skip	;Compile program: get word
5BA1	CALL	ctoken	;PROGRAM ?
5BA4	W	tkprog
5BA6	JNZ	comnoprm	;:no
5BA8	CALL	dummysym	;read dummy symbol
5BAB	CALL	cbrack1	;( ?
5BAE	JNZ	comprmen	;:no
5BB0comprmlp	CALL	dummysym	;read dummy symbol
5BB3	CALL	ccomma	;, ?
5BB6	JZ	comprmlp	;yes: repeat
5BB8	CALL	ebrack2	;! )
5BBBcomprmen	CALL	esemi	;! ;
5BBEcomnoprm	MOV	AX,#initmem	;* CALL initmem
5BC1	CALL	ecall	;emit CALL
5BC4	XOR	AX,AX	;set mode flag
5BC6	CMP.B	cpmode,#$00	;to memory ?
5BCB	JNZ	comcom	;:no
5BCD	OR	AX,#$0001	;flag: direct mode
5BD0comcom	TEST	direct,#$0080	;device checking ?
5BD6	JZ	comdevck	;:no
5BD8	OR	AX,#$0002	;set flag
5BDBcomdevck	TEST	direct,#$0008	;test ^C and ^S ?
5BE1	JZ	comctcs	;:no
5BE3	OR	AX,#$0004	;set flag
5BE6comctcs	PUSH	AX	;save flag
5BE7	PUSH	cdptr	;save code ptr
5BEB	CALL	eword	;emit mode flag
5BEE	MOV	AX,CS	;emit Turbo CS
5BF0	CALL	eword
5BF3	MOV	AX,DS	;emit Turbo DS
5BF5	CALL	eword
5BF8	PUSH	cdptr	;save code ptr
5BFC	CALL	eword	;emit 4 dummy words:
5BFF	CALL	eword	;memory size is not yet known
5C02	CALL	eword
5C05	CALL	eword
5C08	MOV	AX,cmaxfil	;max number of open files
5C0B	ADD	dc,AX	;add to data counter
5C0F	ADD	dc,AX	;(file handle list)
5C13	CALL	eword	;emit file count
5C16	MOV	AX,cinpsize	;std in buf size
5C19	ADD	dc,AX	;add to DC
5C1D	CALL	eword	;emit
5C20	MOV	AX,coutsize	;std out buf size
5C23	ADD	dc,AX	;add to DC
5C27	CALL	eword	;emit
5C2A	CALL	ecode	;* MOV BP,SP
5C2D	B	$02,$8B,$EC
5C30	MOV	varspc,#$0000	;clear var space used
5C36	CALL	emcrunch	;emit overlay uncrunch
5C39	CALL	defpart	;declaration part
5C3C	CALL	progpart	;program part
5C3F	MOV	DI,chptr
5C43	CMP.B	[DI],#$2E
5C46	CALL	errnz
5C49	B	$0A
5C4A	CALL	ecode	;* XOR AX,AX
5C4D	B	$02,$33,$C0
5C50	MOV	AX,#progend	;* CALL progend
5C53	CALL	ecall
5C56	CALL	ptcrunch	;end overlay crunch list
5C59	MOV	AX,pc	;(PC+15)/16
5C5C	ADD	AX,#$000F
5C5F	MOV	CL,#$04
5C61	SHR	AX,CL
5C63	MOV	codesize,AX	;-> CS size
5C66	MOV	AX,dc	;(DC+15)/16
5C69	ADD	AX,#$000F
5C6C	MOV	CL,#$04
5C6E	SHR	AX,CL
5C70	MOV	datasize,AX	;-> DS size
5C73	POP	BX	;code ptr: memory sizes
5C74	MOV	AX,codesize	;CS size > min CS size ?
5C77	CMP	AX,mincssz
5C7B	JNB	comcs	;:ok
5C7D	MOV	AX,mincssz	;at least min CS size
5C80comcs	CALL	patch	;patch in
5C83	INC	BX
5C84	INC	BX
5C85	MOV	AX,datasize	;DS size > min DS size ?
5C88	CMP	AX,mindssz
5C8C	JNB	comds	;:ok
5C8E	MOV	AX,mindssz	;at least min DS size
5C91comds	CALL	patch	;patch in
5C94	INC	BX
5C95	INC	BX
5C96	MOV	AX,minhpsz	;min free heap
5C99	CMP.B	cpmode,#$02	;COM / CHN ?
5C9E	JNB	comfile	;:yes
5CA0	MOV	AX,minstksz	;min stack size
5CA3	SUB	AX,codesize	;- code size - data size
5CA7	SUB	AX,datasize
5CAB	MOV	minstksz,AX	;-> min stack size
5CAEcomfile	PUSH	AX	;save it
5CAF	CALL	patch	;patch in
5CB2	POP	AX	;restore
5CB3	INC	BX
5CB4	INC	BX
5CB5	CMP	AX,maxhpsz	;> max free heap size ?
5CB9	JNB	comhp	;:ok
5CBB	MOV	AX,maxhpsz	;at least max free heap
5CBEcomhp	CALL	patch	;patch in
5CC1	POP	BX	;code ptr mode flag
5CC2	POP	AX	;flag
5CC3	CMP.B	usrint,#$00	;user interrupt used ?
5CC8	JZ	comnobrk	;:no
5CCA	OR	AX,#$0008	;set flag: user interrupt
5CCDcomnobrk	CALL	patch	;patch in
5CD0	JMP	ptcflush	;"patch code in file
5CD3dummysym	PUSH	symtop	;read dummy symbol
5CD7	CALL	rdsym	;read symbol
5CDA	POP	symtop	;restore symtob: forget symbol read
5CDE	RET		;"
5CDFchkovrfl	PUSH	AX	;Test for overflow
5CE0	PUSH	BX
5CE1	PUSH	CX	;save regs
5CE2	CMP.B	cpmode,#$00	;to memory ?
5CE7	JNZ	ckvfil	;:no
5CE9	MOV	AX,pc	;(PC/16)+1
5CEC	MOV	CL,#$04
5CEE	SHR	AX,CL
5CF0	INC	AX
5CF1	MOV	BX,dc	;+(DC/16)+64
5CF5	MOV	CL,#$04
5CF7	SHR	BX,CL
5CF9	ADD	BX,AX
5CFB	ADD	BX,#$40
5CFE	CMP	BX,minstksz	;>= free memory ?
5D02	CALL	errnb	;98:memory overflow
5D05	B	$62
5D06	JMP.b	ckvmem	;'ok
5D08ckvfil	MOV	AX,cdptr	;code ptr
5D0B	SUB	AX,cdbufpt	;-code pos of buffer
5D0F	ADD	AX,cdbegpt	;+beg of code buffer
5D13	MOV	CL,#$04	;convert to paragraphs
5D15	SHR	AX,CL
5D17	INC	AX
5D18ckvmem	ADD	AX,destseg	;+ dest segment
5D1C	ADD	AX,#$0020	;+ spare
5D1F	MOV	BX,symtop	;(symtab top/16)+SS
5D23	SHR	BX,CL
5D25	MOV	CX,SS
5D27	ADD	BX,CX
5D29	CMP	AX,BX	;crash ?
5D2B	JB	ckvok	;:no
5D2D	PUSH	DX	;save
5D2E	CALL	codflush	;flush code buffer
5D31	CALL	errb	;99:compiler overflow
5D34	B	$63
5D35	POP	DX	;restore
5D36ckvok	POP	CX	;restore regs
5D37	POP	BX
5D38	POP	AX
5D39	RET		;"
5D3Aalpha	CMP	AL,#$41	;valid symbol char ?
5D3C	JB	alpharet	;:no
5D3E	CMP	AL,#$5B	;A..Z ?
5D40	CMC	
5D41	JNB	alpharet	;:ok
5D43	CMP	AL,#$5F	;_ ?
5D45	JZ	alpharet	;yes: ok
5D47	CMP	AL,#$61	;a..z ?
5D49	JB	alpharet	;:no
5D4B	CMP	AL,#$7B
5D4D	CMC	
5D4Ealpharet	RET		;"
5D4Falphanum	CALL	alpha	;valid alphanumeric char ?
5D52	JNB	alnret	;:ok
5D54number	CMP	AL,#$30	;0..9 ?
5D56	JB	alnret	;:no
5D58	CMP	AL,#$3A
5D5A	CMC	
5D5Balnret	RET		;"
5D5Cperrb	MOV	chptr,DI	;Error if below: store error pos
5D60errb	JNB	skiperr	;:no error
5D62	JMP.b	err	;'
5D64	MOV	chptr,DI	;Error if not below
5D68errnb	JB	skiperr	;:no error
5D6A	JMP.b	err	;'
5D6Cperrz	MOV	chptr,DI	;Error if equal
5D70errz	JNZ	skiperr	;:no error
5D72	JMP.b	err	;'
5D74perrnz	MOV	chptr,DI	;Error if not equal
5D78errnz	JNZ	err	;:error
5D7Askiperr	PUSH	BP	;no error: skip inline parameter
5D7B	MOV	BP,SP
5D7D	INC	[BP]$02
5D80	POP	BP
5D81	RET		;'
5D82perr	MOV	chptr,DI	;store error position
5D86err	POP	BX	;Error: get return addr
5D87	CS:	
5D88	MOV.B	AL,[BX]	;get error number (inline)
5D8Aerrexit	MOV	cperr,AL	;store it
5D8D	CALL	disline	;write line number
5D90	OR.B	AL,AL	;test error
5D92	JZ	exitcom	;:no error
5D94	MOV	AX,chptr	;calculate error position
5D97	SUB	AX,#pnbuf	;pos in buffer - buffer beg
5D9A	CMP.B	inclflg,#$00	;include file ?
5D9F	JNZ	errfil	;:yes
5DA1	SUB	AX,txbeg	;- text beg
5DA5	ADD	AX,srclnbeg	;+ beginning of source line
5DA9	JMP.b	errmem	;'
5DABerrfil	ADD	AX,srclnbg	;pos of line begin
5DAFerrmem	MOV	txerrpos,AX	;store relative error pos
5DB2exitcom	MOV	AH,#$80	;close all files
5DB4	CALL	dos
5DB7	MOV	SP,spsav	;restore stack pointer
5DBB	RET		;"return to user-interface
5DBCdefpart	PUSH	cdptr	;Definition part: save code pointer
5DC0	CALL	ejump	;* JMP ....
5DC3	PUSH	pc	;save PC
5DC7defloop	CALL	ckey	;search keyword
5DCA	B	$01	;offset between keywords
5DCB	W	tklabel	;keyword pointer
5DCD	CALL	errnz	;not found ?
5DD0	B	$0C	;12:BEGIN expected
5DD1deflab	CMP	AL,#$01	;LABEL ?
5DD3	JNZ	defconst	;:no
5DD5	CALL	label	;do label
5DD8	JMP	defloop	;'next def
5DDAdefconst	CMP	AL,#$02	;CONST ?
5DDC	JNZ	deftype	;:no
5DDE	CALL	const	;do const
5DE1	JMP	deflab	;'next def, already searched
5DE3deftype	CMP	AL,#$03	;TYPE ?
5DE5	JNZ	defvar	;:no
5DE7	CALL	type	;do type
5DEA	JMP	deflab	;'next def
5DECdefvar	CMP	AL,#$04	;VAR ?
5DEE	JNZ	defover	;:no
5DF0	CALL	var	;do var
5DF3	JMP	deflab	;'next def
5DF5defover	CMP	AL,#$07	;OVERLAY ?
5DF7	JNZ	defproc	;:no
5DF9	CALL	overlay	;do overlay
5DFC	JMP	defloop	;'next def
5DFEdefproc	CMP	AL,#$08	;BEGIN ?
5E00	JZ	defend	;:yes
5E02	MOV.B	ovrproc,#$00	;flag: not overlay procedure
5E07	CALL	procfunc	;do procedure / function def
5E0A	JMP	defloop	;'next def
5E0Cdefend	CALL	resforw	;resolve forward definitions
5E0F	POP	CX	;restore beginning PC
5E10	MOV	AX,pc	;new PC
5E13	SUB	AX,CX	;calc offset
5E15	POP	BX	;code ptr of beginning
5E16	INC	BX	;+1: offset
5E17	JMP	patch	;"patch it
5E1Aemcrunch	MOV	AX,#uncrunch	;emit code for overlay uncrunch
5E1D	CALL	ecall	;* CALL uncrunch
5E20	MOV	AX,cdptr	;code ptr
5E23	MOV	uncrlink,AX	;-> link
5E26	CALL	eword	;emit it (dummy)
5E29	MOV	AX,pc	;PC+2
5E2C	INC	AX
5E2D	INC	AX
5E2E	JMP	eword	;"emit it
5E31ptcrunch	MOV	BX,uncrlink	;do overlay uncrunch list
5E35	MOV	AX,cdptr	;code ptr
5E38	SUB	AX,BX	;- pos old link
5E3A	CALL	patch	;patch offset
5E3D	XOR	AX,AX	;emit a zero:
5E3F	JMP	eword	;"current end of the list
5E42label	MOV	AX,#$0100	;label definition
5E45	CALL	symword	;store word in symtab
5E48	MOV	DI,chptr	;current pos
5E4C	MOV.B	AL,[DI]	;get char
5E4E	CALL	alphanum	;in alphanum ?
5E51	CALL	rdsym0	;get sym - numbers allowed
5E54	MOV.B	AH,lexnest	;lexical nesting
5E58	MOV	AL,#$FF	;flag: unresolved
5E5A	CALL	symword	;store word
5E5D	CALL	symword	;store dummy: offset
5E60	CALL	symoffs	;write symtab offset
5E63	CALL	ccomma	;, ?
5E66	JZ	label	;yes: do another definition
5E68	JMP	esemi	;"! ;
5E6Bconst	PUSH	symtop	;Constant definition
5E6F	XOR	AX,AX	;tag: invisible
5E71	CALL	symword	;store in symtab
5E74	CALL	rdsym	;get symbol name
5E77	CALL	cequal	;= ?
5E7A	JNZ	cnstruct	;no: structured constant
5E7C	CALL	rdconst	;read constant
5E7F	MOV.B	AL,CL	;type
5E81	CALL	symbyte	;store in symtab
5E84	CMP.B	CL,#$09	;real ?
5E87	JNZ	cnstr	;:no
5E89	MOV	AX,creal3	;store real number in symtab
5E8C	CALL	symword	;6 bytes
5E8F	MOV	AX,creal2
5E92	CALL	symword
5E95	MOV	AX,creal1
5E98	CALL	symword
5E9B	JMP.b	cnput	;'do end of entry
5E9Dcnstr	CMP.B	CL,#$08	;string ?
5EA0	JNZ	cnint	;:no
5EA2	MOV	BX,#wordbuf	;buffer pointer
5EA5	MOV.B	AL,CH	;get length
5EA7	INC.B	CH	;counter
5EA9cnstlp	CALL	symbyte	;store byte in symtab
5EAC	MOV.B	AL,[BX]	;get next char
5EAE	INC	BX
5EAF	DEC.B	CH	;another ?
5EB1	JNZ	cnstlp	;:yes
5EB3	JMP.b	cnput	;'do end of entry
5EB5cnint	XCHG	AX,BX	;integer constant: result -> AX
5EB6	CALL	symword	;store in symtab
5EB9cnput	CALL	symoffs	;write symtab offset
5EBC	MOV	AL,#$02	;set tag: normal constant
5EBE	JMP.b	cnput2	;'do it
5EC0cnstruct	CALL	ecolon	;! : (structured constant)
5EC3	PUSH	symtop	;save symtab pos
5EC7	CALL	symword	;store dummy type
5ECA	MOV	AX,pc	;store offset in symtab
5ECD	CALL	symword
5ED0	MOV	AX,#$FE00	;segment CS
5ED3	CALL	symword
5ED6	CALL	symoffs	;write symtab offset
5ED9	CALL	rdtype	;get type
5EDC	POP	BP	;restore symtab pos
5EDD	MOV	AX,vartp	;store type ptr
5EE0	MOV	[BP]-$02,AX
5EE3	CALL	eequal	;! =
5EE6	CALL	structcn	;read structured constant
5EE9	MOV	AL,#$04	;tag: structured constant
5EEBcnput2	POP	BP	;restore symtab pos
5EEC	MOV.B	[BP]-$01,AL	;set tag byte: entry type
5EEF	CALL	esemi	;! ;
5EF2	CALL	ckey	;search keyword: definitions
5EF5	B	$01
5EF6	W	tklabel
5EF8	JZ	cnrt	;:found, exit
5EFA	JMP	const	;'do another const definition
5EFDcnrt	RET		;"
5EFEstructcn	MOV	AL,varctp	;read structured constant
5F01	CMP	AL,#$04	;test component type
5F03	JB	scnok	;:ok
5F05	CMP	AL,#$08	;file / pointer ?
5F07	JNB	scnok	;:no
5F09	CALL	err	;61:Files and pointers
5F0C	B	$3D	;'are not allowed here
5F0Dscnok	CMP	AL,#$01	;array ?
5F0F	JNZ	scnrec	;:no
5F11	CALL	pushe1	;save entry to stack
5F14	MOV	BP,upper	;index type
5F18	CALL	getparm	;get parameters
5F1B	MOV	AX,upper2	;upper bound - lower bound + 1
5F1E	SUB	AX,lower2
5F22	INC	AX
5F23	PUSH	AX	;save count
5F24	MOV	BP,lower	;component type pointer
5F28	CALL	getvprm2	;get parms
5F2B	POP	CX	;restore count
5F2C	CMP.B	varctp,#$0C	;array of char ?
5F31	JNZ	scnarray	;:no
5F33	OR.B	CH,CH	;test count
5F35	JNZ	scnarray	;:more than 256
5F37	CALL	cbrack1	;( ?
5F3A	JNZ	scnarrch	;no: defined by string constant
5F3C	JMP.b	scnarrlp	;'
5F3Escnarray	CALL	ebrack1	;! (
5F41scnarrlp	PUSH	CX	;save count
5F42	CALL	structcn	;read structured constant (recursive !)
5F45	POP	CX	;restore count
5F46	DEC	CX	;count down
5F47	JCXZ	scnaend	;:done
5F49	CALL	ecomma	;! ,
5F4C	JMP	scnarrlp	;'do next entry
5F4Escnarrch	PUSH	CX	;save count
5F4F	CALL	rdstrcn	;read constant
5F52	POP	DX	;restore expected length
5F53	CMP.B	CH,DL	;= length read ?
5F55	CALL	errnz	;50:String const length does not
5F58	B	$32	;match type
5F59	CALL	estr2	;emit string (without length byte)
5F5C	JMP.b	scnaend2	;'done
5F5Escnaend	CALL	ebrack2	;! )
5F61scnaend2	CALL	pope1	;restore entry
5F64	RET		;'
5F65scnrec	CMP	AL,#$02	;record ?
5F67	JNZ	scset	;:no
5F69	CALL	pushe1	;save entry to stack
5F6C	CALL	ebrack1	;! (
5F6F	MOV.B	CL,varnest	;record nesting level
5F73	PUSH	varsize	;save component size
5F77	XOR	AX,AX	;offset in record: size done
5F79scnrlp	PUSH	CX	;save nesting, size
5F7A	PUSH	AX
5F7B	MOV	CH,#$04	;search variable
5F7D	CALL	search
5F80	CALL	errnz	;41:Unknown ID or syntax error
5F83	B	$29
5F84	CALL	getvprm	;get parms
5F87	POP	AX	;restore size
5F88	CMP	AX,varofs	;= offset of record sub-var ?
5F8C	CALL	errnz	;69:Invalid ordering of fields
5F8F	B	$45
5F90	ADD	AX,varsize	;add size to offset
5F94	PUSH	AX	;save it
5F95	CALL	ecolon	;! :
5F98	CALL	structcn	;read structured constant
5F9B	CALL	csemi	;, ?
5F9E	POP	AX	;restore size, nesting level
5F9F	POP	CX
5FA0	JZ	scnrlp	;yes: continue
5FA2	PUSH	AX	;save size
5FA3	CALL	ebrack2	;! )
5FA6	POP	AX	;current size
5FA7	POP	CX	;component size of record type
5FA8	SUB	CX,AX	;compare them
5FAA	JZ	scnrok	;:ok
5FACscnrfill	XOR.B	AL,AL	;emit zeroes to fill
5FAE	CALL	ebyte
5FB1	LOOP	scnrfill	;:another
5FB3scnrok	CALL	pope1	;restore entry from stack
5FB6	RET		;'
5FB7scset	CMP	AL,#$03	;set ?
5FB9	JNZ	scstr	;:no
5FBB	CALL	pushe1	;save entry to stack
5FBE	PUSH	varsize	;save component size
5FC2	MOV	BP,lower	;type ptr
5FC6	CALL	getvprm2	;get type parms
5FC9	CALL	esqr1	;! [
5FCC	MOV	DI,#wordbuf	;buffer ptr
5FCF	PUSH	DS	;DS,DI: dest ptr
5FD0	PUSH	DI
5FD1	CALL	sldempty	;make empty set (on stack)
5FD4	CALL	csqr2	;] ?
5FD7	JZ	scssto	;:yes
5FD9scslp	CALL	rdscalar	;get scalar element
5FDC	PUSH	AX	;save
5FDD	CALL	ctoken
5FE0	W	tk2dot
5FE2	JNZ	scsincl	;:no
5FE4	CALL	rdscalar	;get scalar element
5FE7	CALL	setinrng	;include range in set
5FEA	JMP.b	scsrng	;'
5FECscsincl	POP	AX	;restore scalar element
5FED	CALL	setincl	;include element in set
5FF0scsrng	CALL	ccomma	;, ?
5FF3	JZ	scslp	;yes: continue
5FF5	CALL	esqr2	;! ]
5FF8scssto	MOV	CX,#$0020	;32 bytes
5FFB	CALL	setsto	;store set into buffer
5FFE	MOV	BX,lower	;crunch set constant:
6002	MOV	CL,#$03	;(lower bound)/8
6004	SHR	BX,CL
6006	ADD	BX,#wordbuf	;+ buffer offset
600A	POP	CX	;restore component size
600Bscsemit	MOV.B	AL,[BX]	;get byte
600D	CALL	ebyte	;emit it
6010	INC	BX	;next one
6011	LOOP	scsemit	;:another
6013	CALL	pope1	;restore entry from stack
6016	RET		;'
6017scstr	CMP	AL,#$08	;string ?
6019	JNZ	screal	;:no
601B	CALL	rdstrcn	;read string constant
601E	MOV.B	CL,varsize	;component size - 1
6022	DEC.B	CL
6024	SUB.B	CL,CH	;>= actual size ?
6026	JNB	scstok	;:ok
6028	ADD.B	CL,CH	;limit to max size
602A	MOV.B	CH,CL
602C	XOR.B	CL,CL	;nothing to fill up
602Escstok	CALL	estring	;emit string
6031	OR.B	CL,CL	;fill up ?
6033	JZ	scstret	;:no
6035scstfill	XOR.B	AL,AL	;emit zeroes to reserve space
6037	CALL	ebyte
603A	DEC.B	CL	;another ?
603C	JNZ	scstfill	;:yes
603Escstret	RET		;'
603Fscreal	CMP	AL,#$09	;real ?
6041	JNZ	scint	;:no
6043	CALL	rdnumcn	;get numeric constant
6046	CMP.B	CL,#$09	;real ?
6049	JZ	scrok	;:ok
604B	CMP.B	CL,#$0A	;integer ?
604E	CALL	errnz	;25:Integer or real const expected
6051	B	$19
6052	XCHG	AX,BX	;get result
6053	CALL	intreal	;convert to real
6056	MOV	creal1,AX	;store it in buffer
6059	MOV	creal2,BX
605D	MOV	creal3,DX
6061scrok	MOV	AX,creal1	;emit resulting real number
6064	CALL	eword
6067	MOV	AX,creal2
606A	CALL	eword
606D	MOV	AX,creal3
6070	JMP	eword	;'done
6073scint	CALL	rdscalar	;integer: get scalar element
6076	CMP	varsize,#$01	;component size = 1 ?
607B	JZ	scbyte	;:yes
607D	JMP	eword	;'emit word
6080scbyte	JMP	ebyte	;"emit byte
6083rdscalar	CALL	rdnumcn	;get scalar element
6086	CMP.B	CL,varctp	;= component type ?
608A	CALL	errnz	;44:Type mismatch
608D	B	$2C
608E	XCHG	AX,BX	;result -> AX
608F	CMP	AX,lower	;< lower bound ?
6093	JL	rscalerr	;:yes
6095	CMP	AX,upper	;> upper bound ?
6099	JG	rscalerr	;:yes
609B	RET		;'
609Crscalerr	CALL	err	;45:Constant out of range
609F	B	$2D	;"
60A0type	PUSH	symtop	;Type definition
60A4typelp	PUSH	symtop	;save symtab top
60A8	MOV	AX,#$0000	;tag: invisible
60AB	CALL	symword	;store in symtab
60AE	CALL	rdsym	;get symbol
60B1	PUSH	symtop	;save symtab top
60B5	CALL	symword	;store dummy
60B8	CALL	symoffs	;write symtab offset
60BB	CALL	eequal	;! =
60BE	CALL	rdtype	;get type
60C1	POP	BP	;restore pos
60C2	MOV	AX,vartp	;store type ptr
60C5	MOV	[BP]-$02,AX
60C8	POP	BP	;pos of tag
60C9	MOV.B	[BP]-$01,#$03	;set tag: type definition
60CD	CALL	esemi	;! ;
60D0	CALL	ckey	;search keyword: definitions
60D3	B	$01
60D4	W	tklabel
60D6	JNZ	typelp	;not found: another type def
60D8	POP	tyfence	;old symtab top -> type fence
60DC	PUSH	AX	;save next element
60DD	CALL	resptr	;fill in pointer types
60E0	POP	AX	;restore next element
60E1	RET		;"
60E2var	CALL	vardef	;Var definition: define var
60E5	CALL	esemi	;! ;
60E8	CALL	ckey	;search keyword: definitions
60EB	B	$01
60EC	W	tklabel
60EE	JNZ	var	;not found: another var
60F0	RET		;"
60F1overlay	MOV.B	cdinval,#$FF	;Overlay: always recompile
60F6	MOV	DI,#destpn	;get filename
60F9	XOR	DX,DX	;end pos
60FBovnm1	MOV.B	AL,[DI]	;get char
60FD	OR.B	AL,AL	;end ?
60FF	JZ	ovnmend	;:yes
6101	CMP	AL,#$2E	;. ?
6103	JNZ	ovnm2	;:no
6105	MOV	DX,DI	;remember end pos
6107ovnm2	INC	DI	;next char
6108	CMP	AL,#$5C	;\ ?
610A	JNZ	ovnm1	;no: loop back
610C	MOV	BX,DI	;set beg position
610E	XOR	DX,DX	;clear end position
6110	JMP	ovnm1	;'loop
6112ovnmend	OR	DX,DX	;end position set ?
6114	JZ	ovnm3	;:no
6116	MOV	DI,DX	;set it
6118ovnm3	CMP	DI,#destpne	;too much ?
611C	CALL	errnb	;92:Unable to create overlay file
611F	B	$5C
6120	MOV	AL,ovrcnt	;overlay counter
6123	XOR.B	AH,AH	;clear high byte
6125	INC.B	ovrcnt	;count up
6129	MOV	[DI],#$302E
612D	MOV	CL,#$0A	;get 10-digit
612F	DIV.B	CL
6131	ADD	AX,#$3030	;-> ASCII
6134	MOV	[DI]$02,AX	;store number
6137	MOV.B	[DI]$04,#$00	;mark end
613B	MOV	AX,#rdover	;* CALL readovr
613E	CALL	ecall
6141	MOV	AX,#$FFFF	;invalid overlay in mem
6144	CALL	eword	;emit word
6147	MOV	CX,#$000D	;13 bytes
614Aovnmem	MOV.B	AL,[BX]	;emit file name
614C	CALL	ebyte
614F	INC	BX
6150	LOOP	ovnmem	;:another
6152	CALL	ptcflush	;patch code in file
6155	CALL	codflush	;flush code buffer
6158	MOV	AL,cpmode	;save code destination
615B	PUSH	AX
615C	PUSH	dstfile	;save dest file handle
6160	PUSH	cdptr	;save code ptr
6164	PUSH	cdbufpt	;save code pos buf beg
6168	PUSH	cdbegpt	;save beg of buf
616C	PUSH	cdfoff	;save current offset in file
6170	PUSH	cdfoff1
6174	PUSH	uncrlink	;save uncrunch link
6178	PUSH	ovrlen	;save max length of overlay part
617C	CMP.B	cpmode,#$00	;compile to memory ?
6181	JNZ	ovfil	;:no
6183	MOV.B	cpmode,#$02	;set: to COM
6188ovfil	MOV	AX,cdptr	;code ptr - code pos of buffer
618B	SUB	AX,cdbufpt	;add to beg of code buffer
618F	ADD	cdbegpt,AX
6193	XOR	AX,AX	;length = 0
6195	MOV	ovrlen,AX
6198	MOV	cdfoff,AX	;no offset in file
619B	MOV	cdfoff1,AX
619E	CMP.B	cpmode,#$01	;find error ?
61A3	JZ	ovloop
61A5	MOV	AH,#$3C	;create file
61A7	XOR	CX,CX	;no attribute
61A9	MOV	DX,#destpn	;name ptr
61AC	PUSH	DS	;DS -> ES
61AD	POP	ES
61AE	CALL	dos	;open it
61B1	CALL	errb	;92:Unable to create overlay file
61B4	B	$5C
61B5	MOV	dstfile,AX	;store dest file handle
61B8ovloop	XOR	AX,AX
61BA	MOV	cdptr,AX	;clear code ptr
61BD	MOV	cdbufpt,AX	;code pos of buffer
61C0	CALL	ckey	;search key word
61C3	B	$01	;(procedure or function)
61C4	W	tkproc
61C6	CALL	errnz	;16:PROC or FUNC expected
61C9	B	$10
61CA	PUSH	pc	;save PC
61CE	PUSH	cdptr	;save code ptr
61D2	PUSH	AX	;save keyword
61D3	CALL	emcrunch	;emit overlay uncrunch code
61D6	POP	AX	;restore keyword
61D7	MOV.B	ovrproc,#$FF	;set flag: in overlay
61DC	CALL	procfunc	;do proc/func
61DF	CALL	ptcrunch	;end overlay uncrunch list
61E2	CALL	ptcflush	;patch code in file
61E5	POP	CX	;restore code ptr, PC
61E6	POP	DX
61E7	PUSH	BP	;save
61E8ovfill	MOV	AX,cdptr	;new - old code ptr
61EB	SUB	AX,CX
61ED	OR.B	AL,AL	;emit zeroes, until length
61EF	JZ	ovnofill	;a multiple of 256
61F1	XOR.B	AL,AL
61F3	CALL	ebyte
61F6	JMP	ovfill	;'
61F8ovnofill	POP	BP	;restore
61F9	MOV	[BP]-$0E,AX	;store code pos in proc def
61FC	ADD	cdfoff,AX	;add to pos in file
6200	ADC	cdfoff1,#$00
6205	MOV	AX,pc	;PC - old PC
6208	SUB	AX,DX
620A	MOV	pc,DX	;restore old PC
620E	CMP	AX,ovrlen	;>= previous procedures ?
6212	JB	ovshort	;:no
6214	MOV	ovrlen,AX	;set as max length
6217ovshort	CALL	codflush	;flush code buffer
621A	CALL	ctoken	;OVERLAY ?
621D	W	tkover
621F	JZ	ovloop	;yes: repeat
6221	CMP.B	cpmode,#$01	;find error ?
6226	JZ	ovfind	;yes: no file
6228	MOV	AH,#$3E	;close file
622A	MOV	BX,dstfile	;file handle
622E	CALL	dos
6231ovfind	MOV	DX,ovrlen	;get maximum length
6235	POP	ovrlen	;restore variables
6239	POP	uncrlink	;same as above
623D	POP	cdfoff1
6241	POP	cdfoff
6245	POP	cdbegpt
6249	POP	cdbufpt
624D	POP	cdptr
6251	POP	dstfile
6255	POP	AX
6256	MOV	cpmode,AL	;restore code destination
6259	ADD	DX,pc	;max length + PC
625D	MOV	BX,uncrlink	;uncrunch link
6261	MOV	AX,cdptr	;code ptr -> uncrunch link
6264	MOV	uncrlink,AX
6267	SUB	AX,BX	;code pos - link
6269	CALL	patch	;patch link
626C	CALL	eword	;emit word
626F	MOV	AX,DX	;max length + PC
6271	CALL	eword	;emit word
6274	MOV	pc,DX	;set new PC
6278	RET		;"
6279procfunc	MOV	procfnc,AL	;define proc / func: set flag
627C	MOV.B	CH,AL	;-> type
627E	XOR.B	CL,CL
6280	PUSH	CX	;save type
6281	CALL	srchvar	;search
6284	POP	AX
6285	JNZ	prfnew	;not found: new definition
6287	JMP	prffwd	;'complete forward definition
628Aprfnew	CALL	symword	;store tag word in symbol table
628D	CALL	rdsym	;get symbol
6290	PUSH	fence	;save current var fence
6294	MOV	AX,symtop2	;current sym top
6297	MOV	fence,AX	;-> new var fence
629A	PUSH	symtop	;save symtab pos
629E	SUB	symtop,#$10	;make space
62A3	CALL	chkovrfl	;test overflow
62A6	MOV	BX,#$0004	;size of stack frame
62A9	XOR	CX,CX	;parameter counter
62AB	CALL	cbrack1	;( ?
62AE	JNZ	prfnil	;no:no parms
62B0prfloop	PUSH	BX	;save
62B1	PUSH	CX
62B2	PUSH	symtop	;save symtab pos
62B6	SUB	symtop,#$04	;make space
62BB	CALL	chkovrfl	;test overflow
62BE	CALL	ctoken	;VAR ?
62C1	W	tkvar
62C3	MOV	CX,#$0000	;normal: 0
62C6	JNZ	prfcnt	;no: normal
62C8	DEC.B	CH	;flag: FF00
62CAprfcnt	PUSH	CX	;save flag
62CB	CALL	rdsym	;read symbol
62CE	POP	CX	;restore type
62CF	INC.B	CL	;count vars of same type
62D1	CALL	ccomma	;, ?
62D4	JZ	prfcnt	;yes: repeat
62D6	PUSH	CX	;save count
62D7	OR.B	CH,CH	;VAR-parameter ?
62D9	JNZ	prfnotyp	;:yes
62DB	CALL	ecolon	;! :
62DE	JMP.b	prftype	;'
62E0prfnotyp	CALL	ccolon	;: ?
62E3	JZ	prftype	;yes: ok
62E5	MOV	AX,ptcbeg	;bottom of symtab
62E8	SUB	AX,#$000E	;point to untyped var
62EB	MOV	vartp,AX	;-> type ptr
62EE	JMP.b	prfnot2	;'
62F0prftype	MOV.B	flgvar,CH	;set VAR flag
62F4	CALL	testtp	;get type
62F7	CALL	tstscal	;limit component size
62FAprfnot2	POP	CX	;restore type, count
62FB	POP	BP	;restore symtab pos
62FC	MOV	AX,vartp	;type ptr
62FF	MOV	[BP]-$02,AX	;-> type
6302	MOV	[BP]-$04,CX	;store count
6305	MOV	AX,varsize	;component size
6308	OR.B	CH,CH	;VAR-parameter ?
630A	JZ	prfnovar	;:no
630C	MOV	AX,#$0004	;size 4: pointer
630Fprfnovar	XOR.B	CH,CH	;clear hi
6311	MUL	CX	;count * component size
6313	POP	CX
6314	POP	BX	;restore
6315	ADD	BX,AX	;add to size of stack frame
6317	INC.B	CL	;count entries
6319	CALL	csemi	;semicolon ?
631C	JZ	prfloop	;yes: another parm
631E	CALL	ebrack2	;! )
6321prfnil	CALL	symoffs	;write symtab offset
6324	CMP.B	procfnc,#$06	;function ?
6329	JNZ	prfprc1	;:no
632B	CALL	ecolon	;! :
632E	PUSH	BX	;save parm count,
632F	PUSH	CX	;stack frame size
6330	MOV.B	flgvar,#$00	;clear flag: normal var
6335	CALL	testtp	;get type
6338	POP	CX	;restore
6339	POP	BX
633A	CMP.B	varctp,#$08	;legal type ?
633F	JNB	prfresok	;:no
6341	CMP.B	varctp,#$04	;pointer ?
6346	CALL	errnz	;48:Invalid result type
6349	B	$30
634Aprfresok	POP	BP	;symtab ptr
634B	PUSH	BP
634C	MOV	AX,vartp	;get type ptr
634F	MOV	[BP]-$02,AX	;store it
6352	MOV	[BP]-$04,BX	;store stack frame size
6355	MOV.B	AH,lexnest	;lexical nesting level
6359	INC.B	AH	;+1
635B	MOV	AL,#$FF
635D	MOV	[BP]-$06,AX	;store segment
6360	ADD	BX,varsize	;add to size of stack frame
6364prfprc1	CALL	esemi	;! ;
6367	POP	BP	;restore symtab ptr
6368	POP	AX	;restore var fence
6369	MOV	fence,AX
636C	MOV	AX,pc	;get PC
636F	CMP.B	ovrproc,#$00	;overlay procedure ?
6374	JZ	prfnoovr	;:no
6376	SUB	AX,#$0019	;entry code...
6379prfnoovr	MOV	[BP]-$08,AX	;store position
637C	MOV	[BP]-$0A,BX	;store stack frame size
637F	XOR.B	CH,CH	;store param count
6381	MOV	[BP]-$10,CX
6384	MOV	AX,cdprcoff	;position in overlay file
6387	MOV	[BP]-$0C,AX
638A	MOV	[BP]-$0E,#$0000	;no forward
638F	CMP.B	ovrproc,#$00	;overlay procedure ?
6394	JNZ	prfovr	;:yes
6396	CALL	ctoken	;FORWARD ?
6399	W	tkforwrd
639B	JNZ	prfnofwd	;:no
639D	MOV	AX,cdptr	;remember code position
63A0	MOV	[BP]-$0C,AX	;for patching
63A3	DEC.B	[BP]-$0F	;set flag: forward def
63A6	CALL	ejump	;emit jump
63A9	JMP	esemi	;'! ;
63ACprfnofwd	CALL	ctoken	;EXTERNAL ?
63AF	W	tkext
63B1	JNZ	prfovr	;:no
63B3	JMP	rdextnal	;'do external procedure
63B6prffwd	CMP.B	[BP]-$0F,#$00	;complete forward definition
63BA	CALL	errz	;test flag. Defined:
63BD	B	$2B	;43:Duplicate ID or label
63BE	CMP.B	ovrproc,#$00	;overlay procedure ?
63C3	CALL	errnz	;yes:
63C6	B	$4C	;76:Overlays cannot be forwarded
63C7	CALL	skipdi	;skip spaces
63CA	CALL	esemi	;! ;
63CD	MOV.B	[BP]-$0F,#$00	;clear forward flag
63D1	MOV	BX,[BP]-$0C	;get addr of forward jump
63D4	INC	BX
63D5	MOV	AX,pc	;PC-proc pos-3 -> offset
63D8	SUB	AX,[BP]-$08
63DB	SUB	AX,#$0003
63DE	CALL	patch	;patch it in
63E1prfovr	PUSH	varspc	;save memory usage
63E5	PUSH	fence	;save fence
63E9	MOV	AX,symtop	;symtab top
63EC	MOV	fence,AX	;-> current fence
63EF	PUSH	BP	;save pos in symtab
63F0	MOV	AX,[BP]-$0A	;get stack frame size
63F3	CMP.B	procfnc,#$05	;procedure ?
63F8	JZ	prfprc2	;:yes
63FA	MOV	BX,[BP]-$02	;subtract size of result
63FD	SS:	
63FE	SUB	AX,[BX]-$02
6401prfprc2	MOV	varspc,AX	;-> memory usage
6404	INC.B	lexnest	;inc nesting
6408	MOV.B	[BP]-$06,#$00
640C	MOV.B	CL,[BP]-$10	;parameter count
640F	MOV	BX,BP	;pos
6411	SUB	BX,#$10
6414prfsto	OR.B	CL,CL	;all parms done ?
6416	JZ	prfentry	;:yes
6418	PUSH	CX	;save count
6419	SS:	
641A	MOV	BP,[BX]-$02	;get variable pointer
641D	PUSH	BX	;save current pos
641E	MOV	vartp,BP	;set type ptr
6422	CALL	getvprm2	;get var parms
6425	POP	BX	;restore pos
6426	SS:	
6427	MOV	CX,[BX]-$04	;get type
642A	MOV.B	flgvar,CH
642E	XOR.B	CH,CH
6430	PUSH	CX	;save type
6431	PUSH	symtop	;save symtab top
6435	SUB	BX,#$04	;go down
6438prfsto2	MOV	BP,symtop	;symtab top
643C	DEC	BP
643D	DEC	BP
643E	MOV	[BP]$00,#$0400	;store: var
6443	DEC	BX
6444	DEC	BP
6445	SS:	
6446	MOV.B	DL,[BX]	;get length
6448	MOV.B	[BP]$00,DL	;store length
644Bprfsto3	DEC	BX	;go down
644C	DEC	BP
644D	SS:	
644E	MOV.B	AL,[BX]	;get char
6450	MOV.B	[BP]$00,AL	;store it
6453	DEC.B	DL	;another ?
6455	JNZ	prfsto3	;:yes
6457	SUB	BP,#$06	;go down
645A	MOV	symtop,BP	;set new symtab top
645E	CALL	symoffs	;write offset
6461	LOOP	prfsto2	;:another var
6463	POP	BP	;restore pos
6464	POP	CX	;restore count
6465	PUSH	BX
6466	CALL	rdvnrm	;store offset, segment
6469	CALL	tstscal	;scalar var: 2 bytes on stack
646C	CALL	vardef2	;do var definitions
646F	POP	BX	;restore pos, cnt
6470	POP	CX
6471	DEC.B	CL	;another ?
6473	JMP	prfsto	;'
6475prfentry	CALL	ecode	;emit stack frame code
6478	B	$01,$55	;* PUSH BP
647A	CMP.B	lexnest,#$01	;lexical nesting = 1 ?
647F	JNZ	prflong	;:no
6481	CALL	ecode
6484	B	$02,$8B,$EC	;* MOV BP,SP
6487	JMP.b	prfshort	;'
6489prflong	CALL	ecode	;complicated - do display
648C	B	$02,$8B,$C4	;* MOV AX,SP
648F	XOR.B	CH,CH
6491	MOV.B	CL,lexnest	;lexical nesting -> count
6495	DEC.B	CL
6497prfcopy	CALL	ecode	;* PUSH [BP+..]
649A	B	$02,$FF,$76
649D	DEC.B	CH	;count down two bytes
649F	DEC.B	CH
64A1	MOV.B	AL,CH	;offset into display
64A3	CALL	ebyte	;emit offset
64A6	DEC.B	CL	;another level ?
64A8	JNZ	prfcopy	;:no
64AA	CALL	ecode
64AD	B	$02,$8B,$E8	;* MOV BP,AX
64B0prfshort	CALL	ecode	;now push current display !
64B3	B	$01,$55	;* PUSH BP
64B5	MOV	AL,lexnest	;lexical nesting * 2
64B8	XOR.B	AH,AH
64BA	ADD	AX,AX
64BC	NEG	AX
64BE	MOV	varspc,AX	;-> stack usage
64C1	PUSH	AX
64C2	MOV	AL,procfnc	;proc or func ?
64C5	PUSH	AX	;save flag
64C6	CALL	defpart	;do definition part
64C9	POP	AX	;restore... (defs may be recursive)
64CA	MOV	procfnc,AL
64CD	POP	AX
64CE	SUB	AX,varspc	;mem usage - current
64D2	CALL	allotstk	;make space on stack
64D5	POP	BP	;restore symtab ptr
64D6	PUSH	BP
64D7	PUSH	[BP]-$0A	;store memory size
64DA	MOV	AX,varspc	;memory usage
64DD	NEG	AX
64DF	ADD	[BP]-$0A,AX	;add to mem size
64E2	CALL	errb	;98:Memory overflow
64E5	B	$62
64E6	CALL	progpart	;do program part
64E9	POP	AX	;restore memory size - 4
64EA	SUB	AX,#$0004
64ED	CMP.B	procfnc,#$06	;function ?
64F2	JNZ	prfret	;:no
64F4	POP	BP	;restore symtab pos
64F5	PUSH	BP
64F6	PUSH	AX	;save mem size
64F7	CALL	getvprm	;get var parms
64FA	MOV.B	indflg,#$00	;flag: not indexed
64FF	POP	AX	;mem size
6500	CMP.B	varctp,#$09	;component type = real ?
6505	JNZ	prfstr	;:no
6507	SUB	AX,#$0006	;6 bytes on stack
650A	JMP.b	prfret	;'
650Cprfstr	CMP.B	varctp,#$08	;string ?
6511	JNZ	prfelse	;:no
6513	SUB	AX,varsize	;- component size -> pos on stack
6517	CALL	emovdxi	;* MOV DX,..
651A	MOV	AX,varsize	;component size: max length - 1
651D	DEC	AX
651E	MOV.B	AH,AL	;max string length
6520	MOV	AL,#$B1	;* MOV CL,..
6522	CALL	eword
6525	CALL	ecode	;* MOV SP,BP
6528	B	$03,$8B,$E5,$5D	;* POP BP
652C	MOV	AX,#retstr	;* JMP retstr
652F	CALL	ejump
6532	JMP.b	prfret2	;'
6534prfelse	PUSH	AX	;save pos
6535	CALL	eload	;load var
6538	POP	AX	;restore
6539	CMP.B	varctp,#$0B	;boolean ?
653E	JNZ	prfret	;:no
6540	CALL	ecode	;* OR AX,AX (set flags)
6543	B	$02,$0B,$C0
6546prfret	CALL	ecode	;* MOV SP,BP
6549	B	$03,$8B,$E5,$5D	;* POP BP
654D	OR	AX,AX	;stack frame ?
654F	JNZ	prfretn	;:yes
6551	CALL	ecode	;none:
6554	B	$01,$C3	;* RET
6556	JMP.b	prfret2	;'
6558prfretn	CALL	ecode	;remove stack frame
655B	B	$01,$C2	;* RET ....
655D	CALL	eword	;emit stack frame size
6560prfret2	CALL	esemi	;! ;
6563	POP	BP	;restore symtab pos
6564	DEC.B	[BP]-$06	;clear flag
6567	DEC.B	lexnest	;restore lexical nesting
656B	MOV	AX,fence	;fence -> symtab top
656E	MOV	symtop,AX	;= remove all local vars
6571	MOV	symtop2,AX
6574	POP	fence	;restore fence
6578	POP	varspc	;restore mem usage
657C	RET		;"
657Drdextnal	PUSH	BP	;read external proc
657E	MOV	CX,#$0500	;tag: procedure
6581	CALL	search
6584	JZ	rdxold	;: found
6586	MOV	CX,#$0600	;tag: function
6589	CALL	search
658C	JNZ	rdxnew	;:not found
658Erdxold	PUSH	[BP]-$08	;get offset
6591	CALL	esqr1	;! [
6594	CALL	rdintcn	;get integer constant
6597	CALL	esqr2	;! ]
659A	POP	AX	;offset + number
659B	ADD	AX,BX
659D	JMP.b	rdxsto	;'-> offset of this proc
659Frdxnew	PUSH	pc	;save PC
65A3	CALL	rdstrcn	;read string constant
65A6	MOV.B	BL,CH	;length
65A8	XOR.B	BH,BH
65AA	MOV.B	[BX]wordbuf,#$00	;store a 0 at the end
65AF	MOV	BX,#wordbuf	;name ptr
65B2	MOV	SI,#extcom	;extension .COM
65B5	CALL	kextdef	;parse filename
65B8	MOV	AX,#$3D00	;open file
65BB	MOV	DX,#scrpn	;name ptr
65BE	PUSH	DS	;DS -> ES
65BF	POP	ES
65C0	CALL	dos	;open it
65C3	CALL	errb	;90:File not found
65C6	B	$5A
65C7	MOV	BX,AX	;file handle
65C9rdxloop	MOV	AH,#$3F	;read from file
65CB	MOV	CX,#$0080	;128 bytes
65CE	MOV	DX,#wordbuf	;dest buffer
65D1	CALL	dos	;do it
65D4	CALL	errb	;90:File not found
65D7	B	$5A
65D8	XCHG	AX,CX	;length read -> CX
65D9	JCXZ	rdxend	;0: end
65DB	MOV	SI,#wordbuf	;source ptr
65DErdxcopy	MOV.B	AL,[SI]	;get byte from external file
65E0	CALL	ebyte	;and emit it
65E3	INC	SI	;next one
65E4	LOOP	rdxcopy	;:again
65E6	JMP	rdxloop	;'try another block
65E8rdxend	MOV	AH,#$3E	;close file
65EA	CALL	dos
65ED	POP	AX	;restore offset
65EErdxsto	POP	BP	;restore symtab pos
65EF	MOV	[BP]-$08,AX	;store offset
65F2	JMP	esemi	;"! ;
65F5tstscal	CMP.B	varctp,#$0A	;scalar var ?
65FA	JB	tsc2	;:no
65FC	MOV	varsize,#$0002	;on stack at least 2 bytes
6602tsc2	RET		;"
6603resforw	MOV	BP,symtop	;Resolve forward definitions
6607rfwloop	CMP	BP,fence	;= var fence ?
660B	JZ	rfwret	;yes: end
660D	ADD	BP,[BP]$00	;go to next entry
6610	CMP.B	[BP]-$01,#$06	;function ?
6614	JZ	rfwfunc	;:yes
6616	CMP.B	[BP]-$01,#$05	;procedure ?
661A	JNZ	rfwloop	;:no, next one
661Crfwfunc	MOV	BX,BP	;entry ptr
661E	SUB	BX,#$03
6621	SS:	
6622	MOV.B	AL,[BX]	;length of name
6624	XOR.B	AH,AH
6626	SUB	BX,AX	;go down
6628	SS:	
6629	CMP.B	[BX]-$0F,#$00	;defined ?
662D	CALL	errnz	;no:
6630	B	$49	;73:Undefined FORWARD procedure
6631	JMP	rfwloop	;'next one
6633rfwret	RET		;"
6634vardef	MOV.B	flgvar,#$00	;define var: clear VAR-flag
6639	CALL	rdvarlst	;get variable list
663C	PUSH	CX	;save counter
663D	PUSH	BP	;save symtab ptr
663E	CALL	ecolon	;! :
6641	CALL	rdvartp	;get type, test absolute
6644	POP	BP	;restore
6645	POP	CX
6646vardef2	MOV	DX,varsize	;component size
664A	CMP.B	flgvar,#$00	;VAR-parameter ?
664F	JZ	vdvar	;:no
6651	MOV	DX,#$0004	;yes: pointer !
6654vdvar	MOV	AX,var3ofs	;var offset
6657	CMP.B	absflg,#$00	;absolute ?
665C	JNZ	vdstore	;:yes
665E	CMP.B	recnum,#$00	;record nesting level ?
6663	JNZ	vdrec	;:in record
6665	CMP.B	lexnest,#$00	;inside procedure ?
666A	JNZ	vdstk	;:yes
666C	MOV	AX,dc	;DC -> offset
666F	ADD	dc,DX	;add size to DC
6673	CALL	errb	;overflow:
6676	B	$62	;98:Memory overflow
6677	JMP.b	vdstore	;'
6679vdstk	SUB	varspc,DX	;go down (stack !)
667D	CALL	errb	;overflow ?
6680	B	$62	;98:Memory overflow
6681	MOV	AX,varspc	;get offset
6684	JMP.b	vdstore	;'
6686vdrec	MOV	AX,varspc	;get offset
6689	ADD	varspc,DX	;add to var space
668D	CALL	errb	;overflow ?
6690	B	$62	;98:memory overflow
6691vdstore	SUB	BP,#$03	;go down in var list
6694	MOV.B	BL,[BP]$00	;get length
6697	XOR.B	BH,BH
6699	SUB	BP,BX	;go down
669B	MOV	[BP]-$04,AX	;store offset
669E	MOV	AX,var3seg	;store segment
66A1	MOV	[BP]-$06,AX
66A4	MOV	AX,vartp	;store type ptr
66A7	MOV	[BP]-$02,AX
66AA	SUB	BP,#$08	;make space
66AD	LOOP	vdvar	;another definition ?
66AF	JMP	chkovrfl	;"test for overflow
66B2rdvarlst	PUSH	symtop	;get variable list
66B6	XOR	CX,CX	;clear counter
66B8rdvloop	PUSH	CX	;save
66B9	MOV	AH,#$04	;tag: var, record nesting
66BB	MOV	AL,recnum
66BE	CALL	symword	;store in symtab
66C1	CALL	rdsym	;store name in symtab
66C4	SUB	symtop,#$06	;reserve some space
66C9	CALL	symoffs	;write symtab offset
66CC	POP	CX	;restore counters
66CD	INC	CX
66CE	CALL	ccomma	;, ?
66D1	JZ	rdvloop	;yes: next var
66D3	POP	BP	;restore symtab pos
66D4	RET		;"(beginning of list)
66D5rdvartp	PUSH	symtop	;get var type, test ABSOLUTE
66D9	CALL	rdtype	;read type
66DC	POP	tyfence	;symtab top -> type fence
66E0	CALL	resptr	;fill in pointer types
66E3	CALL	ctoken	;ABSOLUTE ?
66E6	W	tkabs
66E8	JNZ	rdvnrm	;:no
66EA	MOV.B	absflg,#$FF	;set flag
66EF	CMP.B	recnum,#$00	;in record ?
66F4	CALL	errnz	;yes:
66F7	B	$4B	;75:Illegal use of ABSOLUTE
66F8	MOV	CX,#$0400	;search var
66FB	CALL	search
66FE	JNZ	rdvabs	;:not found
6700	MOV	AX,[BP]-$06	;get offset
6703	MOV	DX,[BP]-$04	;get segment
6706	JMP.b	rdvofs	;'store parms
6708rdvabs	CALL	rdconst	;read constant -> segment
670B	JNZ	rdvseg	;:no good
670D	CALL	testint	;test type: integer
6710	PUSH	BX	;save segment
6711	CALL	ecolon	;! :
6714	CALL	rdintcn	;get integer constant
6717	MOV	DX,pc	;get PC: pos of pointer
671B	XCHG	AX,BX
671C	CALL	eword	;emit result = offset
671F	POP	AX	;emit segment
6720	CALL	eword
6723	MOV	AX,#$FEFF	;flag: CS indirect
6726	JMP.b	rdvofs	;'
6728rdvseg	CALL	ctoken	;DSEG ?
672B	W	tkdseg
672D	MOV	AX,#$FF00	;flag: DS
6730	JZ	rdvseg2	;:yes
6732	CALL	ctoken	;CSEG ?
6735	W	tkcseg
6737	MOV	AX,#$FE00	;flag: CS
673A	JZ	rdvseg2	;:yes
673C	JMP	snerror	;'Unknown ID or syntax error
673Frdvseg2	PUSH	AX	;save segment flag
6740	CALL	ecolon	;! :
6743	CALL	rdintcn	;get integer constant
6746	POP	AX	;restore segment
6747	MOV	DX,BX	;offset -> DX
6749rdvofs	MOV	var3ofs,DX
674D	JMP.b	rdvsto	;'
674Frdvnrm	MOV.B	absflg,#$00	;clear absolute flag
6754	MOV	AL,flgvar	;VAR-parameter ?
6757	MOV.B	AH,lexnest	;lexical nesting
675B	OR.B	AH,AH	;inside proc ?
675D	JNZ	rdvofs	;:yes, use stack segment
675F	MOV	AH,#$FF	;data segment
6761rdvsto	MOV	var3seg,AX	;store segment
6764	RET		;"
6765testtp	CALL	srchtype	;Test file type: search type
6768	JZ	ttpsto	;:found
676A	CALL	ctoken	;TEXT ?
676D	W	tktext
676F	JNZ	ttpnotxt	;:no
6771	CALL	textstd	;get ptr to that type
6774	JMP.b	ttpsto	;'
6776ttpnotxt	CALL	ctoken	;FILE ?
6779	W	tkfile
677B	CALL	errnz	;no:
677E	B	$24	;36:Type ID expected
677F	CALL	filuntp	;point to typed/untyped file
6782ttpsto	CMP.B	flgvar,#$00	;VAR-parameter ?
6787	JNZ	rdvnrm	;yes: ok
6789	CMP.B	varctp,#$05	;typed file ?
678E	JB	rdvnrm	;:below
6790	CMP.B	varctp,#$07	;above file ?
6795	JA	rdvnrm	;yes: ok
6797	CALL	err
679A	B	$43	;"67:Files must be VAR parameters
679Bresptr	MOV	BP,symtop	;Fill in pointer types
679Frptlp	CMP	BP,tyfence	;= type fence ?
67A3	JZ	rptret	;yes: done
67A5	ADD	BP,[BP]$00	;go to next var
67A8	CMP.B	[BP]-$01,#$08	;subtype ?
67AC	JNZ	rptlp	;no: next one
67AE	MOV.B	[BP]-$01,#$00	;make it invisible
67B2	CMP.B	[BP]-$0A,#$04	;pointer ?
67B6	JNZ	rptlp	;no: next one
67B8	CMP.B	[BP]-$09,#$00	;filled in ?
67BC	JZ	rptlp	;:yes
67BE	MOV.B	[BP]-$09,#$00	;flag: filled in
67C2	MOV	BX,[BP]-$08	;get pos of type name
67C5	SS:	
67C6	MOV.B	DL,[BX]-$01	;name length
67C9	XOR.B	DH,DH
67CB	INC	DX	;-> count
67CC	PUSH	BP	;save pos
67CD	MOV	BP,symtop	;search from top
67D1rptsrch	CMP	BP,ptcbeg	;bottom of symbol table ?
67D5	JZ	rpterr	;yes: error
67D7	ADD	BP,[BP]$00	;go to next var
67DA	CMP.B	[BP]-$01,#$03	;type ?
67DE	JNZ	rptsrch	;:no, search next
67E0	MOV	SI,BP	;pointer
67E2	DEC	SI
67E3	DEC	SI
67E4	MOV	DI,BX	;pos of searched string
67E6	MOV	CX,DX	;len -> count
67E8rptcmp	DEC	SI	;go back
67E9	DEC	DI
67EA	SS:	
67EB	MOV.B	AL,[SI]	;compare chars
67ED	SS:	
67EE	CMP.B	AL,[DI]
67F0	JNZ	rptsrch	;:not the right one
67F2	LOOP	rptcmp	;:test another char
67F4	POP	BP	;restore symtab pos
67F5	SS:	
67F6	MOV	AX,[SI]-$02	;get type pointer
67F9	MOV	[BP]-$08,AX	;store into pointer entry
67FC	JMP	rptlp	;'next one
67FErptret	RET		;'
67FFrpterr	CALL	err	;42:Undefd ptr type in preceding
6802	B	$2A	;"type defs
6803rdtype	CALL	srchtype	;get type: search type ID
6806	JZ	rdtpret	;found: ret
6808	CALL	ctoken	;PACKED ?
680B	W	tkpacked	;(ignored)
680D	CALL	array	;array ?
6810	JZ	rdtpret	;:done
6812	CALL	record	;record ?
6815	JZ	rdtpret	;:done
6817	CALL	set	;set ?
681A	JZ	rdtpret	;:done
681C	CALL	pointer	;pointer ?
681F	JZ	rdtpret	;:done
6821	CALL	file	;file ?
6824	JZ	rdtpret	;:done
6826	CALL	text	;text ?
6829	JZ	rdtpret	;:done
682B	CALL	string	;string ?
682E	JZ	rdtpret	;:done
6830	CALL	scalar	;scalar list ?
6833	JZ	rdtpret	;:done
6835	CALL	subrange	;subrange ?
6838	JZ	rdtpret	;:done
683A	CALL	err	;36:Type identifier expected
683D	B	$24	;'
683Erdtpret	RET		;"
683Fsrchtype	MOV	CX,#$0300	;search type
6842	CALL	search
6845	JNZ	srtret	;:not found - ret
6847	MOV	BP,[BP]-$02	;type pointer
684Astdtype	MOV	vartp,BP	;store it
684E	CALL	getvprm2	;get type parms
6851	XOR	AX,AX	;ok
6853srtret	RET		;"
6854array	CALL	ctoken	;ARRAY ?
6857	W	tkarray
6859	JNZ	arret	;:no
685B	CALL	esqr1	;! [
685E	XOR	CX,CX	;clear dimension count
6860arrlp	PUSH	CX	;save
6861	CALL	rdscaltp	;get scalar type
6864	POP	CX
6865	PUSH	vartp	;save type pointer: index type
6869	MOV	AX,upper	;upper bound - lower bound
686C	SUB	AX,lower
6870	INC	AX	;+ 1
6871	CALL	errz	;98:Memory overflow
6874	B	$62
6875	PUSH	AX	;save component count
6876	INC	CX	;count dimensions
6877	CALL	ccomma	;, ?
687A	JZ	arrlp	;yes: another dimension
687C	PUSH	CX	;save dim count
687D	CALL	esqr2	;! ]
6880	CALL	expof	;! OF
6883	CALL	rdtype	;get type
6886	POP	CX	;dim count
6887arrlp2	MOV	AX,vartp	;type ptr
688A	MOV	lower,AX	;-> type
688D	MOV	AX,varsize	;component size
6890	POP	BX	;* component count
6891	MUL	BX
6893	CALL	errb	;too much ?
6896	B	$62	;98:Memory overflow
6897	MOV	varsize,AX	;-> component size
689A	POP	AX	;index type
689B	MOV	upper,AX	;store it
689E	MOV.B	varctp,#$01	;tag: array
68A3	CALL	stotype	;store type
68A6	LOOP	arrlp2	;:another dimension
68A8arret	RET		;"
68A9record	CALL	ctoken	;RECORD ?
68AC	W	tkrec
68AE	JNZ	recret	;no: ret
68B0	MOV	AL,vrecflg	;save variant rec nesting
68B3	PUSH	AX
68B4	MOV	AL,recnum	;save rec nesting
68B7	PUSH	AX
68B8	INC.B	reccnt	;one more level
68BC	MOV	AL,reccnt	;record counter
68BF	MOV	recnum,AL	;-> record number
68C2	PUSH	varspc	;save space used
68C6	PUSH	maxsize	;save max size of variant rec
68CA	MOV	varspc,#$0000	;clear them
68D0	MOV	maxsize,#$0000
68D6	MOV.B	vrecflg,#$00	;no variant record
68DB	CALL	recdef	;do record definition
68DE	MOV	AX,maxsize	;max component size
68E1	MOV	varsize,AX	;-> variable size
68E4	POP	maxsize	;restore vars
68E8	POP	varspc
68EC	MOV	AL,recnum	;record number
68EF	MOV	varnest,AL	;-> subtype
68F2	POP	AX
68F3	MOV	recnum,AL
68F6	POP	AX
68F7	MOV	vrecflg,AL
68FA	MOV.B	varctp,#$02	;type: record
68FF	CALL	stotype	;store type
6902recret	RET		;"
6903recdef	CALL	rectest	;do record def: test end
6906	JZ	rcdret	;yes: ret
6908	CALL	ctoken	;CASE ?
690B	W	tkcase
690D	JZ	rcdvrec	;:yes
690F	CALL	vardef	;define variables
6912	MOV	AX,varspc	;memory used
6915	CMP	AX,maxsize	;>= max size ?
6919	JB	rcdsmall	;below: forget
691B	MOV	maxsize,AX	;store as new max size
691Ercdsmall	CALL	csemi	;semicolon ?
6921	JZ	recdef	;yes: loop back
6923	JMP.b	rcde	;'end it
6925rcdvrec	CALL	srchtype	;variant record: search type
6928	JZ	rcdnotag	;:found
692A	CALL	vardef	;define var: tag field
692Drcdnotag	CALL	expof	;! OF
6930rcdvlp	CALL	rectest	;test for end
6933	JZ	rcdret	;yes: ret
6935	PUSH	varspc	;save mem used
6939rcdtag	CALL	rdnumcn	;get constant
693C	CALL	ccomma	;, ?
693F	JZ	rcdtag	;:another constant
6941	CALL	ecolon	;! :
6944	CALL	ebrack1	;! (
6947	MOV	AL,vrecflg	;save variant rec flag
694A	PUSH	AX
694B	MOV.B	vrecflg,#$FF	;set it
6950	CALL	recdef	;do type definition list
6953	POP	AX	;restore flag
6954	MOV	vrecflg,AL
6957	POP	varspc	;restore memory used
695B	CALL	csemi	;semicolon ?
695E	JZ	rcdvlp	;yes: another
6960rcde	CMP.B	vrecflg,#$00	;variant record ?
6965	JZ	rcde1	;:no
6967	JMP	ebrack2	;'! )
696Arcde1	CALL	ctoken	;END ?
696D	W	tkend
696F	CALL	errnz	;no:
6972	B	$0E	;14:END expected
6973rcdret	RET		;"
6974rectest	CMP.B	vrecflg,#$00	;test end
6979	JZ	rectest2	;:normal rec
697B	JMP	cbrack2	;'in variant rec: ) ?
697Erectest2	CALL	ctoken	;END ?
6981	W	tkend
6983	RET		;"
6984set	CALL	ctoken	;SET ?
6987	W	tkset
6989	JNZ	setret	;no: ret
698B	CALL	expof	;! OF
698E	CALL	rdscaltp	;get scalar type
6991	MOV	AX,upper	;upper bound
6994	MOV	BX,lower	;lower bound
6998	MOV.B	CL,AH	;one of them > 255 ?
699A	OR.B	CL,BH
699C	CALL	errnz	;yes:
699F	B	$46	;70:Set base type out of range
69A0	MOV	CL,#$03	;calculate component size
69A2	SHR	AX,CL	;(upper/8)-(lower/8)+1
69A4	MOV	CL,#$03
69A6	SHR	BX,CL
69A8	SUB	AX,BX
69AA	INC	AX
69AB	MOV	varsize,AX	;-> component size
69AE	MOV	AX,vartp	;type ptr
69B1	MOV	lower,AX	;-> type
69B4	MOV.B	varctp,#$03	;tag: set
69B9	CALL	stotype	;store type
69BCsetret	RET		;"
69BDpointer	CALL	cptr	;pointer: prelim def
69C0	JNZ	ptrret	;ptr ? no: ret
69C2	MOV	AX,#$0000	;tag: invisible
69C5	CALL	symword	;store in symtab
69C8	PUSH	symtop	;save pos
69CC	CALL	rdsymnew	;get name of ptr
69CF	CALL	symoffs	;write symtab offset
69D2	POP	lower	;restore pos of prelim offset
69D6	MOV.B	varctp,#$04	;tag: pointer
69DB	MOV.B	varnest,#$FF	;flag: not fully defined
69E0	MOV	varsize,#$0004	;size: 4 bytes
69E6	CALL	stotype	;store type
69E9ptrret	RET		;"
69EAfile	CALL	ctoken	;FILE ?
69ED	W	tkfile
69EF	JNZ	fileret	;no: ret
69F1	CALL	ctoken	;OF ?
69F4	W	tkof
69F6	JNZ	filuntp	;no: untyped file
69F8	CALL	rdtype	;read type
69FB	CMP.B	varctp,#$05	;component type = file ?
6A00	JB	file2	;:no
6A02	CMP.B	varctp,#$07
6A07	JA	file2	;:no
6A09	CALL	err	;yes:
6A0C	B	$44	;'68:File components may not be files
6A0Dfile2	MOV	AX,vartp	;type ptr
6A10	MOV	lower,AX	;store it
6A13	MOV.B	varctp,#$05	;typed file
6A18	MOV	varsize,#$004C	;set size
6A1E	CALL	stotype	;store type
6A21fileret	RET		;'
6A22filuntp	MOV	BP,ptcbeg	;untyped file
6A26	B	$81,$ED,$02,$00	;point to it
6A2A	JMP	stdtype	;"standard type
6A2Dtext	CALL	ctoken	;TEXT ?
6A30	W	tktext
6A32	JNZ	textret	;no:ret
6A34	CALL	csqr1	;[ ?
6A37	JNZ	textstd	;no: standard text file
6A39	CALL	rdintcn	;get integer constant
6A3C	OR	BX,BX	;buffer size = 0 ?
6A3E	CALL	errz	;yes:
6A41	B	$2D	;45:Constant out of range
6A42	CALL	esqr2	;! ]
6A45	ADD	BX,#$4C	;add size of file var
6A48	MOV	varsize,BX	;-> var size
6A4C	MOV.B	varctp,#$06	;text file
6A51	CALL	stotype	;store type
6A54textret	RET		;'
6A55textstd	MOV	BP,ptcbeg	;set ptr to std TEXT file
6A59	B	$81,$ED,$3E,$00
6A5D	JMP	stdtype	;'standard type
6A60string	CALL	ctoken	;STRING ?
6A63	W	tkstr
6A65	JNZ	strrt	;no: ret
6A67	CALL	esqr1	;! [
6A6A	CALL	rdintcn	;get integer constant
6A6D	OR.B	BH,BH	;> 255 ?
6A6F	CALL	errnz	;yes:
6A72	B	$31	;49:Invalid string length
6A73	OR.B	BL,BL	;length = 0 ?
6A75	CALL	errz	;yes:
6A78	B	$31	;49:Invalid string length
6A79	CALL	esqr2	;! ]
6A7C	INC	BX	;len+1 (for length byte)
6A7D	MOV	varsize,BX	;-> component size
6A81	MOV.B	varctp,#$08	;tag: string
6A86	CALL	stotype	;store type
6A89strrt	RET		;"
6A8Ascalar	CALL	cbrack1	;do scalar list
6A8D	JNZ	scalret	;( ? no: ret
6A8F	MOV	BX,#$FFFF	;init counter
6A92scallp	PUSH	BX
6A93	MOV	AX,#$0200	;tag: const
6A96	CALL	symword	;store tag word
6A99	CALL	rdsym	;read symbol
6A9C	MOV	AL,scalcnt	;number of scalar type
6A9F	CALL	symbyte	;store (elementary type)
6AA2	POP	AX	;restore counter
6AA3	INC	AX	;inc it
6AA4	PUSH	AX	;save it again
6AA5	CALL	symword	;store value of that const
6AA8	CALL	symoffs	;write symtab offset
6AAB	CALL	ccomma	;, ?
6AAE	POP	BX
6AAF	JZ	scallp	;yes: another element
6AB1	CALL	ebrack2	;! )
6AB4	MOV.B	CL,scalcnt	;number of this type
6AB8	INC.B	scalcnt	;count scalar types
6ABC	XOR	DX,DX	;clear lower bound
6ABEscalsto	MOV.B	varctp,CL	;store component type
6AC2	MOV	upper,BX	;store upper bound
6AC6	MOV	lower,DX	;store lower bound
6ACA	OR.B	DH,BH	;byte possible ?
6ACC	MOV	AX,#$0001	;size = 1
6ACF	JZ	scalbyt	;yes: ok
6AD1	INC	AX	;size = 2
6AD2scalbyt	MOV	varsize,AX	;store component size
6AD5	CALL	stotype	;store type
6AD8scalret	RET		;"
6AD9subrange	CALL	rdconst	;do subrange: read constant
6ADC	JNZ	subret	;no good: ret
6ADE	PUSH	CX	;save type, result
6ADF	PUSH	BX
6AE0	CMP.B	CL,#$0A	;scalar ?
6AE3	CALL	errb	;no:
6AE6	B	$33	;51:Invalid subrange base type
6AE7	CALL	ctoken	;.. ?
6AEA	W	tk2dot
6AEC	CALL	errnz	;no:
6AEF	B	$0B	;11: .. expected
6AF0	CALL	rdnumcn	;get constant
6AF3	POP	DX	;restore component type
6AF4	POP	AX	;restore lower bound
6AF5	CMP.B	CL,AL	;same component type ?
6AF7	CALL	errnz	;no:
6AFA	B	$2C	;44:Type mismatch
6AFB	CMP	BX,DX	;upper >= lower ?
6AFD	JGE	scalsto	;yes: ok
6AFF	CALL	err	;52:Lower bound > upper bound
6B02	B	$34	;'
6B03subret	RET		;"
6B04rdscaltp	CALL	subrange	;get scalar type: do subrange
6B07	JZ	rdscret	;done: ret
6B09	CALL	scalar	;do scalar list
6B0C	JZ	rdscret	;done: ret
6B0E	CALL	srchtype	;search type
6B11	CALL	errnz	;complex ?
6B14	B	$1E	;30:Simple type expected
6B15	CMP.B	varctp,#$0A	;scalar ?
6B1A	JNB	rdscret	;:yes
6B1C	CALL	err	;30:Simple type expected
6B1F	B	$1E	;'
6B20rdscret	RET		;"
6B21progpart	MOV.B	stklev,#$00	;Program part
6B26	MOV.B	withnest,#$00	;no with nesting
6B2B	CALL	block	;do block
6B2E	PUSH	pc	;save PC: jump to end of exit codes
6B32	CALL	ejump	;emit jump
6B35	MOV	BP,symtop2
6B39prpatch	CMP	BP,symtop	;= actual symtab top ?
6B3D	JZ	prpend	;yes: end it
6B3F	MOV	BX,[BP]-$02	;get dest addr
6B42	OR	BX,BX	;exit ?
6B44	JZ	prpexit	;:yes
6B46	SS:	
6B47	MOV	AX,[BX]-$02	;get dest offset (from label)
6B4A	SS:	
6B4B	MOV.B	CH,[BX]-$04	;label defined ?
6B4E	CMP.B	CH,#$FF	;no:
6B51	CALL	errz	;40:Undefined label
6B54	B	$28
6B55	JMP.b	prpgoto	;'patch GOTO
6B57prpexit	POP	AX	;get PC of end jump
6B58	PUSH	AX	;= dest
6B59	MOV	CH,#$00	;level: 0
6B5Bprpgoto	MOV	BX,[BP]-$04	;get addr of jump
6B5E	INC	BX	;+1: point to offset
6B5F	MOV.B	CL,[BP]-$05	;stack level-dest stack level
6B62	SUB.B	CL,CH
6B64	JNZ	prpremov	;not zero: remove from stack
6B66	CALL	ptcjmp	;patch jump
6B69	JMP.b	prpnxt	;'
6B6Bprpremov	CALL	errb	;trying to jump into a WITH/FOR ?
6B6E	B	$47	;71:Invalid GOTO
6B6F	PUSH	AX	;save PC of end jump
6B70	CALL	ptcjmppc	;patch jump to current pos
6B73prpremlp	CALL	epopax	;* POP AX
6B76	DEC.B	CL	;remove another var from stack ?
6B78	JNZ	prpremlp	;:no
6B7A	POP	AX	;restore PC of end jump
6B7B	CALL	ejump	;emit jump to end jump
6B7Eprpnxt	SUB	BP,#$05	;go to next entry
6B81	JMP	prpatch	;'next one
6B83prpend	POP	BX	;restore PC of end jump
6B84	INC	BX	;point to offset
6B85	JMP	ptcjmppc	;"patch jump
6B88block	CALL	statemnt	;do block: do statement
6B8B	CALL	ctoken	;END ?
6B8E	W	tkend
6B90	JZ	blkret	;yes: done
6B92	CALL	esemi2	;! ;
6B95	JMP	block	;'next statement
6B97blkret	RET		;"
6B98statemnt	MOV.B	semiflg,#$FF	;Do statement
6B9D	MOV	AX,direct	;get compiler directives
6BA0	MOV	direcsv,AX	;use copy during statement
6BA3	TEST	direcsv,#$0010	;user interrupt ?
6BA9	JZ	stmnoint	;:no
6BAB	MOV.B	usrint,#$FF	;set flag: used
6BB0	CALL	ecode	;* INT 3
6BB3	B	$01,$CC
6BB5stmnoint	CALL	ckey	;search keyword - code level
6BB8	B	$02
6BB9	W	tkbegin
6BBB	JZ	stmstd2	;:found
6BBD	CALL	rdvar	;search var
6BC0	JNZ	stmproc	;:not found
6BC2	JMP	cassign	;'do assignment
6BC5stmproc	MOV	CX,#$0500	;search procedure
6BC8	CALL	search
6BCB	JNZ	stmlabel	;:not found
6BCD	JMP	cproc	;'do procedure
6BD0stmlabel	MOV	CX,#$0100	;search label
6BD3	CALL	search
6BD6	JZ	clabel	;:found
6BD8	MOV	CX,#$0600	;search function
6BDB	CALL	search
6BDE	JNZ	stmstd	;:not found
6BE0	JMP	assgnvar	;'do function: assign return var
6BE3stmstd	CALL	ckey	;search keyword: std procedures
6BE6	B	$02
6BE7	W	stdprocs
6BE9	JZ	stmstd2	;:found
6BEB	RET		;'
6BECstmstd2	CS:		;jump to procedure compilation
6BED	JMP	[BX]	;"routine
6BEFclabel	CALL	ecolon	;! : - do label
6BF2	MOV	AL,lexnest	;lexical level
6BF5	CMP.B	AL,[BP]-$03	;= that of label ?
6BF8	CALL	errnz	;no:
6BFB	B	$48	;72:Label not within current block
6BFC	CMP.B	[BP]-$04,#$FF	;label already defined ?
6C00	CALL	errnz	;43:Duplicate ID or label
6C03	B	$2B
6C04	MOV	AL,stklev	;store stack level
6C07	MOV.B	[BP]-$04,AL	;in label entry
6C0A	MOV	AX,pc	;store offset
6C0D	MOV	[BP]-$02,AX
6C10	JMP	statemnt	;"do statement
6C12if	CALL	excond	;IF: evaluate condition
6C15	MOV	AL,brnchop	;branch opcode
6C18	MOV	AH,#$03	;offset
6C1A	CALL	eword	;emit branch
6C1D	PUSH	pc	;save pos of jump
6C21	CALL	ejump	;emit jump
6C24	CALL	ctoken	;THEN ?
6C27	W	tkthen
6C29	CALL	errnz	;no:
6C2C	B	$11	;17:THEN expected
6C2D	CALL	statemnt	;do statement
6C30	CALL	ctoken	;ELSE ?
6C33	W	tkelse
6C35	JNZ	ifnoelse	;:no
6C37	POP	BX	;get pos of THEN-jump
6C38	PUSH	pc	;save pos of second jump
6C3C	CALL	ejump	;emit second jump
6C3F	INC	BX	;point to offset
6C40	CALL	ptcjmppc	;patch jump addr: to ELSE-part
6C43	CALL	statemnt	;do statement
6C46ifnoelse	POP	BX	;restore pos
6C47	INC	BX	;point to offset
6C48	JMP	ptcjmppc	;"patch jump offset
6C4Bwhile	PUSH	pc	;WHILE: save loop beg addr
6C4F	CALL	excond	;evaluate condition
6C52	MOV	AL,brnchop	;branch opcode
6C55	MOV	AH,#$03	;offset
6C57	CALL	eword	;emit branch
6C5A	PUSH	pc	;save pos of jump to end
6C5E	CALL	ejump	;emit it
6C61	CALL	ctoken	;DO ? Bug: not checked
6C64	W	tkdo	;(try it !!)
6C66	CALL	statemnt	;do statement
6C69	POP	BX	;pos of jump
6C6A	POP	AX	;pos of loop beg
6C6B	CALL	ejump	;emit jump to loop beg
6C6E	INC	BX	;point to offset
6C6F	JMP	ptcjmppc	;"patch jump to loop end
6C72repeat	PUSH	pc	;REPEAT: save loop beg addr
6C76reploop	CALL	statemnt	;do statement
6C79	CALL	ctoken	;UNTIL ?
6C7C	W	tkuntil
6C7E	JZ	repend	;yes: end it
6C80	CALL	esemi2	;! ;
6C83	JMP	reploop	;'
6C85repend	CALL	excond	;evaluate condition
6C88	MOV	AL,brnchop	;branch opcode
6C8B	MOV	AH,#$03	;offset
6C8D	CALL	eword	;emit branch
6C90	POP	AX	;restore pos: loop beg
6C91	JMP	ejump	;"emit jump to loop beg
6C94for	MOV	CX,#$0400	;FOR
6C97	CALL	search	;search loop var
6C9A	CALL	errnz	;not found:
6C9D	B	$29	;41:Unknown ID or syntax error
6C9E	CALL	getvprm	;get var parms
6CA1	MOV.B	indflg,#$00	;not indexed
6CA6	CMP.B	indptflg,#$00	;var indirect ?
6CAB	JNZ	forerr	;yes: error
6CAD	CMP.B	varctp,#$0A	;scalar ?
6CB2	JNB	forstrt	;:yes, ok
6CB4forerr	CALL	err	;30:Simple type expected
6CB7	B	$1E	;'
6CB8forstrt	CALL	pushe1	;push var entry
6CBB	MOV	AL,varctp	;save component type
6CBE	PUSH	AX
6CBF	CALL	eassign	;! :=
6CC2	CALL	exprax	;expression -> AX
6CC5	CALL	epushax	;* PUSH AX
6CC8	POP	AX	;component type
6CC9	PUSH	AX
6CCA	CMP.B	AL,CL	;= type read ?
6CCC	CALL	errnz	;no:
6CCF	B	$2C	;44:Type mismatch
6CD0	CALL	ckey	;TO or DOWNTO ?
6CD3	B	$04
6CD4	W	tkto
6CD6	CALL	errnz	;not found:
6CD9	B	$12	;18:TO or DOWNTO expected
6CDA	MOV	forptr,BX	;store direction pointer
6CDE	CALL	exprax	;expression -> AX
6CE1	POP	AX	;test component type
6CE2	CMP.B	AL,CL
6CE4	CALL	errnz	;44:Type mismatch
6CE7	B	$2C
6CE8	CALL	ctoken	;DO ?
6CEB	W	tkdo
6CED	CALL	errnz	;no:
6CF0	B	$0D	;13:DO expected
6CF1	CALL	pope1	;restore entry from stack
6CF4	CALL	ecode	;* POP CX
6CF7	B	$04,$59,$91,$2B,$C8	;* XCHG CX,AX
6CFC	MOV	BX,forptr	;* SUB CX,AX
6D00	CS:		;get flag: pointer to table entry
6D01	MOV.B	AL,[BX]	;get branch
6D03	CALL	ebyte	;emit it
6D06	CALL	ecode	;* branch offset
6D09	B	$04,$03,$E9,$00,$00	;* JUMP ....
6D0E	PUSH	pc	;save jump pos
6D12	CS:	
6D13	MOV.B	AL,[BX]$01	;emit INC/DEC
6D16	CALL	ebyte
6D19	CALL	estore2	;store var
6D1C	PUSH	pc	;save PC
6D20	CALL	ecode	;* PUSH CX
6D23	B	$01,$51
6D25	CALL	pushe1	;save var entry
6D28	PUSH	forptr	;save for-ptr
6D2C	INC.B	stklev	;space used on stack (counter!)
6D30	CALL	statemnt	;do statement
6D33	DEC.B	stklev	;remove from stack
6D37	POP	forptr	;restore FOR-ptr
6D3B	CALL	pope1	;restore var entry
6D3E	CALL	ecode	;* POP CX
6D41	B	$01,$59	;(get counter var from stack)
6D43	MOV	BX,forptr
6D47	CS:	
6D48	MOV.B	AL,[BX]$02	;INC/DEC CX
6D4B	CALL	ebyte	;emit
6D4E	PUSH	pc	;save PC
6D52	CALL	eword	;emit (dummy) branch to loop end
6D55	CS:	
6D56	MOV.B	DH,[BX]$03	;INC or DEC var ?
6D59	MOV	DL,#$FF	;word opcode
6D5B	CMP	varsize,#$01	;test component size
6D60	JA	forword	;:word
6D62	MOV	DL,#$FE	;byte obcode
6D64forword	CALL	einstr	;emit INC loop var
6D67	POP	BX	;restore PC
6D68	POP	AX	;restore PC: beg of loop
6D69	CALL	ejump	;emit jump to loop beg
6D6C	MOV	AX,pc	;PC-dest-2
6D6F	SUB	AX,BX
6D71	DEC	AX
6D72	DEC	AX
6D73	MOV.B	AH,AL	;-> offset
6D75	MOV	AL,#$74	;JZ
6D77	CALL	ptcjmp2	;patch branch: to loop end
6D7A	POP	BX	;restore addr: loop beg-2
6D7B	DEC	BX
6D7C	DEC	BX
6D7D	JMP	ptcjmppc	;"patch jump to loop end
6D80case	CALL	exscal	;CASE: get scalar expression
6D83	MOV.B	casectp,CL	;store CASE-type
6D87	CALL	expof	;! OF
6D8A	XOR	CX,CX	;clear counter: main
6D8C	PUSH	CX
6D8Dcaselp1	XOR	CX,CX	;clear counter: sub
6D8Fcaselp2	PUSH	CX	;save it
6D90	CALL	cmpbound	;get element / lower bound
6D93	CALL	ctoken	;.. ?
6D96	W	tk2dot
6D98	MOV	DL,#$74	;JZ
6D9A	JNZ	casenrng	;:no
6D9C	CALL	ecode	;* JL +05
6D9F	B	$02,$7C,$05
6DA2	CALL	cmpbound	;get upper bound
6DA5	MOV	DL,#$7E	;JG
6DA7	POP	CX	;count: range done
6DA8	INC.B	CH	;count space used
6DAA	PUSH	CX
6DABcasenrng	POP	CX	;restore counter
6DAC	INC.B	CH	;count space used
6DAE	INC.B	CL	;count labels
6DB0	PUSH	DX	;save opcode
6DB1	PUSH	pc	;save pos
6DB5	CALL	eword	;emit branch op
6DB8	CALL	ccomma	;, ?
6DBB	JNZ	caselab	;:no
6DBD	CMP.B	CH,#$14	;branch distance ok ?
6DC0	JB	caselp2	;:yes
6DC2	CALL	ecode	;* JMP +02
6DC5	B	$02,$EB,$02	;make a hip
6DC8	XOR.B	CH,CH	;clear space used
6DCAcasehip	POP	BX	;get branch pos
6DCB	POP	DX	;get opcode
6DCC	MOV	AX,pc	;PC-pos-2
6DCF	SUB	AX,BX
6DD1	DEC	AX
6DD2	DEC	AX
6DD3	MOV.B	AH,AL	;-> offset
6DD5	MOV.B	AL,DL	;branch opcode
6DD7	CALL	ptcjmp2	;patch in branch
6DDA	LOOP	casehip	;:another one
6DDC	MOV	DL,#$EB	;JMP
6DDE	PUSH	DX	;remember opcode
6DDF	PUSH	pc	;& position
6DE3	CALL	eword	;emit it (dummy)
6DE6	MOV	CX,#$0101	;space counter
6DE9	JMP	caselp2	;'continue
6DEBcaselab	CALL	ecolon	;! :
6DEE	CALL	ejump	;emit jump to next case label
6DF1	XOR.B	CH,CH	;clear space counter
6DF3caseres	POP	BX	;fill in branches - as above !
6DF4	POP	DX
6DF5	MOV	AX,pc
6DF8	SUB	AX,BX
6DFA	DEC	AX
6DFB	DEC	AX
6DFC	MOV.B	AH,AL
6DFE	MOV.B	AL,DL
6E00	CALL	ptcjmp2	;patch it
6E03	LOOP	caseres	;:another
6E05	POP	CX	;restore main counter
6E06	PUSH	pc	;save current pos
6E0A	INC	CX	;count case labels
6E0B	PUSH	CX	;save again
6E0C	MOV	AL,casectp	;save type
6E0F	PUSH	AX	;(CASE may be nested !)
6E10	CALL	statemnt	;do statement
6E13	POP	AX	;restore type
6E14	MOV	casectp,AL
6E17	CALL	csemi	;semicolon ?
6E1A	MOV	DL,#$FF	;set flag
6E1C	JZ	casesemi	;:yes
6E1E	XOR.B	DL,DL	;clr flag
6E20casesemi	PUSH	DX	;save it
6E21	CALL	ctoken	;END ?
6E24	W	tkend
6E26	POP	DX	;restore flag
6E27	JZ	caseres2	;:yes
6E29	CALL	ejump	;emit jump to end of CASE
6E2C	POP	CX	;counter
6E2D	POP	BX	;pos of last comparison
6E2E	PUSH	pc	;save pos of jump to CASE-end
6E32	PUSH	CX	;save counter
6E33	DEC	BX	;pos-2
6E34	DEC	BX
6E35	CALL	ptcjmppc	;patch jump
6E38	PUSH	DX	;flag
6E39	CALL	ctoken	;ELSE ?
6E3C	W	tkelse
6E3E	POP	DX	;'flag
6E3F	JZ	caseelse	;:yes
6E41	OR.B	DL,DL	;test flag
6E43	JZ	caseend	;:no semicolon
6E45	JMP	caselp1	;'case loop
6E48caseend	CMP.B	semiflg,#$00	;flag for semi error
6E4D	CALL	errz	;cleared:
6E50	B	$0E	;14:END expected
6E51	CALL	err
6E54	B	$29	;"41:Unknown ID or syntax error
6E55caseelse	CALL	statemnt	;ELSE-part: do statement
6E58	CALL	ctoken	;END ?
6E5B	W	tkend
6E5D	JZ	caseres2	;:yes
6E5F	CALL	esemi2	;! ;
6E62	JMP	caseelse	;'
6E64caseres2	POP	CX	;number of jumps
6E65caseres3	POP	BX	;addr of jump-2
6E66	DEC	BX
6E67	DEC	BX	;patch jumps to end of CASE
6E68	CALL	ptcjmppc
6E6B	LOOP	caseres3	;:another
6E6D	RET		;"
6E6Ecmpbound	CALL	rdnumcn	;get bound: read num constant
6E71	CMP.B	CL,casectp	;correct type ?
6E75	CALL	errnz	;46:Constant and CASE selector type
6E78	B	$2E	;does not match
6E79	MOV	AL,#$3D	;* CMP AX,i
6E7B	CALL	ebyte
6E7E	XCHG	AX,BX	;emit constant: bound
6E7F	JMP	eword	;"
6E82goto	MOV	CX,#$0100	;do GOTO
6E85	CALL	search	;search label
6E88	CALL	errnz	;not found:
6E8B	B	$28	;40:Undefined label
6E8C	MOV.B	AL,[BP]-$03	;lexical level
6E8F	CMP.B	AL,lexnest	;= current ?
6E93	CALL	errnz	;no:
6E96	B	$48	;72:Label not within current block
6E97	MOV	AX,BP	;symtab-ptr of label
6E99exit	CALL	symword	;store in symtab
6E9C	MOV	AX,pc	;store PC
6E9F	CALL	symword
6EA2	MOV	AL,stklev	;store stack level
6EA5	CALL	symbyte
6EA8	JMP	ejump	;"emit jump - resolved at block end
6EABwith	MOV	AL,withnest	;WITH: nesting level
6EAE	MOV.B	AH,stklev	;stack level
6EB2	PUSH	AX	;save them
6EB3withlp	CMP.B	withnest,#$10	;too much ?
6EB8	CALL	errz	;yes:
6EBB	B	$61
6EBC	CALL	rdvar	;get var
6EBF	CALL	errnz	;not found:
6EC2	B	$29	;41:Unknown ID or syntax error
6EC3	CMP.B	varctp,#$02	;type = record ?
6EC8	CALL	errnz	;no:
6ECB	B	$1D	;29:Record variable expected
6ECC	CMP.B	indflg,#$00	;indexed ?
6ED1	JNZ	withindx	;:yes
6ED3	MOV.B	AH,varseg	;segment and offset
6ED7	MOV	DX,varofs	;already known
6EDB	JMP.b	withsto	;'store in WITH-buffer
6EDDwithindx	CALL	varptr2	;get var ptr
6EE0	CALL	epushdi	;* PUSH DI
6EE3	ADD.B	stklev,#$02	;4 bytes on stack
6EE8	MOV.B	AH,stklev	;get stack level
6EEC	MOV	DX,#$FFFF	;dummy pos: variable
6EEFwithsto	MOV.B	BL,withnest
6EF3	XOR.B	BH,BH	;nesting level*4 -> BX
6EF5	SHL	BX,1 	;offset into WITH-buffer
6EF7	SHL	BX,1 
6EF9	MOV	AL,varnest	;store type, position
6EFC	MOV	[BX]withtab,AX	;-> WITH-buffer
6F00	MOV	[BX]withtab1,DX
6F04	INC.B	withnest	;inc nesting level
6F08	CALL	ccomma	;, ?
6F0B	JZ	withlp	;yes: repeat
6F0D	CALL	ctoken	;DO ?
6F10	W	tkdo
6F12	CALL	errnz	;no:
6F15	B	$0D	;13:DO expected
6F16	CALL	statemnt	;do statement
6F19	MOV.B	CL,stklev	;stack usage
6F1D	POP	AX	;restore stack usage, nesting level
6F1E	MOV	withnest,AL
6F21	MOV.B	stklev,AH
6F25	SUB.B	CL,AH	;remove from stack ?
6F27	JZ	withret	;:nothing to remove
6F29	MOV	AX,#$C483	;* ADD SP,...
6F2C	CALL	eword
6F2F	MOV.B	AL,CL	;var count * 2
6F31	SHL.B	AL,1 
6F33	CALL	ebyte	;emit byte
6F36withret	RET		;"
6F37inline	CALL	ebrack1	;! ( - Inline
6F3Ainllp	MOV.B	inlinflg,#$02	;flag: byte mode
6F3F	MOV	AL,#$3E
6F41	CALL	chkal	;> ?
6F44	JZ	inltp	;:yes
6F46	MOV.B	inlinflg,#$01	;word mode
6F4B	MOV	AL,#$3C	;< ?
6F4D	CALL	chkal
6F50	JZ	inltp	;:yes
6F52	MOV.B	inlinflg,#$00	;normal mode
6F57inltp	XOR	BX,BX	;clear number
6F59	XOR	CX,CX	;clear neg flag
6F5Binlexlp	PUSH	BX	;save
6F5C	PUSH	CX
6F5D	CALL	rdconst	;read num constant
6F60	JNZ	inlnocn	;:no good
6F62	CMP.B	CL,#$0A	;type = integer ?
6F65	CALL	errnz	;no:
6F68	B	$16	;22:Integer constant expected
6F69	XCHG	AX,BX	;result -> AX
6F6A	JMP.b	inlatom	;'
6F6Cinlnocn	CMP.B	inlinflg,#$00	;normal mode ?
6F71	JNZ	inlpc	;:no
6F73	MOV.B	inlinflg,#$02	;set word mode
6F78inlpc	MOV	AL,#$2A	;* ?
6F7A	CALL	chkal
6F7D	JNZ	inlvar	;:no
6F7F	MOV	AX,pc	;PC -> result
6F82	JMP.b	inlatom	;'
6F84inlvar	MOV	CX,#$0400	;search var
6F87	CALL	search
6F8A	JNZ	inlproc	;:not found
6F8C	CALL	getvprm	;get var parms
6F8F	MOV	AX,varofs	;get var offset
6F92	JMP.b	inlatom	;'
6F94inlproc	MOV	CX,#$0500	;search proc
6F97	CALL	search
6F9A	JZ	inlproc2	;:found
6F9C	MOV	CX,#$0600	;search func
6F9F	CALL	search
6FA2	CALL	errnz	;not found:
6FA5	B	$4A	;74:Inline error
6FA6inlproc2	MOV	AX,[BP]-$08	;get offset
6FA9inlatom	POP	CX	;restore
6FAA	POP	BX
6FAB	JCXZ	inlnoneg	;:no negation
6FAD	NEG	AX	;negate result
6FAFinlnoneg	ADD	BX,AX	;add to number
6FB1	XOR	CX,CX	;clear neg flag
6FB3	MOV	AL,#$2B	;+ ?
6FB5	CALL	chkal
6FB8	JZ	inlexlp	;:yes
6FBA	DEC	CX	;set neg flag
6FBB	MOV	AL,#$2D	;- ?
6FBD	CALL	chkal
6FC0	JZ	inlexlp	;:yes
6FC2	XCHG	AX,BX	;else: end of expression
6FC3	CMP.B	inlinflg,#$01	;byte mode ?
6FC8	JA	inlword	;:word mode
6FCA	JZ	inlbyte	;:byte mode
6FCC	OR.B	AH,AH	;normal mode: result > 255 ?
6FCE	JNZ	inlword	;:yes
6FD0inlbyte	CALL	ebyte	;emit byte
6FD3	JMP.b	inlchk	;'
6FD5inlword	CALL	eword	;emit word
6FD8inlchk	MOV	AL,#$2F	;/ ?
6FDA	CALL	chkal
6FDD	JNZ	inlend	;no: end it
6FDF	JMP	inllp	;'loop back: next expression
6FE2inlend	CALL	ebrack2	;! )
6FE5	RET		;"
6FE6cproc	CALL	estkchk	;procedure call: stack checking
6FE9cproc2	PUSH	BP	;save symtab pos
6FEA	MOV.B	CL,[BP]-$10	;parameter count
6FED	SUB	BP,#$10	;go to parameter
6FF0	OR.B	CL,CL	;any parms ?
6FF2	JNZ	cprparms	;:yes
6FF4	JMP	cprnoprm	;'none - end it
6FF7cprparms	CALL	ebrack1	;! (
6FFAcprlp1	PUSH	CX	;parameter loop
6FFB	PUSH	BP	;save counter, symtab pos
6FFC	MOV	CX,[BP]-$04	;parm count same type
6FFF	MOV	BP,[BP]-$02	;type ptr
7002	CALL	getvprm2	;get type parms
7005cprlp2	PUSH	CX	;save counter
7006	OR.B	CH,CH	;VAR-parameter ?
7008	JNZ	cprvar	;:yes
700A	CMP.B	varctp,#$03	;set ?
700F	JB	cprcpl	;:below, complex var
7011	CALL	exprsave	;get expression -> AX/stack
7014	CALL	typechk	;type checking, conversions
7017	CALL	erngchk	;range check
701A	CMP.B	varctp,#$0A	;scalar ?
701F	JNB	cprscal	;:yes
7021	CMP.B	varctp,#$04	;ptr ?
7026	JNZ	cprstr	;:no
7028	CALL	ecode	;* PUSH DX
702B	B	$01,$52
702Dcprscal	CALL	epushax	;* PUSH AX
7030	JMP.b	cprnext	;'next parm
7032cprstr	CMP.B	varctp,#$08	;string ?
7037	JNZ	cprset	;:no
7039	MOV.B	AH,varsize	;get max length
703D	DEC.B	AH
703F	MOV	AL,#$B1
7041	CALL	eword	;* MOV CL,max_len
7044	MOV	AX,#xstrparm	;adapt string size
7047	CALL	ecall	;* CALL xstrparm
704A	JMP.b	cprnext	;'next parm
704Ccprset	CMP.B	varctp,#$03	;set ?
7051	JNZ	cprnext	;no:next parm
7053	CALL	esetfac	;calc set crunch factor
7056	MOV	AX,#xsetparm	;adapt set size
7059	CALL	ecall	;* CALL xsetparm
705C	JMP.b	cprnext	;'next parm
705Ecprcpl	CALL	pushe1	;save var entry: complex var
7061	CALL	fullvar	;do full var
7064	CALL	errnz	;no good:
7067	B	$29	;41:Unknown ID or syntax error
7068	CALL	varptr2	;get var ptr
706B	MOV	AX,varsize	;component size
706E	CALL	emovcxi	;* MOV CX,compo_size
7071	MOV	AX,#xblkparm	;copy complex var to stack
7074	CALL	ecall	;* CALL xblkparm
7077	JMP.b	cprchk	;'check type
7079cprvar	CALL	pushe1	;save entry - VAR-parameter
707C	CALL	varptr	;get var ptr
707F	CALL	epushdi	;* PUSH DI
7082cprchk	CALL	copye2	;copy entry from stack
7085	CMP.B	var2ctp,#$00	;type = 0 ?
708A	JZ	cpruntyp	;yes: untyped
708C	CALL	tchkstrc	;type checking struct vars
708Fcpruntyp	CALL	pope1	;restore entry
7092cprnext	POP	CX	;restore counter
7093	DEC.B	CL	;another parm of same type ?
7095	JZ	cprskip	;:no
7097	CALL	ecomma	;! ,
709A	JMP	cprlp2	;'loop back - same type
709Dcprskip	POP	BP	;restore symtab pos
709E	SUB	BP,#$04	;go to next parm
70A1	MOV.B	AL,[BP]$00	;get cnt
70A4cprsklp	DEC	BP
70A5	MOV.B	CL,[BP]$00	;skip var entries
70A8	XOR.B	CH,CH
70AA	SUB	BP,CX	;skip name
70AC	DEC.B	AL	;count down
70AE	JNZ	cprsklp	;:another
70B0	POP	CX	;restore count
70B1	DEC.B	CL	;another parameter ?
70B3	JZ	cprend	;:no
70B5	CALL	ecomma	;! ,
70B8	JMP	cprlp1	;'loop back
70BBcprend	CALL	ebrack2	;! )
70BEcprnoprm	POP	BP	;symtab pos
70BF	MOV	AX,[BP]-$0E	;overlay ?
70C2	OR	AX,AX
70C4	JZ	cprnoovr	;:no
70C6	CALL	emovaxi	;* MOV AX,proc_len
70C9	MOV	AX,[BP]-$0C	;get file offset
70CC	CALL	emovdxi	;* MOV DX,file_offs
70CFcprnoovr	MOV	AX,[BP]-$08	;get proc offset
70D2	JMP	ecall	;"* CALL proc
70D5estkchk	TEST	direcsv,#$0020	;Stack checking ?
70DB	JZ	estkret	;:switched off
70DD	MOV	AX,[BP]-$0A	;get space needed
70E0	CALL	emovcxi	;* MOV CX,space_needed
70E3	MOV	AX,#xchkstk
70E6	CALL	ecall	;* CALL xchkstk
70E9estkret	RET		;"
70EAcassign	CMP.B	varctp,#$00	;Do assignment: untyped ?
70EF	JZ	asnerr	;yes: error
70F1	CMP.B	varctp,#$05	;file var ?
70F6	JB	asnscal	;:no
70F8	CMP.B	varctp,#$07
70FD	JA	asnscal	;:no
70FFasnerr	CALL	err	;files cannot be assigned !
7102	B	$36	;'54:Illegal assignment
7103asnscal	CMP.B	varctp,#$0A	;scalar ?
7108	JNB	asnscal2	;:yes
710A	CMP.B	varctp,#$04	;pointer ?
710F	JNZ	asnvar	;:no
7111asnscal2	CMP.B	varseg,#$FD	;segment = ES ?
7116	JNZ	asnnoseg	;:no
7118	MOV.B	flgpshes,#$01	;set flag: PUSH ES
711Dasnnoseg	CMP.B	indflg,#$00	;indexed ?
7122	JZ	asn2	;:no
7124	MOV.B	flgpshdi,#$01	;set flag: PUSH DI
7129	JMP.b	asn2	;'
712Basnvar	CALL	varptr2	;get var ptr
712E	CALL	epushdi	;* PUSH DI
7131asn2	CALL	eassign	;! :=
7134	CMP.B	varctp,#$03	;set ?
7139	JB	asncpl	;:no, complex type
713B	CALL	pushe1	;save dest var entry
713E	PUSH	pc	;save PC
7142	CALL	expr	;evaluate expression
7145	POP	AX	;old = new PC ?
7146	SUB	AX,pc
714A	MOV	flgpshes,#$0000	;clear flag: PUSH ES
7150	PUSH	AX	;save difference
7151	CALL	expload	;get expression, ready for store
7154	POP	AX
7155	CALL	pope1	;restore dest var entry
7158	PUSH	AX	;save diff
7159	CALL	typechk	;type checking, conversions
715C	POP	AX
715D	CMP.B	varctp,#$0A	;scalar ?
7162	JNB	asnscal3	;:yes
7164	CMP.B	varctp,#$04	;pointer ?
7169	JNZ	asnstore	;:no
716Basnscal3	OR	AX,AX	;test diff
716D	JZ	asnstore	;none: ok
716F	CMP.B	indflg,#$00	;indexed ?
7174	JZ	asnnoind	;:no
7176	CALL	ecode	;* POP DI - restore ptr
7179	B	$01,$5F
717Basnnoind	CMP.B	varseg,#$FD	;segment = ES ?
7180	JNZ	asnstore	;:no
7182	CALL	ecode	;* POP ES
7185	B	$01,$07
7187asnstore	JMP	estore	;'Store var
718Aasncpl	CALL	pushe1	;store dest var entry
718D	CALL	fullvar	;do full var
7190	CALL	errnz	;no good:
7193	B	$29	;41:Unknown ID or syntax error
7194	CALL	varptr2	;get var ptr
7197	CALL	pope2	;restore dest var entry
719A	CALL	tchkstrc	;type checking - struct vars
719D	MOV	AX,var2size	;component size
71A0	CALL	emovcxi	;* MOV CX,comp_size
71A3	MOV	AX,#xmovevar
71A6	JMP	ecall	;'* CALL xmovevar
71A9typechk	CMP.B	varctp,#$09	;Type checking, conversions
71AE	JNZ	tckstr	;:no real
71B0	CMP.B	CL,#$0A	;now integer ?
71B3	JNZ	tckchk	;:no
71B5	MOV	AX,#xintreal	;conversion int -> real
71B8	CALL	ecall	;* CALL xintreal
71BB	MOV	CL,#$09	;now real
71BD	JMP.b	tckchk	;'
71BFtckstr	CMP.B	varctp,#$08	;string expected ?
71C4	JNZ	tckch	;:no
71C6	CMP.B	CL,#$0C	;result = char ?
71C9	JNZ	tckchk	;:no
71CB	CALL	ecode	;* MOV AH,AL
71CE	B	$05,$8A,$E0,$B0,$01,$50	;* MOV AL,01
71D4	MOV	CL,#$08	;* PUSH AX
71D6	JMP.b	tckchk	;'now string
71D8tckch	CMP.B	varctp,#$0C	;char expected ?
71DD	JNZ	tckchk	;:no
71DF	CMP.B	CL,#$08	;result = string ?
71E2	JNZ	tckchk	;:no
71E4	MOV	AX,#xstrch	;convert to char
71E7	CALL	ecall	;* CALL xstrch
71EA	MOV	CL,#$0C	;now char
71ECtckchk	CMP.B	CL,varctp	;type = expected ?
71F0	JNZ	tckerr	;no: error
71F2	CMP.B	CL,#$03	;set ?
71F5	JNZ	tckptr	;:no
71F7	OR.B	CH,CH	;constant ?
71F9	JZ	tckret	;yes: ret
71FB	MOV	BP,lower	;same base type ?
71FF	CMP.B	CH,[BP]-$08
7202	JZ	tckret	;yes: ret
7204tckerr	CALL	err	;44:Type mismatch
7207	B	$2C	;'
7208tckptr	CMP.B	CL,#$04	;pointer ?
720B	JNZ	tckret	;no: ret
720D	MOV	AX,functp	;type pointer
7210	OR	AX,AX	;untyped ?
7212	JZ	tckret	;yes: ret
7214	CMP	AX,lower	;compare types
7218	JNZ	tckerr	;different: error
721Atckret	RET		;"
721Btchkstrc	MOV	AL,varctp	;Type checking struct vars
721E	CMP	AL,#$00	;type expected: untyped ?
7220	JZ	tcserr	;yes: type mismatch
7222	MOV	DL,#$BF	;check everything
7224	CMP	AL,#$0A	;scalar ?
7226	JNB	tcschk	;yes: check it
7228	CMP	AL,#$08	;string ?
722A	JNZ	tcsnostr	;:no
722C	MOV	DL,#$80	;check type only
722E	TEST	direcsv,#$0040	;string checking ?
7234	JZ	tcschk	;:no
7236tcsnostr	MOV	DL,#$83	;check type, component size
7238	CMP	AL,#$06	;text, untyped file ?
723A	JNB	tcschk	;:check it
723C	MOV	DL,#$B3
723E	CMP	AL,#$03	;set ?
7240	JNB	tcschk	;:check it
7242	MOV	DL,#$C3	;check type, rec nest, size
7244	CMP	AL,#$02	;record ?
7246	JNB	tcschk	;:check it
7248	CMP	upper,#$00	;second type
724D	MOV	DL,#$BF	;check everything
724F	JNZ	tcschk	;:check it
7251	MOV	BP,upper2	;second type
7255	CMP.B	[BP]-$08,#$0A	;scalar index ?
7259	JNZ	tcserr	;no: type mismatch
725B	MOV	DL,#$B3	;check type, lower, upper, size
725Dtcschk	MOV	SI,#varctp	;check buffers
7260	MOV	DI,#var2ctp
7263	MOV	CX,#$0008	;check 8 bytes
7266tcschklp	ROL.B	DL,1 	;test this byte ?
7268	JNB	tcsnochk	;:no
726A	MOV.B	AL,[SI]	;compare
726C	CMP.B	AL,[DI]
726E	JNZ	tcserr	;different: error
7270tcsnochk	INC	SI	;next byte
7271	INC	DI
7272	LOOP	tcschklp	;:another
7274	RET		;'
7275tcserr	CALL	err	;44:Type mismatch
7278	B	$2C	;"
7279assgnvar	CALL	getvprm	;get var parms
727C	CMP.B	indptflg,#$00	;indirect ?
7281	CALL	errnz	;yes:
7284	B	$29	;41:Unknown ID or syntax error
7285	CALL	rdvarind	;do indexing
7288	JMP	cassign	;"do assignment
728Bpassign	CALL	brfilvar	;ASSIGN: get file var
728E	MOV	AX,#xassign	;normal Assign
7291	CMP.B	CL,#$06	;text file ?
7294	JNZ	pasgn2	;:no
7296	MOV	AX,#xassgntx	;assign text file
7299	CALL	pasgn2	;get params
729C	JMP.b	pfilchk	;'do checking
729Epasgn2	PUSH	AX	;save call addr
729F	CALL	epushdi	;* PUSH DI
72A2	CALL	ecomma	;! ,
72A5	CALL	exstr	;get string expr
72A8	POP	AX	;restore call addr
72A9pemit	PUSH	AX	;save call addr
72AA	CALL	ebrack2	;! )
72AD	POP	AX	;call addr
72AE	JMP	ecall	;"emit call
72B1prename	CALL	brfilvar	;RENAME: get file var
72B4	MOV	AX,#xrename
72B7	CALL	pasgn2	;get string, emit call
72BA	JMP.b	pfilchk	;"do checking
72BCperase	CALL	brfilvar	;ERASE: get file var
72BF	MOV	AX,#xerase
72C2	JMP.b	pfilend	;'put it
72C4pchain	MOV	AX,#xchain	;CHAIN
72C7	JMP.b	pexec2	;'put it
72C9pexecute	MOV	AX,#xexecute	;EXECUTE
72CCpexec2	PUSH	AX	;save addr
72CD	CALL	brfilvar	;get file var
72D0pexec3	POP	AX	;restore addr
72D1pfilend	CALL	pemit	;test ), emit call
72D4pfilchk	JMP	efilchk	;"do checking
72D7pseek	CALL	brfilvar	;SEEK, LONGSEEK: get file var
72DA	CMP.B	CL,#$06	;text file ?
72DD	CALL	errz	;yes:
72E0	B	$3F	;63:Textfiles are not allowed here
72E1	CALL	epushdi	;* PUSH DI
72E4	CALL	ecomma	;! ,
72E7	CALL	exnum	;get num expr
72EA	MOV	AX,#xseek
72ED	CMP.B	CL,#$0A	;integer ?
72F0	JZ	pseekint	;:yes
72F2	MOV	AX,#xlngseek	;real...
72F5pseekint	JMP	pfilend	;"test ), emit call, check
72F7pappend	CALL	brfilvar	;APPEND: get file var
72FA	CMP.B	CL,#$06	;text file ?
72FD	CALL	errnz	;no:
7300	B	$23	;35:Textfile expected
7301	MOV	AX,varsize	;component size
7304	SUB	AX,#$004C	;sub size of file var
7307	CALL	emovcxi	;* MOV CX,buf_size
730A	MOV	AX,#xappndtx
730D	JMP	pfilend	;"test ), emit call, check
730Fpreset	MOV	BX,#vreset	;RESET
7312	JMP.b	prw2	;'ptr into vector table
7314prewrite	MOV	BX,#vrewrite	;REWRITE
7317prw2	PUSH	BX	;save ptr
7318	CALL	brfilvar	;get file var
731B	CMP.B	varctp,#$05	;typed file ?
7320	JNZ	prwtext	;:no
7322	MOV	BP,lower	;type ptr
7326	CALL	getparm	;get var parms
7329	MOV	AX,var2size	;component size
732C	CALL	emovcxi	;* MOV CX,compo_size
732F	JMP.b	prwemit	;'
7331prwtext	CMP.B	varctp,#$06	;text file ?
7336	JNZ	prwuntp	;:no
7338	MOV	AX,varsize	;var size-base size
733B	SUB	AX,#$004C
733E	CALL	emovcxi	;* MOV CX,buf_size
7341	JMP.b	prwemit	;'
7343prwuntp	CALL	epushdi	;* PUSH DI - untyped file
7346	CALL	ccomma	;, ?
7349	JNZ	prwuntp2	;:no
734B	CALL	pushe1	;save var entry
734E	CALL	exint	;get int expr: block size
7351	CALL	pope1	;restore var entry
7354	JMP.b	prwemit	;'
7356prwuntp2	MOV	AX,#$0080	;std blk size
7359	CALL	emovaxi	;* MOV AX,0080
735Cprwemit	POP	BX	;restore table index
735D	JMP.b	pclose3	;'
735Fptruncat	MOV	BX,#vtruncat	;TRUNCATE
7362	JMP.b	pclose2	;'
7364pflush	MOV	BX,#vflush	;FLUSH
7367	JMP.b	pclose2	;'
7369pclose	MOV	BX,#vclose	;CLOSE
736Cpclose2	PUSH	BX	;save table index
736D	CALL	brfilvar	;get file var
7370	POP	BX	;restore index
7371pclose3	CALL	ebrack2	;! )
7374	CALL	ecallio	;emit call
7377	JMP	pfilchk	;"do checking
737Aecallio	MOV	AL,varctp	;emit call for I/O
737D	SUB	AL,#$05	;(component type-5)*2
737F	XOR.B	AH,AH
7381	ADD	AX,AX
7383	ADD	BX,AX	;+ BX -> pointer
7385	CS:	
7386	MOV	AX,[BX]	;get vector
7388	JMP	ecall	;"emit call
738Bvreset	W	xresetty,xresettx,xresetun	;vector table for I/O
7391vrewrite	W	xrewrtty,xrewrttx,xrewrtun
7397vclose	W	xclosety,xclosetx,xclosety
739Dvflush	W	xflushty,xflush,xflushty
73A3vtruncat	W	xtruncat,xtrunctx,xtruncat	;"
73A9brfilvar	CALL	ebrack1	;! (
73AC	CALL	rdfilvar	;get file var
73AF	JZ	brfilret	;ok:ret
73B1	CALL	err
73B4	B	$15	;'21:File variable expected
73B5brfilret	RET		;"
73B6rdfilvar	CALL	rdvar	;get file var: get var
73B9	JZ	rdfil2	;:found
73BB	STC		;not found
73BC	RET		;'
73BDrdfil2	CMP.B	varctp,#$05	;file var ?
73C2	JB	rdfilnf	;:no
73C4	CMP.B	varctp,#$07
73C9	JA	rdfilnf	;:no
73CB	CALL	varptr2	;get var ptr
73CE	MOV.B	CL,varctp	;get type
73D2	XOR	AX,AX	;ok
73D4rdfilnf	CLC	
73D5	RET		;"
73D6preadln	MOV	AL,#$FF	;READLN: set flag
73D8	JMP.b	prd1	;'
73DApread	XOR.B	AL,AL	;READ
73DCprd1	MOV	rdlnflg,AL	;store flag
73DF	CALL	cbrack1	;( ?
73E2	JZ	prdfil	;:yes
73E4	CALL	setinp	;set input path
73E7	JMP	prdrdln	;'do checking
73EAprdfil	CALL	rdfilvar	;get file var
73ED	JB	prderr	;:error
73EF	JNZ	prdsetin	;no file var: use std
73F1	CMP.B	CL,#$05	;typed file ?
73F4	JNZ	prdtext	;:no
73F6	JMP	prdtyped	;'do read typed file
73F9prdtext	CMP.B	CL,#$06	;text file ?
73FC	CALL	errnz	;no:
73FF	B	$41	;65:Untyped files are not allowed here
7400	MOV	AX,#xrdfil	;(prepare for input)
7403	CALL	ecall	;* CALL xrdfil
7406	JMP	prdnxt	;'
7409prderr	CALL	err	;41:Unknown ID or syntax error
740C	B	$29	;'
740Dprdsetin	CALL	setinp	;set input path
7410	JMP.b	prdlp2	;'
7412prdloop	CALL	rdvar	;parameter loop: read var
7415	CALL	errnz	;not found:
7418	B	$29	;41:Unknown ID or syntax error
7419prdlp2	CALL	varptr2	;get var ptr
741C	MOV.B	CL,varctp	;component type
7420	CMP.B	CL,#$01	;array ?
7423	JZ	prdarrch	;yes: read as byte block
7425	CMP.B	CL,#$08	;file, ptr, set, record ?
7428	JB	prderrtp	;:not allowed
742A	CMP.B	CL,#$0B	;boolean ?
742D	JZ	prderrtp	;:not allowed
742F	CMP.B	CL,#$0D	;scalar ?
7432	JB	prdstr	;below: ok
7434prderrtp	CALL	err	;66:I/O not allowed here
7437	B	$42	;'
7438prdarrch	MOV	BP,lower	;type ptr - test array of char
743C	CMP.B	[BP]-$08,#$0C	;component type = char ?
7440	JNZ	prderrtp	;no:error
7442	MOV	BP,upper	;index type = integer ?
7446	CMP.B	[BP]-$08,#$0A
744A	JNZ	prderrtp	;no:error
744C	MOV	AX,varsize	;component size
744F	OR.B	AH,AH	;> 255 ?
7451	JNZ	prderrtp	;yes:error
7453	MOV.B	AH,AL	;* MOV CL,len
7455	MOV	AL,#$B1
7457	CALL	eword
745A	MOV	AX,#xrdarrch	;(read array of char)
745D	JMP.b	prdemit	;'
745Fprdstr	CMP.B	CL,#$08	;string ?
7462	JNZ	prdnum	;:no
7464	MOV.B	AH,varsize	;max len-1
7468	DEC.B	AH
746A	MOV	AL,#$B1
746C	CALL	eword	;* MOV CL,max_len
746F	MOV	AX,#xrdstr	;(read string)
7472	JMP.b	prdemit	;'
7474prdnum	MOV	AX,#xrdreal	;(read real)
7477	CMP.B	CL,#$09	;real ?
747A	JZ	prdemit	;:yes
747C	MOV	AX,#xrdchar	;(read char)
747F	CMP.B	CL,#$0C	;char ?
7482	JZ	prdemit	;:yes
7484	MOV	AX,#xrdint	;(read integer)
7487	CMP	varsize,#$01	;word ?
748C	JA	prdemit	;:yes
748E	MOV	AX,#xrdbyte	;(read byte)
7491prdemit	CALL	ecall	;emit call
7494prdnxt	CALL	ccomma	;another var ?
7497	JNZ	prdend	;no: end it
7499	JMP	prdloop	;'parameter loop
749Cprdend	CALL	ebrack2	;! )
749Fprdrdln	MOV	AX,#xreadln	;(readln)
74A2prdln	CMP.B	rdlnflg,#$00	;ReadLn ?
74A7	JZ	efilchk	;:no
74A9	CALL	ecall	;emit call
74ACefilchk	TEST	direcsv,#$0001	;do I/O-checking ?
74B2	JZ	prdret	;:no
74B4	MOV	AX,#xiochk	;(I/O-check)
74B7	CALL	ecall
74BAprdret	RET		;"
74BBsetinp	MOV	AX,#xstdin	;set input path: std input
74BE	CMP	cinpsize,#$00	;buffer > 0 ?
74C3	JNZ	setinprt	;yes: do it
74C5	TEST	direcsv,#$0004	;test I/O-mode
74CB	JZ	setinprt	;:MS-DOS std input
74CD	MOV	AX,#xrdln	;(read with editing)
74D0	CMP.B	rdlnflg,#$00	;ReadLn ?
74D5	JZ	setinprt	;:no
74D7	MOV.B	rdlnflg,#$00	;clear flag
74DC	MOV	AX,#xrd	;(Readln with editing)
74DFsetinprt	JMP	ecall	;"emit call
74E2pwriteln	MOV	AL,#$FF	;WRITELN
74E4	JMP.b	pwr1	;'
74E6pwrite	XOR.B	AL,AL	;WRITE
74E8pwr1	MOV	rdlnflg,AL	;set flag
74EB	CALL	cbrack1	;( ?
74EE	JZ	pwrfil	;yes: ok
74F0	MOV	AX,#xstdout	;set std output
74F3	CALL	ecall	;emit call
74F6	JMP	pwrend2	;'end it
74F9pwrfil	CALL	rdfilvar	;get file var
74FC	JB	pwrstd2	;:none
74FE	JNZ	pwrstd	;no file var
7500	CMP.B	CL,#$05	;typed file ?
7503	JNZ	pwrtext	;:no
7505	JMP	pwrtyped	;'write typed file
7508pwrtext	CMP.B	CL,#$06	;text file ?
750B	CALL	errnz	;no:
750E	B	$41	;65:Untyped files are not allowed here
750F	MOV	AX,#xwrfil	;(prepare for write)
7512	CALL	ecall	;* CALL xwrfil
7515	JMP	pwrnext	;'
7518pwrstd	MOV	AX,#xstdout	;set std output
751B	CALL	ecall	;* CALL xstdout
751E	CALL	expvar	;expression (var pre-read)
7521	JMP.b	pwrstr	;'check type
7523pwrstd2	MOV	AX,#xstdout	;set std output
7526	CALL	ecall	;* CALL xstdout
7529pwrloop	CALL	constel	;get const element
752C	JNZ	pwrexpv	;:no, try expression
752E	CMP.B	CL,#$08	;string ?
7531	JNZ	pwrexpc	;:no
7533	MOV	DI,chptr	;check current char
7537	CMP.B	[DI],#$2C	;, ?
753A	JZ	pwrinlin	;:yes
753C	CMP.B	[DI],#$29	;) ?
753F	JNZ	pwrexpc	;no: normal
7541pwrinlin	MOV	AX,#xwrtinl	;(write inline string)
7544	CALL	ecall	;* CALL xwrtinl
7547	CALL	estring	;emit string
754A	JMP.b	pwrnext	;'get next element
754C	NOP	
754Dpwrexpc	CALL	expconst	;expression (const pre-read)
7550	JMP.b	pwrstr	;'check type
7552pwrexpv	CALL	exprax	;expression (var pre-read)
7555pwrstr	CMP.B	CL,#$08	;string ?
7558	JB	pwrerrtp	;below:illegal
755A	CMP.B	CL,#$0D	;scalar ?
755D	JB	pwrint	;below: ok
755Fpwrerrtp	CALL	err	;66:I/O not allowed here
7562	B	$42	;'
7563pwrint	CMP.B	CL,#$0A	;integer ?
7566	JB	pwrnoint	;below: real, string
7568	CALL	epushax	;* PUSH AX - stack it
756Bpwrnoint	CALL	ccolon	;: ?
756E	JNZ	pwrdef	;no:default format
7570	PUSH	CX	;save type
7571	CALL	exint	;get int expression
7574	POP	CX
7575	CMP.B	CL,#$09	;real ?
7578	JNZ	pwrchk	;no: no second parm
757A	CALL	ccolon	;: ?
757D	JNZ	pwrdef3	;no: use default
757F	CALL	epushax	;* PUSH AX
7582	PUSH	CX	;save type
7583	CALL	exint	;get int expression
7586	POP	CX
7587	JMP.b	pwrchk	;'continue
7589pwrdef	XOR	AX,AX	;standard format
758B	CMP.B	CL,#$09	;real ?
758E	JNZ	pwrdef2	;:no
7590	MOV	AL,#$12	;default: 18 chars
7592pwrdef2	CALL	emovaxi	;* MOV AX,field_len
7595	CMP.B	CL,#$09	;real ?
7598	JNZ	pwrchk	;:no
759Apwrdef3	CALL	epushax	;* PUSH AX
759D	MOV	AX,#$FFFF
75A0	CALL	emovaxi	;* MOV AX,#FFFF
75A3pwrchk	MOV	AX,#xwrtstr	;(write string)
75A6	CMP.B	CL,#$08	;string ?
75A9	JZ	pwremit	;:yes
75AB	MOV	AX,#xwrreal	;(write real)
75AE	CMP.B	CL,#$09	;real ?
75B1	JZ	pwremit	;:yes
75B3	MOV	AX,#xwrint	;(write integer)
75B6	CMP.B	CL,#$0A	;integer ?
75B9	JZ	pwremit	;:yes
75BB	MOV	AX,#xwrbool	;(write boolean)
75BE	CMP.B	CL,#$0B	;boolean ?
75C1	JZ	pwremit	;:yes
75C3	MOV	AX,#xwrchar	;(write char)
75C6pwremit	CALL	ecall	;emit call
75C9pwrnext	CALL	ccomma	;, ?
75CC	JNZ	pwrend	;no: end it
75CE	JMP	pwrloop	;'do param loop
75D1pwrend	CALL	ebrack2	;! )
75D4pwrend2	MOV	AX,#xwrln	;(writeln)
75D7	JMP	prdln	;"like read/readln
75DAprdtyped	MOV	AX,#xrdvar	;Read typed file
75DD	JMP.b	pwt2	;'(read byte block)
75DFpwrtyped	MOV	AX,#xwrvar	;Write typed file
75E2pwt2	CMP.B	rdlnflg,#$00	;ReadLn/WriteLn ?
75E7	CALL	errnz	;yes:
75EA	B	$23	;35:Textfile expected
75EB	PUSH	AX	;save addr
75EC	MOV	AX,#xfilsel	;(select file)
75EF	CALL	ecall	;* CALL xfilsel
75F2	MOV	BP,lower	;type ptr
75F6	CALL	getparm	;get type parms
75F9pwtloop	CALL	ccomma	;, ?
75FC	JNZ	pwtend	;no: end it
75FE	CALL	pushe2	;push entry
7601	CALL	varptr	;get var ptr
7604	CALL	pope2	;pop entry
7607	CALL	tchkstrc	;check type struct vars
760A	POP	AX	;get routine addr
760B	PUSH	AX
760C	CALL	ecall	;* CALL xwrvar / xrdvar
760F	JMP	pwtloop	;'parameter loop
7611pwtend	POP	AX	;remove
7612	CALL	ebrack2	;! )
7615	JMP	efilchk	;"do checking
7618pblockrd	MOV	AX,#xblkrdrd	;BLOCKREAD
761B	MOV	BX,#xblkrd	;with / without res var
761E	JMP.b	pbl1	;'
7620pblockwr	MOV	AX,#xblkwrrs	;BLOCKWRITE
7623	MOV	BX,#xblkwr
7626pbl1	PUSH	AX	;save addr
7627	PUSH	BX
7628	CALL	brfilvar	;get file var
762B	CMP.B	CL,#$07	;untyped ?
762E	CALL	errnz	;no:
7631	B	$25	;37:Untyped file expected
7632	CALL	epushdi	;* PUSH DI
7635	CALL	ecomma	;! ,
7638	CALL	varptr	;get var ptr (src/dst var)
763B	CALL	epushdi	;* PUSH DI
763E	CALL	ecomma	;! ,
7641	CALL	exint	;get int expr (count)
7644	CALL	ccomma	;, ?
7647	POP	BX	;restore addr
7648	POP	AX
7649	JZ	pblres	;yes: with result var
764B	PUSH	BX	;without result var
764C	JMP.b	pblend	;'
764Epblres	PUSH	AX	;save routine addr
764F	CALL	epushax	;* PUSH AX (save count)
7652	CALL	varptr	;get res var ptr
7655	CMP.B	varctp,#$0A	;integer ?
765A	JNZ	pblerr	;no: error
765C	CMP	varsize,#$02	;word ?
7661	JZ	pblend	;yes: ok
7663pblerr	CALL	err	;24:Integer variable expected
7666	B	$18	;'
7667pblend	JMP	pexec3	;"emit call, check end
766Apchdir	MOV	AX,#xchdir	;CHDIR
766D	JMP.b	prmd2	;'
766Fpmkdir	MOV	AX,#xmkdir	;MKDIR
7672	JMP.b	prmd2	;'
7674prmdir	MOV	AX,#xrmdir	;RMDIR
7677prmd2	PUSH	AX	;save addr
7678	CALL	ebrack1	;! (
767B	CALL	exstr	;get string expr
767E	JMP	pexec3	;"complete it
7681pgetdir	CALL	ebrack1	;! ( : GETDIR
7684	CALL	exint	;get int expr
7687	CALL	epushax	;* PUSH AX
768A	CALL	ecomma	;! ,
768D	CALL	rdstrvar	;get string var
7690	MOV.B	AH,varsize	;max len-1
7694	DEC.B	AH
7696	MOV	AL,#$B1
7698	CALL	eword	;* MOV CL,max_len
769B	MOV	AX,#xgetdir
769E	JMP	pemit	;"end it
76A1povrpath	CALL	ebrack1	;! ( : OVRPATH
76A4	CALL	exstr	;get string expr
76A7	MOV	AX,#xovrpath
76AA	JMP	pemit	;"end it
76ADpdelete	CALL	ebrack1	;! ( : DELETE
76B0	CALL	rdstrvar	;get string var
76B3	CALL	epushdi	;* PUSH DI
76B6	CALL	ecomma	;! ,
76B9	CALL	exint	;get int expr
76BC	CALL	epushax	;* PUSH AX
76BF	CALL	ecomma	;! ,
76C2	CALL	exint	;get int expr
76C5	MOV	AX,#xdelete
76C8	JMP	pemit	;"end it
76CBpinsert	CALL	ebrack1	;! ( : INSERT
76CE	CALL	exstr	;get string expr
76D1	CALL	ecomma	;! ,
76D4	CALL	rdstrvar	;get string var
76D7	CALL	epushdi	;* PUSH DI
76DA	MOV.B	AH,varsize	;component size - 1
76DE	DEC.B	AH
76E0	MOV	AL,#$B1
76E2	PUSH	AX	;save it
76E3	CALL	ecomma	;! ,
76E6	CALL	exint	;get integer expr
76E9	POP	AX	;restore
76EA	CALL	eword	;* MOV CL,max_len
76ED	MOV	AX,#xinsert
76F0	JMP	pemit	;"end it
76F3rdstrvar	CALL	varptr	;get string var: get var ptr
76F6	CMP.B	varctp,#$08	;string ?
76FB	CALL	errnz	;no:
76FE	B	$22	;34:String variable expected
76FF	RET		;"
7700pstr	CALL	ebrack1	;! ( : STR
7703	CALL	exnum	;get num expr
7706	CMP.B	CL,#$0A	;integer ?
7709	JNZ	pstnoint	;real: is already on stack !
770B	CALL	epushax	;* PUSH AX
770Epstnoint	CALL	ccolon	;: ?
7711	JNZ	pstdef1	;:no formatting
7713	PUSH	CX	;save type
7714	CALL	exint	;get int expr
7717	CALL	epushax	;* PUSH AX
771A	POP	CX	;restore type
771B	CMP.B	CL,#$0A	;integer ?
771E	JZ	pstnxt	;yes: no second parm
7720	CALL	ccolon	;: ?
7723	JNZ	pstdef3	;no: get default
7725	PUSH	CX	;save type
7726	CALL	exint	;get int expr
7729	CALL	epushax	;* PUSH AX
772C	POP	CX	;restore type
772D	JMP.b	pstnxt	;'
772Fpstdef1	XOR	AX,AX	;set default
7731	CMP.B	CL,#$0A	;integer ?
7734	JZ	pstdef2	;:yes
7736	MOV	AL,#$12	;real: 18 chars
7738pstdef2	CALL	emovaxi	;* MOV AX,i
773B	CALL	epushax	;* PUSH AX
773E	CMP.B	CL,#$0A	;integer ?
7741	JZ	pstnxt	;:yes
7743pstdef3	MOV	AX,#$FFFF	;default for second parm:
7746	CALL	emovaxi	;* MOV AX,#FFFF
7749	CALL	epushax	;* PUSH AX
774Cpstnxt	CALL	ecomma	;! ,
774F	PUSH	CX	;save type
7750	CALL	rdstrvar	;get string var
7753	MOV.B	AH,varsize	;component size-1
7757	DEC.B	AH
7759	MOV	AL,#$B1
775B	CALL	eword	;* MOV CL,max_len
775E	POP	CX	;restore type
775F	MOV	AX,#xstrint	;(str integer)
7762	CMP.B	CL,#$0A	;integer ?
7765	JZ	pstemit	;:yes
7767	MOV	AX,#xstrreal	;(str real)
776Apstemit	JMP	pemit	;"emit call, check )
776Dpval	CALL	ebrack1	;! ( : VAL
7770	CALL	exstr	;get string expression
7773	CALL	ecomma	;! ,
7776	CALL	varptr	;get dest var ptr
7779	MOV.B	CL,varctp	;test type
777D	CMP.B	CL,#$0A	;integer ?
7780	JZ	pvalint	;:yes
7782	CMP.B	CL,#$09	;real
7785	JZ	pvalreal	;:yes
7787	CALL	err	;27:Integer or real var expected
778A	B	$1B	;'
778Bpvalint	CMP	varsize,#$02	;test component size
7790	JNZ	pvalerr	;byte: error
7792pvalreal	PUSH	CX	;save type
7793	CALL	epushdi	;* PUSH DI
7796	CALL	ecomma	;! ,
7799	CALL	varptr	;get status var ptr
779C	CMP.B	varctp,#$0A	;integer ?
77A1	JNZ	pvalerr	;no: error
77A3	CMP	varsize,#$02	;byte ?
77A8	JZ	pvalok	;word:ok
77AApvalerr	CALL	err	;24:Int var expected
77AD	B	$18	;'
77AEpvalok	POP	CX	;restore type
77AF	MOV	AX,#xvalint	;(val integer)
77B2	CMP.B	CL,#$0A	;integer ?
77B5	JZ	pstemit	;:yes
77B7	MOV	AX,#xvalreal	;(val real)
77BA	JMP	pstemit	;"emit call, check )
77BCpgotoxy	CALL	ebrack1	;! ( : GOTOXY
77BF	CALL	exint	;get integer expr
77C2	CALL	epushax	;* PUSH AX
77C5	MOV	AX,#xgotoxy
77C8pgxy2	PUSH	AX	;save addr
77C9	CALL	ecomma	;! ,
77CC	CALL	exint	;get integer expr
77CF	POP	AX	;restore addr
77D0	JMP	pemit	;"emit call, check )
77D3prndmize	MOV	AX,#xrndmize	;RANDOMIZE
77D6	JMP	ecall	;"emit call
77D9pnew	MOV	AX,#xnew	;NEW
77DCpnew2	PUSH	AX	;save addr
77DD	CALL	ebrack1	;! (
77E0	CALL	varptr	;get var ptr
77E3	CMP.B	varctp,#$04	;pointer var ?
77E8	JNZ	prelerr	;no: error
77EA	MOV	BP,lower	;get type ptr
77EE	CALL	getparm	;get type parms
77F1	MOV	AX,var2size	;get its component size
77F4	CALL	emovcxi	;* MOV CX,compo_size
77F7	POP	AX	;restore addr
77F8	JMP	pemit	;"emit call, check )
77FBpgetmem	MOV	AX,#xgetmem	;GETMEM
77FEpgm2	PUSH	AX	;save addr
77FF	CALL	ebrack1	;! (
7802	CALL	varptr	;get var ptr
7805	CMP.B	varctp,#$04	;pointer ?
780A	JNZ	prelerr	;no: error
780C	CALL	epushdi	;* PUSH DI
780F	CALL	ecomma	;! ,
7812	CALL	exint	;get int expr
7815	POP	AX	;restore addr
7816	JMP	pemit	;"emit call, check )
7819pdispose	MOV	AX,#xdispose	;DISPOSE
781C	JMP	pnew2	;"like New
781Epfreemem	MOV	AX,#xfreemem	;FREEMEM
7821	JMP	pgm2	;"like Getmem
7823pmark	MOV	AX,#xmark	;MARK
7826	JMP.b	prel2	;'like Release
7828prelease	MOV	AX,#xrelease	;RELEASE
782Bprel2	PUSH	AX	;save addr
782C	CALL	ebrack1	;! (
782F	CALL	varptr	;get var ptr
7832	POP	AX	;restore addr
7833	CMP.B	varctp,#$04	;pointer ?
7838	JNZ	prelerr	;no: error
783A	JMP	pemit	;'emit call, check )
783Dprelerr	CALL	err	;28:Pointer var expected
7840	B	$1C	;"
7841pmove	CALL	ebrack1	;! ( : MOVE
7844	CALL	varptr	;get src var ptr
7847	CALL	epushdi	;* PUSH DI
784A	CALL	ecomma	;! ,
784D	CALL	varptr	;get dest var ptr
7850	CALL	epushdi	;* PUSH DI
7853	MOV	AX,#xmove
7856	JMP	pgxy2	;"get int expr, end it
7859pfillchr	CALL	ebrack1	;! ( : FILLCHAR
785C	CALL	varptr	;get dest var ptr
785F	CALL	epushdi	;* PUSH DI
7862	CALL	ecomma	;! ,
7865	CALL	exint	;get int expr
7868	CALL	epushax	;* PUSH AX
786B	CALL	ecomma	;! ,
786E	CALL	exscal	;get scalar expr
7871	MOV	AX,#xfillchr
7874	JMP	pemit	;"end it
7877pexit	XOR	AX,AX	;EXIT: clear flag
7879	JMP	exit	;"do it
787Cphalt	CALL	cbrack1	;HALT: ( ?
787F	JNZ	phlt2	;no: normal
7881	CALL	exint	;get int expr
7884	CALL	ebrack2	;! )
7887	JMP.b	phlt3	;'
7889phlt2	CALL	ecode	;* XOR AX,AX
788C	B	$02,$33,$C0
788Fphlt3	MOV	AX,#progend
7892	JMP	ejump	;"emit jump
7895pmsdos	CALL	ebrack1	;! ( : MSDOS
7898	MOV	BX,#$0021	;int number 21
789B	PUSH	BX	;save it
789C	JMP.b	pint2	;'like INTR
789Epintr	CALL	ebrack1	;! ( : INTR
78A1	CALL	rdintcn	;read integer constant
78A4	PUSH	BX	;save it
78A5	CALL	ecomma	;! ,
78A8pint2	CALL	varptr	;get var ptr
78AB	MOV	AX,#xsetregs	;(set registers from rec)
78AE	CALL	ecall	;* CALL xsetregs
78B1	POP	AX	;interrupt number
78B2	MOV.B	AH,AL
78B4	MOV	AL,#$CD	;* INT nn
78B6	CALL	eword
78B9	MOV	AX,#xgetregs	;(get registers back)
78BC	JMP	pemit	;"emit call, check )
78BFpportw	MOV	AL,#$EF	;PORTW: opcode OUT
78C1	JMP.b	pprt2	;'
78C3pport	MOV	AL,#$EE	;PORT: opcode OUTB
78C5pprt2	PUSH	AX	;save opcode
78C6	CALL	esqr1	;! [
78C9	CALL	exint	;get int expr
78CC	CALL	esqr2	;! ]
78CF	CALL	epushax	;* PUSH AX (port number)
78D2	CALL	eassign	;! :=
78D5	CALL	exint	;get int expr
78D8	CALL	ecode	;* POP DX
78DB	B	$01,$5A
78DD	POP	AX	;restore opcode
78DE	JMP	ebyte	;"emit OUT [DX],AX
78E1pcrtinit	MOV	AX,#xcrtinit	;CRTINIT
78E4	JMP.b	pdelemit	;'
78E6pcrtexit	MOV	AX,#xcrtexit	;CRTEXIT
78E9	JMP.b	pdelemit	;'
78EBpclrscr	MOV	AX,#xclrscr	;CLRSCR
78EE	JMP.b	pdelemit	;'
78F0pclreol	MOV	AX,#xclreol	;CLREOL
78F3	JMP.b	pdelemit	;'
78F5pnrmvid	MOV	AX,#xnormvid	;NORMVIDEO, HIGHVIDEO
78F8	JMP.b	pdelemit	;'
78FAplowvid	MOV	AX,#xlowvid	;LOWVIDEO
78FD	JMP.b	pdelemit	;'
78FFpinsline	MOV	AX,#xinsline	;INSLINE
7902	JMP.b	pdelemit	;'
7904pdelline	MOV	AX,#xdelline	;DELLINE
7907pdelemit	JMP	ecall	;"emit call
790Apdelay	MOV	AX,#xdelay	;DELAY
790Dpdel2	PUSH	AX	;save addr
790E	CALL	ebrack1	;! (
7911	CALL	exint	;get int expr
7914	POP	AX	;restore addr
7915	JMP	pemit	;"emit, check )
7918pwindow	MOV	AX,#xwindow	;WINDOW
791Bpwind4	PUSH	AX	;save addr
791C	CALL	ebrack1	;! (
791Fpwind3	CALL	exint	;get int expr
7922	CALL	epushax	;* PUSH AX
7925	CALL	ecomma	;! ,
7928pwind2	CALL	exint	;get int expr
792B	CALL	epushax	;* PUSH AX
792E	CALL	ecomma	;! ,
7931	CALL	exint	;get int expr
7934	CALL	epushax	;* PUSH AX
7937	POP	AX	;restore addr
7938	JMP	pgxy2	;"get int, end it
793Bptextcol	MOV	AX,#xtxtcol	;TEXTCOLOR
793E	JMP	pdel2	;"(int)
7940ptextbg	MOV	AX,#xtxtbg	;TEXTBACKGROUND
7943	JMP	pdel2	;"(int)
7945pgraphbg	MOV	AX,#xgrbg	;GRAPHBACKGROUND
7948	JMP	pdel2	;"(int)
794Appalette	MOV	AX,#xpalette	;PALETTE
794D	JMP	pdel2	;"(int)
794Fphirscol	MOV	AX,#xhirscol	;HIRESCOLOR
7952	JMP	pdel2	;"(int)
7954pgrcolmd	MOV	AX,#xgrcolmd	;GRAPHCOLORMODE
7957pgremit	JMP	ecall	;'emit call
795Apgrmode	MOV	AX,#xgrmode	;GRAPHMODE
795D	JMP	pgremit	;'emit call
795Fphires	MOV	AX,#xhires	;HIRES
7962	JMP	pgremit	;"emit call
7964ptxtmode	CALL	cbrack1	;TEXTMODE
7967	JZ	ptxtmd2	;( ? yes: get mode
7969	MOV	AX,#$00FF
796C	CALL	emovaxi	;* MOV AX,#00FF
796F	JMP.b	ptxtdef	;'
7971ptxtmd2	CALL	exint	;get int expr
7974	CALL	ebrack2	;! )
7977ptxtdef	MOV	AX,#xtxtmode
797A	JMP	ecall	;"emit call
797Dpgrwind	MOV	AX,#xgrwindw	;GRAPHWINDOW
7980	JMP	pwind4	;"like window
7982pplot	CALL	ebrack1	;! ( : PLOT
7985	MOV	AX,#xplot
7988	PUSH	AX	;save it
7989	JMP	pwind2	;"like window - only 3 parms
798Bpdraw	CALL	ebrack1	;! ( : DRAW
798E	CALL	exint	;get int expr
7991	CALL	epushax	;* PUSH AX
7994	CALL	ecomma	;! ,
7997	MOV	AX,#xdraw
799A	PUSH	AX	;save addr
799B	JMP	pwind3	;"now like window
799Dpsound	MOV	AX,#xsound	;SOUND
79A0	JMP	pdel2	;"(int)
79A3pnosound	MOV	AX,#xnosound	;NOSOUND
79A6	JMP	ecall	;"emit call
79A9exprsave	CALL	pushe1	;push entry
79AC	CALL	exprax	;read expression
79AF	CALL	pope1	;restore entry
79B2exintrt	RET		;"
79B3exint	CALL	exprax	;get integer expression: rd expr
79B6	CMP.B	CL,#$0A	;integer ?
79B9	JZ	exintrt	;yes:ret
79BB	CALL	err	;23:Integer expression expected
79BE	B	$17	;"
79BFexnum	CALL	exprax	;get numeric expression: rd expr
79C2	CMP.B	CL,#$0A	;integer ?
79C5	JZ	exintrt	;yes: ret
79C7	CMP.B	CL,#$09	;real ?
79CA	JZ	exintrt	;yes: ret
79CC	CALL	err	;26:Int or real expression expected
79CF	B	$1A	;"
79D0exscal	CALL	exprax	;get scalar expression: rd expr
79D3chksimpl	CMP.B	CL,#$0A	;scalar ?
79D6	JNB	exscret	;:ok
79D8	CMP.B	CL,#$08	;string ?
79DB	CALL	errnz	;no:
79DE	B	$1F	;31:Simple expression expected
79DF	MOV	AX,#xstrch	;(string -> char)
79E2	CALL	ecall	;* CALL xstrch
79E5	MOV	CX,#$020C	;type: char in AX
79E8exscret	RET		;"
79E9exstr	CALL	expr	;get string expression: do expr
79EC	CMP.B	CL,#$08	;string ?
79EF	JZ	exstrret	;:yes
79F1	CMP.B	CL,#$0C	;char ?
79F4	CALL	errnz	;no:
79F7	B	$21	;33:String expression expected
79F8	OR.B	CH,CH	;constant ?
79FA	JNZ	ecstrch	;:no
79FC	MOV	AX,exres	;get result
79FF	MOV.B	AH,AL	;char
7A01	MOV	AL,#$01	;length
7A03	CALL	emovaxi	;* MOV AX,#...
7A06	JMP.b	exstrch2	;'
7A08ecstrch	CALL	loadatom	;get atom
7A0B	CALL	ecode	;* MOV AH,AL
7A0E	B	$04,$8A,$E0,$B0,$01	;* MOV AL,#01
7A13exstrch2	CALL	epushax	;* PUSH AX
7A16	MOV	CL,#$08	;type = string
7A18exstrret	RET		;"
7A19excond	CALL	expr	;evaluate boolean expr: do expr
7A1C	CMP.B	CL,#$0B	;boolean ?
7A1F	CALL	errnz	;no:
7A22	B	$14	;20:Boolean expression expected
7A23	CALL	loadatom	;get atom
7A26	CMP.B	CH,#$04	;comparision outside ?
7A29	JZ	excondrt	;yes: ok
7A2B	MOV	AL,#$75	;store branch op: JNZ
7A2D	MOV	brnchop,AL
7A30	CMP.B	CH,#$03	;flags set ?
7A33	JZ	excondrt	;:yes
7A35	CALL	ecode	;* OR AX,AX
7A38	B	$02,$0B,$C0
7A3Bexcondrt	RET		;"
7A3Cexprax	CALL	expr	;read expression
7A3Fexpload	CMP.B	CL,#$0A	;scalar ?
7A42	JB	excondrt	;below: ret
7A44	CALL	loadatom	;get atom
7A47	JMP	flgbool	;"flags -> boolean
7A4Aexpvar	MOV	AX,#expload	;do expression - var pre-read
7A4D	PUSH	AX	;set up return stack
7A4E	MOV	AX,#expr2
7A51	PUSH	AX
7A52	MOV	AX,#add2
7A55	PUSH	AX
7A56	MOV	AX,#mul2
7A59	PUSH	AX
7A5A	JMP	cvar2	;"start with var
7A5Dexpconst	MOV	AX,#expload	;do expression - const pre-read
7A60	PUSH	AX	;set up return stack
7A61	MOV	AX,#expr2
7A64	PUSH	AX
7A65	MOV	AX,#add2
7A68	PUSH	AX
7A69	MOV	AX,#mul2
7A6C	PUSH	AX
7A6D	JMP	cconst2	;"start with const
7A70expr	CALL	addlevel	;Comparison level: do add level
7A73expr2	PUSH	CX	;save type
7A74	CALL	ckey	;check comparisons
7A77	B	$02
7A78	W	tkcmp
7A7A	POP	CX	;restore type
7A7B	JZ	cmp1	;found: do comparison
7A7D	RET		;'
7A7Ecmp1	INC.B	AL	;IN ?
7A80	JZ	cmpin	;:yes
7A82	PUSH	BX	;save op ptr, type
7A83	PUSH	CX
7A84	CALL	pushres	;save entry
7A87	PUSH	pc	;save PC
7A8B	PUSH	functp	;save type ptr
7A8F	CALL	addlevel	;addition level
7A92	POP	comptp	;restore type ptr
7A96	POP	oldpc	;restore PC
7A9A	POP	DX	;restore type
7A9B	CALL	typeconv	;do type conversion
7A9E	POP	BX	;restore op ptr
7A9F	CMP.B	CL,#$0A	;scalar ?
7AA2	JB	cmpdiff	;:no
7AA4	CS:	
7AA5	MOV.B	AL,[BX]$01	;set branch opcode
7AA8	MOV	brnchop,AL	;(from comparison table)
7AAB	MOV	BX,#cmpcode	;emit parms for comparison
7AAE	CALL	ecalc	;emit instruction
7AB1	MOV	CX,#$040B	;return type: boolean, flags set
7AB4	RET		;'
7AB5cmpdiff	CS:		;real, string, set, ptr comparisons
7AB6	MOV.B	BL,[BX]	;get offset in cmp table
7AB8	XOR.B	BH,BH	;-> table index
7ABA	CMP.B	CL,#$09	;real ?
7ABD	JZ	cmpfnd	;:yes
7ABF	INC	BX	;+2
7AC0	INC	BX
7AC1	CMP.B	CL,#$08	;string ?
7AC4	JZ	cmpfnd	;:yes
7AC6	INC	BX	;+2
7AC7	INC	BX
7AC8	CMP.B	CL,#$03	;set ?
7ACB	JZ	cmpfnd	;:yes
7ACD	INC	BX	;+2;(pointer)
7ACE	INC	BX
7ACFcmpfnd	CS:	
7AD0	MOV	AX,[BX]vcompare	;get vector from table
7AD4	OR	AX,AX	;test it
7AD6	CALL	errz	;47:Operand type(s) do
7AD9	B	$2F	;not match operator
7ADA	JMP.b	cmpemit	;'end it
7ADCcmpin	CALL	loadatom	;IN: get atom
7ADF	CALL	epushax	;* PUSH AX
7AE2	PUSH	CX	;save type
7AE3	CALL	addlevel	;do addition level
7AE6	POP	DX	;restore type
7AE7	CMP.B	CL,#$03	;set ?
7AEA	CALL	errnz	;47:Operand type(s) do
7AED	B	$2F	;not match operator
7AEE	OR.B	CH,CH	;constant ?
7AF0	JZ	cmpconst	;:yes
7AF2	CMP.B	DL,CH	;compare types
7AF4	CALL	errnz	;different base type:
7AF7	B	$2C	;44:Type mismatch
7AF8cmpconst	MOV	AX,#xsetin
7AFBcmpemit	CALL	ecall	;* CALL xsetin
7AFE	MOV	CX,#$030B	;boolean, flags set
7B01	RET		;"
7B02vcompare	W	realeq,csteq,seteq,ptreq	;= vector table for comparisons
7B0A	W	realne,cstne,setne,ptrne	;<>
7B12	W	realge,cstge,setge	;>=
7B18	W	$0000
7B1A	W	realle,cstle,setle	;<=
7B20	W	$0000
7B22	W	realg,cstg	;>
7B26	W	$0000,$0000
7B2A	W	reall,cstl	;<
7B2E	W	$0000,$0000	;"
7B32addlevel	CALL	mullevel	;Addition level: do mult level
7B35add2	PUSH	CX	;save type
7B36	CALL	ckey	;check add ops
7B39	B	$05
7B3A	W	tkadd
7B3C	POP	CX	;restore type
7B3D	JZ	addptr	;:found
7B3F	RET		;'
7B40addptr	CMP.B	CL,#$04	;pointer ?
7B43	CALL	errz	;yes:
7B46	B	$2F	;47:Operand type(s) does not match op
7B47	PUSH	BX	;save op ptr
7B48	PUSH	CX	;save type
7B49	CALL	pushres	;save first result
7B4C	PUSH	pc	;save PC
7B50	CALL	mullevel	;mult level
7B53	CMP.B	CL,#$0C	;char ?
7B56	JNZ	add3	;:no
7B58	OR.B	CH,CH	;constant ?
7B5A	JNZ	addch	;:no
7B5C	MOV	AX,exres	;get resulting char
7B5F	MOV.B	AH,AL
7B61	MOV	AL,#$01	;convert to string
7B63	CALL	emovaxi	;* MOV AX,#..
7B66	JMP.b	addch2	;'
7B68addch	CALL	loadatom	;load second result
7B6B	CALL	ecode	;* MOV AH,AL
7B6E	B	$04,$8A,$E0,$B0,$01	;* MOV AL,#01
7B73addch2	CALL	epushax	;* PUSH AX
7B76	MOV	CL,#$08	;convert to string
7B78add3	POP	oldpc	;restore PC
7B7C	POP	DX	;type first part
7B7D	CALL	typeconv	;do type conversions
7B80	POP	BX	;restore op ptr
7B81	CS:	
7B82	CMP.B	[BX],#$02	;OR, XOR ?
7B85	JNB	addbool	;:yes
7B87	MOV	AX,#sunion	;(set +)
7B8A	MOV	DX,#sdiff	;(set -)
7B8D	CMP.B	CL,#$03	;set ?
7B90	JZ	addset	;:yes
7B92	MOV	AX,#xadd	;(add real)
7B95	MOV	DX,#xsub	;(sub real)
7B98	CMP.B	CL,#$09	;real ?
7B9B	JNZ	addstr	;:no
7B9Daddset	CS:	
7B9E	CMP.B	[BX],#$00	;add ?
7BA1	JZ	addadd	;:yes
7BA3	XCHG	AX,DX	;get subtract vector
7BA4addadd	CALL	ecall	;emit call
7BA7	JMP	add2	;'loop back
7BA9addstr	CMP.B	CL,#$08	;string ?
7BAC	JNZ	addscal	;:no
7BAE	CS:	
7BAF	CMP.B	[BX],#$00	;add ?
7BB2	CALL	errnz	;no:
7BB5	B	$2F	;47:Operand type(s) does not match op
7BB6	MOV	AX,#xconcat	;(concat strings)
7BB9	JMP	addadd	;'emit call, loop back
7BBBaddbool	CMP.B	CL,#$0B	;boolean ?
7BBE	JZ	addsc2	;:yes
7BC0addscal	CMP.B	CL,#$0A	;scalar ?
7BC3	CALL	errnz	;no:
7BC6	B	$2F	;47:Operand type(s) does not match op
7BC7addsc2	CALL	ecalc	;emit instructions
7BCA	JMP	add2	;"loop back
7BCDmullevel	CALL	neglevel	;Multiplication level: do unary level
7BD0mul2	PUSH	CX	;save result type
7BD1	CALL	ckey	;check multiplication ops
7BD4	B	$05
7BD5	W	tkmul
7BD7	POP	CX	;restore type
7BD8	JZ	mulptr	;:found
7BDA	RET		;'
7BDBmulptr	CMP.B	CL,#$04	;pointer ?
7BDE	CALL	errz	;yes:
7BE1	B	$2F	;47:Operand type(s) does not match op
7BE2	PUSH	BX	;save op ptr, type
7BE3	PUSH	CX
7BE4	CALL	pushres	;emit push first value
7BE7	PUSH	pc
7BEB	CALL	neglevel	;do unary level
7BEE	POP	oldpc	;restore old PC
7BF2	POP	DX	;type first op
7BF3	POP	BX	;op ptr
7BF4	PUSH	BX	;save it again
7BF5	CS:	
7BF6	CMP.B	[BX],#$01	;division ?
7BF9	JNZ	mulnodiv	;:no
7BFB	CMP.B	CL,#$0A	;second = integer ?
7BFE	JNZ	mulnodiv	;:no
7C00	CALL	loadatom	;load result
7C03	MOV	AX,#xintreal	;convert to real
7C06	CALL	ecall	;* CALL xintreal
7C09	MOV	CL,#$09	;now real
7C0Bmulnodiv	CALL	typeconv	;do type conversions
7C0E	POP	BX	;op ptr
7C0F	CS:	
7C10	CMP.B	[BX],#$01	;division ?
7C13	JA	muland	;higher: no reals, sets
7C15	JZ	muldiv	;:division
7C17	MOV	AX,#xmul	;(multiply real)
7C1A	CMP.B	CL,#$09	;real ?
7C1D	JZ	mulreal	;:yes
7C1F	MOV	AX,#sinter	;(set *)
7C22	CMP.B	CL,#$03	;set ?
7C25	JNZ	muland	;no: go out
7C27mulreal	CALL	ecall	;emit call
7C2A	JMP	mul2	;'loop back
7C2Cmuldiv	MOV	AX,#xdiv	;(divide real)
7C2F	CMP.B	CL,#$09	;real ?
7C32	JZ	mulreal	;:yes
7C34	CALL	err	;47:Operand type(s) does not match op
7C37	B	$2F	;'
7C38muland	CS:		;AND ?
7C39	CMP.B	[BX],#$02
7C3C	JNZ	mulscal	;:no
7C3E	CMP.B	CL,#$0B	;boolean ?
7C41	JZ	mulemit	;:yes
7C43mulscal	CMP.B	CL,#$0A	;scalar ?
7C46	CALL	errnz	;no:
7C49	B	$2F	;47:Operand type(s) does not match op
7C4Amulemit	CALL	ecalc	;emit arithmetic op
7C4D	JMP	mul2	;"loop back
7C4Fneglevel	CALL	ctoken	;Unary level
7C52	W	tknot	;NOT ?
7C54	JNZ	negneg	;:no
7C56	CALL	negneg	;do negation level
7C59	CALL	flgbool	;flags -> boolean
7C5C	CMP.B	CL,#$0A	;integer ?
7C5F	JZ	negnot	;:ok
7C61	CMP.B	CL,#$0B	;boolean ?
7C64	CALL	errnz	;no:
7C67	B	$2F	;47:Operand type(s) does not match op
7C68	CALL	loadatom	;load value
7C6B	CALL	ecode	;* XOR AL,#01
7C6E	B	$02,$34,$01
7C71	MOV	CH,#$03	;flags set...
7C73	RET		;'
7C74negnot	CALL	loadatom	;get value
7C77	CALL	ecode	;* NOT AX
7C7A	B	$02,$F7,$D0
7C7D	RET		;'
7C7Enegneg	PUSH	negflg	;do negation: save flag
7C82	CALL	testsign	;test sign
7C85	MOV	negflg,DX	;store it
7C89	CALL	atom	;do atom
7C8C	MOV	DX,negflg	;get neg flag
7C90	CALL	testnum	;test type
7C93	JZ	negend	;:ok
7C95	CMP.B	CL,#$0A	;integer ?
7C98	JNZ	negreal	;:no
7C9A	CALL	loadatom	;get value
7C9D	CALL	ecode	;* NEG AX
7CA0	B	$02,$F7,$D8
7CA3	JMP.b	negend	;'
7CA5negreal	MOV	AX,#xneg	;(negate real)
7CA8	CALL	ecall
7CABnegend	POP	negflg	;restore neg flag
7CAF	RET		;"
7CB0pushres	CALL	flgbool	;store result on stack
7CB3	CMP.B	CL,#$0A	;integer ?
7CB6	JB	pushptr	;:no
7CB8	CALL	loadatom	;get value
7CBB	MOV.B	flgpshax,#$01	;set flag: PUSH AX
7CC0	RET		;'
7CC1pushptr	CMP.B	CL,#$04	;pointer ?
7CC4	JNZ	pushret	;:no
7CC6	CALL	ecode	;* PUSH DX
7CC9	B	$02,$52,$50	;* PUSH AX
7CCCpushret	RET		;"
7CCDtypeconv	CALL	flgbool	;Do type conversions
7CD0	MOV.B	flgpshax,#$00	;no PUSH AX
7CD5	CMP.B	DL,#$09	;first = real ?
7CD8	JNZ	tcvstr	;:no
7CDA	CMP.B	CL,#$0A	;second = integer ?
7CDD	JNZ	tcvreal	;:no
7CDF	CALL	loadatom	;get value
7CE2	MOV	AX,#xintreal
7CE5	CALL	ecall	;* CALL xintreal
7CE8	MOV	CL,#$09	;-> real
7CEA	JMP.b	tcvreal	;'
7CECtcvstr	CMP.B	DL,#$08	;first = string ?
7CEF	JNZ	tcvreal	;:no
7CF1	CMP.B	CL,#$0C	;second = char ?
7CF4	JNZ	tcvreal	;:no
7CF6	OR.B	CH,CH	;constant ?
7CF8	JNZ	tcvchstr	;:no
7CFA	MOV	AX,exres	;get char
7CFD	MOV.B	AH,AL	;convert to string
7CFF	MOV	AL,#$01
7D01	CALL	emovaxi	;* MOV AX,#i
7D04	JMP.b	tcvchst2	;'
7D06tcvchstr	CALL	loadatom	;get value
7D09	CALL	ecode	;* MOV AH,AL (convert to string)
7D0C	B	$04,$8A,$E0,$B0,$01	;* MOV AL,#01
7D11tcvchst2	CALL	epushax	;* PUSH AX
7D14	MOV	CL,#$08	;-> string
7D16tcvreal	CMP.B	CL,#$09	;second = real ?
7D19	JNZ	tcvchst1	;:no
7D1B	CMP.B	DL,#$0A	;first = integer ?
7D1E	JNZ	tcvint	;:no
7D20	MOV	AX,#xintre2	;convert first number
7D23	CALL	ecall
7D26	MOV	DL,#$09	;first -> real
7D28	JMP.b	tcvint	;'
7D2Atcvchst1	CMP.B	CL,#$08	;second = string ?
7D2D	JNZ	tcvint	;:no
7D2F	CMP.B	DL,#$0C	;first = char ?
7D32	JNZ	tcvint	;:no
7D34	MOV	AX,#xchstr	;first -> string
7D37	CALL	ecall	;* CALL xchstr1
7D3A	MOV	DL,#$08	;-> string
7D3Ctcvint	CMP.B	CL,#$0A	;second = integer ?
7D3F	JB	tcvnoint	;:no
7D41	CMP.B	CH,#$02	;calculated ?
7D44	JNZ	tcvpop	;:no
7D46	CALL	ecode	;* POP CX
7D49	B	$01,$59
7D4B	JMP.b	tcvchk	;'
7D4Dtcvpop	MOV	AX,pc	;PC = old PC ?
7D50	CMP	AX,oldpc
7D54	JZ	tcvchk	;:yes
7D56	CALL	epopax	;* POP AX
7D59	JMP.b	tcvchk	;'
7D5Btcvnoint	CMP.B	CL,#$04	;pointer ?
7D5E	JNZ	tcvchk	;:no
7D60	CALL	ecode	;* POP BX
7D63	B	$02,$5B,$59	;* POP DX
7D66tcvchk	CMP.B	CL,DL	;first = second ?
7D68	CALL	errnz	;no:
7D6B	B	$2C	;44:Type mismatch
7D6C	CMP.B	CL,#$03	;set ?
7D6F	JNZ	tcvset	;:no
7D71	CMP.B	CH,DH	;same base types !
7D73	JZ	tcvret	;:ok
7D75	OR.B	DH,DH	;constant 1 ?
7D77	JZ	tcvret	;yes: ret
7D79	OR.B	CH,CH	;constant 2 ?
7D7B	MOV.B	CH,DH	;copy base type
7D7D	JZ	tcvret	;yes: ret
7D7F	CALL	err	;44:Type mismatch
7D82	B	$2C	;'
7D83tcvset	CMP.B	CL,#$04	;pointer ?
7D86	JNZ	tcvret	;:no
7D88	CMP	functp,#$00	;untyped ?
7D8D	JZ	tcvret	;yes: ret
7D8F	CMP	comptp,#$00	;untyped ?
7D94	JZ	tcvret	;yes: ret
7D96	MOV	AX,functp	;get type ptr
7D99	CMP	AX,comptp	;compare
7D9D	JZ	tcvret	;equal: ok
7D9F	CALL	err	;44:Type mismatch
7DA2	B	$2C	;'
7DA3tcvret	RET		;"
7DA4loadatom	OR.B	CH,CH	;load value -> AX
7DA6	JNZ	latvar	;:no constant
7DA8	MOV	AX,exres	;get result
7DAB	CALL	emovaxi	;* MOV AX,#result
7DAE	JMP.b	latres	;'
7DB0latvar	CMP.B	CH,#$01	;var ?
7DB3	JNZ	latret	;no: ret - already in AX
7DB5	PUSH	CX	;save
7DB6	PUSH	DX
7DB7	CALL	eload	;load var
7DBA	POP	DX
7DBB	POP	CX
7DBClatres	MOV	CH,#$02	;flag: in AX
7DBElatret	RET		;"
7DBFflgbool	CMP.B	CL,#$0B	;Flags -> boolean
7DC2	JNZ	flgbret	;:no boolean
7DC4	CMP.B	CH,#$03	;flags set ?
7DC7	JB	flgbret	;:constant, var, AX
7DC9	JZ	flgbres	;flags set: ok
7DCB	CALL	ecode	;convert
7DCE	B	$03,$B8,$01,$00	;* MOV AX,#0001
7DD2	MOV	AL,brnchop
7DD5	CALL	ebyte	;emit branch op
7DD8	CALL	ecode	;* offset
7DDB	B	$02,$01,$48	;* DEC AX
7DDEflgbres	MOV	CH,#$02	;flag: result in AX
7DE0flgbret	RET		;"
7DE1ecalc	PUSH	CX	;Emit arithmetic operation
7DE2	OR.B	CH,CH	;second = const ?
7DE4	JNZ	ecvar	;:no
7DE6	CS:	
7DE7	TEST.B	[BX]$04,#$02	;is there a const form ?
7DEB	JNZ	ecnocn	;:no
7DED	CS:	
7DEE	MOV.B	AL,[BX]$01	;get its opcode
7DF1	CALL	ebyte	;emit it
7DF4	MOV	AX,exres	;emit the result
7DF7	CALL	eword	;as immediate value
7DFA	JMP.b	ecxchg2	;'done
7DFCecnocn	MOV	AX,exres	;take immediate
7DFF	CALL	emovcxi	;* MOV CX,#result
7E02	JMP.b	ecnoxchg	;'
7E04ecvar	CMP.B	CH,#$01	;variable ?
7E07	JNZ	eccalc	;:no
7E09	CS:	
7E0A	TEST.B	[BX]$04,#$04	;is there a var form ?
7E0E	JNZ	ecnovar	;:no
7E10	CS:	
7E11	TEST.B	[BX]$04,#$08	;CWD needed ?
7E15	JZ	eccwd1	;:no
7E17	CALL	ecode
7E1A	B	$01,$99	;* CWD
7E1Ceccwd1	CS:	
7E1D	MOV	DX,[BX]$02	;base opcode
7E20	AND.B	DH,#$38	;convert to AX,var
7E23	CALL	einstr	;emit instruction
7E26	JMP.b	ecxchg2	;'done
7E28ecnovar	MOV	DX,#$088B	;* MOV CX,...
7E2B	CALL	einstr	;emit instruction
7E2E	JMP.b	ecnoxchg	;'
7E30eccalc	CS:		;second number in AX
7E31	TEST.B	[BX]$04,#$01	;XCHG needed ?
7E35	JZ	ecnoxchg	;:no
7E37	CALL	ecode
7E3A	B	$01,$91	;* XCHG CX,AX
7E3Cecnoxchg	CS:	
7E3D	TEST.B	[BX]$04,#$08	;CWD needed ?
7E41	JZ	eccwd2	;:no
7E43	CALL	ecode
7E46	B	$01,$99	;* CWD
7E48eccwd2	CS:	
7E49	MOV	DX,[BX]$02	;base opcode
7E4C	CALL	emitdx	;emit it
7E4Fecxchg2	CS:	
7E50	TEST.B	[BX]$04,#$10	;second XCHG needed ?
7E54	JZ	ecres	;:no
7E56	CALL	ecode
7E59	B	$01,$92	;* XCHG DX,AX (for MOD)
7E5Becres	POP	CX	;restore type
7E5C	MOV	CH,#$02	;result in AX
7E5E	RET		;"
7E5Fatom	CALL	cvar	;Do atom: do var
7E62	JZ	atomret	;:done
7E64	CALL	cconst	;do constant
7E67	JZ	atomret	;:done
7E69	CALL	cfunc	;do function
7E6C	JZ	atomret	;:done
7E6E	CALL	cset	;do set
7E71	JZ	atomret	;:done
7E73	CALL	cparens	;do parentheses
7E76	JZ	atomret	;:done
7E78	CALL	cstdfn	;do standard functions
7E7B	JZ	atomret	;:done
7E7D	CALL	ctype	;do type conversions
7E80	JZ	atomret	;:done
7E82	CALL	cnil	;test for NIL
7E85	CALL	errnz	;not found:
7E88	B	$29	;41:Unknown ID or syntax error
7E89atomret	RET		;"
7E8Acvar	CALL	rdvar	;get var
7E8D	JNZ	atomret	;no:ret
7E8Fcvar2	MOV	AL,varctp	;component type:
7E92	CMP	AL,#$0A	;integer ?
7E94	JB	cvareal	;:below
7E96	MOV	CH,#$01	;var
7E98	CMP	varsize,#$01	;byte ?
7E9D	JA	cvaint	;:no, word
7E9F	CALL	eload	;load var
7EA2	MOV	CH,#$02	;now in AX
7EA4cvaint	MOV.B	CL,varctp	;get component type
7EA8	JMP.b	cvaok	;'ok
7EAAcvareal	CMP	AL,#$09	;real ?
7EAC	JZ	cvaload	;:yes
7EAE	CMP	AL,#$08	;string ?
7EB0	JZ	cvaload	;:yes
7EB2	CMP	AL,#$03	;set ?
7EB4	JZ	cvaload	;:yes
7EB6	CMP	AL,#$04	;pointer ?
7EB8	JNZ	cvaarrch	;:no
7EBAcvaload	CALL	eload	;load var
7EBD	MOV	BP,lower	;type ptr
7EC1	MOV	functp,BP
7EC5	MOV.B	CL,varctp	;component type
7EC9	CMP.B	CL,#$03	;set ?
7ECC	JNZ	cvaok	;:no, ok
7ECE	MOV.B	CH,[BP]-$08	;get base type
7ED1	JMP.b	cvaok	;'ok
7ED3cvaarrch	CMP	AL,#$01	;array ?
7ED5	CALL	errnz	;no:
7ED8	B	$3E	;62:Struct vars are not allowed here
7ED9	CALL	varptr2	;get var ptr
7EDC	MOV	BP,lower	;type ptr
7EE0	CMP.B	[BP]-$08,#$0C	;array of char ?
7EE4	CALL	errnz	;no:
7EE7	B	$3E	;62:Struct vars are not allowed here
7EE8	MOV	BP,upper	;index type
7EEC	CMP.B	[BP]-$08,#$0A	;= scalar ?
7EF0	CALL	errnz	;no:
7EF3	B	$3E	;62:Struct vars are not allowed here
7EF4	MOV	AX,varsize	;component size
7EF7	OR.B	AH,AH	;> 255 ?
7EF9	CALL	errnz	;yes:
7EFC	B	$3E	;62:Struct vars are not allowed here
7EFD	MOV.B	AH,AL
7EFF	MOV	AL,#$B1
7F01	CALL	eword	;* MOV CL,#len
7F04	MOV	AX,#xldarrch	;(load array of char)
7F07	CALL	ecall	;* CALL xldarrch
7F0A	MOV	CL,#$08
7F0Ccvaok	XOR	AX,AX	;ok
7F0E	RET		;"
7F0Fcconst	CALL	constel	;get constant element
7F12	JNZ	ccnret	;no good: ret
7F14	MOV	DX,negflg	;negation flag
7F18	CALL	donegate	;do negation
7F1B	MOV	negflg,#$0000	;clear neg flag
7F21cconst2	CMP.B	CL,#$09	;real ?
7F24	JNZ	ccnstr	;:no
7F26	MOV	AX,#xrealcn	;(load real constant)
7F29	CALL	ecall	;* CALL xrealcn
7F2C	MOV	AX,creal1	;emit real constant
7F2F	CALL	eword	;as inline code
7F32	MOV	AX,creal2
7F35	CALL	eword
7F38	MOV	AX,creal3
7F3B	CALL	eword
7F3E	JMP.b	ccnok	;'ok
7F40ccnstr	CMP.B	CL,#$08	;string ?
7F43	JNZ	ccnscal	;:no
7F45	MOV	AX,#xstrcn	;(get inline string)
7F48	CALL	ecall	;* CALL xstrcn
7F4B	PUSH	CX	;save
7F4C	CALL	estring	;emit string
7F4F	POP	CX
7F50	JMP.b	ccnok	;'ok
7F52ccnscal	MOV	exres,BX	;store result
7F56	XOR.B	CH,CH	;type: constant
7F58ccnok	XOR	AX,AX	;ok
7F5Accnret	RET		;"
7F5Bcfunc	MOV	CX,#$0600	;Do function
7F5E	CALL	search	;search it
7F61	JNZ	cfnret	;not found: ret
7F63	CALL	estkchk	;emit stack check
7F66	MOV	BX,[BP]-$02	;result type ptr
7F69	SS:	
7F6A	MOV	AX,[BX]-$02	;result type size
7F6D	CALL	allotstk	;allot stack space for result
7F70	CALL	cproc2	;call function (like procedure)
7F73	CALL	getvprm	;get var parms
7F76	MOV	AX,lower	;result type ptr
7F79	MOV	functp,AX
7F7C	MOV.B	CL,varctp	;component type
7F80	MOV	CH,#$02	;result in AX / on stack
7F82	CMP.B	CL,#$0B	;boolean ?
7F85	JNZ	cfnok	;:no
7F87	MOV	CH,#$03	;flags set
7F89cfnok	XOR	AX,AX	;ok
7F8Bcfnret	RET		;"
7F8Callotstk	CMP	AX,#$0002	;Allocate space on stack
7F8F	JA	astksub	;:offset > 2
7F91	XCHG	AX,CX	;offset -> CX
7F92	JCXZ	cfnret	;:nothing to allot
7F94astkdec	CALL	ecode	;* DEC SP
7F97	B	$01,$4C
7F99	LOOP	astkdec	;:another byte
7F9B	RET		;'
7F9Castksub	CALL	offslen	;short or long offset
7F9F	MOV	DX,#$EC83	;short
7FA2	JZ	astkshrt	;:short
7FA4	MOV	DL,#$81	;long
7FA6astkshrt	PUSH	AX	;save AX
7FA7	CALL	emitdx	;* SUB SP,#....
7FAA	POP	AX	;restore
7FAB	TEST.B	DL,#$02	;short ?
7FAE	JZ	astklong	;:no
7FB0	JMP	ebyte	;'emit byte offset
7FB3astklong	JMP	eword	;"emit word offset
7FB6cset	CALL	csqr1	;Do set: [ ?
7FB9	JNZ	csetret	;no:ret
7FBB	MOV	AX,#sldempty	;(make empty set)
7FBE	CALL	ecall	;* CALL sldempty
7FC1	CALL	csqr2	;] ?
7FC4	MOV	CX,#$0003	;type: untyped set
7FC7	JZ	csetret	;:yes
7FC9csetlp	PUSH	CX	;save type
7FCA	CALL	exscal	;get scalar expression
7FCD	MOV.B	AL,CL	;type read
7FCF	POP	CX	;restore type
7FD0	OR.B	CH,CH	;typed set ?
7FD2	JNZ	csetcn	;:yes
7FD4	MOV.B	CH,AL	;set type from const read
7FD6csetcn	CMP.B	AL,CH	;compare base type
7FD8	CALL	errnz	;not equal:
7FDB	B	$2C	;44:Type mismatch
7FDC	PUSH	CX	;save type
7FDD	CALL	ctoken	;.. ?
7FE0	W	tk2dot
7FE2	MOV	AX,#setincl	;(include element in set)
7FE5	JNZ	csetincl	;:no
7FE7	CALL	epushax	;* PUSH AX
7FEA	CALL	exscal	;get scalar expr
7FED	MOV.B	AL,CL	;result type
7FEF	POP	CX
7FF0	PUSH	CX
7FF1	CMP.B	AL,CH	;= type of set ?
7FF3	CALL	errnz	;no:
7FF6	B	$2C	;44:Type mismatch
7FF7	MOV	AX,#setinrng	;(include range in set)
7FFAcsetincl	CALL	ecall	;emit call
7FFD	POP	CX	;restore type
7FFE	CALL	ccomma	;, ?
8001	JZ	csetlp	;yes: loop back
8003	CALL	esqr2	;! ]
8006	XOR	AX,AX	;ok
8008csetret	RET		;"
8009cparens	CALL	cbrack1	;Do parentheses: ( ?
800C	JNZ	cparret	;no:ret
800E	CALL	expr	;get expression
8011	CALL	ebrack2	;! )
8014	XOR	AX,AX	;ok
8016cparret	RET		;"
8017ctype	MOV	CX,#$0300	;Do type conversions
801A	CALL	search	;search type
801D	JNZ	ctpret	;not found: ret
801F	MOV	BP,[BP]-$02	;get type ptr
8022	MOV.B	AL,[BP]-$08	;get component type
8025	CMP	AL,#$0A	;scalar ?
8027	CALL	errb	;no:
802A	B	$1E	;30:Simple type expected
802B	PUSH	AX	;save type
802C	CALL	ebrack1	;! (
802F	CALL	expr	;get expression
8032	CALL	ebrack2	;! )
8035	CALL	chksimpl	;check simple type
8038	POP	AX	;restore type
8039	MOV.B	CL,AL	;convert to type wanted
803B	XOR	AX,AX	;ok
803Dctpret	RET		;"
803Ecnil	CALL	ctoken	;test for NIL
8041	W	tknil
8043	JNZ	cnilret	;no:ret
8045	CALL	ecode	;* XOR AX,AX
8048	B	$04,$33,$C0,$33,$D2	;* XOR DX,DX
804D	MOV	CL,#$04	;type: pointer
804F	XOR	AX,AX	;ok
8051	MOV	functp,AX	;untyped ptr
8054cnilret	RET		;"
8055cstdfn	CALL	ckey	;Do standard functions
8058	B	$02
8059	W	stdfuncs
805B	JNZ	csfret	;not found: ret
805D	CS:	
805E	CALL	[BX]	;call compiler routine
8060	MOV	CH,#$02	;flag: result in AX
8062	CMP.B	CL,#$0B	;boolean ?
8065	JNZ	csfok	;:no
8067	MOV	CH,#$03	;flags set
8069csfok	XOR	AX,AX	;ok
806Bcsfret	RET		;"
806Cfsqr	CALL	getnum	;SQR (num)
806F	CMP.B	CL,#$0A	;integer ?
8072	JNZ	fsqr2	;:no
8074	CALL	ecode
8077	B	$02,$F7,$E8	;* IMUL AX
807A	RET		;'
807Bfsqr2	MOV	AX,#xsqr	;(sqr real)
807Efsqremit	JMP	ecall	;"emit call
8081fabs	CALL	getnum	;ABS (num)
8084	MOV	AX,#iabs	;(abs integer)
8087	CMP.B	CL,#$0A	;integer ?
808A	JZ	fsqremit	;yes: emit call
808C	MOV	AX,#xabs	;(abs real)
808F	JMP	fsqremit	;"
8091fsqrt	MOV	AX,#xsqrt	;SQRT
8094	JMP.b	freal	;'
8096fsin	MOV	AX,#xsin	;SIN
8099	JMP.b	freal	;'
809Bfcos	MOV	AX,#xcos	;COS
809E	JMP.b	freal	;'
80A0farctan	MOV	AX,#xarctan	;ARCTAN
80A3	JMP.b	freal	;'
80A5fln	MOV	AX,#xln	;LN
80A8	JMP.b	freal	;'
80AAfexp	MOV	AX,#xexp	;EXP
80AD	JMP.b	freal	;'
80AFfint	MOV	AX,#xint	;INT
80B2	JMP.b	freal	;'
80B4ffrac	MOV	AX,#xfrac	;FRAC
80B7freal	PUSH	AX	;save function addr
80B8	CALL	getnum	;(num)
80BB	CMP.B	CL,#$09	;real ?
80BE	JZ	freal2	;:yes
80C0	MOV	AX,#xintreal	;(integer -> real)
80C3	CALL	ecall
80C6	MOV	CL,#$09	;now: real
80C8freal2	POP	AX	;restore addr
80C9	JMP	ecall	;"emit call
80CCftrunc	MOV	AX,#xtrunc	;TRUNC
80CF	JMP.b	frnd2	;'
80D1fround	MOV	AX,#xround	;ROUND
80D4frnd2	PUSH	AX	;save addr
80D5	CALL	getnum	;(num)
80D8	POP	AX	;restore
80D9	CMP.B	CL,#$0A	;integer ?
80DC	JNZ	frndemit	;:no
80DE	RET		;'int: do nothing
80DFfrndemit	MOV	CL,#$0A	;convert to integer
80E1	JMP	ecall	;"emit call
80E4fsucc	MOV	AL,#$40	;SUCC: INC AX
80E6	JMP.b	fpred2	;'
80E8fpred	MOV	AL,#$48	;PRED: DEC AX
80EAfpred2	PUSH	AX	;save opcode
80EB	CALL	getscal	;(scal)
80EE	POP	AX	;restore op
80EF	JMP	ebyte	;"emit it
80F2flo	CALL	getint	;LO: (int)
80F5	CALL	ecode
80F8	B	$02,$32,$E4	;* XOR AH,AH
80FB	RET		;"
80FCfhi	CALL	getint	;HI: (int)
80FF	CALL	ecode	;* MOV AL,AH
8102	B	$04,$8A,$C4,$32,$E4	;* XOR AH,AH
8107	RET		;"
8108fswap	CALL	getint	;SWAP: (int)
810B	CALL	ecode
810E	B	$02,$86,$C4	;* XCHG AH,AL
8111	RET		;"
8112fodd	CALL	getint	;ODD: (int)
8115	CALL	ecode
8118	B	$03,$25,$01,$00	;* AND AX,#0001
811C	MOV	CL,#$0B	;boolean result
811E	RET		;"
811Ffkeypres	MOV	AX,#xkeypres	;KEYPRESSED
8122	MOV	CL,#$0B	;result: boolean
8124	JMP	ecall	;"emit call
8127ford	CALL	getscal	;ORD: (scalar)
812A	MOV	CL,#$0A	;result: integer
812C	RET		;"
812Dfchr	CALL	getint	;CHR: (int)
8130	MOV	CL,#$0C	;result: char
8132	RET		;"
8133flength	CALL	ebrack1	;! ( : LENGTH
8136	MOV	AX,#xlength
8139flen2	PUSH	AX	;save addr
813A	CALL	exstr	;get string expression
813D	CALL	ebrack2	;! )
8140	POP	AX	;restore addr
8141	JMP	frndemit	;"int result, emit call
8143fpos	CALL	ebrack1	;! ( : POS
8146	CALL	exstr	;get string expression
8149	CALL	ecomma	;! ,
814C	MOV	AX,#xpos
814F	JMP	flen2	;"get second string expr
8151fcopy	CALL	ebrack1	;! ( : COPY
8154	CALL	exstr	;get string expr
8157	CALL	ecomma	;! ,
815A	CALL	exint	;get int expr
815D	CALL	ecomma	;! ,
8160	CALL	epushax	;* PUSH AX
8163	CALL	exint	;get int expr
8166	MOV	AX,#xcopy
8169	CALL	ecall	;emit call
816Cfcopemit	CALL	ebrack2	;! )
816F	MOV	CL,#$08	;result: string
8171	RET		;"
8172fconcat	CALL	ebrack1	;! ( : CONCAT
8175	CALL	exstr	;get string expr
8178fconlp	CALL	ccomma	;, ?
817B	JNZ	fcopemit	;no:end it
817D	CALL	exstr	;get string expr
8180	MOV	AX,#xconcat
8183	CALL	ecall	;emit call
8186	JMP	fconlp	;"another string ?
8188fparmcnt	MOV	AX,#xparmcnt	;PARAMCOUNT
818B	JMP	frndemit	;"result: integer
818Efparmstr	CALL	getint	;PARAMSTR: (int)
8191	MOV	AX,#xparmstr
8194	MOV	CL,#$08	;result: string
8196	JMP	ecall	;"emit call
8199frandom	CALL	cbrack1	;RANDOM: ( ?
819C	MOV	AX,#xrandom	;(random real)
819F	MOV	CL,#$09	;result: real
81A1	JNZ	frndreal	;no (: take real
81A3	CALL	exint	;get int expr
81A6	CALL	ebrack2	;! )
81A9	MOV	AX,#irandom	;(random int)
81ACfemitint	MOV	CL,#$0A	;result: integer
81AEfrndreal	JMP	ecall	;"emit call
81B1fiores	MOV	AX,#xiores	;IORESULT
81B4	JMP	femitint	;"-> integer
81B6feof	CALL	getfil	;EOF: (file)
81B9	MOV	BX,#veof	;ptr to vector table
81BC	CALL	ecallio	;emit call for I/O
81BFfemitboo	MOV	CL,#$0B	;result: boolean
81C1	RET		;"
81C2fseekeof	MOV	AX,#xseekeof	;SEEKEOF
81C5	JMP.b	feo2	;'
81C7fseekeol	MOV	AX,#xseekeol	;SEEKEOLN
81CA	JMP.b	feo2	;'
81CCfeoln	MOV	AX,#xeoln	;EOLN
81CFfeo2	PUSH	AX	;save addr
81D0	CALL	getfil	;(file)
81D3	CMP.B	CL,#$06	;text file ?
81D6	CALL	errnz	;no:
81D9	B	$23	;35:Textfile expected
81DA	POP	AX	;restore addr
81DB	CALL	ecall	;emit call
81DE	JMP	femitboo	;"result: boolean
81E0ffilpos	MOV	AX,#xfilepos	;FILEPOS
81E3	JMP.b	ffil2	;'
81E5ffilsize	MOV	AX,#xfilesiz	;FILESIZE
81E8ffil2	PUSH	AX	;save addr
81E9	CALL	getfil	;(file)
81EC	POP	AX	;addr
81ED	CMP.B	CL,#$06	;text file ?
81F0	CALL	errz	;yes:
81F3	B	$3F	;63:Textfiles are not allowed here
81F4	JMP	femitint	;"int result, emit call
81F6flfilpos	MOV	AX,#xlfilpos	;LONGFILEPOS
81F9	JMP.b	flf2	;'
81FBflfilsiz	MOV	AX,#xlfilsiz	;LONGFILESIZE
81FEflf2	PUSH	AX	;save addr
81FF	CALL	getfil	;(file)
8202	POP	AX	;addr
8203	CMP.B	CL,#$06	;text file ?
8206	CALL	errz	;yes:
8209	B	$3F	;63:Textfiles are not allowed here
820A	MOV	CL,#$09	;result: real
820C	JMP	ecall	;"emit call
820Ffmemavl	MOV	AX,#xmemavl	;MEMAVAIL
8212	JMP	femitint	;"int result, emit call
8214fmaxavl	MOV	AX,#xmaxavl	;MAXAVAIL
8217	JMP	femitint	;"int result, emit call
8219faddr	CALL	ebrack1	;! ( : ADDR
821C	CALL	varptr	;get var ptr
821F	CALL	ecode	;* POP DX
8222	B	$02,$5A,$97	;* XCHG DI,AX
8225fretptr	CALL	ebrack2	;! )
8228	MOV	CL,#$04	;result: pointer
822A	MOV	functp,#$0000	;untyped
8230	RET		;"
8231fptr	CALL	ebrack1	;! ( : PTR
8234	CALL	exint	;get int expr
8237	CALL	ecomma	;! ,
823A	CALL	epushax	;* PUSH AX
823D	CALL	exint	;get int expr
8240	CALL	ecode	;* POP DX (segment)
8243	B	$01,$5A
8245	JMP	fretptr	;"expect ), pointer
8247fofs	CALL	ebrack1	;! ( : OFS
824A	MOV	CX,#$0500	;search procedure
824D	CALL	search
8250	JZ	fofsproc	;:found
8252	MOV	CX,#$0600	;search function
8255	CALL	search
8258	JNZ	fofsvar	;:not found
825Afofsproc	MOV	AX,[BP]-$08	;get offset
825Dfofsimme	CALL	emovaxi	;* MOV AX,#proc_offset
8260	JMP.b	fofsint	;'type: integer
8262fofsvar	CALL	rdvar	;get var
8265	CALL	errnz	;not found:
8268	B	$29	;41:Unknown ID or syntax error
8269	CALL	loadoffs	;get offset
826C	CALL	ecode	;* XCHG DI,AX
826F	B	$01,$97	;(offset -> AX)
8271fofsint	CALL	ebrack2	;! )
8274	MOV	CL,#$0A	;result: integer
8276	RET		;"
8277fseg	CALL	ebrack1	;! ( : SEG
827A	CALL	rdvar	;get var
827D	CALL	errnz	;not found:
8280	B	$29	;41:Unknown ID or syntax error
8281	MOV	AL,#$8C	;(MOV AX,DS)
8283	MOV	AH,#$D8
8285	CMP.B	varseg,#$FF	;DS ?
828A	JZ	fsegemit	;yes: ok
828C	MOV	AH,#$C0	;(MOV AX,ES)
828E	CMP.B	varseg,#$FD	;ES ?
8293	JZ	fsegemit	;yes: ok
8295	MOV	AH,#$D0	;(MOV AX,SS)
8297	JB	fsegemit	;below: ok
8299	MOV	AH,#$C8	;(MOV AX,CS)
829Bfsegemit	CALL	eword	;emit word
829E	JMP	fofsint	;"expect ), integer
82A0fsizeof	CALL	ebrack1	;! ( : SIZEOF
82A3	MOV	CX,#$0300	;search type
82A6	CALL	search
82A9	JNZ	fszvar	;:not found
82AB	MOV	BP,[BP]-$02	;type ptr
82AE	MOV	AX,[BP]-$02	;get component size
82B1	CALL	emovaxi	;* MOV AX,#compo_size
82B4	JMP	fofsimme	;'(Bug: redundant load !)
82B6fszvar	CALL	rdvar	;get var
82B9	CALL	errnz	;not found:
82BC	B	$29	;41:Unknown ID or syntax error
82BD	MOV	AX,varsize	;get component size
82C0	JMP	fofsimme	;"emit MOV AX,#.., integer
82C2fdseg	CALL	ecode	;DSEG
82C5	B	$02,$8C,$D8	;* MOV AX,DS
82C8	JMP.b	fsseg2	;'int result
82CAfcseg	CALL	ecode	;CSEG
82CD	B	$02,$8C,$C8	;* MOV AX,CS
82D0	JMP.b	fsseg2	;'int result
82D2fsseg	CALL	ecode	;SSEG
82D5	B	$02,$8C,$D0	;* MOV AX,SS
82D8fsseg2	MOV	CL,#$0A	;integer
82DA	RET		;"
82DBfportw	MOV	AL,#$ED	;PORTW
82DD	JMP.b	fprt2	;'(IN AX,[DX])
82DFfport	MOV	AL,#$EC	;PORT (INB AL,[DX])
82E1fprt2	PUSH	AX	;save opcode
82E2	CALL	esqr1	;! [
82E5	CALL	exint	;get int expr
82E8	CALL	esqr2	;! ]
82EB	CALL	ecode
82EE	B	$01,$92	;* XCHG DX,AX (port number)
82F0	POP	AX	;restore opcode
82F1	CALL	ebyte	;emit it
82F4	CMP	AL,#$ED	;integer ?
82F6	JZ	fsseg2	;:yes
82F8	CALL	ecode	;byte:
82FB	B	$02,$32,$E4	;* XOR AH,AH
82FE	JMP	fsseg2	;"int result
8300fupcase	CALL	getscal	;UPCASE: (scalar)
8303	MOV	CL,#$0C	;result: char
8305	MOV	AX,#xupcase
8308	JMP	ecall	;"emit call
830Bfwherex	MOV	AX,#xwherex	;WHEREX
830E	JMP	femitint	;"int result, emit call
8311fwherey	MOV	AX,#xwherey	;WHEREY
8314	JMP	femitint	;"int result, emit call
8317veof	W	xeofty,xeoftx,xeofty	;"EOF vector table
831Dgetint	CALL	ebrack1	;! ( : get (int)
8320	CALL	exint	;get int expr
8323	JMP	ebrack2	;"! )
8326getnum	CALL	ebrack1	;! ( : get (num)
8329	CALL	exnum	;get num expr
832C	JMP	ebrack2	;"! )
832Fgetscal	CALL	ebrack1	;! ( : get (scalar)
8332	CALL	exscal	;get scalar expr
8335	JMP	ebrack2	;"! )
8338getfil	CALL	cbrack1	;get (file): ( ?
833B	JNZ	gtfstd	;:no
833D	CALL	rdfilvar	;get file var
8340	JNB	gtf2	;:ok
8342	CALL	err	;41:Unknown ID or syntax error
8345	B	$29	;'
8346gtf2	CALL	errnz	;not file var:
8349	B	$15	;21:File var expected
834A	JMP	ebrack2	;'! )
834Dgtfstd	CALL	ecode	;set ptr to std input file
8350	B	$04,$BF,$5A,$01,$1E	;* MOV DI,#stdin
8355	MOV	CL,#$06	;* PUSH DS
8357	MOV.B	varctp,CL	;type: text file
835B	RET		;"
835Cfullvar	CALL	rdconst	;Do full var: read constant
835F	JNZ	rdvar	;no good: read var
8361	CMP.B	CL,#$08	;string constant ?
8364	CALL	errnz	;no:
8367	B	$3C	;60:Constants are not allowed here
8368	MOV	AL,#$EB	;JMP
836A	MOV.B	AH,CH	;offset: length of string
836C	CALL	eword	;emit branch around string constant
836F	MOV	AX,pc	;save current pos
8372	MOV	varofs,AX	;-> offset of var
8375	MOV.B	indflg,#$00	;not indexed
837A	MOV.B	varseg,#$FE	;segment CS
837F	MOV.B	varctp,#$01	;type: array
8384	MOV	AX,ptcbeg	;std type: char
8387	SUB	AX,#$0062
838A	MOV	lower,AX	;-> type pointer
838D	XOR	AX,AX	;no index type
838F	MOV	upper,AX
8392	MOV.B	AL,CH	;length -> component size
8394	MOV	varsize,AX
8397	CALL	estr2	;emit array of char
839A	XOR	AX,AX	;ok
839C	RET		;'
839Drdvar	CALL	indwith	;do WITH-indexing
83A0	JZ	rdvarlp	;:done
83A2	MOV	CX,#$0400	;search var
83A5	CALL	search
83A8	JNZ	rvamem	;not found: try MEM
83AA	CALL	getvprm	;get var parms
83ADrdvarind	MOV.B	indflg,#$00	;flag: not indexed
83B2	CMP.B	indptflg,#$00	;indirect by ptr ?
83B7	JZ	rdvarlp	;:no
83B9	CALL	indptrld	;get ptr to var
83BCrdvarlp	CALL	indarray	;do array indexing
83BF	JZ	rdvarlp	;done: loop
83C1	CALL	indrec	;do record indexing
83C4	JZ	rdvarlp	;done: loop
83C6	CALL	indptr	;do pointer indexing
83C9	JZ	rdvarlp	;done: loop
83CB	CALL	indstr	;do string indexing
83CE	XOR	AX,AX	;ok
83D0	RET		;'
83D1rvamem	CALL	ckey	;search keyword:
83D4	B	$01	;MEM / MEMW
83D5	W	tkmem
83D7	JNZ	rvaret	;not found: ret
83D9	CS:	
83DA	MOV.B	AL,[BX]	;get component size
83DC	PUSH	AX	;save it
83DD	CALL	esqr1	;! [
83E0	CALL	exint	;get int expr
83E3	CALL	epushax	;* PUSH AX (segment)
83E6	CALL	ecolon	;! :
83E9	CALL	exint	;get int expr
83EC	CALL	esqr2	;! ]
83EF	CALL	ecode	;* XCHG DI,AX
83F2	B	$02,$97,$07	;* POP ES
83F5	POP	AX	;get length flag
83F6	XOR.B	AH,AH	;clr hi
83F8	MOV	varsize,AX	;-> component size
83FB	MOV.B	varctp,#$0A	;type integer
8400	CMP	AL,#$01	;byte ?
8402	JNZ	rvamemw	;:no
8404	MOV	lower,#$0000	;set lower, upper bound
840A	MOV	upper,#$00FF
8410	JMP.b	rvamemb	;'
8412rvamemw	MOV	lower,#$8000	;set lower, upper bound
8418	MOV	upper,#$7FFF
841Ervamemb	MOV	varofs,#$0000	;var offset: none
8424	MOV.B	indflg,#$FF	;indexed
8429	MOV.B	varseg,#$FD	;segment ES
842E	XOR	AX,AX	;ok
8430rvaret	RET		;"
8431indwith	MOV.B	BL,withnest	;Do WITH indexing
8435	XOR.B	BH,BH	;with nesting -> count
8437iwloop	DEC	BX	;count down
8438	JNS	iw1	;:another level to test
843A	RET		;'
843Biw1	PUSH	BX	;save counter
843C	SHL	BX,1 	;* 4
843E	SHL	BX,1 	;-> pointer into with-table
8440	MOV	CX,[BX]withtab	;type
8444	PUSH	CX
8445	PUSH	[BX]withtab1	;position
8449	MOV	CH,#$04	;search var (record num)
844B	CALL	search
844E	POP	AX	;restore pos, type, counter
844F	POP	CX
8450	POP	BX
8451	JNZ	iwloop	;not found: do next level
8453	MOV.B	indflg,#$00	;flag: not indexed
8458	CMP	AX,#$FFFF	;indexed WITH ?
845B	JZ	iwvar	;:yes
845D	MOV.B	varseg,CH	;get offset from with-table
8461	MOV	varofs,AX
8464	JMP.b	iwconst	;'do record indexing
8466iwvar	PUSH	BP	;save symtab pos
8467	MOV.B	BL,CH	;get stack offset
8469	SHL	BX,1 
846B	MOV	AX,varspc	;stack usage
846E	SUB	AX,BX	;- position
8470	MOV	varofs,AX	;-> offset
8473	MOV	AL,lexnest	;lexical nesting
8476	MOV	varseg,AL	;-> var segment
8479	CALL	indptrld	;get pointer to var
847C	POP	BP	;restore symtab ptr
847Diwconst	JMP	iraddofs	;"do record indexing
8480indstr	CMP.B	varctp,#$08	;Do string indexing
8485	JNZ	iaret	;no string: ret
8487	CALL	csqr1	;[ ?
848A	JNZ	iaret	;no: ret
848C	MOV	AX,ptcbeg	;point to char type
848F	SUB	AX,#$0062
8492	MOV	lower,AX	;-> type ptr
8495	JMP.b	ialoop	;"get index
8497indarray	CMP.B	varctp,#$01	;Do array indexing
849C	JNZ	iaret	;no array: ret
849E	CALL	csqr1	;[ ?
84A1	JZ	ialoop	;yes: do it
84A3iaret	RET		;'
84A4ialoop	MOV	AX,flgpshes	;flag: emit PUSH ES
84A7	CMP.B	varseg,#$FD	;segment ES ?
84AC	JNZ	ialp2	;:no
84AE	MOV.B	flgpshes,#$01	;set flag
84B3ialp2	CMP.B	indflg,#$00	;indexed ?
84B8	JZ	ianoind	;:no
84BA	MOV.B	flgpshdi,#$01	;set flag: emit PUSH DI
84BFianoind	CALL	pushe1	;push entry
84C2	PUSH	pc	;save PC, flag
84C6	PUSH	AX
84C7	CALL	expr	;evaluate expression
84CA	POP	AX	;restore
84CB	CMP	flgpshes,#$00	;flag = 0 ?
84D0	JZ	iarest	;:yes
84D2	MOV	flgpshes,AX	;restore flag
84D5iarest	POP	AX	;old PC
84D6	SUB	AX,pc	;anything emitted ?
84DA	OR.B	CH,CH	;constant ?
84DC	JZ	ianosto	;:yes
84DE	PUSH	AX	;save
84DF	PUSH	CX
84E0	CALL	expload	;load result
84E3	POP	CX
84E4	POP	AX
84E5ianosto	CALL	pope1	;restore entry
84E8	OR	AX,AX	;test flag
84EA	JZ	ianopop	;:not set
84EC	CMP.B	indflg,#$00	;indexed ?
84F1	JZ	ianoind2	;:no
84F3	CALL	ecode	;* POP DI
84F6	B	$01,$5F
84F8ianoind2	CMP.B	varseg,#$FD	;segment ES ?
84FD	JNZ	ianopop	;:no
84FF	CALL	ecode	;* POP ES
8502	B	$01,$07
8504ianopop	CMP.B	varctp,#$08	;string ?
8509	JNZ	ianostr	;:no
850B	MOV.B	var2ctp,#$0A	;component type = scalar
8510	MOV	lower2,#$0000	;lower bound
8516	MOV	AX,varsize	;component size - 1
8519	DEC	AX
851A	MOV	upper2,AX	;-> upper bound
851D	JMP.b	iastr	;'
851Fianostr	MOV	BP,upper	;index type ptr
8523	CALL	getparm	;get type parms
8526iastr	MOV	BP,lower	;type ptr
852A	CALL	getvprm2	;get type parms
852D	CMP.B	CL,var2ctp	;type = index type ?
8531	CALL	errnz	;no:
8534	B	$2C	;44:Type mismatch
8535	OR.B	CH,CH	;constant index ?
8537	JNZ	iavarind	;:no
8539	MOV	AX,exres	;get result
853C	CMP	AX,lower2	;< lower bound ?
8540	JL	iaerr	;yes: error
8542	CMP	AX,upper2	;> upper bound ?
8546	JLE	iacnind	;no: ok
8548iaerr	CALL	err	;45:Constant out of range
854B	B	$2D	;'
854Ciacnind	SUB	AX,lower2	;subtract lower bound
8550	MOV	CX,varsize	;* component size
8554	MUL	CX
8556	ADD	varofs,AX	;add to var offset
855A	JMP	iaind	;'store it
855Diavarind	MOV	AX,lower2	;lower bound
8560	TEST	direcsv,#$0002	;range check ?
8566	JNZ	iarngind	;:yes
8568	MOV	CX,varsize	;lower bound * component size
856C	MUL	CX
856E	SUB	varofs,AX	;subtract from var offset
8572	JMP.b	iacnind2	;'-> faster array indexing
8574iarngind	OR	AX,AX	;subtract lower bound from index
8576	JZ	iaoff2	;0:done
8578	CMP	AX,#$0001	;1 ?
857B	JNZ	iaoff	;:no
857D	CALL	ecode
8580	B	$01,$48	;* DEC AX
8582	JMP.b	iaoff2	;'
8584iaoff	CALL	ecode
8587	B	$01,$2D	;* SUB AX,#lower_bound
8589	CALL	eword
858Ciaoff2	MOV	AX,upper2	;upper bound-lower bound+1
858F	SUB	AX,lower2
8593	INC	AX
8594	CALL	emovcxi	;* MOV CX,#ind_count
8597	MOV	AX,#xindchk	;(range check)
859A	CALL	ecall	;* CALL xindchk
859Diacnind2	MOV	AX,varsize	;index * component size
85A0	CMP	AX,#$0001	;component size = 1 ?
85A3	JZ	iacsend	;yes: ok
85A5	CMP	AX,#$0002	;= 2 ?
85A8	JNZ	iacs4	;:no
85AA	CALL	ecode
85AD	B	$02,$D1,$E0	;* SHL AX,1
85B0	JMP.b	iacsend	;'
85B2iacs4	CMP	AX,#$0004	;= 4 ?
85B5	JNZ	iacs6	;:no
85B7	CALL	ecode	;* SHL AX,1
85BA	B	$04,$D1,$E0,$D1,$E0	;* SHL AX,1
85BF	JMP.b	iacsend	;'
85C1iacs6	CMP	AX,#$0006	;= 6 ?
85C4	JNZ	iacs	;:no
85C6	CALL	ecode	;* SHL AX,1
85C9	B	$08,$D1,$E0,$8B,$C8	;* MOV CX,AX
85CE	B	$D1,$E0,$03,$C1	;* SHL AX,1
85D2	JMP.b	iacsend	;'* ADD AX,CX
85D4iacs	CALL	emovcxi	;* MOV CX,#compo_size
85D7	CALL	ecode
85DA	B	$02,$F7,$E1	;* MUL CX
85DDiacsend	CMP.B	indflg,#$00	;already indexed ?
85E2	JZ	ianotind	;:no
85E4	CALL	ecode	;add to previous index
85E7	B	$02,$03,$F8	;* ADD DI,AX
85EA	JMP.b	iaind	;'
85ECianotind	CALL	ecode
85EF	B	$01,$97	;* XCHG DI,AX
85F1	MOV.B	indflg,#$FF	;flag: indexed
85F6iaind	CMP.B	varctp,#$01	;component type = array ?
85FB	JNZ	iaend	;no: end it
85FD	CALL	ccomma	;, ?
8600	JNZ	iaend	;no: end it
8602	JMP	ialoop	;'get next index
8605iaend	CALL	esqr2	;! ]
8608	XOR	AX,AX	;ok
860A	RET		;"
860Bindrec	CMP.B	varctp,#$02	;Do record indexing
8610	JNZ	irret	;no record: ret
8612	CALL	cdot	;. ?
8615	JNZ	irret	;no: ret
8617	MOV.B	CL,varnest	;record nesting level
861B	MOV	CH,#$04	;var
861D	CALL	search	;search subvar
8620	CALL	errnz	;not found:
8623	B	$29	;41:Unknown ID or syntax error
8624iraddofs	PUSH	indptflg	;save base parms
8628	PUSH	varofs
862C	CALL	getvprm	;get var parms
862F	POP	AX	;restore offset
8630	ADD	varofs,AX	;add to new offset
8634	POP	indptflg	;restore indirection ptr
8638	XOR	AX,AX	;ok
863Airret	RET		;"
863Bindptr	CMP.B	varctp,#$04	;Do pointer indexing
8640	JNZ	iptret	;no pointer: ret
8642	CALL	cptr	;^ ?
8645	JNZ	iptret	;no: ret
8647	MOV	BP,lower	;type ptr
864B	CALL	getvprm2	;get type parms
864Eindptrld	MOV	DX,#$38C4	;* LES DI,pointer_var
8651	CALL	einstr	;emit instruction
8654	MOV	varofs,#$0000	;offset = 0
865A	MOV.B	varseg,#$FD	;segment = ES
865F	MOV.B	indflg,#$FF	;indexed
8664	XOR	AX,AX	;ok
8666iptret	RET		;"
8667einstr	MOV	AL,varseg	;Emit instruction with addressing
866A	CMP	AL,#$FD	;ES ?
866C	JB	eistk	;:stack segment
866E	CALL	esegment	;emit segment prefix
8671	CMP.B	indflg,#$00	;indexed ?
8676	JNZ	eiind	;:yes
8678	MOV	CH,#$06	;mode: direct
867A	OR.B	DH,CH
867C	CALL	emitdx	;emit DX
867F	MOV	AX,varofs	;get offset
8682	CALL	eword	;emit offset
8685	JMP.b	eiret	;'ret
8687eiind	MOV	AX,varofs	;get offset
868A	OR	AX,AX	;test offset
868C	MOV	CH,#$05	;[DI]
868E	JZ	eiindofs	;:yes
8690	CALL	offslen	;short or long offset ?
8693	MOV	CH,#$45	;short
8695	JZ	eiindofs	;:ok
8697	MOV	CH,#$85	;long offset
8699eiindofs	OR.B	DH,CH	;set addressing mode
869B	CALL	emitdx	;emit opcode
869E	TEST.B	DH,#$C0	;offset ?
86A1	JZ	eiret	;no: ret
86A3	JMP.b	eioffs	;'emit offset
86A5eistk	CMP.B	AL,lexnest	;in current procedure ?
86A9	MOV	CX,#$0306	;[BP]offs / [BP+DI]offs
86AC	JZ	eistk2	;:yes
86AE	CALL	ecode	;* MOV BX,[BP]lex_level
86B1	B	$02,$8B,$5E	;(get ptr from display)
86B4	ADD.B	AL,AL	;- nesting level * 2
86B6	NEG.B	AL
86B8	CALL	ebyte	;emit offset
86BB	MOV	AL,#$36	;* SS:
86BD	CALL	ebyte
86C0	MOV	CX,#$0107	;[BX]offs / [BX+DI]offs
86C3eistk2	CMP.B	indflg,#$00	;indexed ?
86C8	JZ	eistk3	;:no
86CA	MOV.B	CL,CH	;use [B.+DI]
86CCeistk3	MOV	AX,varofs	;get offset
86CF	CALL	offslen	;short or long ?
86D2	MOV	CH,#$40	;short
86D4	JZ	eistksh	;:ok
86D6	MOV	CH,#$80	;long
86D8eistksh	OR.B	DH,CL	;set addressing mode
86DA	OR.B	DH,CH
86DC	CALL	emitdx	;emit opcode
86DFeioffs	MOV	AX,varofs	;get offset
86E2	TEST.B	DH,#$40	;long ?
86E5	JNZ	eioffbyt	;:no
86E7	CALL	eword	;emit word offset
86EA	JMP.b	eiret	;'
86ECeioffbyt	CALL	ebyte	;emit byte offset
86EFeiret	RET		;"
86F0offslen	OR.B	AL,AL	;Short or long offset ?
86F2	JS	offneg	;:negative
86F4	OR.B	AH,AH	;high byte must be zero
86F6	RET		;'
86F7offneg	CMP.B	AH,#$FF	;high byte must be FF
86FA	RET		;"
86FBesegment	CMP.B	varseg,#$FF	;emit segment prefix
8700	JZ	eseges	;DS:no prefix needed
8702	CMP.B	varseg,#$FD	;ES ?
8707	MOV	AL,#$26	;(ES:)
8709	JZ	esegret	;:yes
870B	MOV	AL,#$2E	;(CS:)
870Desegret	CALL	ebyte	;emit prefix
8710eseges	RET		;"
8711loadoffs	CMP.B	varseg,#$FD	;Get offset
8716	JB	ldostk	;:stack segment
8718	MOV	AX,varofs	;var offset
871B	CMP.B	indflg,#$00	;indexed ?
8720	JNZ	ldoind	;:yes
8722	JMP	emovdii	;'* MOV DI,#offset
8725ldoind	OR	AX,AX	;test offset
8727	JZ	eseges	;0:ret
8729	CALL	offslen	;short or long offset ?
872C	MOV	DX,#$C783	;(ADD DI,#byte)
872F	JZ	ldobyt	;:short
8731	MOV	DL,#$81	;(ADD DI,#word)
8733ldobyt	PUSH	AX	;save offset
8734	CALL	emitdx	;emit operation
8737	POP	AX	;offset
8738	TEST.B	DL,#$02	;short ?
873B	JZ	ldoword	;:no
873D	JMP	ebyte	;'emit byte offset
8740ldoword	JMP	eword	;'emit word offset
8743ldostk	MOV	DX,#$388D	;(LEA DI,..)
8746	JMP	einstr	;"get effective addr -> DI
8749varptr	CALL	rdvar	;Get var ptr: get var
874C	CALL	errnz	;not found:
874F	B	$29	;41:Unknown ID or syntax error
8750varptr2	CALL	loadoffs	;get offset -> DI
8753	MOV	AL,#$1E	;(PUSH DS) push offset
8755	CMP.B	varseg,#$FF	;DS ?
875A	JZ	varptret	;:yes
875C	MOV	AL,#$06	;(PUSH ES)
875E	CMP.B	varseg,#$FD	;ES ?
8763	JZ	varptret	;:yes
8765	MOV	AL,#$16	;(PUSH SS)
8767	JB	varptret	;:yes
8769	MOV	AL,#$0E	;(PUSH CS)
876Bvarptret	JMP	ebyte	;"emit op
876Eeload	CMP.B	varctp,#$0A	;Load var
8773	JB	eldptr	;:no scalar
8775	CMP.B	varseg,#$FD	;ES ?
877A	JB	eldstk	;:SS: no shortcuts
877C	CMP.B	indflg,#$00	;indexed ?
8781	JZ	elddir	;:no
8783eldstk	MOV	DL,#$8B	;(MOV)
8785	CMP	varsize,#$01	;byte ?
878A	JA	eldword	;:no
878C	MOV	DL,#$8A	;(MOVB)
878Eeldword	MOV	DH,#$00	;MOV AX,...
8790	CALL	einstr	;emit instruction
8793	JMP.b	eldpbyt	;'byte: clr hi byte
8795elddir	CALL	esegment	;emit segment prefix
8798	MOV	AL,#$A1	;(MOV AX,var)
879A	CMP	varsize,#$01	;byte ?
879F	JA	elddbyt	;:no
87A1	MOV	AL,#$A0	;(MOVB AL,var)
87A3elddbyt	CALL	ebyte	;emit operation
87A6	MOV	AX,varofs	;emit offset
87A9	CALL	eword
87ACeldpbyt	CMP	varsize,#$01	;byte ?
87B1	JA	eldret	;:no
87B3	CALL	ecode
87B6	B	$02,$32,$E4	;* XOR AL,AL
87B9eldret	RET		;'
87BAeldptr	CMP.B	varctp,#$04	;load other types
87BF	JNZ	eldreal	;:no ptr
87C1	MOV	DX,#$00C4	;LES AX,ptr_var
87C4	CALL	einstr	;emit instruction
87C7	CALL	ecode
87CA	B	$02,$8C,$C2	;* MOV DX,ES
87CD	RET		;'
87CEeldreal	CALL	varptr2	;get ptr -> DI,stack
87D1	MOV	AX,#xldreal	;(load real)
87D4	CMP.B	varctp,#$09	;real ?
87D9	JZ	eldemit	;:yes
87DB	MOV	AX,#strload	;(load string)
87DE	CMP.B	varctp,#$08	;string ?
87E3	JZ	eldemit	;:yes
87E5	CALL	esetfac	;emit set crunch factor
87E8	MOV	AX,#xldset	;(load set)
87EBeldemit	JMP	ecall	;"emit call
87EEestore	CALL	erngchk	;Store var: emit range check
87F1estore2	CMP.B	varctp,#$0A	;scalar ?
87F6	JB	estcpl	;:no
87F8eststo	CMP.B	varseg,#$FD	;SS ?
87FD	JB	eststk	;yes: no shortcuts
87FF	CMP.B	indflg,#$00	;indexed ?
8804	JZ	estdir	;no: optimize
8806eststk	MOV	DL,#$89	;(MOV dest_var,AX)
8808	CMP	varsize,#$01	;byte ?
880D	JA	estword	;:no
880F	MOV	DL,#$88	;(MOVB dest_var,AL)
8811estword	MOV	DH,#$00	;mode
8813	JMP	einstr	;'emit instruction
8816estdir	CALL	esegment	;emit segment prefix
8819	MOV	AL,#$A3	;(MOV var,AX)
881B	CMP	varsize,#$01	;byte ?
8820	JA	estdbyt	;:no
8822	MOV	AL,#$A2	;(MOVB var,AL)
8824estdbyt	CALL	ebyte	;emit opcode
8827	MOV	AX,varofs	;emit var offset
882A	JMP	eword	;'
882Destptr	CALL	eststo	;store ptr: emit store AX
8830	ADD	varofs,#$02	;offs second word
8835	MOV	DX,#$1089	;emit store DX
8838	JMP	einstr	;'emit instruction
883Bestcpl	CMP.B	varctp,#$04	;pointer ?
8840	JZ	estptr	;:yes
8842	MOV	AX,#xstoreal	;(store real)
8845	CMP.B	varctp,#$09	;real ?
884A	JZ	estemit	;:yes
884C	CMP.B	varctp,#$08	;string ?
8851	JNZ	estset	;:no
8853	MOV.B	AH,varsize	;get string length
8857	DEC.B	AH
8859	MOV	AL,#$B1
885B	CALL	eword	;* MOV CL,max_len
885E	MOV	AX,#strstore	;(store string)
8861	JMP.b	estemit	;'emit call
8863estset	CALL	esetfac	;set crunch factor
8866	MOV	AX,#setsto	;(store set)
8869estemit	JMP	ecall	;"emit call
886Cesetfac	MOV	BP,lower	;calculate set crunch factor
8870	CALL	getparm	;get parms of base type
8873	MOV	AL,varsize	;component size
8876	MOV.B	AH,lower2	;lower bound/8
887A	MOV	CL,#$03
887C	SHR.B	AH,CL
887E	JMP	emovcxi	;"* MOV CX,#crunch
8881erngchk	CMP.B	varctp,#$0A	;Emit range check
8886	JB	erngret	;no scalar: ret
8888	TEST	direcsv,#$0002	;range checking on ?
888E	JZ	erngret	;:no
8890	MOV	AX,lower	;lower bound-1 = upper bound ?
8893	DEC	AX
8894	CMP	AX,upper
8898	JZ	erngret	;yes: no check
889A	INC	AX	;restore lower
889B	CALL	emovcxi	;* MOV CX,#lower_bound
889E	MOV	AX,upper	;upper bound
88A1	CALL	emovdxi	;* MOV DX,#upper_bound
88A4	MOV	AX,#xrngchk	;(range check)
88A7	CALL	ecall	;emit call
88AAerngret	RET		;"
88ABrdnumcn	CALL	rdconst	;read numeric constant
88AEsnerror	CALL	errnz	;no good:
88B1	B	$29	;41:Unknown ID or syntax error
88B2	RET		;"
88B3rdintcn	CALL	rdnumcn	;get integer constant
88B6testint	CMP.B	CL,#$0A	;integer ?
88B9	CALL	errnz	;no:
88BC	B	$16	;22:Integer constant expected
88BD	RET		;"
88BErdstrcn	CALL	rdnumcn	;get string constant
88C1	CMP.B	CL,#$08	;string ?
88C4	JZ	rdstrret	;yes: ok
88C6	CMP.B	CL,#$0C	;char ?
88C9	CALL	errnz	;no:
88CC	B	$20	;32:String constant expected
88CD	MOV	CL,#$08	;convert to string
88CFrdstrret	RET		;"
88D0rdconst	CALL	testsign	;Read constant: test sign
88D3	PUSH	DX	;save it
88D4	CALL	constel	;get constant element
88D7	POP	DX	;restore sign
88D8	JZ	donegate	;:ok
88DA	OR	DX,DX	;didn't work
88DC	CALL	errnz	;25:Int or real const expected
88DF	B	$19
88E0	DEC	DX	;ok
88E1rdcnret	RET		;'
88E2donegate	CALL	testnum	;test type
88E5	JZ	rdcnret	;:ret - no negation
88E7	CMP.B	CL,#$09	;real ?
88EA	JNZ	rdcnnegi	;:no
88EC	CMP.B	creal1,#$00	;0 ?
88F1	JZ	rdcnok	;yes: don't negate
88F3	XOR.B	cresign,#$80	;negate it
88F8	JMP.b	rdcnok	;'ok
88FArdcnnegi	NEG	BX	;negate result
88FCrdcnok	XOR	DX,DX	;ok
88FE	RET		;"
88FFtestsign	MOV	DI,chptr	;Test sign:test char
8903	MOV	DX,#$FFFF	;flag: negative
8906	CMP.B	[DI],#$2D	;- ?
8909	JZ	tsminus	;:yes
890B	INC	DX	;clear neg flag
890C	CMP.B	[DI],#$2B	;+ ?
890F	JNZ	tsret	;no: don't skip char
8911	INC	DX	;set + flag
8912tsminus	INC	DI	;skip that char
8913	CALL	skipdi	;read next word
8916tsret	RET		;"
8917testnum	OR	DX,DX	;Test type
8919	JZ	tnret	;:no negation - ok
891B	CMP.B	CL,#$0A	;integer ?
891E	JZ	tndec	;:ok
8920	CMP.B	CL,#$09	;real ?
8923	CALL	errnz	;no:
8926	B	$19	;25:Int or real constant expected
8927tndec	DEC	DX	;clear plus flag
8928tnret	RET		;"
8929constel	CALL	immecn	;Get const element: immediate const
892C	JNZ	clconst	;:no
892E	RET		;'
892Fclconst	MOV	CX,#$0200	;search constant
8932	CALL	search
8935	JNZ	clret	;:not found
8937	MOV.B	CL,[BP]-$01	;get component type
893A	CMP.B	CL,#$0A	;scalar ?
893D	JB	clreal	;:no
893F	MOV	BX,[BP]-$03	;get value
8942	JMP.b	clok	;'ok
8944clreal	CMP.B	CL,#$09	;real ?
8947	JNZ	clstring	;:no
8949	MOV	AX,[BP]-$07	;get real const
894C	MOV	creal1,AX	;store in buffer
894F	MOV	AX,[BP]-$05
8952	MOV	creal2,AX
8955	MOV	AX,[BP]-$03
8958	MOV	creal3,AX
895B	JMP.b	clok	;'ok
895Dclstring	MOV.B	CH,[BP]-$02	;string: get length
8960	MOV.B	DL,CH
8962	MOV	BX,#wordbuf	;dest buffer
8965clstrlp	OR.B	DL,DL	;test len
8967	JZ	clok	;:done
8969	DEC	BP	;stored backwards !
896A	MOV.B	AL,[BP]-$02	;get char
896D	MOV.B	[BX],AL	;copy into buffer
896F	INC	BX	;next pos
8970	DEC.B	DL	;another char ?
8972	JMP	clstrlp	;'
8974clok	XOR	DX,DX	;ok
8976clret	RET		;"
8977immecn	MOV	DI,chptr	;get immediate constant
897B	MOV.B	AL,[DI]	;current char
897D	CMP	AL,#$27	; ' ?
897F	JZ	icstr	;yes: string const
8981	CMP	AL,#$5E	;^ ?
8983	JZ	icstr	;yes: string const
8985	CMP	AL,#$23	;# ?
8987	JNZ	icnum	;no: numeric const
8989icstr	MOV	BX,#wordbuf	;dest buffer
898C	MOV	CH,#$00	;length = 0
898Eicsloop	MOV.B	AL,[DI]	;current char
8990	CMP	AL,#$5E	;^ ?
8992	JZ	icscntrl	;:yes
8994	CMP	AL,#$23	;# ?
8996	JZ	icsnum	;:yes
8998	CMP	AL,#$27	; ' ?
899A	JNZ	icsend	;no: end of string const
899Cicslp2	INC	DI	;next char
899D	MOV.B	AL,[DI]	;get char
899F	OR.B	AL,AL	;line end ?
89A1	CALL	perrz	;yes:
89A4	B	$37	;55:String constant exceeds line
89A5	CMP	AL,#$27	; ' ?
89A7	JNZ	icssto	;:no
89A9	INC	DI	;test next char: may be ''
89AA	CMP.B	[DI],#$27	; ' ?
89AD	JNZ	icsloop	;no: end of string
89AFicssto	MOV.B	[BX],AL	;store in buffer
89B1	INC	BX	;next pos
89B2	INC.B	CH	;count length
89B4	JMP	icslp2	;'continue
89B6icscntrl	INC	DI	;next char: do ^char
89B7	MOV.B	AL,[DI]	;get it
89B9	CALL	upcase	;UpCase
89BC	OR.B	AL,AL	;0 ?
89BE	CALL	perrz	;yes:
89C1	B	$37	;55:String constant exceeds line
89C2	XOR	AL,#$40	;make it a control char
89C4	INC	DI	;next char
89C5icssto2	MOV.B	[BX],AL	;store in buffer
89C7	INC	BX
89C8	INC.B	CH	;count length
89CA	JMP	icsloop	;'get next element
89CCicsnum	INC	DI	;read #char
89CD	PUSH	BX	;save dest ptr, counter
89CE	PUSH	CX
89CF	MOV	BX,DI	;pos of number
89D1	CALL	asccard	;read integer
89D4	MOV	DI,BX	;set new position
89D6	POP	CX	;restore
89D7	POP	BX
89D8	CALL	perrb	;error:
89DB	B	$38	;56:Error in int constant
89DC	JMP	icssto2	;'store it, continue
89DEicsend	MOV	CL,#$08	;string
89E0	CMP.B	CH,#$01	;length = 1 ?
89E3	JNZ	icend	;:no
89E5	MOV.B	BL,wordbuf	;get char
89E9	XOR.B	BH,BH	;clear high byte
89EB	MOV	CL,#$0C	;char
89EDicend	JMP	skipdi	;'get next word
89F0icnum	MOV	BX,DI	;numeric constant: beg pos
89F2	CMP	AL,#$24	;$ ?
89F4	JZ	icnint	;yes: integer constant
89F6	CALL	number	;char in 0..9 ?
89F9	JNB	icnscan	;:yes
89FB	XOR	AX,AX	;set flag: invalid
89FD	DEC	AX
89FE	RET		;'
89FFicnscan	INC	DI	;next char
8A00	MOV.B	AL,[DI]	;get it
8A02	CALL	number	;in 0..9 ?
8A05	JNB	icnscan	;yes: loop
8A07	CALL	upcase	;UpCase
8A0A	CMP	AL,#$45	;E ?
8A0C	JZ	icnreal	;yes: real constant
8A0E	CMP	AL,#$2E	;. ?
8A10	JNZ	icnint	;no: integer constant
8A12	INC	DI	;test next char: .. ?
8A13	MOV.B	AL,[DI]
8A15	CMP	AL,#$2E	;. ?
8A17	JZ	icnint	;:yes, integer constant
8A19	CMP	AL,#$29	;) ? (.) = ])
8A1B	JZ	icnint	;yes: integer constant
8A1Dicnreal	MOV	DI,#creal1	;dest buffer
8A20	CALL	ascreal2	;read real number
8A23	MOV	DI,BX	;set new position
8A25	CALL	perrb	;error:
8A28	B	$39	;57:Error in real const
8A29	MOV	CL,#$09	;real
8A2B	JMP	icend	;'end it
8A2Dicnint	CALL	asccard	;read integer const
8A30	MOV	DI,BX	;set new pos
8A32	MOV	BX,AX	;get result
8A34	CALL	perrb	;ok ? no:
8A37	B	$38	;56:Error in integer constant
8A38	MOV	CL,#$0A	;integer
8A3A	JMP	icend	;"end it
8A3Cecode	PUSH	AX	;Emit inline code
8A3D	PUSH	BP	;(stored as inline string)
8A3E	MOV	BP,SP	;stack frame
8A40	XCHG	BX,[BP]$04	;get return addr
8A43	CS:	
8A44	MOV.B	AH,[BX]	;get length
8A46	INC	BX	;next byte
8A47ecodelp	CS:		;get byte
8A48	MOV.B	AL,[BX]
8A4A	CALL	ebyte	;emit it
8A4D	INC	BX	;next one
8A4E	DEC.B	AH
8A50	JNZ	ecodelp	;:another
8A52	XCHG	BX,[BP]$04	;restore ret, BX
8A55	POP	BP	;restore
8A56	POP	AX
8A57	RET		;"
8A58estring	MOV.B	AL,CH	;Emit string, CH=length
8A5A	CALL	ebyte	;emit length
8A5Destr2	MOV	BX,#wordbuf	;buffer ptr
8A60estrlp	OR.B	CH,CH	;test length
8A62	JZ	estrret	;:null string
8A64	MOV.B	AL,[BX]	;get char
8A66	CALL	ebyte	;emit it
8A69	INC	BX	;next one
8A6A	DEC.B	CH
8A6C	JMP	estrlp	;'
8A6Eestrret	RET		;"
8A6Fepushax	CALL	ecode	;* PUSH AX
8A72	B	$01,$50
8A74	RET		;"
8A75epopax	CALL	ecode	;* POP AX
8A78	B	$01,$58
8A7A	RET		;"
8A7Bepushdi	CALL	ecode	;* PUSH DI
8A7E	B	$01,$57
8A80	RET		;"
8A81emovaxi	CALL	ecode	;* MOV AX,#..
8A84	B	$01,$B8
8A86	JMP.b	eword	;"emit immediate value in AX
8A88	CALL	ecode	;* MOV BX,#..
8A8B	B	$01,$BB
8A8D	JMP.b	eword	;"emit immediate
8A8Femovcxi	CALL	ecode	;* MOV CX,#..
8A92	B	$01,$B9
8A94	JMP.b	eword	;"emit immediate
8A96emovdxi	CALL	ecode	;* MOV DX,#..
8A99	B	$01,$BA
8A9B	JMP.b	eword	;"emit immediate
8A9Demovdii	CALL	ecode	;* MOV DI,#..
8AA0	B	$01,$BF
8AA2	JMP.b	eword	;"emit immediate
8AA4ecall	CALL	ecode	;* CALL ..
8AA7	B	$01,$E8
8AA9	JMP.b	ejmp2	;'emit offset
8AABejump	CALL	ecode	;* JMP ..
8AAE	B	$01,$E9
8AB0ejmp2	SUB	AX,pc	;dest-PC-2 -> offset
8AB4	DEC	AX
8AB5	DEC	AX
8AB6	JMP.b	eword	;"emit offset word
8AB8emitdx	MOV	AX,DX	;emit DX
8ABAeword	CALL	ebyte	;emit AX
8ABD	PUSH	AX	;save it
8ABE	MOV.B	AL,AH	;emit high byte
8AC0	CALL	ebyte	;emit byte
8AC3	POP	AX	;restore
8AC4	RET		;"
8AC5ebyte	CMP.B	flgpshax,#$00	;Emit byte in AL
8ACA	JZ	ebes	;:no PUSH AX
8ACC	PUSH	AX	;save
8ACD	MOV	AL,#$50	;* PUSH AX
8ACF	CALL	ebemit
8AD2	POP	AX
8AD3	MOV.B	flgpshax,#$00	;reset flag
8AD8ebes	CMP.B	flgpshes,#$00	;emit PUSH ES ?
8ADD	JZ	ebdi	;:no
8ADF	PUSH	AX	;save
8AE0	MOV	AL,#$06	;* PUSH ES
8AE2	CALL	ebemit
8AE5	POP	AX	;restore
8AE6	MOV.B	flgpshes,#$00	;reset flag
8AEBebdi	CMP.B	flgpshdi,#$00	;emit PUSH DI ?
8AF0	JZ	ebemit	;:no
8AF2	PUSH	AX	;save
8AF3	MOV	AL,#$57	;* PUSH DI
8AF5	CALL	ebemit
8AF8	POP	AX	;restore
8AF9	MOV.B	flgpshdi,#$00	;reset flag
8AFEebemit	PUSH	BX	;save
8AFF	CMP.B	cpmode,#$01	;find runtime error ?
8B04	JZ	ebfind	;:yes
8B06	MOV	BX,cdptr	;code ptr-code pos of buffer
8B0A	SUB	BX,cdbufpt
8B0E	ADD	BX,cdbegpt	;+ beg of code buffer
8B12	MOV	ES,destseg	;dest segment
8B16	ES:	
8B17	MOV.B	[BX],AL	;store byte
8B19	JMP.b	ebend	;'
8B1Bebfind	MOV	BX,pc	;PC = error pos ?
8B1F	CMP	BX,errpos2
8B23	JZ	ebfound	;:yes - found !
8B25ebend	INC	cdptr	;inc code pointers
8B29	INC	pc
8B2D	MOV	BX,pc	;get PC
8B31	INC.B	BH	;overflow ?
8B33	JZ	eberr	;:yes
8B35	OR.B	BL,BL	;256 bytes done ?
8B37	JNZ	ebnochk	;:no
8B39	CALL	chkovrfl	;test for overflow
8B3Cebnochk	POP	BX	;restore BX
8B3D	RET		;'
8B3Eeberr	CALL	err	;98:Memory overflow
8B41	B	$62	;'
8B42ebfound	CALL	err	;C8:Error position found
8B45	B	$C8	;"
8B46codflush	CMP.B	cpmode,#$02	;Flush code buffer
8B4B	JB	cfret	;not to file:ret
8B4D	MOV	CX,cdptr	;code pointer
8B51	SUB	CX,cdbufpt	;= code pos of buffer ?
8B55	STC	
8B56	JZ	cfret	;yes: nothing to flush
8B58	MOV	AH,#$40	;write byte block
8B5A	MOV	BX,dstfile	;dest file handle
8B5E	MOV	DX,cdbegpt	;beginning of code buffer
8B62	PUSH	DS	;save DS
8B63	MOV	DS,destseg	;dest segment
8B67	CALL	dos	;write buffer
8B6A	POP	DS	;restore DS
8B6B	JB	cferr	;:error
8B6D	CMP	AX,CX	;length = expected ?
8B6F	JZ	cfok	;:yes
8B71cferr	CALL	err	;C9:File error
8B74	B	$C9	;'
8B75cfok	MOV	AX,cdptr	;code ptr -> code pos of buffer
8B78	MOV	cdbufpt,AX
8B7Bcfret	RET		;"
8B7Cptcjmppc	MOV	AX,pc	;Patch jump address
8B7Fptcjmp	SUB	AX,BX	;dest (AX)-src (BX)-2
8B81	DEC	AX
8B82	DEC	AX
8B83ptcjmp2	PUSH	BX	;save dest
8B84	SUB	BX,pc	;dest-PC+code ptr
8B88	ADD	BX,cdptr
8B8C	CALL	patch	;patch it
8B8F	POP	BX	;restore
8B90	RET		;"
8B91patch	CMP.B	cpmode,#$01	;Patch word AX at pos BX
8B96	JZ	ptret	;find error:ret
8B98	CMP	BX,cdbufpt	;>= code pos of buffer ?
8B9C	JB	ptlist	;no: put it into patch list
8B9E	PUSH	BX	;save pos
8B9F	SUB	BX,cdbufpt	;-code pos of buffer
8BA3	ADD	BX,cdbegpt	;+beg of code buffer
8BA7	MOV	ES,destseg	;dest segment
8BAB	ES:	
8BAC	MOV	[BX],AX	;patch it in memory
8BAE	POP	BX	;restore
8BAFptret	RET		;'
8BB0ptlist	PUSH	CX	;save regs
8BB1	PUSH	DI	;patch list is sorted to
8BB2	PUSH	SI	;minimize disk accesses
8BB3	PUSH	SS	;SS -> ES
8BB4	POP	ES
8BB5	MOV	SI,ptcbeg	;start of patch list
8BB9	MOV	DI,ptctop	;top of patch list
8BBDptsearch	CMP	SI,DI	;at the end ?
8BBF	JZ	ptstore	;yes: put it there
8BC1	SS:	
8BC2	CMP	BX,[SI]	;put it here ?
8BC4	JB	ptins	;:yes
8BC6	ADD	SI,#$04	;go to next entry
8BC9	JMP	ptsearch	;'continue searching
8BCBptins	MOV	CX,DI	;calculate count to shift
8BCD	SUB	CX,SI
8BCF	MOV	SI,DI	;end position
8BD1	ADD	DI,#$04	;-> end pos+4
8BD4	DEC	DI
8BD5	DEC	SI
8BD6	PUSH	DS	;save DS
8BD7	PUSH	SS	;SS -> DS
8BD8	POP	DS
8BD9	STD		;make space for new entry
8BDA	REPZ	
8BDB	MOVS.B	
8BDC	POP	DS	;restore DS
8BDD	INC	SI	;point to dest pos
8BDEptstore	SS:		;store in patch list:
8BDF	MOV	[SI],BX	;address
8BE1	SS:	
8BE2	MOV	[SI]$02,AX	;value to be patched
8BE5	ADD	ptctop,#$04	;add 4 to patch top
8BEA	MOV	CX,ptctop	;patch list top = end of
8BEE	CMP	CX,ptcend	;patch list space ?
8BF2	JNZ	ptnofl	;:no
8BF4	CALL	ptcflush	;flush patch list
8BF7ptnofl	POP	SI	;restore registers
8BF8	POP	DI
8BF9	POP	CX
8BFA	RET		;"
8BFBptcflush	CMP.B	cpmode,#$02	;Patch code in file
8C00	JB	ptfret	;no file - ret
8C02	PUSH	AX	;save regs
8C03	PUSH	BX
8C04	PUSH	CX
8C05	PUSH	DX
8C06	PUSH	BP
8C07	MOV	AX,#$4201	;seek relative
8C0A	MOV	BX,dstfile	;dest file handle
8C0E	XOR	CX,CX	;get current pos in file
8C10	XOR	DX,DX
8C12	CALL	dos
8C15	PUSH	AX	;save it
8C16	PUSH	DX
8C17	MOV	BP,ptcbeg	;start of patch list
8C1Bptflp	CMP	BP,ptctop	;end reached ?
8C1F	JZ	ptfend	;:yes
8C21	MOV	AX,#$4200	;seek absolute
8C24	MOV	BX,dstfile	;dest file handle
8C28	MOV	DX,cdfoff	;file offset
8C2C	MOV	CX,cdfoff1
8C30	ADD	DX,[BP]$00	;+ patch addr
8C33	ADC	CX,#$00	;carry
8C36	CALL	dos	;do seek
8C39	MOV	AX,[BP]$02	;get value to patch
8C3C	MOV	ptcbuf1,AX	;store in buffer
8C3F	MOV	AH,#$40	;write patch value
8C41	MOV	BX,dstfile	;dest file handle
8C45	MOV	CX,#$0002	;2 bytes
8C48	MOV	DX,#ptcbuf1	;buffer ofs
8C4B	CALL	dos
8C4E	CALL	errb
8C51	B	$C9	;C):File error
8C52	ADD	BP,#$04	;next patch list entry
8C55	JMP	ptflp	;'
8C57ptfend	MOV	AX,ptcbeg	;clear patch list:
8C5A	MOV	ptctop,AX	;beg -> top
8C5D	MOV	AX,#$4200	;seek absolute
8C60	MOV	BX,dstfile	;dest file handle
8C64	POP	CX	;restore current pos
8C65	POP	DX
8C66	CALL	dos	;set it again
8C69	POP	BP	;restore regs
8C6A	POP	DX
8C6B	POP	CX
8C6C	POP	BX
8C6D	POP	AX
8C6Eptfret	RET		;"
8C6Fpushe2	MOV	SI,#parm2	;save entry 2 on stack
8C72	JMP.b	pshe1	;'
8C74pushe1	MOV	SI,#indflg	;save entry 1 on stack
8C77pshe1	POP	retbuf	;ret addr
8C7B	MOV	cxbuf,CX	;save CX
8C7F	MOV	CX,SS	;SS -> ES
8C81	MOV	ES,CX
8C83	MOV	CX,#$000F	;15 bytes
8C86	SUB	SP,CX	;make space on stack
8C88	MOV	DI,SP	;dest: stack
8C8A	CLD	
8C8B	REPZ	
8C8C	MOVS.B		;move it
8C8Dpsheend	MOV	CX,cxbuf	;restore CX
8C91	JMP	[retbuf]	;"return
8C95pope2	MOV	DI,#parm2	;restore entry 2 from stack
8C98	JMP.b	pope	;'
8C9Apope1	MOV	DI,#indflg	;restore entry 1 from stack
8C9Dpope	POP	retbuf	;ret addr
8CA1	MOV	cxbuf,CX	;save CX
8CA5	MOV	SI,SP	;SP -> source
8CA7	MOV	CX,DS	;DS -> ES
8CA9	MOV	ES,CX
8CAB	MOV	CX,SS	;SS -> DS
8CAD	MOV	DS,CX
8CAF	MOV	CX,#$000F	;15 bytes
8CB2	CLD	
8CB3	REPZ	
8CB4	MOVS.B		;move it
8CB5	MOV	CX,ES	;restore DS
8CB7	MOV	DS,CX
8CB9	MOV	SP,SI	;remove entry from stack
8CBB	JMP	psheend	;"return
8CBDcopye2	MOV	DI,#parm2	;copy entry 2 from stack
8CC0	JMP.b	cpe	;'
8CC2	MOV	DI,#indflg	;copy entry 1 from stack
8CC5cpe	PUSH	CX	;save CX
8CC6	MOV	SI,SP	;source: on stack
8CC8	ADD	SI,#$04	;skip ret addr, CX
8CCB	MOV	CX,DS	;DS -> ES
8CCD	MOV	ES,CX
8CCF	MOV	CX,SS	;SS -> DS
8CD1	MOV	DS,CX
8CD3	MOV	CX,#$000F	;15 bytes
8CD6	CLD	
8CD7	REPZ	
8CD8	MOVS.B		;copy it
8CD9	MOV	CX,ES	;restore DS
8CDB	MOV	DS,CX
8CDD	POP	CX	;restore CX
8CDE	RET		;"
8CDFsymbyte	MOV	BP,symtop	;store AL in symtab
8CE3	DEC	BP	;down one byte
8CE4	MOV.B	[BP]$00,AL	;store it
8CE7	MOV	symtop,BP	;set new symtab top
8CEB	RET		;"
8CECsymword	MOV	BP,symtop	;store AX in symtab
8CF0	DEC	BP	;down two bytes
8CF1	DEC	BP
8CF2	MOV	[BP]$00,AX	;store it
8CF5	MOV	symtop,BP	;set new symtab top
8CF9	RET		;"
8CFAsymoffs	MOV	AX,symtop2	;Write symtab offset
8CFD	SUB	AX,symtop	;last entry-current+2
8D01	ADD	AX,#$0002
8D04	CALL	symword	;store offset
8D07	MOV	AX,symtop	;symtab top ->
8D0A	MOV	symtop2,AX	;symtab top at beg of definition
8D0D	JMP	chkovrfl	;"test size
8D10stotype	MOV	AX,#$0800	;store type
8D13	CALL	symword	;store tag: subtype
8D16	MOV	AX,symtop	;symtab top
8D19	MOV	vartp,AX	;-> type ptr
8D1C	MOV	BX,#parm1end	;source buffer
8D1F	MOV	BP,symtop	;destination
8D23stotlp	DEC	BX	;go down
8D24	DEC	BX	;write size, upper bound,
8D25	DEC	BP	;lower bound, component type
8D26	DEC	BP
8D27	MOV	AX,[BX]	;get word
8D29	MOV	[BP]$00,AX	;store it
8D2C	CMP	BX,#varctp	;end ?
8D30	JNZ	stotlp	;:not yet
8D32	MOV	symtop,BP	;set new top
8D36	CALL	symoffs	;write offset
8D39	XOR	AX,AX	;ok
8D3B	RET		;"
8D3Cgetparm	MOV	BX,#maxsize	;Get var parms -> entry 2
8D3F	JMP.b	gvp2	;'
8D41getvprm	MOV	AX,[BP]-$06	;Get var parms
8D44	MOV	indptflg,AX	;var segment
8D47	MOV	AX,[BP]-$04	;var offset
8D4A	MOV	varofs,AX
8D4D	MOV	BP,[BP]-$02	;type pointer
8D50getvprm2	MOV	BX,#parm1end	;to entry 1
8D53gvp2	PUSH	CX	;save
8D54	MOV	CX,#$0004	;8 bytes
8D57gvplp	DEC	BP	;go down
8D58	DEC	BP	;copy size, upper & lower bound,
8D59	DEC	BX	;component type
8D5A	DEC	BX
8D5B	MOV	AX,[BP]$00	;copy entry -> buffer
8D5E	MOV	[BX],AX
8D60	LOOP	gvplp	;:another
8D62	POP	CX	;restore
8D63	RET		;"
8D64rdsymnew	MOV	AX,#$0100	;'Read symbol
8D67	JMP.b	rsy1	;'no numbers, verify in symtab
8D69rdsym0	MOV	AX,#$0001	;numbers allowed
8D6C	JMP.b	rsy1	;'
8D6Erdsym	XOR	AX,AX	;no numbers
8D70rsy1	PUSH	AX	;save flag
8D71	CALL	rdword	;read word
8D74	POP	AX	;restore flag
8D75	OR.B	AL,AL	;numbers allowed ?
8D77	MOV	AL,wrdbuf1	;first char ?
8D7A	JZ	rsynonum	;:no
8D7C	CALL	number	;0..9 ?
8D7F	JNB	rsynum	;yes: ok
8D81rsynonum	CALL	alpha	;valid char ?
8D84	CALL	errb	;no:
8D87	B	$3A	;58:Illegal char in ID
8D88rsynum	OR.B	AH,AH	;verify in symbol table ?
8D8A	JNZ	rsynotst	;:no
8D8C	CALL	dupvar	;test if duplicate
8D8Frsynotst	CALL	dupkey	;test if keyword
8D92	MOV	BP,symtop	;destination
8D96	MOV.B	BL,wordbuf	;word length
8D9A	XOR.B	BH,BH	;-> count
8D9C	DEC	BP	;go down
8D9D	MOV.B	[BP]$00,BL	;store length
8DA0rsysto	DEC	BP	;go down
8DA1	MOV.B	AL,[BX]wordbuf	;get char from buffer
8DA5	MOV.B	[BP]$00,AL	;store in symtab
8DA8	DEC	BX	;go back
8DA9	JNZ	rsysto	;:another char
8DAB	MOV	symtop,BP	;set new symtab top
8DAFrsynext	MOV	DI,wrdend	;go to end of word
8DB3	JMP	skipdi	;"get next word
8DB6rdword	CMP.B	wordflg,#$FF	;read word: word available ?
8DBB	JNZ	rdwret	;yes: ret
8DBD	XOR	BX,BX
8DBF	MOV	DI,chptr	;char ptr: source
8DC3	MOV.B	AL,[DI]	;get char
8DC5	CALL	alphanum	;char in alphanum ?
8DC8	JB	rdwother	;:no
8DCArdwlp	CMP.B	BL,#$7F	;end of buffer ?
8DCD	JZ	rdwfull	;:yes - don't store
8DCF	CMP	AL,#$61	;do UpCase
8DD1	JB	rdwupper	;:no
8DD3	SUB	AL,#$20
8DD5rdwupper	INC	BX	;go to next pos
8DD6	MOV.B	[BX]wordbuf,AL	;store char in buffer
8DDArdwfull	INC	DI	;next char from source
8DDB	MOV.B	AL,[DI]	;get it
8DDD	CALL	alphanum	;in alphanum ?
8DE0	JNB	rdwlp	;yes: loop back
8DE2	JMP.b	rdwend	;'no: end
8DE4rdwother	INC	DI	;go to next pos
8DE5	INC	BX
8DE6	MOV.B	[BX]wordbuf,AL	;store char
8DEA	MOV.B	AL,[DI]	;next char
8DEC	CMP	AL,#$2E	;. ?
8DEE	JZ	rdwchar2	;:yes
8DF0	CMP	AL,#$3D	;= ?
8DF2	JZ	rdwchar2	;:yes
8DF4	CMP	AL,#$3E	;> ?
8DF6	JNZ	rdwend	;:no
8DF8rdwchar2	INC	DI	;store that char
8DF9	INC	BX
8DFA	MOV.B	[BX]wordbuf,AL
8DFErdwend	MOV.B	wordbuf,BL	;store word length
8E02	MOV	wrdend,DI	;store end addr of word
8E06	MOV.B	wordflg,#$FE	;word available
8E0Brdwret	RET		;"
8E0Csearch	CALL	srchall	;search whole symbol table
8E0F	JNZ	rdwret	;not found:ret
8E11	JMP	skipdi	;"get next word
8E14srchvar	MOV	BX,fence	;current var fence
8E18	JMP.b	src1	;'(BX=search limit)
8E1Asrchall	MOV	BX,ptcbeg	;start of symtab
8E1Esrc1	MOV	DX,CX	;type wanted
8E20	CMP.B	DL,wordflg	;= type of current word ?
8E24	JZ	srcsame	;:yes
8E26	PUSH	BX	;save fence
8E27	CALL	rdword	;read word
8E2A	POP	BX	;restore
8E2B	MOV.B	wordflg,DL	;store type wanted
8E2F	CALL	srchsym	;search in symbol table
8E32	JB	srcnofnd	;:not found
8E34	MOV	typept,AL	;store type returned
8E37	MOV	sympos,BP	;store pos in symbol table
8E3Bsrcsame	MOV	BP,sympos	;get symtab pos
8E3F	MOV	DI,wrdend	;get end pos of word
8E43	MOV	CX,DX	;type -> CX
8E45	CMP.B	CH,typept	;compare type
8E49	RET		;'
8E4Asrcnofnd	XOR	AX,AX	;type returned: none
8E4C	MOV	typept,AL
8E4F	DEC	AX	;not found
8E50	RET		;"
8E51srchsym	MOV.B	CL,wordbuf	;word length
8E55	XOR.B	CH,CH	;-> count
8E57	MOV	BP,symtop2	;symtab position
8E5B	PUSH	SS	;SS -> ES
8E5C	POP	ES
8E5D	CLD		;forward search
8E5Esrchloop	CMP	BP,BX	;fence reached ?
8E60	JZ	srsynf	;yes: not found
8E62	ADD	BP,[BP]$00	;add offset
8E65	MOV.B	AL,[BP]-$01	;get tag byte
8E68	OR.B	AL,AL	;0 ?
8E6A	JZ	srchloop	;yes: invisible entry
8E6C	CMP	AL,#$08	;subtype ?
8E6E	JZ	srchloop	;yes: invisible
8E70	MOV	AX,[BP]-$03	;string length
8E73	CMP.B	AL,CL	;= searched ?
8E75	JNZ	srchloop	;:no
8E77	CMP.B	AH,DL	;= wanted type ?
8E79	JNZ	srchloop	;:no
8E7B	MOV	DI,BP	;calculate string position
8E7D	SUB	DI,#$03
8E80	SUB	DI,CX	;- count
8E82	MOV	SI,#wrdbuf1	;word ptr
8E85	MOV	AX,CX	;save count
8E87	REPZ		;do comparison
8E88	CMPS.B	
8E89	XCHG	AX,CX	;restore count
8E8A	JNZ	srchloop	;not the same: continue
8E8C	MOV.B	AL,[BP]-$01	;get type
8E8F	SUB	BP,#$03	;set ptr to beg of string
8E92	SUB	BP,CX	;= beg of entry
8E94	CLC		;found !
8E95	RET		;'
8E96srsynf	STC		;not found
8E97	RET		;"
8E98ckey	CALL	rdword	;check keyword: read word
8E9B	POP	BX	;return addr
8E9C	CS:	
8E9D	MOV.B	DL,[BX]	;get offset between words
8E9F	CS:	
8EA0	MOV	DI,[BX]$01	;get pointer
8EA3	ADD	BX,#$03	;skip inline parms
8EA6	PUSH	BX	;restore ret addr
8EA7ckey2	XOR.B	DH,DH	;distance between keywords
8EA9	MOV	BX,#wordbuf	;word ptr
8EAC	PUSH	CS	;CS -> ES
8EAD	POP	ES
8EAE	CLD		;forward search
8EAFckloop	CS:	
8EB0	MOV.B	CL,[DI]	;get length
8EB2	XOR.B	CH,CH
8EB4	JCXZ	cknf	;nothing - end of list
8EB6	INC	CX	;-> count
8EB7	MOV	SI,BX	;source
8EB9	REPZ	
8EBA	CMPS.B		;compare words
8EBB	JZ	ckfound	;:equal
8EBD	ADD	DI,CX	;add remaining count
8EBF	ADD	DI,DX	;add offset
8EC1	JMP	ckloop	;'try next keyword
8EC3cknf	DEC	CX	;flag: not found
8EC4	RET		;'
8EC5ckfound	MOV	BX,DI	;position in keyword table
8EC7	CALL	rsynext	;get next word
8ECA	CS:	
8ECB	MOV	AX,[BX]	;get word from keyword table
8ECDckret	RET		;"
8ECEctoken	CALL	rdword	;Check keyword: read word
8ED1	POP	BX	;return address
8ED2	CS:	
8ED3	MOV	DI,[BX]	;inline parm: pointer
8ED5	INC	BX	;skip inline parm
8ED6	INC	BX
8ED7	PUSH	BX	;restore ret
8ED8	MOV	SI,#wordbuf	;word ptr
8EDB	MOV.B	CL,[SI]	;get length of keyword
8EDD	XOR.B	CH,CH	;-> count
8EDF	INC	CX
8EE0	PUSH	CS	;CS -> ES
8EE1	POP	ES
8EE2	CLD		;compare words
8EE3	REPZ	
8EE4	CMPS.B	
8EE5	JNZ	ckret	;:not the same - ret
8EE7	JMP	rsynext	;"ok, get next word
8EEAdupkey	MOV	BX,#keytable	;new ID = keyword ?
8EEDdkloop	CS:		;pointer: list of keyword areas
8EEE	MOV.B	DL,[BX]	;get offset
8EF0	CMP.B	DL,#$FF	;end of table ?
8EF3	JZ	dkret	;:yes
8EF5	PUSH	BX	;save pointer
8EF6	CS:	
8EF7	MOV	DI,[BX]$01	;get pointer into table
8EFA	CALL	ckey2	;check it
8EFD	POP	BX	;restore pointer
8EFE	CALL	errz	;yes:
8F01	B	$35	;53:Reserved word
8F02	INC	BX	;next entry
8F03	INC	BX
8F04	INC	BX
8F05	JMP	dkloop	;'do next one
8F07dkret	RET		;"
8F08dupvar	MOV	BX,fence	;Duplicate ID ?
8F0C	MOV.B	DL,recnum	;expected type
8F10	CALL	srchsym	;search in symbol table
8F13	JB	dkret	;:ret
8F15	CALL	err	;43:Duplicate ID or label
8F18	B	$2B	;"
8F19csqr1	MOV	DI,chptr	;Check [, (.
8F1D	CMP.B	[DI],#$5B	;[ ?
8F20	JZ	chkskip	;yes: skip it
8F22	CMP.B	[DI],#$28	;( ?
8F25	JNZ	chkret	;no: ret
8F27	INC	DI	;next char
8F28	CMP.B	[DI],#$2E	;. ?
8F2B	JMP.b	chkcskip	;'check it
8F2Dcsqr2	MOV	DI,chptr	;Check ], .)
8F31	CMP.B	[DI],#$5D	;] ?
8F34	JZ	chkskip	;yes: skip it
8F36	CMP.B	[DI],#$2E	;. ?
8F39	JNZ	chkret	;no: ret
8F3B	INC	DI	;next char
8F3C	CMP.B	[DI],#$29	;) ?
8F3F	JMP.b	chkcskip	;'check it
8F41ccolon	MOV	AL,#$3A	;: ?
8F43	JMP.b	chkal	;'check it
8F45csemi	MOV	AL,#$3B	;semicolon ?
8F47	JMP.b	chkal	;'check it
8F49ccomma	MOV	AL,#$2C	;, ?
8F4B	JMP.b	chkal	;'check it
8F4Dcdot	MOV	AL,#$2E	;. ?
8F4F	JMP.b	chkal	;'check it
8F51cbrack1	MOV	AL,#$28	;( ?
8F53	JMP.b	chkal	;'check it
8F55cbrack2	MOV	AL,#$29	;) ?
8F57	JMP.b	chkal	;'check it
8F59cequal	MOV	AL,#$3D	;= ?
8F5B	JMP.b	chkal	;'check it
8F5Dcptr	MOV	AL,#$5E	;^ ?
8F5Fchkal	MOV	DI,chptr	;current char = AL ?
8F63	CMP.B	AL,[DI]	;compare
8F65chkcskip	JNZ	chkret	;no: ret
8F67chkskip	INC	DI	;skip it
8F68	JMP.b	skipdi	;'read next word
8F6A	NOP	
8F6Bchkret	RET		;"
8F6Cesqr1	CALL	csqr1	;expect [: check [
8F6F	CALL	errnz	;no:
8F72	B	$08	;8:[ expected
8F73	RET		;"
8F74esqr2	CALL	csqr2	;expect ]: check ]
8F77	CALL	errnz	;no:
8F7A	B	$09	;9:] expected
8F7B	RET		;"
8F7Cecolon	CALL	ccolon	;expect :
8F7F	CALL	errnz	;no:
8F82	B	$02	;2:':' expected
8F83ecolret	RET		;"
8F84esemi	CALL	csemi	;expect semicolon
8F87	JZ	ecolret	;yes: ret
8F89esemierr	CALL	err	;1:Semicolon expected
8F8C	B	$01	;'
8F8Desemi2	CALL	csemi	;expect semicolon
8F90	JZ	ecolret	;yes: ret
8F92	CMP.B	semiflg,#$00	;flag set ?
8F97	JZ	esemierr	;yes: error 1
8F99	CALL	err	;41:Unknown ID or syntax error
8F9C	B	$29	;"
8F9Decomma	CALL	ccomma	;expect ,
8FA0	CALL	errnz	;no:
8FA3	B	$03	;3:',' expected
8FA4	RET		;"
8FA5ebrack1	CALL	cbrack1	;expect (
8FA8	CALL	errnz	;no:
8FAB	B	$04	;4:'(' expected
8FAC	RET		;"
8FADebrack2	CALL	cbrack2	;expect )
8FB0	CALL	errnz	;no:
8FB3	B	$05	;5:')' expected
8FB4	RET		;"
8FB5eequal	CALL	cequal	;expect =
8FB8	CALL	errnz	;no:
8FBB	B	$06	;6:'=' expected
8FBC	RET		;"
8FBDeassign	CALL	ctoken	;expect :=
8FC0	W	tkassign	;check token
8FC2	CALL	errnz	;no:
8FC5	B	$07	;7:':=' expected
8FC6	RET		;"
8FC7expof	CALL	ctoken	;expect OF
8FCA	W	tkof	;check token
8FCC	CALL	errnz	;no:
8FCF	B	$0F	;15:OF expected
8FD0	RET		;"
	;This routine skips spaces until next word is reached.
8FD1skip	MOV	DI,chptr	;get next word: get char ptr
8FD5skipdi	MOV.B	semiflg,#$00	;flag for semicolon error
8FDA	MOV.B	wordflg,#$FF	;search flag
8FDFskloop	MOV	AX,[DI]	;get char (two, actually)
8FE1	CMP	AL,#$20	;space, control ?
8FE3	JBE	skspace	;yes: skip spaces
8FE5	CMP	AL,#$7B	; '{' ?
8FE7	JZ	skcom2	;yes: comment
8FE9	CMP	AX,#$2A28	; '(*' ?
8FEC	JZ	skcom	;yes: comment
8FEE	MOV	chptr,DI	;set char pointer
8FF2	XOR	AX,AX	;ok
8FF4	RET		;'
8FF5skspace	CALL	getchar	;skip spaces: get char
8FF8	JMP	skloop	;'loop back
8FFAskcom	CALL	getchar	;Comment: get char
8FFDskcom2	PUSH	DX	;save
8FFE	MOV.B	DL,[DI]	;comment type
9000	CMP.B	[DI]$01,#$24	;$ ?
9004	JZ	cdirec	;yes: compiler directive
9006skcomlp	CALL	getchar	;get char
9009skcom3	MOV	AX,[DI]	;test two chars
900B	CMP.B	DL,#$2A	; '(*' ?
900E	JNZ	skcomcur	;:no
9010	CMP	AX,#$292A	;now '*)' ?
9013	JNZ	skcomlp	;no: loop back
9015	CALL	getchar	;end of comment - get char
9018	JMP.b	skcomend	;'continue scanning
901Askcomcur	CMP	AL,#$7D	; '}' ?
901C	JNZ	skcomlp	;no: loop back
901Eskcomend	POP	DX	;restore
901F	JMP	skspace	;"continue scanning
9021cdirec	PUSH	BX	;Compiler directive: save regs
9022	PUSH	CX
9023	PUSH	DX
9024	CALL	getchar	;get char
9027cdlop	CALL	getchar	;get char
902A	MOV.B	AL,[DI]	;get directive
902C	CALL	upcase	;UpCase
902F	CMP	AL,#$49	;I ? I/O-error handling, Include
9031	MOV	DX,#$0001	;flag
9034	JZ	cdplus	;:yes +-
9036	CMP	AL,#$52	;R ? Range checking
9038	MOV	DX,#$0002
903B	JZ	cdplus	;:yes +-
903D	CMP	AL,#$42	;B ? I/O-mode (CON or TRM)
903F	MOV	DX,#$0004
9042	JZ	cdplus	;:yes +-
9044	CMP	AL,#$43	;C ? Control C and S
9046	MOV	DX,#$0008
9049	JZ	cdplus	;:yes +-
904B	CMP	AL,#$55	;U ? User Interrupt
904D	MOV	DX,#$0010
9050	JZ	cdplus	;:yes +-
9052	CMP	AL,#$4B	;K ? Stack check
9054	MOV	DX,#$0020
9057	JZ	cdplus	;:yes +-
9059	CMP	AL,#$56	;V ? Type checking
905B	MOV	DX,#$0040
905E	JZ	cdplus	;:yes +-
9060	CMP	AL,#$44	;D ? Device checking
9062	MOV	DX,#$0080
9065	JZ	cdplus	;:yes +-
9067	CMP	AL,#$47	;G ? Input file buffer size
9069	MOV	BX,#cinpsize	;dest var: buffer size
906C	JZ	cdnum	;:yes #
906E	CMP	AL,#$50	;P ? Output file buffer size
9070	MOV	BX,#coutsize	;dest var: buffer size
9073	JZ	cdnum	;:yes #
9075	CMP	AL,#$46	;F ? Max number open files
9077	MOV	BX,#cmaxfil	;dest var: max files
907A	JZ	cdnum	;:yes #
907C	XOR	DX,DX	;no flag
907E	CMP	AL,#$41	;A ? Absolute code
9080	JZ	cdplus	;:yes +-
9082	CMP	AL,#$57	;W ? WITH nesting
9084	JZ	cdignore	;:yes #
9086	CMP	AL,#$58	;X ? Array optimization
9088	JZ	cdplus	;:yes +-
908A	CMP	AL,#$4F	;O ?
908C	JZ	cdignore	;:yes #
908Ecderr	CALL	perr	;remember pos
9091	B	$5D	;'93:Invalid compiler directive
9092cdend	POP	DX	;restore regs
9093	POP	CX
9094	POP	BX
9095	JMP	skcom3	;'continue scanning comment
9098cdplus	CALL	getchar	;+/- directive: get char
909B	MOV.B	AL,[DI]	;read it
909D	XOR	CX,CX	;clear flag
909F	CMP	AL,#$2B	; '+' ?
90A1	JZ	cdset	;:yes
90A3	DEC	CX	;set flag
90A4	CMP	AL,#$2D	; '-' ?
90A6	JZ	cdset	;:yes
90A8	CMP	DX,#$01	;include ?
90AB	JZ	cdinclsk	;yes: do it
90AD	JMP	cderr	;'Invalid compiler directive
90AFcdset	MOV	AX,direct	;old directives
90B2	XOR	AX,CX	;invert if reset bit
90B4	OR	AX,DX	;set / reset bit
90B6	XOR	AX,CX	;invert if reset bit
90B8	MOV	direct,AX	;set new directive
90BB	CALL	getchar	;get char
90BEcdnext	MOV.B	AL,[DI]	; ',' ?
90C0	CMP	AL,#$2C
90C2	JNZ	cdend	;no: end directive
90C4	JMP	cdlop	;'yes: loop back
90C7cdignore	CALL	getchar	;Ignore directive: get char
90CA	MOV.B	AL,[DI]
90CC	CALL	alphanum	;valid char ?
90CF	JNB	cdignore	;yes: continue
90D1	JMP	cdnext	;'another directive ?
90D3cdnum	CALL	getchar	;Get number: get char
90D6	PUSH	BX	;save dest ptr
90D7	MOV	BX,DI	;position
90D9	CALL	asccard	;read integer
90DC	MOV	DI,BX	;new position
90DE	POP	BX	;dest ptr
90DF	JB	cderr	;:error
90E1	OR	AX,AX	;0 ?
90E3	JZ	cderr	;yes: error
90E5	MOV	[BX],AX	;store result
90E7	JMP	cdnext	;'another directive ?
90E9cdinclsk	CMP.B	[DI],#$20	;Set include file: space ?
90EC	JNZ	cdincl	;no: do it
90EE	CALL	getchar	;get char
90F1	JMP	cdinclsk	;'skip spaces
90F3cdincl	CMP.B	inclflg,#$00	;include file active ?
90F8	CALL	errnz	;yes:
90FB	B	$60	;96:Illegal nesting of include files
90FC	MOV	BX,DI	;position
90FE	CALL	kpasext	;parse filename, default .PAS
9101	PUSH	BX	;save pos
9102	MOV	DI,#inclpn	;copy path name
9105	CALL	fnscdi	;-> include filename buffer
9108	POP	DI	;restore pos
9109	MOV	AX,#$3D00	;open file
910C	MOV	DX,#inclpn	;name ptr
910F	PUSH	DS	;DS -> ES
9110	POP	ES
9111	CALL	dos	;open it
9114	CALL	errb	;90:File not found
9117	B	$5A
9118	MOV	incfile,AX	;store file handle
911B	MOV	AX,direct	;save compiler directives
911E	MOV	direcin,AX
9121	XOR	AX,AX	;clear vars:
9123	MOV	bufpt,AX	;buffer ptr
9126	MOV	bufend,AX	;buffer end
9129	MOV	frelpos,AX	;relative pos in file
912C	MOV.B	inclflg,#$FF	;set include flag
9131	CALL	disline	;display line number
9134	JMP	cdend	;"restore regs, continue scanning
9137getchar	MOV.B	AL,[DI]	;Get char
9139	INC	DI	;go to next one
913A	OR.B	AL,AL	;end of line ?
913C	JZ	getln	;:yes
913E	RET		;'
913Fgetln	PUSH	BX	;save regs
9140	PUSH	CX
9141	PUSH	DX
9142	CMP.B	srcend,#$00	;last line ?
9147	CALL	perrnz	;yes:
914A	B	$5B	;91:Unexpected end of source
914B	INC	lincnt	;count lines
914F	MOV	DI,#pnbuf	;destination: line buffer
9152	MOV	CX,#$007F	;up to 127 chars
9155	CMP.B	inclflg,#$00	;from include file ?
915A	JNZ	fileline	;:yes
915C	MOV	BX,srcptr	;pointer into text
9160	MOV	srclnbeg,BX	;-> beginning of source line
9164memline	MOV.B	AL,[BX]	;get char
9166	CMP	AL,#$1A	;^Z ?
9168	JZ	memeof	;yes: mark end of source
916A	INC	BX	;next char
916B	CMP	AL,#$0D	;CR ?
916D	JZ	memlf	;yes: end of line
916F	MOV.B	[DI],AL	;store in buffer
9171	INC	DI	;next pos
9172	LOOP	memline	;:another char
9174	JMP.b	memsto	;'end it
9176memlf	CMP.B	[BX],#$0A	;LF ?
9179	JNZ	memsto	;no: forget it
917B	INC	BX	;yes: skip it
917C	JMP.b	memsto	;'set new pos
917Ememeof	MOV	srcend,AL	;set flag: end of source
9181memsto	MOV	srcptr,BX	;store new pos in buffer
9185	JMP.b	filesto	;'mark end of line
9187fileline	MOV	BX,bufpt	;buffer pointer
918B	MOV	AX,frelpos	;relative pos in file
918E	ADD	AX,BX	;+ buffer offset
9190	SUB	AX,bufend	;- buffer end
9194	MOV	srclnbg,AX	;-> pos of line begin
9197fileloop	CALL	getincl	;get char from include file
919A	CMP	AL,#$1A	;^Z ?
919C	JZ	fileeof	;:yes, close include
919E	INC	BX	;next char
919F	CMP	AL,#$0D	;CR ?
91A1	JZ	filelf	;yes: end of line
91A3	MOV.B	[DI],AL	;store char in buffer
91A5	INC	DI	;next pos
91A6	LOOP	fileloop	;:another char
91A8	JMP.b	filelf2	;'end it
91AAfilelf	CALL	getincl	;get char from include file
91AD	CMP	AL,#$0A	;LF ?
91AF	JNZ	filelf2	;no: forget it
91B1	INC	BX	;skip
91B2filelf2	MOV	bufpt,BX	;store buffer ptr
91B6	JMP.b	filesto	;'mark end of line
91B8fileeof	MOV.B	inclflg,#$00	;clear include flag
91BD	MOV	AX,direcin	;restore directives to
91C0	MOV	direct,AX	;state before include
91C3	MOV	AH,#$3E	;close
91C5	MOV	BX,incfile	;file handle
91C9	CALL	dos
91CCfilesto	MOV.B	[DI],#$00	;store a 0 at the end
91CF	MOV	DI,#pnbuf	;go to beg of buffer
91D2	CALL	disline1	;display line number
91D5	POP	DX	;restore regs
91D6	POP	CX
91D7	POP	BX
91D8	RET		;"
91D9getincl	CMP	BX,bufend	;Get char from include file
91DD	JB	ginend	;:not yet end of buffer
91DF	PUSH	CX	;save
91E0	MOV	AH,#$3F	;read byte block
91E2	MOV	BX,incfile	;file handle
91E6	MOV	CX,#$0080	;128 bytes
91E9	MOV	DX,#inclbuf	;buffer ptr
91EC	MOV	SI,#$0080	;?
91EF	CALL	dos	;read buffer
91F2	POP	CX	;restore
91F3	JNB	ginok	;:ok
91F5	XOR	AX,AX	;nothing read
91F7ginok	MOV	BX,#inclbuf	;start of buffer
91FA	OR	AX,AX	;anything read ?
91FC	JNZ	ginnoeof	;:yes
91FE	MOV.B	[BX],#$1A	;store ^Z
9201	INC	AX	;1 char
9202ginnoeof	ADD	frelpos,AX	;relative pos in file
9206	ADD	AX,BX	;pos of buffer end
9208	MOV	bufend,AX
920Bginend	MOV.B	AL,[BX]	;get char
920D	RET		;"
920Edisline1	TEST.B	lincnt,#$0F	;Display line number
9213	JZ	disline	;:once every 16 lines
9215	RET		;'
9216disline	PUSH	AX	;save regs
9217	PUSH	BX
9218	PUSH	CX
9219	PUSH	DX
921A	MOV	AL,#$0D	;write CR
921C	CALL	conput
921F	CMP.B	inclflg,#$00	;include ?
9224	JZ	dismem	;:no
9226	MOV	AL,#$49	;I
9228	JMP.b	disincl	;'
922Adismem	MOV	AL,#$20	;space
922Cdisincl	CALL	conput	;write it
922F	MOV	AL,#$20	;write space
9231	CALL	conput
9234	MOV	AX,lincnt	;get line number
9237	CALL	knum1	;display it
923A	CALL	xkeypres	;Keypressed
923D	OR.B	AL,AL	;test flag
923F	JZ	disret	;:no
9241	CALL	prints	;write string
9244	B	"   *** Abort compilation",$00
925D	CALL	yorn	;Y or N ?
9260	JZ	disok	;no: continue
9262	CALL	err	;CA:Compilation aborted
9265	B	$CA	;'
9266disok	MOV	CX,#$0020	;clear 32 bytes
9269disera	CALL	prints	;write BS space BS
926C	B	$08," ",$08,$00
9270	LOOP	disera	;:another
9272disret	POP	DX	;restore regs
9273	POP	CX
9274	POP	BX
9275	POP	AX
9276	RET		;"
	;*** Start of Tables ***
	;Standard definitions
9277	W	$000E,$02FC
927B	B	"INTEGER",$07,$00,$03
9285	W	$000B,$0308
9289	B	"CHAR",$04,$00,$03
9290	W	$000B,$0314
9294	B	"REAL",$04,$00,$03
929B	W	$000E,$0320
929F	B	"BOOLEAN",$07,$00,$03
92A9	W	$000B,$0338
92AD	B	"BYTE",$04,$00,$03
92B4	W	$000C,$0001
92B8	B	$0B,"TRUE",$04,$00,$02
92C0	W	$000D,$0000
92C4	B	$0B,"FALSE",$05,$00,$02
92CD	W	$000E,$7FFF
92D1	B	$0A,"MAXINT",$06,$00,$02
92DB	W	$000D,$0000
92DF	B	$0A,"BLACK",$05,$00,$02
92E8	W	$000C,$0001
92EC	B	$0A,"BLUE",$04,$00,$02
92F4	B	$0D,$00,$02,$00
92F8	B	$0A,"GREEN",$05,$00,$02
9301	W	$000C,$0003
9305	B	$0A,"CYAN",$04,$00,$02
930D	W	$000B,$0004
9311	B	$0A,"RED",$03,$00,$02
9318	W	$000F,$0005
931C	B	$0A,"MAGENTA",$07,$00,$02
9327	W	$000D,$0006
932B	B	$0A,"BROWN",$05,$00,$02
9334	W	$0011,$0007
9338	B	$0A,"LIGHTGRAY",$09,$00,$02
9345	W	$0010,$0008
9349	B	$0A,"DARKGRAY",$08,$00,$02
9355	W	$0011,$0009
9359	B	$0A,"LIGHTBLUE",$09,$00,$02
9366	W	$0012,$000A
936A	B	$0A,"LIGHTGREEN",$0A,$00,$02
9378	W	$0011,$000B
937C	B	$0A,"LIGHTCYAN",$09,$00,$02
9389	W	$0010,$000C
938D	B	$0A,"LIGHTRED",$08,$00,$02
9399	W	$0014,$000D
939D	B	$0A,"LIGHTMAGENTA",$0C,$00,$02
93AD	W	$000E,$000E
93B1	B	$0A,"YELLOW",$06,$00,$02
93BB	W	$000D,$000F
93BF	B	$0A,"WHITE",$05,$00,$02
93C8	W	$000D,$0010
93CC	B	$0A,"BLINK",$05,$00,$02
93D5	W	$000C,$0000
93D9	B	$0A,"BW40",$04,$00,$02
93E1	W	$000C,$0002
93E5	B	$0A,"BW80",$04,$00,$02
93ED	W	$000B,$0001
93F1	B	$0A,"C40",$03,$00,$02
93F8	W	$000B,$0003
93FC	B	$0A,"C80",$03,$00,$02
9403	W	$000E
9405	W	$2182,$DAA2,$490F	; 3.1415926536E+00
940B	B	$09,"PI",$02,$00,$02
9411	W	$0011,$FF00
9415	W	conbufln
9417	W	$0338
9419	B	"BUFLEN",$06,$00,$04
9422	W	$0012,$FF00
9426	W	hptop
9428	W	$0344
942A	B	"HEAPPTR",$07,$00,$04
9434	W	$0011,$FF00
9438	W	stdout
943A	W	$032C
943C	B	"OUTPUT",$06,$00,$04
9445	W	$0010,$FF00
9449	W	stdin
944B	W	$032C
944D	B	"INPUT",$05,$00,$04
9455	W	$000E,$FF00
9459	W	filcon
945B	W	$032C
945D	B	"CON",$03,$00,$04
9463	W	$000E,$FF00
9467	W	filcon
9469	W	$032C
946B	B	"TRM",$03,$00,$04
9471	W	$000E,$FF00
9475	W	filkbd
9477	W	$032C
9479	B	"KBD",$03,$00,$04
947F	W	$000E,$FF00
9483	W	fillst
9485	W	$032C
9487	B	"LST",$03,$00,$04
948D	W	$000E,$FF00
9491	W	filaux
9493	W	$032C
9495	B	"AUX",$03,$00,$04
949B	W	$000E,$FF00
949F	W	filusr
94A1	W	$032C
94A3	B	"USR",$03,$00,$04
94A9	W	$0011,$FF00
94AD	W	cbreak
94AF	W	$0320
94B1	B	"CBREAK",$06,$00,$04
94BA	W	$0013,$FF00
94BE	W	vkbdstat
94C0	W	$02FC
94C2	B	"CONSTPTR",$08,$00,$04
94CD	W	$0013,$FF00
94D1	W	vkbdget
94D3	W	$02FC
94D5	B	"CONINPTR",$08,$00,$04
94E0	W	$0014,$FF00
94E4	W	vconput
94E6	W	$02FC
94E8	B	"CONOUTPTR",$09,$00,$04
94F4	W	$0014,$FF00
94F8	W	vprnput
94FA	W	$02FC
94FC	B	"LSTOUTPTR",$09,$00,$04
9508	W	$0014,$FF00
950C	W	vauxput
950E	W	$02FC
9510	B	"AUXOUTPTR",$09,$00,$04
951C	W	$0013,$FF00
9520	W	vauxget
9522	W	$02FC
9524	B	"AUXINPTR",$08,$00,$04
952F	W	$0014,$FF00
9533	W	vusrput
9535	W	$02FC
9537	B	"USROUTPTR",$09,$00,$04
9543	W	$0013,$FF00
9547	W	vusrget
9549	W	$02FC
954B	B	"USRINPTR",$08,$00,$04
9556	W	$0013,$FF00
955A	W	verror
955C	W	$02FC
955E	B	"ERRORPTR",$08,$00,$04	;"
	; Standard types
	; link  type  lower upper size  tag: invisible
9569	B	$0C,$00,$0A,$00,$00,$80,$FF,$7F,$02,$00,$00,$00	;integer
9575	B	$0C,$00,$0C,$00,$00,$00,$FF,$00,$01,$00,$00,$00	;char
9581	B	$0C,$00,$09,$00,$00,$00,$00,$00,$06,$00,$00,$00	;real
958D	B	$0C,$00,$0B,$00,$00,$00,$01,$00,$01,$00,$00,$00	;boolean
9599	B	$0C,$00,$06,$00,$00,$00,$00,$00,$CC,$00,$00,$00	;text file
95A5	B	$0C,$00,$0A,$00,$00,$00,$FF,$00,$01,$00,$00,$00	;byte
95B1	B	$0C,$00,$04,$00,$00,$00,$00,$00,$04,$00,$00,$00	;pointer
95BD	B	$0C,$00,$08,$00,$00,$00,$00,$00,$09,$00,$00,$00	;string
95C9	B	$0C,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00	;untyped file
95D5	B	$0C,$00,$07,$00,$00,$00,$00,$00,$4C,$00,$00,$00	;"typed file
	;Patch table to patch in pointers to type entries
	;Offsets relative to 9277
95E1varpatch	W	$0002,$0010,$001B,$0026,$0034,$01A0,$01B1,$01C3,$01D4
95F3	W	$01E4,$01F2,$0200,$020E,$021C,$022A,$0249,$025C,$026F
9605	W	$0283,$0297,$02AB,$02BE,$02D2,$02E5,$0238
	;"
9613keytable	B	$00	;Pointers into keyword table
9614	W	tkprog	;(offset between entries, pointer)
9616	B	$01
9617	W	tklabel
9619	B	$02
961A	W	tkbegin
961C	B	$04
961D	W	tkto
961F	B	$05
9620	W	tkmul2
9622	B	$05
9623	W	tkadd2
9625	B	$02
9626	W	tkcmp2
9628	B	$FF	;"end of table
9629tkprog	B	$07,"PROGRAM"	;Keyword table
9631tkend	B	$03,"END"
9635tkforwrd	B	$07,"FORWARD"
963Dtkext	B	$08,"EXTERNAL"
9646tkpacked	B	$06,"PACKED"
964Dtkarray	B	$05,"ARRAY"
9653tkfile	B	$04,"FILE"
9658tkset	B	$03,"SET"
965Ctkrec	B	$06,"RECORD"
9663tkstr	B	$06,"STRING"
966Atkof	B	$02,"OF"
966Dtkabs	B	$08,"ABSOLUTE"
9676tkthen	B	$04,"THEN"
967Btkelse	B	$04,"ELSE"
9680tkdo	B	$02,"DO"
9683tkuntil	B	$05,"UNTIL"
9689tknot	B	$03,"NOT"
968Dtknil	B	$03,"NIL",$00	;'
9692tktext	B	$04,"TEXT"	;other reserved words
9697tk2dot	B	$02,".."
969Atkassign	B	$02,":="	;'
969Dtklabel	B	$05,"LABEL",$01	;definition part
96A4	B	$05,"CONST",$02	;byte at the end = token
96AB	B	$04,"TYPE",$03
96B1tkvar	B	$03,"VAR",$04
96B6	B	$05,"BEGIN",$08
96BDtkover	B	$07,"OVERLAY",$07
96C6tkproc	B	$09,"PROCEDURE",$05
96D1	B	$08,"FUNCTION",$06,$00	;'
96DCtkbegin	B	$05,"BEGIN"	;program part
96E2	W	block	;word = vector to compiler routine
96E4	B	$02,"IF"
96E7	W	if
96E9	B	$05,"WHILE"
96EF	W	while
96F1	B	$06,"REPEAT"
96F8	W	repeat
96FA	B	$03,"FOR"
96FE	W	for
9700tkcase	B	$04,"CASE"
9705	W	case
9707	B	$04,"GOTO"
970C	W	goto
970E	B	$04,"WITH"
9713	W	with
9715	B	$06,"INLINE"
971C	W	inline
971E	B	$00	;'
971Ftkto	B	$02,"TO"	;keywords used with FOR
9722	B	$7D,$41,$49,$00	;JGE / INC CX / DEC CX
9726	B	$06,"DOWNTO"
972D	B	$7E,$49,$41,$08	;JNG / DEC CX / INC CX
9731	B	$00	;'
9732tkmem	B	$03,"MEM",$01	;special arrays
9737	B	$04,"MEMW",$02	;(not reserved)
973D	B	$00	;'
	;Code descriptors: parameters for the code generator
	;+0:operation #
	;+1:opcode immediate form
	;+2:standard opcode
	;+4:option bits
	;    1:XCHG CX,AX needed
	;    2:no immediate form available
	;    4:no var form available
	;    8:CWD needed
	;"   10:XCHG DX,AX needed at end
973Etkmul	B	$01,"*"	;Multiplication ops
9740	B	$00,$00,$F7,$E9,$02	;no imme, IMUL CX
9745	B	$01,"/"
9747	B	$01,$00,$00,$00,$00	;real only !
974Ctkmul2	B	$03,"AND"	;AND AX,CX
9750	B	$02,$25,$23,$C1,$00
9755	B	$03,"MOD"	;IDIV CX
9759	B	$03,$00,$F7,$F9,$1B	;no imme, both XCHG, CWD
975E	B	$03,"DIV"	;IDIV CX
9762	B	$04,$00,$F7,$F9,$0B	;no imme, XCHG CX,AX, CWD
9767	B	$03,"SHL"	;SHL AX,CL
976B	B	$05,$00,$D3,$E0,$07	;no imme, no var, XCHG CX,AX
9770	B	$03,"SHR"	;SHR AX,CL
9774	B	$06,$00,$D3,$E8,$07	;no imme, no var, XCHG CX,AX
9779	B	$00	;'
977Atkadd	B	$01,"+"	;Addition ops
977C	B	$00,$05,$03,$C1,$00	;ADD AX,CX
9781	B	$01,"-"	;SUB AX,CX
9783	B	$01,$2D,$2B,$C1,$01	;XCHG CX,AX
9788tkadd2	B	$02,"OR"	;OR AX,CX
978B	B	$02,$0D,$0B,$C1,$00
9790	B	$03,"XOR"	;XOR AX,CX
9794	B	$03,$35,$33,$C1,$00
9799	B	$00	;'
979Atkcmp	B	$01,"="	;Comparison ops
979C	B	$00,$74	;table offset, branch op: JZ
979E	B	$02,"<>"
97A1	B	$08,$75	;JNZ
97A3	B	$02,">="
97A6	B	$10,$7D	;JGE
97A8	B	$02,"<="
97AB	B	$18,$7E	;JNG
97AD	B	$01,">"
97AF	B	$20,$7F	;JG
97B1	B	$01,"<"
97B3	B	$28,$7C	;JL
97B5tkcmp2	B	$02,"IN"
97B8	B	$FF,$00	;special
97BA	B	$00	;'
97BBcmpcode	B	$00,$3D,$3B,$C1,$01	;"CMP AX,CX; XCHG CX,AX
97C0stdprocs	B	$07,"WRITELN"	;Standard procedures
97C8	W	pwriteln	;vector to COMPILER routine
97CA	B	$05,"WRITE"
97D0	W	pwrite
97D2	B	$06,"READLN"
97D9	W	preadln
97DB	B	$04,"READ"
97E0	W	pread
97E2	B	$06,"DELETE"
97E9	W	pdelete
97EB	B	$06,"INSERT"
97F2	W	pinsert
97F4	B	$06,"GOTOXY"
97FB	W	pgotoxy
97FD	B	$06,"ASSIGN"
9804	W	passign
9806	B	$05,"RESET"
980C	W	preset
980E	B	$07,"REWRITE"
9816	W	prewrite
9818	B	$06,"APPEND"
981F	W	pappend
9821	B	$05,"CLOSE"
9827	W	pclose
9829	B	$05,"ERASE"
982F	W	perase
9831	B	$06,"RENAME"
9838	W	prename
983A	B	$04,"SEEK"
983F	W	pseek
9841	B	$08,"LONGSEEK"
984A	W	pseek
984C	B	$03,"NEW"
9850	W	pnew
9852	B	$04,"MARK"
9857	W	pmark
9859	B	$07,"RELEASE"
9861	W	prelease
9863	B	$06,"GETMEM"
986A	W	pgetmem
986C	B	$07,"DISPOSE"
9874	W	pdispose
9876	B	$07,"FREEMEM"
987E	W	pfreemem
9880	B	$03,"STR"
9884	W	pstr
9886	B	$03,"VAL"
988A	W	pval
988C	B	$09,"BLOCKREAD"
9896	W	pblockrd
9898	B	$0A,"BLOCKWRITE"
98A3	W	pblockwr
98A5	B	$05,"CHDIR"
98AB	W	pchdir
98AD	B	$05,"MKDIR"
98B3	W	pmkdir
98B5	B	$05,"RMDIR"
98BB	W	prmdir
98BD	B	$06,"GETDIR"
98C4	W	pgetdir
98C6	B	$07,"OVRPATH"
98CE	W	povrpath
98D0	B	$09,"RANDOMIZE"
98DA	W	prndmize
98DC	B	$04,"MOVE"
98E1	W	pmove
98E3	B	$08,"FILLCHAR"
98EC	W	pfillchr
98EE	B	$04,"EXIT"
98F3	W	pexit
98F5	B	$04,"HALT"
98FA	W	phalt
98FC	B	$05,"PORTW"
9902	W	pportw
9904	B	$04,"PORT"
9909	W	pport
990B	B	$05,"FLUSH"
9911	W	pflush
9913	B	$08,"TRUNCATE"
991C	W	ptruncat
991E	B	$07,"EXECUTE"
9926	W	pexecute
9928	B	$05,"CHAIN"
992E	W	pchain
9930	B	$04,"INTR"
9935	W	pintr
9937	B	$05,"MSDOS"
993D	W	pmsdos
993F	B	$07,"CRTINIT"
9947	W	pcrtinit
9949	B	$07,"CRTEXIT"
9951	W	pcrtexit
9953	B	$06,"CLRSCR"
995A	W	pclrscr
995C	B	$06,"CLREOL"
9963	W	pclreol
9965	B	$09,"HIGHVIDEO"
996F	W	pnrmvid
9971	B	$09,"NORMVIDEO"
997B	W	pnrmvid
997D	B	$08,"LOWVIDEO"
9986	W	plowvid
9988	B	$07,"INSLINE"
9990	W	pinsline
9992	B	$07,"DELLINE"
999A	W	pdelline
999C	B	$05,"DELAY"
99A2	W	pdelay
99A4	B	$06,"WINDOW"
99AB	W	pwindow
99AD	B	$09,"TEXTCOLOR"
99B7	W	ptextcol
99B9	B	$0E,"TEXTBACKGROUND"
99C8	W	ptextbg
99CA	B	$0E,"GRAPHCOLORMODE"
99D9	W	pgrcolmd
99DB	B	$09,"GRAPHMODE"
99E5	W	pgrmode
99E7	B	$05,"HIRES"
99ED	W	phires
99EF	B	$08,"TEXTMODE"
99F8	W	ptxtmode
99FA	B	$0F,"GRAPHBACKGROUND"
9A0A	W	pgraphbg
9A0C	B	$07,"PALETTE"
9A14	W	ppalette
9A16	B	$0A,"HIRESCOLOR"
9A21	W	phirscol
9A23	B	$0B,"GRAPHWINDOW"
9A2F	W	pgrwind
9A31	B	$04,"PLOT"
9A36	W	pplot
9A38	B	$04,"DRAW"
9A3D	W	pdraw
9A3F	B	$05,"SOUND"
9A45	W	psound
9A47	B	$07,"NOSOUND"
9A4F	W	pnosound
9A51	B	$00	;"
9A52stdfuncs	B	$03,"CHR"	;Standard functions
9A56	W	fchr	;vector to COMPILER routine
9A58	B	$03,"ORD"
9A5C	W	ford
9A5E	B	$04,"COPY"
9A63	W	fcopy
9A65	B	$06,"LENGTH"
9A6C	W	flength
9A6E	B	$03,"POS"
9A72	W	fpos
9A74	B	$06,"CONCAT"
9A7B	W	fconcat
9A7D	B	$04,"SUCC"
9A82	W	fsucc
9A84	B	$04,"PRED"
9A89	W	fpred
9A8B	B	$06,"UPCASE"
9A92	W	fupcase
9A94	B	$05,"TRUNC"
9A9A	W	ftrunc
9A9C	B	$05,"ROUND"
9AA2	W	fround
9AA4	B	$03,"ODD"
9AA8	W	fodd
9AAA	B	$03,"ABS"
9AAE	W	fabs
9AB0	B	$03,"SQR"
9AB4	W	fsqr
9AB6	B	$04,"SQRT"
9ABB	W	fsqrt
9ABD	B	$03,"SIN"
9AC1	W	fsin
9AC3	B	$03,"COS"
9AC7	W	fcos
9AC9	B	$06,"ARCTAN"
9AD0	W	farctan
9AD2	B	$02,"LN"
9AD5	W	fln
9AD7	B	$03,"EXP"
9ADB	W	fexp
9ADD	B	$06,"RANDOM"
9AE4	W	frandom
9AE6	B	$03,"INT"
9AEA	W	fint
9AEC	B	$04,"FRAC"
9AF1	W	ffrac
9AF3	B	$0A,"PARAMCOUNT"
9AFE	W	fparmcnt
9B00	B	$08,"PARAMSTR"
9B09	W	fparmstr
9B0B	B	$02,"LO"
9B0E	W	flo
9B10	B	$02,"HI"
9B13	W	fhi
9B15	B	$04,"SWAP"
9B1A	W	fswap
9B1C	B	$08,"IORESULT"
9B25	W	fiores
9B27	B	$03,"EOF"
9B2B	W	feof
9B2D	B	$04,"EOLN"
9B32	W	feoln
9B34	B	$07,"SEEKEOF"
9B3C	W	fseekeof
9B3E	B	$08,"SEEKEOLN"
9B47	W	fseekeol
9B49	B	$08,"FILESIZE"
9B52	W	ffilsize
9B54	B	$0C,"LONGFILESIZE"
9B61	W	flfilsiz
9B63	B	$07,"FILEPOS"
9B6B	W	ffilpos
9B6D	B	$0B,"LONGFILEPOS"
9B79	W	flfilpos
9B7B	B	$0A,"KEYPRESSED"
9B86	W	fkeypres
9B88	B	$08,"MAXAVAIL"
9B91	W	fmaxavl
9B93	B	$08,"MEMAVAIL"
9B9C	W	fmemavl
9B9E	B	$05,"PORTW"
9BA4	W	fportw
9BA6	B	$04,"PORT"
9BAB	W	fport
9BAD	B	$04,"ADDR"
9BB2	W	faddr
9BB4	B	$03,"PTR"
9BB8	W	fptr
9BBA	B	$03,"OFS"
9BBE	W	fofs
9BC0	B	$03,"SEG"
9BC4	W	fseg
9BC6	B	$06,"SIZEOF"
9BCD	W	fsizeof
9BCFtkdseg	B	$04,"DSEG"
9BD4	W	fdseg
9BD6tkcseg	B	$04,"CSEG"
9BDB	W	fcseg
9BDD	B	$04,"SSEG"
9BE2	W	fsseg
9BE4	B	$06,"WHEREX"
9BEB	W	fwherex
9BED	B	$06,"WHEREY"
9BF4	W	fwherey	;"
	;*** End of Turbo 3.0 ***
9BF6	B	$00
