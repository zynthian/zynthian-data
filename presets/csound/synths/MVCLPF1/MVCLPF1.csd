<CsoundSynthesizer>
<CsOptions>

;-odac -+rtaudio=jack -Ma -dm0
</CsOptions>
<CsInstruments>

;sr=44100
ksmps=256
nchnls=2
0dbfs=1

;panel
FLcolor	182, 182, 182, 255, 0, 0
FLpanel  "MVCLPF1",1200,800,300,100,4,-1,1
;FLvkeybd	"keyboard.map",960,90,20,460
gkonoff,ihb2	FLbutton "On/Off",0,1,2,100,30,20,20,0,1,0,0
gk3,ihb4		FLbutton "Exit",1,0,21,100,30,20,70,0,2,0,0

;displays for Flsliders-DetuneKnobs
ihval1	FLvalue	"",65,30,145,110
ihval2	FLvalue "",65,30,215,110
ihval3	FLvalue "",65,30,125,665
ihval3b	FLvalue "",65,30,125,740
ihval4a	FLvalue "",65,30,30,290
ihval4b	FLvalue "",65,30,95,290
ihval4c	FLvalue "",65,30,160,290
ihval4d	FLvalue "",65,30,225,290
ihval4e	FLvalue "",65,30,290,290
ihval4f	FLvalue "",65,30,355,290
ihval4g	FLvalue "",65,30,420,290
ihval4h	FLvalue "",65,30,485,290
ihval4i	FLvalue "",65,30,550,290
ihval5a	FLvalue "",65,30,30,440
ihval5b	FLvalue "",65,30,95,440
ihval5c	FLvalue "",65,30,160,440
ihval5d	FLvalue "",65,30,225,440
ihval5e	FLvalue "",65,30,290,440
ihval5f	FLvalue "",65,30,355,440
ihval5g	FLvalue "",65,30,420,440
ihval5h	FLvalue "",65,30,485,440
ihval5i	FLvalue "",65,30,550,440
ihval6a	FLvalue "",65,30,30,590
ihval6b	FLvalue "",65,30,95,590
ihval6c	FLvalue "",65,30,160,590
ihval6d	FLvalue "",65,30,225,590
ihval6e	FLvalue "",65,30,290,590
ihval6f	FLvalue "",65,30,355,590
ihval6g	FLvalue "",65,30,420,590
ihval6h	FLvalue "",65,30,485,590
ihval6i	FLvalue "",65,30,550,590

ihval12	FLvalue "",65,30,870,65
ihval13	FLvalue "",65,30,700,65
ihval14	FLvalue "",65,30,285,110
ihval15	FLvalue "",65,30,700,155
ihval16	FLvalue "",65,30,700,245
ihval17	FLvalue "",65,30,700,335
ihval18	FLvalue "",65,30,700,425
ihval19	FLvalue "",65,30,870,155
ihval20	FLvalue "",65,30,870,245
ihval21	FLvalue "",65,30,870,335
ihval22	FLvalue "",65,30,870,425
ihval23	FLvalue "",65,30,355,110
ihval23a	FLvalue "",65,30,420,110
ihval23b	FLvalue "",65,30,485,110
;ihval24	FLvalue "",65,30,285,110
ihval25	FLvalue "",65,30,1010,155
ihval26	FLvalue "",65,30,1010,335

ihval31	FLvalue "",65,30,1010,65


;kout,ihandle		Flslider  "",imin,imax,  iexp, itype,  idisp, iwidth, iheight,  ix, iy

gkfreq,gih1 		FLknob	"Cutoff", 10, (sr)/2, 0, 1, ihval1, 50, 150, 20
gkreso,gih2 		FLknob	"Resonance", 0.001, 1, 0, 1, ihval2, 50, 220, 20
gklfo,gih3 		FLknob	"Pitch-LFO-Depth", 0.0001, 80, -1, 1, ihval3, 50, 50, 650
gkrate,gih3b 		FLknob	"Pitch-LFO-Rate", 0, 20, 0, 1, ihval3b, 50, 50, 725
gkBendRange,ihBendRange	FLcount "Bend Range", -48, 48, 1, 1, 2, 100, 25, 20, 140, -1
gkdet1,gihdet1		FLknob "Detune 1", 0, 4.0, 0, 1, ihval12, 50, 800, 50
gkdet2,gihdet2		FLknob "Detune 2", 0, 4.0, 0, 1, ihval19, 50, 800, 140
gkdet3,gihdet3		FLknob "Detune 3", 0, 4.0, 0, 1, ihval20, 50, 800, 230
gkdet4,gihdet4		FLknob "Detune 4", 0, 4.0, 0, 1, ihval21, 50, 800, 320
gkdet5,gihdet5		FLknob "Detune 5", 0, 4.0, 0, 1, ihval22, 50, 800, 410
gkdet6,gihdet6		FLknob "Noise", 0.001, 1.0, -1, 1, ihval23, 50, 360, 20
gksens6,gihsens6	FLknob "Amp Sens", 0.1, 0.99, 0, 1, ihval23a, 50, 420, 20
gksens7,gihsens7	FLknob "Filt Sens", 0.1, 0.99, 0, 1, ihval23b, 50, 490, 20
gkdet8,gihdet8		FLknob "Skew", 0.001, 0.999, 0, 1, ihval25, 50, 950, 140
gkdet8b,gihdet8b	FLknob "Skew", 0.001, 0.999, 0, 1, ihval31, 50, 950, 50
gkdet9,gihdet9		FLknob "PWM", 0, 1, 0, 1, ihval26, 50, 950, 320

;adsr volume
gkaea,gih4a	FLknob		"Amplitude Init-Level", 0, 1, 0, 1, ihval4a, 50, 40, 200
gkaeb,gih4b	FLslider	"T1", 0.001, 8, -1, 6, ihval4b, 20, 70, 120, 200
gkaec,gih4c	FLknob		"L1", 0, 1, 0, 1, ihval4c, 50, 170, 210
gkaed,gih4d	FLslider	"T2", 0.001, 8, -1, 6, ihval4d, 20, 70, 250, 200
gkaee,gih4e	FLknob		"L2", 0, 1, 0, 1, ihval4e, 50, 300, 210
gkaef,gih4f	FLslider	"T3", 0.001, 8, -1, 6, ihval4f, 20, 70, 380, 200
gkaeg,gih4g	FLknob		"L3", 0, 1, 0, 1, ihval4g, 50, 430, 210
gkaeh,gih4h	FLslider	"T4", 0.001, 8, -1, 6, ihval4h, 20, 70, 510, 200
gkaei,gih4i	FLknob		"L4", 0, 1, 0, 1, ihval4i, 50, 560, 210

;adsr filter
gkfea,gih5a	FLknob		"Filter Init-Level", -1, 1, 0, 1, ihval5a, 50, 40, 350
gkfeb,gih5b	FLslider	"T1", 0.001, 8, -1, 6, ihval5b, 20, 70, 120, 350
gkfec,gih5c	FLknob		"L1", -1, 1, 0, 1, ihval5c, 50, 170, 360
gkfed,gih5d	FLslider	"T2", 0.001, 8, -1, 6, ihval5d, 20, 70, 250, 350
gkfee,gih5e	FLknob		"L2", -1, 1, 0, 1, ihval5e, 50, 300, 360
gkfef,gih5f	FLslider	"T3", 0.001, 8, -1, 6, ihval5f, 20, 70, 380, 350
gkfeg,gih5g	FLknob		"L3", -1, 1, 0, 1, ihval5g, 50, 430, 360
gkfeh,gih5h	FLslider	"T4", 0.001, 8, -1, 6, ihval5h, 20, 70, 510, 350
gkfei,gih5i	FLknob		"L4", -1, 1, 0, 1, ihval5i, 50, 560, 360

;adsr pitch
gkpea,gih6a	FLknob		"Pitch Init-Level", 1, 2, 0, 1, ihval6a, 50, 40, 500
gkpeb,gih6b	FLslider	"T1", 0.001, 8, -1, 6, ihval6b, 20, 70, 120, 500
gkpec,gih6c	FLknob		"L1", 1, 2, 0, 1, ihval6c, 50, 170, 510
gkped,gih6d	FLslider	"T2", 0.001, 8, -1, 6, ihval6d, 20, 70, 250, 500
gkpee,gih6e	FLknob		"L2", 1, 2, 0, 1, ihval6e, 50, 300, 510
gkpef,gih6f	FLslider	"T3", 0.001, 8, -1, 6, ihval6f, 20, 70, 380, 500
gkpeg,gih6g	FLknob		"L3", 1, 2, 0, 1, ihval6g, 50, 430, 510
gkpeh,gih6h	FLslider	"T4", 0.001, 8, -1, 6, ihval6h, 20, 70, 510, 500
gkpei,gih6i	FLknob		"L4", 1, 2, 0, 1, ihval6i, 50, 560, 510

gkamp1,gih13	FLslider	"Osc-1 Tri-Saw", 0.001, 0.5, 0, 5, ihval13, 70, 20, 700, 20
gkcont,gih14	FLknob		"Contour", 0.001, 0.999, 0, 1, ihval14, 50, 290, 20
gkamp2,gih15	FLslider	"Osc-2 Tri-Saw", 0.001, 0.5, 0, 5, ihval15, 70, 20, 700, 110
gkamp3,gih16	FLslider	"Osc-3 IntSaw", 0.001, 0.5, 0, 5, ihval16, 70, 20, 700, 200
gkamp4,gih17	FLslider	"Osc-4 Square", 0.001, 0.5, 0, 5, ihval17, 70, 20, 700, 290
gkamp5,gih18	FLslider	"Osc-5 Sine", 0.001, 0.5, 0, 5, ihval18, 70, 20, 700, 380


FLpanel_end
FLrun

;initial values
FLsetVal_i	20442,gih1	;init Filter Cutoff value
FLsetVal_i	0.15,gih2	;init Resonance
FLsetVal_i	0.219,gih3	;init LFO depth
FLsetVal_i	4.2647,gih3b	;init LFO rate
FLsetVal_i	0.996,gihdet1	;init Detune 1
FLsetVal_i	0.996,gihdet2	;init Detune 2
FLsetVal_i	1.001,gihdet3	;init Detune 3
FLsetVal_i	0.998,gihdet4	;init Detune 4
FLsetVal_i	1.003,gihdet5	;init Detune 5
FLsetVal_i	0.001,gihdet6	;init Noise
FLsetVal_i	0.7,gihsens6	;init Amp-Sense
FLsetVal_i	0.6,gihsens7	;init Filt-Sense
FLsetVal_i	0.077,gih4a	;init value amp 
FLsetVal_i	0.022,gih4b	;init value amp T1
FLsetVal_i	0.998,gih4c	;init value amp L1
FLsetVal_i	0.9,gih4d	;init value amp T2
FLsetVal_i	0.99,gih4e	;init value amp L2
FLsetVal_i	2.537,gih4f	;init value amp T3
FLsetVal_i	0.919,gih4g	;init value amp L3
FLsetVal_i	0.005,gih4h	;init value amp T4
FLsetVal_i	0,gih4i		;init value amp L4
FLsetVal_i	0.08,gih5a	;init value filter 
FLsetVal_i	0.02,gih5b	;init value filter T1
FLsetVal_i	0.99,gih5c	;init value filter L1
FLsetVal_i	1.04,gih5d	;init value filter T2
FLsetVal_i	0.02,gih5e	;init value filter L2
FLsetVal_i	3.31,gih5f	;init value filter T3
FLsetVal_i	0,gih5g		;init value filter L3
FLsetVal_i	0.2,gih5h	;init value filter T4
FLsetVal_i	0,gih5i		;init value filter L4
FLsetVal_i	1.592,gih6a	;init value pitch 
FLsetVal_i	0.042,gih6b	;init value pitch T1
FLsetVal_i	2,gih6c		;init value pitch L1
FLsetVal_i	0.001,gih6d	;init value pitch T2
FLsetVal_i	2,gih6e		;init value pitch L2
FLsetVal_i	0.422,gih6f	;init value pitch T3
FLsetVal_i	2,gih6g		;init value pitch L3
FLsetVal_i	0.001,gih6h	;init value pitch T4
FLsetVal_i	2,gih6i		;init value pitch L4

FLsetVal_i	7,ihBendRange	;init Pitch Bend value
FLsetVal_i	0.46,gih13	;init value Volume Osc1
FLsetVal_i	0.5,gih14	;init value Contour
FLsetVal_i	0.001,gih15	;init value Volume Osc2
FLsetVal_i	0.47,gih16	;init value Volume Osc3
FLsetVal_i	0.001,gih17	;init value Volume Osc4
FLsetVal_i	0.001,gih18	;init value Volume Osc5
FLsetVal_i	0.109,gihdet8	;init value Tri-Saw Skew
FLsetVal_i	0.001,gihdet8b	;init value Tri-Saw Skew
FLsetVal_i	0.1,gihdet9	;init value Sq-PWM

instr 1

;if gkonoff	=	1	then
;turnoff
;endif


iamp	ampmidi	i(gksens6)
ifilt	ampmidi i(gksens7)
ifreq	cpsmidi

kamp = iamp
kmax = 10
kmin = 0
imin = 0
imax = 1
ichan = 1
ictlno = 1

;kdest	ctrl7	ichan, ictlno, kmin, kmax

;k1	ctrl7	1,1,10,(sr)/2
;ktrig	changed	k1
;FLsetVal	ktrig,k1,gih1


kbend	pchbend	imin,imax
kbend = kbend*gkBendRange
kbend = semitone(kbend)

klfo	lfo	gklfo,gkrate,1
klfo    +=  gklfo


kadsrpitch	linsegr	i(gkpea),i(gkpeb),i(gkpec),i(gkped),i(gkpee),i(gkpef),i(gkpeg),i(gkpeh),i(gkpei)
avco1	vco2	gkamp1,(ifreq*kbend*gkdet1)*kadsrpitch+(klfo*(ifreq/127)),4,gkdet8b ;tri-saw
avco2	vco2	gkamp2,(ifreq*kbend*gkdet2)*kadsrpitch+(klfo*(ifreq/127)),4,gkdet8 ;tri-saw
avco3	vco2	gkamp3,(ifreq*kbend*gkdet3)*kadsrpitch+(klfo*(ifreq/127)),8 ;int saw
avco4	vco2	gkamp4,(ifreq*kbend*gkdet4)*kadsrpitch+(klfo*(ifreq/127)),2,gkdet9 ;Sq-PWM
a0	poscil	gkamp5,(ifreq*kbend*gkdet5)*kadsrpitch+(klfo*(ifreq/127)),-1 ;sine
a1	rand	gkdet6
asum	sum	avco1,avco2,avco3,avco4,a0,a1
kadsrfilt	linsegr	i(gkfea),i(gkfeb),i(gkfec),i(gkfed),i(gkfee),i(gkfef),i(gkfeg),i(gkfeh),i(gkfei)
afilt	mvclpf1	asum,(gkfreq*(gkcont+kadsrfilt))*ifilt,gkreso,0
kadsr		linsegr	i(gkaea),i(gkaeb),i(gkaec),i(gkaed),i(gkaee),i(gkaef),i(gkaeg),i(gkaeh),i(gkaei)
outs	afilt*(kadsr*iamp),afilt*(kadsr*iamp)

endin

instr 2
exitnow
endin


</CsInstruments>
<CsScore>

f1	0	16384	10	1	

f0	[3600*24]

</CsScore>
</CsoundSynthesizer>
