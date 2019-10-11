; MonoPolySynthII.csd
; Written by Iain McCurdy 2006. 
; Updated 2011. 
; Updated 2015 after suggestions by Brian Collins.
; rev. 23rd November 2015

; --Hard wired MIDI mappings--
; 1		--	modulation wheel
; 2		--	modulation frequency
; 3		--	filter cutoff
; 4		--	resonance
; 5		--	pulse width
; 6		--	delay time
; 7		--	amplitude

; --Modulation and General Control--
; Gliss.Time	--	portamento time (monophonic and polyphonic II modes)
; Amp		--	output amplitude (pre-distortion)
; Trem.Amt.	--	tremolo amount (amplitude modulation)
; Vib.Amt.	--	vibrato amount (pitch modulation)
; Mod.Frq.	--	modulation frequency
; Type (button bank)	--	sine, triangle, random spline, square, S&H (sample and hold) I, S&H II
;				   S&H I  (steady) is a normal sample and hold fucntion with a steady rate of new random value generation defined by the 'Rate' control.
;				   S&H II (aleatoric) 	the rate of new random value generation is itself random within the range Rate/4 and Rate*4
; Bend.Range	--	pitch bend range in semitones
; polyphony mode:	monophonic	--	only one note at a time permitted. Glissando between notes controlled by 'Gliss.Tim.'. Envelopes can be re-triggered by activating 'Mono Retrig.'
;			polyphonic I	--	normal polyphonic mode (no glissandos)
;			polyphonic II	--	polyphonic but with glissando from previous note. Gliss time controlled by 'Gliss Time'
;						two gliss mode are available: 	1 (button off) - fixed gliss time
;										2 (button on) - consistant rate of gliss. i.e. wider glissandi will take longer to complete 

; --Polyphony Control--
; Poly.Limit		-- polyphony limit, if more notes than this value are sounding the oldest one will be removed (0 = no polyphony limiting)
; Preserve Held Notes	-- if this is active, held notes are exempt from polyphony limiting

; Mono retrig	--	if active, envelopes are restarted with each new note (monophonic mode)

; Waveform type	--	saw, pulse-square-pulse, tri-saw-ramp, buzz
; --VCO Parameters--
; P.W.		--	pulse width

; --Buzz Parameters--
; Mul		--	Power multiplier (spectral peak)
; Number of Harms.	--	number of harmonics present above 'Lowest Harm.'
; Lowest Harm.	--	Lowest harmonic partial (1=fundamental)

; --Cluster Oscillator (Cl) parameters--
; Spread	--	detuning spread of the cluster of oscillators
; Speed		--	speed of detuning modulation of the oscillators within the cluster
; Number	--	number of oscillators within the cluster

; --Mixer--
; Osc.1		--	amplitude of oscillator 1
; Osc.2 	--	amplitude of oscillator 2
; Sub.Osc.	--	amplitude of a sine oscillator 1 octave below the fundemental 

; --Pitch Envelope--
; (values are ratios) (sustain level is '1')
; Str.Lev	--	starting level
; Att.Tim.	--
; Att.Lev.	--	attack level
; Dec.Tim.	--	decay time
; Rel.Tim.	--	release time
; Rel.Lev.	--	release level (final value)

; --Pitch Wobble-- (random spline modulation of pitch)
; Amount	--	amount of modulation in semitones
; Rate		--	average rate of modulation in hertz

; --Velocity--
; Curve		--	choose from one of four response curves
;			1) Linear 
;			2) Concave
;			3) Convex
;			4) 'S' shaped Spline
; Amp.Vel.	--	Amount of influence key velocity has upon amplitude
; Filt.Vel.	--	Amount of influence key velocity has upon filter cutoff

; --Filter Envelope--
; Att.Tim.	--	attack time
; Att.Lev.	--	attack level
; Dec.Tim.	--	decay time
; Sus.Lev.	--	sustain level
; Rel.Tim.	--	release time
; Rel.Lev	--	release level (final value)
; Env.Amt.	--	amount of influence of this envelope

; --Filter LFO--
; Type (button bank)	--	sine, triangle, random spline, square, S&H (sample and hold) I, S&H II
;				   S&H I  (steady) is a normal sample and hold fucntion with a steady rate of new random value generation defined by the 'Rate' control.
;				   S&H II (aleatoric) 	the rate of new random value generation is itself random within the range Rate/4 and Rate*4 
; Amount	--	oct format range: 0 to -2/+2
; Rate		--	rate of modulation. range: 0.001 to 20

; --Filter-- (filter setup)
; Base.Frq.	--	base frequency (in 'oct' format). Filter envelope can raise actual cutoff frequency above the value.
; Filter Type (button bank)	--	lowpass (moogladder), highpass (svfilter), bandpass (reson), lowpass dist(ort) (lpf18), Chebyshev I
; Res.		--	resonance (this value is translated differently depending on filter choice but this mechanism is transparent ot the user)

; --Amplitude Envelope--
; Att.Tim.	--	attack time
; Att.Lev.	--	attack level
; Dec.Tim.	--	decay time
; Sus.Lev.	--	sustain level
; Rel.Tim.	--	release time

; --Distortion-- applied to the mixed output of all concurrent notes
; Amount	--	amount of distortion. The effect is bypassed when this is zero.
; Tone		--	lowpass filter cutoff

; --Chorus--
; Level		--	amount of chorus effect
; Depth		--	depth of chorus modulation
; Rate		--	rate of chorus modulation

; --Delay-- (a ping pong delay)
; Level		--	level of the delay effect
; Time		--	delay time
; Feedback	--	delay feedback

; --Reverb--
; Level		--	level of the reverb effect
; Time		--	reverb size

; --Stereo--
; Mix		--	level of the stereo effect
; Width		--	right channel delay time offset (range 0.5 - 1.5). Centre is default/minimal stereo position.

<CsoundSynthesizer>

<CsOptions>
;-odac -M8 -dm0 -B1024 -b256
;-odac -+rtaudio=jack -+rtmidi=alsa -Ma -dm0
;-odac4 -M0 -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100
ksmps 		= 	256
nchnls 		= 	2
0dbfs		=	4	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH                                

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255,255,255,0,0,0
		FLpanel	"Mono-Poly Synth II", 1120, 820, 0, 0,    0,         1
;		FLscroll	              1120, 820, 0, 0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"", 	6,       9,    15,    430,    100,  685,  10		; PRESETS
ih		 	FLbox  	"", 	6,       9,    15,    380,    110,    5, 220		; PITCH ENVELOPE
ih		 	FLbox  	"", 	6,       9,    15,    140,    110,  390, 220		; PITCH WOBBLE
ih		 	FLbox  	"", 	6,       9,    15,    220,    110,  535, 220		; VELOCITY
ih		 	FLbox  	"", 	6,       9,    15,    440,    110,    5, 340		; FILTER ENVELOPE
ih		 	FLbox  	"", 	6,       9,    15,    260,    110,  450, 340		; FILTER LFO
ih		 	FLbox  	"", 	6,       9,    15,    325,    110,    5, 460		; FILTER SET-UP
ih		 	FLbox  	"", 	6,       9,    15,    325,    110,    5, 580		; AMPLITUDE ENVELOPE
ih		 	FLbox  	"", 	6,       9,    15,    135,    110,    5, 700		; DISTORTION
ih		 	FLbox  	"", 	6,       9,    15,    180,    110,  145, 700		; CHORUS
ih		 	FLbox  	"", 	6,       9,    15,    200,    110,  330, 700		; DELAY
ih		 	FLbox  	"", 	6,       9,    15,    135,    110,  535, 700		; REVERB
ih		 	FLbox  	"", 	6,       9,    15,    135,    110,  675, 700		; STEREO

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Presets",		1,      12,    13,     60,     25,  687,   15
ih		 	FLbox  	"Pitch Envelope",	1,      12,    13,    130,     25,   10,  222
ih		 	FLbox  	"Pitch Wobble",		1,      12,    13,    110,     25,  395,  222
ih		 	FLbox  	"Velocity",		1,      12,    13,     60,     25,  545,  222
ih		 	FLbox  	"Filter Envelope",	1,      12,    13,    130,     25,   10,  342
ih		 	FLbox  	"Filter LFO",		1,      12,    13,    100,     25,  455,  342
ih		 	FLbox  	"Filter",		1,      12,    13,     70,     25,   10,  462
ih		 	FLbox  	"Amplitude Envelope",	1,      12,    13,    150,     25,   15,  582
ih		 	FLbox  	"Distortion",		1,      12,    13,     70,     25,   10,  702
ih		 	FLbox  	"Chorus",		1,      12,    13,     50,     25,  150,  702
ih		 	FLbox  	"Delay",		1,      12,    13,     60,     25,  335,  702
ih		 	FLbox  	"Reverb",		1,      12,    13,     60,     25,  540,  702
ih		 	FLbox  	"Stereo",		1,      12,    13,     60,     25,  677,  702

;FLCOUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkPreset, gihPreset 	FLcount  "Preset",			0,    499,    1,     10,      1,    100,     20,   745,  20,   -1	;0,   109, 0, 0.01

;BUTTONS                                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkSave,ihSave		FLbutton	"Save Preset",		1,    0,     1,    100,     20,   860, 20,    0,    101,      0,      0.001
gkLoad,ihLoad		FLbutton	"Load Preset",		1,    0,     1,    100,     20,  1000, 20,    0,    102,      0,      0.001
FLsetColor	255,100,100,ihSave
FLsetColor	100,255,100,ihLoad
;gkRename,ihRename	FLbutton	"Rename",		1,    0,     2,    150,     20,   660, 40,    0,    108,      0,      -1
;gkSave2D,ihSave2D	FLbutton	"Save All To Disc",	1,    0,     1,    150,     20,   860, 40,    0,    103,      0,      0.001
;gkLoad2D,ihLoad2D	FLbutton	"Load All From Disc",	1,    0,     1,    150,     20,   980, 40,    0,    104,      0,      0.001

gkDn10,ihDn10		FLbutton	"@<<",			1,    0,     1,     30,     20,   665+80, 70,    0,    107,      0,      0.001, -10
gk0,ih0			FLbutton	"0",			1,    0,     1,     30,     20,   695+80, 70,    0,    106,      0,      0.001, 0
gk1,ih1			FLbutton	"1",			1,    0,     1,     30,     20,   725+80, 70,    0,    106,      0,      0.001, 1
gk2,ih2			FLbutton	"2",			1,    0,     1,     30,     20,   755+80, 70,    0,    106,      0,      0.001, 2
gk3,ih3			FLbutton	"3",			1,    0,     1,     30,     20,   785+80, 70,    0,    106,      0,      0.001, 3
gk4,ih4			FLbutton	"4",			1,    0,     1,     30,     20,   815+80, 70,    0,    106,      0,      0.001, 4
gk5,ih5			FLbutton	"5",			1,    0,     1,     30,     20,   845+80, 70,    0,    106,      0,      0.001, 5
gk6,ih6			FLbutton	"6",			1,    0,     1,     30,     20,   875+80, 70,    0,    106,      0,      0.001, 6
gk7,ih7			FLbutton	"7",			1,    0,     1,     30,     20,   905+80, 70,    0,    106,      0,      0.001, 7
gk8,ih8			FLbutton	"8",			1,    0,     1,     30,     20,   935+80, 70,    0,    106,      0,      0.001, 8
gk9,ih9			FLbutton	"9",			1,    0,     1,     30,     20,   965+80, 70,    0,    106,      0,      0.001, 9
gkUp10,ihUp10		FLbutton	"@>>",			1,    0,     1,     30,     20,   995+80, 70,    0,    107,      0,      0.001, 10

;					WIDTH | HEIGHT | X  | Y
idgliss			FLvalue	" ",	 60,      20,     5,  65
idamp			FLvalue	" ",	 60,      20,    65,  65
idtrmdep		FLvalue	" ",	 60,      20,   125,  65
idvibdep		FLvalue	" ",	 60,      20,   185,  65
idmodfreq		FLvalue	" ",	 60,      20,   245,  65

idOsc1Lev		FLvalue	" ",	 60,      20,   490, 180
idOsc2Lev		FLvalue	" ",	 60,      20,   550, 180
idSubOsc		FLvalue	" ",	 60,      20,   610, 180

;PITCH
idPStrLev		FLvalue	" ",	 60,      20,    15, 300
idPAttTim		FLvalue	" ",	 60,      20,    75, 300
idPAttLev		FLvalue	" ",	 60,      20,   135, 300
idPDecTim		FLvalue	" ",	 60,      20,   195, 300
idPRelTim		FLvalue	" ",	 60,      20,   255, 300
idPRelLev		FLvalue	" ",	 60,      20,   315, 300
;PITCH WOBBLE
idPWobAmt		FLvalue	" ",	 60,      20,   400, 300
idPWobRte		FLvalue	" ",	 60,      20,   460, 300

;VELOCITY
idAmpVel		FLvalue	" ",	 60,      20,   620, 300
idFiltVel		FLvalue	" ",	 60,      20,   680, 300

;FILTER ENVELOPE
idFAttTim		FLvalue	" ",	 60,      20,    15, 420
idFAttLev		FLvalue	" ",	 60,      20,    75, 420
idFDecTim		FLvalue	" ",	 60,      20,   135, 420
idFSusLev		FLvalue	" ",	 60,      20,   195, 420
idFRelTim		FLvalue	" ",	 60,      20,   255, 420
idFRelLev		FLvalue	" ",	 60,      20,   315, 420
idFEnvAmt		FLvalue	" ",	 60,      20,   375, 420
;FILTER LFO
idFLFOAmt		FLvalue	" ",	 60,      20,   580, 420
idFLFORte		FLvalue	" ",	 60,      20,   640, 420
;FILTER SETUP
idBaseFrq		FLvalue	" ",	 60,      20,    15, 540
idRes			FLvalue	" ",	 60,      20,   195, 540
gidDist			FLvalue	" ",	 60,      20,   255, 540
;AMPLITUDE ENVELOPE
idAAttTim		FLvalue	" ",	 60,      20,    15, 660
idAAttLev		FLvalue	" ",	 60,      20,    75, 660
idADecTim		FLvalue	" ",	 60,      20,   135, 660
idASusLev		FLvalue	" ",	 60,      20,   195, 660
idARelTim		FLvalue	" ",	 60,      20,   255, 660
;DELAY
idDlyAmt		FLvalue	" ",	 60,      20,   340, 780
idDlyTim		FLvalue	" ",	 60,      20,   400, 780
idDlyFB			FLvalue	" ",	 60,      20,   460, 780

FLcolor	230,230,250,230,230,250

;	FLtabs	          itabswidth,itabsheight, ix,iy
	FLtabs	                380,  90, 100,  95

	FLgroup	"Oscillator 1", 380,  90, 100, 115
;					WIDTH | HEIGHT | X  | Y
gidpw			FLvalue	" ",	 60,      20,   255, 180
gidmul			FLvalue	" ",	 60,      20,   255, 180
;KNOBS					MIN    |   MAX | EXP|  TYPE |  DISP    | WIDTH | X | Y
gkpw, gihpw		FLknob		"P.W.CC#5",   		0.01,    0.99,    0,    1,   gidpw,        40, 265, 125		; PW
gkmul, gihmul		FLknob		"Mul.",			0,          2,    0,    1,   gidmul,       40, 265, 125		; BUZZ MUL.
gkfmd, gihfmd		FLknob		"Spread",   		0.001,      1,   -1,    1,   -1,           40, 265, 125		; oscbnk
gkmvt, gihmvt		FLknob		"Speed",   		0.0001,   100,   -1,    1,   -1,           40, 325, 125		; 
;FLCOUNTERS					MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkwave,gihwave 		FLcount  "", 		1,      8,    1,      1,      2,     80,     20,  125, 118,   -1
gkharm, gihharm 	FLcount  "N.Harms",     1,    200,    1,     10,      1,     80,     20,  315, 125,   -1
gklh, gihlh 		FLcount  "L.Harm.",	1,    100,    1,      1,      2,     60,     20,  405, 125,   -1
gkNOsc, gihNOsc 	FLcount  "Number",	1,    100,    1,     10,      1,     90,     20,  380, 125,   -1

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
gihWaveName1	 	FLbox  	"Saw", 	1,       1,    15,     80,     20,   125,138		; WAVEFORM 1 NAME

	FLgroupEnd

	FLgroup	"Oscillator 2", 380,  90, 100, 115
;					WIDTH | HEIGHT | X  | Y
gidpw2			FLvalue	" ",	 60,      20,   255, 180
gidmul2			FLvalue	" ",	 60,      20,   255, 180
;KNOBS					MIN    |   MAX | EXP|  TYPE |  DISP    | WIDTH | X | Y
gkpw2, gihpw2		FLknob		"P.W.",   0.01,    0.99,    0,    1,   gidpw2,       40, 265, 125		; PW
gkmul2, gihmul2		FLknob		"Mul.",	  0,          2,    0,    1,   gidmul2,      40, 265, 125		; BUZZ MUL.
gkfmd2, gihfmd2		FLknob		"Spread", 0.001,      1,   -1,    1,   -1,           40, 265, 125		; oscbnk
gkmvt2, gihmvt2		FLknob		"Speed",  0.0001,   100,   -1,    1,   -1,           40, 325, 125		; 
;FLCOUNTERS					MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkwave2,gihwave2 	FLcount  "Saw", 	1,      8,    1,      1,      2,     80,     20,  125, 118,   -1
gksemis,gihsemis 	FLcount  "Semis",	-36,   36,    1,      1,      2,     50,     17,  125, 160,   -1
gkcents,gihcents 	FLcount  "Cents",	-100, 100,    1,      1,      2,     50,     17,  180, 160,   -1
gkharm2, gihharm2 	FLcount  "N.Harms",     1,    200,    1,     10,      1,     80,     20,  315, 125,   -1
gklh2, gihlh2 		FLcount  "L.Harm.",	1,    100,    1,      1,      2,     60,     20,  405, 125,   -1
gkNOsc2, gihNOsc2 	FLcount  "Number",	1,    100,    1,     10,      1,     90,     20,  380, 125,   -1
;BUTTONS                                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOsc2OnOff,gihOsc2OnOff	FLbutton	"On/Off",	1,    0,     2,     55,     20,   210,118,   -1
FLsetTextSize	11,gihOsc2OnOff
FLsetColor2	255,255,0,gihOsc2OnOff

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
gihWaveName2	 	FLbox  	"Saw", 	1,       1,    15,     80,     20,   125,138		; WAVEFORM 2 NAME

	FLgroupEnd

	FLtabsEnd

FLcolor	255,255,255,0,0,0

;MODULATION AND PORTAMENTO					MIN    |   MAX | EXP|  TYPE |  DISP    | WIDTH | X | Y
gkgliss, gihgliss	FLknob		"Gliss.Time",		0,          5,    0,    1,   idgliss,      40,  15,  10
gkamp, gihamp		FLknob		"Amp.",			0,          1,    0,    1,   idamp,        40,  75,  10
gktrmdep, gihtrmdep	FLknob		"Trem.Amt.",		0,          1,    0,    1,   idtrmdep,     40, 135,  10
gkvibdep, gihvibdep	FLknob		"Vib.Amt.",		0,          1,    0,    1,   idvibdep,     40, 195,  10
gkmodfreq, gihmodfreq	FLknob		"Mod.Frq.",		0,         20,    0,    1,   idmodfreq,    40, 255,  10

;					WIDTH | HEIGHT | X  | Y
gidmodwhl		FLvalue	"",	30,      20,    57,  135

gkmodwhlFLTK,gihmodwhl	FLroller	"Mod.Wheel",		0,        127,    1,  0,    2,  -1,20, 100, 35,  90

gkOsc1Lev, gihOsc1Lev	FLknob		"Osc.1",		0,          1,    0,    1,   idOsc1Lev,    40, 500, 125		; OSC.1
gkOsc2Lev, gihOsc2Lev	FLknob		"Osc.2",		0,          1,    0,    1,   idOsc2Lev,    40, 560, 125		; OSC.2
gkSubOsc, gihSubOsc	FLknob		"Sub.Osc.",		0,          1,    0,    1,   idSubOsc,     40, 620, 125		; SUB OSC.

;FLCOUNTERS					MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkPolyLimit,gihPolyLimit FLcount  "Poly.Limit", 0,     16,    1,      1,      2,     80,     20,   680,140,   -1

;BUTTONS                                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkPLimitMode,gihPLimitMode	FLbutton	"Preserve Held Notes",	1,    0,     2,    125,     24,   770,138,    -1
FLsetColor2	255,0,0,gihPLimitMode
FLsetTextSize	11,gihPLimitMode

;PITCH
gkPStrLev, gihPStrLev	FLknob 		"Str.Lev.", 		0.125,      2,    0,    1,   idPStrLev,    40,  25, 245
gkPAttTim, gihPAttTim	FLknob 		"Att.Tim.", 		0.001,      8,    0,    1,   idPAttTim,    40,  85, 245
gkPAttLev, gihPAttLev	FLknob 		"Att.Lev.", 		0.125,      2,    0,    1,   idPAttLev,    40, 145, 245
gkPDecTim, gihPDecTim	FLknob 		"Dec.Tim.", 		0.001,      8,    0,    1,   idPDecTim,    40, 205, 245
gkPRelTim, gihPRelTim	FLknob 		"Rel.Tim.", 		0.001,      8,    0,    1,   idPRelTim,    40, 265, 245 
gkPRelLev, gihPRelLev	FLknob 		"Rel.Lev.", 		0.125,      2,    0,    1,   idPRelLev,    40, 325, 245
;PITCH WOBBLE
gkPWobAmt, gihPWobAmt	FLknob 		"Amount", 		0,          1,    0,    1,   idPWobAmt,    40, 410, 245
gkPWobRte, gihPWobRte	FLknob 		"Rate", 		0.001,     20,   -1,    1,   idPWobRte,    40, 470, 245

;VELOCITY
gkAmpVel, gihAmpVel	FLknob 		"Amp.Vel.", 		0,          1,    0,    1,   idAmpVel,     40, 630, 245
gkFiltVel, gihFiltVel	FLknob 		"Filt.Vel.", 		0,          1,    0,    1,   idFiltVel,    40, 690, 245

;FILTER ENVELOPE
gkFAttTim, gihFAttTim	FLknob 		"Att.Tim.", 		0.001,      8,    0,    1,   idFAttTim,    40,  25, 365
gkFAttLev, gihFAttLev	FLknob 		"Att.Lev.", 		0,          1,    0,    1,   idFAttLev,    40,  85, 365
gkFDecTim, gihFDecTim	FLknob 		"Dec.Tim.", 		0.001,      8,    0,    1,   idFDecTim,    40, 145, 365
gkFSusLev, gihFSusLev	FLknob 		"Sus.Lev.", 		0,          1,    0,    1,   idFSusLev,    40, 205, 365
gkFRelTim, gihFRelTim	FLknob 		"Rel.Tim.", 		0.001,      8,    0,    1,   idFRelTim,    40, 265, 365
gkFRelLev, gihFRelLev	FLknob 		"Rel.Lev.", 		0,          1,    0,    1,   idFRelLev,    40, 325, 365
gkFEnvAmt, gihFEnvAmt	FLknob 		"Env.Amt.", 		-10,       10,    0,    1,   idFEnvAmt,    40, 385, 365

;FILTER LFO
gkFLFOAmt, gihFLFOAmt	FLknob 		"Amount", 		0,          2,    0,    1,   idFLFOAmt,    40, 590, 365
gkFLFORte, gihFLFORte	FLknob 		"Rate", 		0.001,     20,   -1,    1,   idFLFORte,    40, 650, 365

;FILTER SETUP
gkBaseFrq, gihBaseFrq	FLknob 		"Base.Frq.", 		2,         14,    0,    1,   idBaseFrq,    40,  25, 485
gkRes, gihRes		FLknob 		"Res.", 		0,          1,    0,    1,   idRes,        40, 205, 485
gkDist, gihDist		FLknob 		"Dist.", 		0,         10,    0,    1,   gidDist,      40, 265, 485
;FLCOUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkNPoles, gihNPoles 	FLcount  	"N.Poles",		2,     50,    2,     10,      2,     60,     20,  255, 500,   -1

;AMPLITUDE
gkAAttTim, gihAAttTim	FLknob 		"Att.Tim.", 		0.001,      5,    0,    1,   idAAttTim,    40,  25, 605
gkAAttLev, gihAAttLev	FLknob 		"Att.Lev.", 		0,          1,    0,    1,   idAAttLev,    40,  85, 605
gkADecTim, gihADecTim	FLknob 		"Dec.Tim.", 		0.001,      5,    0,    1,   idADecTim,    40, 145, 605
gkASusLev, gihASusLev	FLknob 		"Sus.Lev.", 		0,          1,    0,    1,   idASusLev,    40, 205, 605
gkARelTim, gihARelTim	FLknob 		"Rel.Tim.", 		0.001,      5,    0,    1,   idARelTim,    40, 265, 605

;DISTORTION
gkDstAmt, gihDstAmt	FLknob 		"Amount", 		0,          1,    0,    1,   -1,           40,  20, 730
gkDstTon, gihDstTon	FLknob 		"Tone", 		400,    12000,   -1,    1,   -1,           40,  80, 730

;CHORUS
gkChoAmt, gihChoAmt	FLknob 		"Level", 		0,          1,    0,    1,   -1,           39, 160, 730
gkChoDep, gihChoDep	FLknob 		"Depth", 		0,          1,    0,    1,   -1,           39, 215, 730
gkChoRte, gihChoRte	FLknob 		"Rate", 		0.001,     10,   -1,    1,   -1,           39, 270, 730

;DELAY
gkDlyAmt, gihDlyAmt	FLknob 		"Level", 		0,          1,    0,    1,   idDlyAmt,     40, 350, 725
gkDlyTim, gihDlyTim	FLknob 		"Time", 		0.01,       2,    0,    1,   idDlyTim,     40, 410, 725
gkDlyFB, gihDlyFB	FLknob 		"Feedback", 		0,          1,    0,    1,   idDlyFB,      40, 470, 725

;REVERB
gkRvbAmt, gihRvbAmt	FLknob 		"Level", 		0,          1,    0,    1,   -1,           40, 550, 730
gkRvbTim, gihRvbTim	FLknob 		"Time", 		0.4,     0.99,    0,    1,   -1,           40, 610, 730

;STEREO
gkSpatMix, gihSpatMix	FLknob 		"Mix", 			0,          1,    0,    1,   -1,           40, 690, 730
gkSpatWidth, gihSpatWidth FLknob 	"Width", 		0.5,      1.5,    0,    1,   -1,           40, 750, 730

;FLCOUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkBendRnge, gihBendRnge FLcount  "Bend Range",	       	        0,     24,    1,      1,      2,     60,     20,  430,  20,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255
;FLcolor	255,255,255
;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X   | Y  | OPCODE | INS | STARTTIM | DUR
gkMonoPoly, gihMonoPoly		FLbutBank	4,      1,     3,     18,    3*30,   500,  10,    -1	
gkFiltType, gihFiltType		FLbutBank	4,      1,     5,     15,    5*15,    80, 470,    -1
gkFiltLFOType, gihFiltLFOType	FLbutBank	4,      1,     6,     15,    6*13,   470, 365,    -1
gkVelCurve, gihVelCurve		FLbutBank	4,      1,     4,     15,    4*13,   540, 245,    -1
gkModShape, gihModShape		FLbutBank	4,      1,     6,     15,    6*13,   310,  10,    -1
gkPolyIIMode, gihPolyIIMode	FLbutBank	4,      2,     1,   14*2,    13,     650,  79,    -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      1,     0,     0,     0
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Monophonic   ",1,       5,    12,    95,     15,   515,   16
ih		 	FLbox  	"Polyphonic I ",1,       5,    12,    95,     15,   515,   46
ih		 	FLbox  	"Polyphonic II",1,       5,    12,    95,     15,   515,   76
ih		 	FLbox  	"Mode:",	1,       5,    11,    25,     15,   620,   77

ih		 	FLbox  	"Lowpass      ",1,       5,    12,    95,     15,    95,  469
ih		 	FLbox  	"Highpass     ",1,       5,    12,    95,     15,    95,  484
ih		 	FLbox  	"Bandpass     ",1,       5,    12,    95,     15,    95,  499
ih		 	FLbox  	"Lowpass Dist.",1,       5,    12,    95,     15,    95,  514
ih		 	FLbox  	"Chebyshev I  ",1,       5,    12,    95,     15,    95,  529
ih		 	FLbox  	"sine         ",1,       5,    12,    95,     12,   485,  363	; FILTER
ih		 	FLbox  	"triangle     ",1,       5,    12,    95,     12,   485,  376
ih		 	FLbox  	"random spline",1,       5,    12,    95,     12,   485,  389
ih		 	FLbox  	"square       ",1,       5,    12,    95,     12,   485,  402
ih		 	FLbox  	"S&H I        ",1,       5,    12,    95,     12,   485,  415
ih		 	FLbox  	"S&H II       ",1,       5,    12,    95,     12,   485,  428

ih		 	FLbox  	"sine         ",1,       5,    12,    95,     12,   330,   10	; MOD WHEEL
ih		 	FLbox  	"triangle     ",1,       5,    12,    95,     12,   330,   23
ih		 	FLbox  	"random spline",1,       5,    12,    95,     12,   330,   36
ih		 	FLbox  	"square       ",1,       5,    12,    95,     12,   330,   49
ih		 	FLbox  	"S&H I        ",1,       5,    12,    95,     12,   330,   62
ih		 	FLbox  	"S&H II       ",1,       5,    12,    95,     12,   330,   75


ih		 	FLbox  	"Linear  ",	1,       5,    12,    60,     12,   555,  244
ih		 	FLbox  	"Concave ",	1,       5,    12,    60,     12,   555,  257
ih		 	FLbox  	"Convex  ",	1,       5,    12,    60,     12,   555,  270
ih		 	FLbox  	"S Spline",	1,       5,    12,    60,     12,   555,  283

;BUTTONS                                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkMRetrig,gihMRetrig	FLbutton	"Retrig.",		1,    0,     2,    70,     16,   610, 16,    -1
FLsetColor2	255,0,0,gihMRetrig
FLsetTextSize	11,gihMRetrig

;gkPolyIIMode,gihPolyIIMode	FLbutton	"Gliss Mode",	1,    0,     2,    70,     16,   610, 38,    -1
;FLsetColor2	255,0,0,gihPolyIIMode
;FLsetTextSize	11,gihPolyIIMode


;INITIALISE VALUATORS		VALUE | HANDLE
		FLsetVal_i	.005, 	gihgliss
		FLsetVal_i	2, 	gihBendRnge

		FLsetVal_i	1, 	gihwave		; oscillator 1
		FLsetVal_i	0.5, 	gihpw
		FLsetVal_i	1, 	gihmul
		FLsetVal_i	30, 	gihharm
		FLsetVal_i	1, 	gihlh
		FLsetVal_i	0.01, 	gihfmd
		FLsetVal_i	1, 	gihmvt
		FLsetVal_i	10, 	gihNOsc

		FLsetVal_i	1, 	gihwave2	; oscillator 2
		FLsetVal_i	0, 	gihOsc2OnOff
		FLsetVal_i	0.5, 	gihpw2
		FLsetVal_i	0, 	gihsemis
		FLsetVal_i	0, 	gihcents
		FLsetVal_i	1, 	gihmul2
		FLsetVal_i	30, 	gihharm2
		FLsetVal_i	1, 	gihlh2
		FLsetVal_i	0.01, 	gihfmd2
		FLsetVal_i	1, 	gihmvt2
		FLsetVal_i	10, 	gihNOsc2
		
		FLsetVal_i	0.2, 	gihamp
		FLsetVal_i	0, 	gihtrmdep
		FLsetVal_i	.1, 	gihvibdep
		FLsetVal_i	5, 	gihmodfreq
		FLsetVal_i	127, 	gihmodwhl
		
		FLsetVal_i	0, 	gihMonoPoly
		FLsetVal_i	1, 	gihOsc1Lev
		FLsetVal_i	1, 	gihOsc2Lev
		FLsetVal_i	0, 	gihSubOsc
		FLsetVal_i	0, 	gihPolyLimit

		FLsetVal_i	1, 	gihPStrLev	; pitch envelope
		FLsetVal_i	.00001,	gihPAttTim
		FLsetVal_i	1, 	gihPAttLev
		FLsetVal_i	.00001,	gihPDecTim
		FLsetVal_i	.00001,	gihPRelTim
		FLsetVal_i	1, 	gihPRelLev
		
		FLsetVal_i	0.1,	gihPWobAmt	; pitch wobble
		FLsetVal_i	0.8,	gihPWobRte

		FLsetVal_i	0.001,  gihFAttTim
		FLsetVal_i	1, 	gihFAttLev
		FLsetVal_i	0.8,    gihFDecTim
		FLsetVal_i	0.616, 	gihFSusLev
		FLsetVal_i	0.1, 	gihFRelTim
		FLsetVal_i	0, 	gihFRelLev
		FLsetVal_i	8, 	gihFEnvAmt

		FLsetVal_i	4, 	gihBaseFrq	; filter setup
		FLsetVal_i	0.7, 	gihFiltType
		FLsetVal_i	0.7, 	gihRes
		FLsetVal_i	0, 	gihDist
		FLsetVal_i	8, 	gihNPoles
		FLsetVal_i	0, 	gihFiltVel

		FLsetVal_i	0.001,  gihAAttTim	; amp envelope
		FLsetVal_i	1, 	gihAAttLev
		FLsetVal_i	0.001,  gihADecTim
		FLsetVal_i	1, 	gihASusLev
		FLsetVal_i	0.001,  gihARelTim
		FLsetVal_i	0, 	gihAmpVel

		FLsetVal_i	0, 	gihDstAmt
		FLsetVal_i	12000, 	gihDstTon

		FLsetVal_i	0.5, 	gihChoAmt
		FLsetVal_i	0.4, 	gihChoDep
		FLsetVal_i	1, 	gihChoRte

		FLsetVal_i	0.2, 	gihDlyAmt	; delay
		FLsetVal_i	0.9, 	gihDlyTim
		FLsetVal_i	0.2, 	gihDlyFB

		FLsetVal_i	0.2, 	gihRvbAmt
		FLsetVal_i	0.8, 	gihRvbTim

		FLsetVal_i	0.3, 	gihSpatMix
		FLsetVal_i	0.9, 	gihSpatWidth

		FLsetVal_i	0, 	gihPreset

		FLsetVal_i	2,	gihFiltLFOType
		FLsetVal_i	0.2,	gihFLFOAmt
		FLsetVal_i	0.3,	gihFLFORte

/* DEFAULT HIDING OF SELECTED WIDGETS */
	  FLhide	gihDist
	  FLhide	gidDist
	  FLhide	gihNPoles
	  FLhide	gihpw
	  FLhide	gidpw
	  FLhide	gihmul
	  FLhide	gidmul
	  FLhide	gihharm
	  FLhide	gihlh
	  FLhide	gihfmd
	  FLhide	gihmvt
	  FLhide	gihNOsc
	  FLhide	gihpw2
	  FLhide	gidpw2
	  FLhide	gihmul2
	  FLhide	gidmul2
	  FLhide	gihharm2
	  FLhide	gihlh2  
	  FLhide	gihfmd2
	  FLhide	gihmvt2
	  FLhide	gihNOsc2

;		FLscroll_end	;END OF PANEL CONTENTS
		FLpanel_end	;END OF PANEL CONTENTS
		FLrun		;RUN THE WIDGET THREAD

;INITIALISE GLOBAL VARIABLES
gkamp		init	0	
gkcps		init	0
gkNumInstr1	init	0
gkvib		init	0
gaSend		init	0
gaMixL		init	0
gaMixR		init	0
gaRvbSndL	init	0
gaRvbSndR	init	0
gkamp		init	0.2
giPresetSize	=	128
giActiveNotes	ftgen	0,0,128,-2,0	; ACTIVE NOTES TABLE
gkHeldNotes	init	0
;0        1        2        3        4        5        6         7        8        9        10       12       13       14       15       16       17       18       19       20       21       22       23       24       25       26       27       28       29       30       31       32       33       34       35       36       37       38           39       40       41       42       43       44       45       46       47       48       49       50       51       52       53       54       55       56       57       58       59       60        61       62       63       64        65       66       67       68       69        70   71  72  73  74  75  76  77  78  79        80        81
#define DEFAULTS
#0.005000,2.000000,0.500000,1.000000,1.000000,30.000000,1.000000,0.203937,0.000000,0.100000,5.000000,0.000000,1.000000,0.001000,1.000000,0.001000,0.001000,1.000000,0.001000,1.000000,0.800000,0.616000,0.100000,0.000000,8.000000,0.001000,1.000000,0.001000,1.000000,0.001000,4.000000,0.700000,0.000000,0.000000,8.000000,0.000000,12000.000000,0.500000,0.400000,1.000000,0.200000,0.907835,0.200000,0.200000,0.800000,0.000000,0.000000,0.100000,0.800000,2.000000,0.200000,0.300000,1.000000,0.000000,0.500000,0.000000,0.000000,1.000000,30.000000,1.000000,0.010000,1.000000,10.000000,0.300000,0.900000,0.010000,1.000000,10.000000,1,       0,   0,  0,  0,  0,  0,  0#
i_	ftgen	1,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	2,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	3,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	4,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	5,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	6,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	7,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	8,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	9,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	10,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	11,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	12,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	13,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	14,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	15,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	16,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	17,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	18,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	19,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	20,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	21,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	22,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	23,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	24,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	25,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	26,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	27,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	28,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	29,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	30,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	31,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	32,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	33,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	34,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	35,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	36,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	37,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	38,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	39,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	40,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	41,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	42,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	43,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	44,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	45,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	46,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	47,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	48,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	49,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	50,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	51,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	52,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	53,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	54,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	55,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	56,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	57,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	58,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	59,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	60,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	61,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	62,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	63,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	64,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	65,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	66,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	67,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	68,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	69,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	70,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	71,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	72,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	73,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	74,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	75,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	76,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	77,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	78,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	79,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	80,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	81,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	82,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	83,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	84,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	85,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	86,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	87,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	88,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	89,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	90,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	91,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	92,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	93,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	94,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	95,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	96,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	97,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	98,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	99,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	100,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	101,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	102,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	103,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	104,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	105,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	106,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	107,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	108,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	109,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	110,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	111,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	112,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	113,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	114,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	115,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	116,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	117,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	118,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	119,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	120,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	121,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	122,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	123,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	124,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	125,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	126,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	127,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	128,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	129,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	130,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	131,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	132,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	133,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	134,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	135,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	136,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	137,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	138,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	139,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	140,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	141,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	142,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	143,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	144,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	145,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	146,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	147,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	148,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	149,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	150,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	151,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	152,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	153,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	154,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	155,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	156,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	157,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	158,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	159,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	160,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	161,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	162,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	163,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	164,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	165,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	166,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	167,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	168,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	169,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	170,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	171,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	172,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	173,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	174,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	175,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	176,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	177,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	178,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	179,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	180,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	181,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	182,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	183,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	184,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	185,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	186,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	187,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	188,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	189,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	190,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	191,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	192,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	193,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	194,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	195,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	196,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	197,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	198,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	199,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	200,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	201,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	202,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	203,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	204,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	205,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	206,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	207,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	208,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	209,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	210,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	211,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	212,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	213,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	214,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	215,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	216,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	217,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	218,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	219,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	220,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	221,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	222,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	223,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	224,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	225,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	226,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	227,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	228,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	229,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	230,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	231,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	232,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	233,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	234,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	235,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	236,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	237,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	238,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	239,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	240,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	241,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	242,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	243,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	244,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	245,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	246,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	247,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	248,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	249,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	250,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	251,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	252,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	253,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	254,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	255,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	256,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	257,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	258,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	259,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	260,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	261,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	262,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	263,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	264,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	265,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	266,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	267,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	268,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	269,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	270,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	271,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	272,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	273,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	274,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	275,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	276,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	277,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	278,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	279,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	280,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	281,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	282,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	283,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	284,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	285,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	286,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	287,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	288,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	289,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	290,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	291,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	292,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	293,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	294,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	295,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	296,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	297,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	298,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	299,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	300,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	301,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	302,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	303,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	304,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	305,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	306,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	307,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	308,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	309,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	310,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	311,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	312,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	313,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	314,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	315,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	316,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	317,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	318,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	319,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	320,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	321,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	322,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	323,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	324,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	325,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	326,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	327,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	328,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	329,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	330,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	331,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	332,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	333,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	334,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	335,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	336,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	337,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	338,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	339,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	340,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	341,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	342,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	343,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	344,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	345,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	346,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	347,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	348,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	349,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	350,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	351,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	352,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	353,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	354,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	355,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	356,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	357,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	358,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	359,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	360,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	361,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	362,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	363,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	364,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	365,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	366,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	367,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	368,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	369,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	370,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	371,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	372,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	373,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	374,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	375,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	376,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	377,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	378,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	379,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	380,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	381,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	382,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	383,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	384,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	385,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	386,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	387,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	388,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	389,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	390,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	391,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	392,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	393,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	394,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	395,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	396,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	397,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	398,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	399,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	400,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	401,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	402,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	403,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	404,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	405,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	406,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	407,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	408,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	409,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	410,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	411,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	412,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	413,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	414,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	415,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	416,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	417,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	418,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	419,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	420,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	421,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	422,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	423,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	424,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	425,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	426,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	427,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	428,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	429,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	430,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	431,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	432,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	433,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	434,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	435,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	436,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	437,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	438,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	439,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	440,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	441,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	442,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	443,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	444,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	445,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	446,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	447,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	448,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	449,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	450,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	451,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	452,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	453,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	454,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	455,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	456,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	457,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	458,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	459,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	460,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	461,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	462,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	463,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	464,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	465,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	466,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	467,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	468,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	469,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	470,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	471,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	472,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	473,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	474,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	475,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	476,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	477,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	478,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	479,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	480,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	481,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	482,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	483,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	484,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	485,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	486,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	487,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	488,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	489,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	490,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	491,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	492,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	493,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	494,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	495,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	496,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	497,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	498,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	499,0,giPresetSize,-2,$DEFAULTS
i_	ftgen	500,0,giPresetSize,-2,$DEFAULTS  

gisine		ftgen	0,0,4096,10,1				;SINE WAVE (USED BY VCO AND VIBRATO AND TREMOLO FUNCTION)
gicos		ftgen	0,0,65536,9,1,1,90  			;COSINE WAVE (USED BY GBUZZ)
giChoShape	ftgen	0, 0, 131072, 19, 0.5, 1, 180, 1	;U-SHAPE PARABOLA

gieqffn		ftgen	0,0,4097,7,-1,4096,1
gieqlfn		ftgen	0,0,4097,7,-1,4096,1
gieqqfn		ftgen	0,0,4097,7,-1,4096,1

; VELOCITY CURVES
giLin		ftgen	0,0,128,-7,0,127,1
iCurve		=	3
giConcave	ftgen	0,0,128,-16,0,127,iCurve,1
giConvex	ftgen	0,0,128,-16,0,127,-iCurve,1
giSSpline	ftgen	0,0,128,-19,0.5,0.5,270,0.5

giLPF18Scale  ftgentmp     0, 0, 1024, -16, 1, 1023,   -8, 0.1	;RESCALING CURVE FOR GAIN COMPENSATION

; band limited saws
isaw	ftgen	0,0,4096,7,1,4096,-1
icount	=	0
loop1:
imaxh	=  sr / (2 * 440.0 * exp(log(2.0) * (icount - 69) / 12))
ifn	ftgen	1000+icount,0,4096,-30,isaw,1,imaxh
	loop_le	icount,1,127,loop1

; band limited squares
isquare		ftgen	0,0,4096,7,1,2048,1,0,-1,2048,-1
icount	=	0
loop2:
imaxh	=  sr / (2 * 440.0 * exp(log(2.0) * (icount - 69) / 12))
ifn	ftgen	2000+icount,0,4096,-30,isquare,1,imaxh
	loop_le	icount,1,127,loop2

; band limited pulses
ipulse		ftgen	0,0,4096,7,1,50,1,0,-1,4096-50,-1
icount	=	0
loop3:
imaxh	=  sr / (2 * 440.0 * exp(log(2.0) * (icount - 69) / 12))
ifn	ftgen	3000+icount,0,4096,-30,ipulse,1,imaxh
	loop_le	icount,1,127,loop3

/* SET INITIAL VALUES OF MIDI CONTROLLERS */	
initc7	1,5,(0.5-0.01)/(0.99-0.01)
initc7	1,6,(0.9-0.01)/(2-0.01)
initc7	1,7,0.2

/* UDOS */
opcode	scale_i,i,iii
 ival,imax,imin	xin
 ival	=	(ival * (imax-imin)) + imin
	xout	ival
endop


instr	99	; UPDATE DUAL MODE MIDI/FLTK VALUATORS
	/* MODULATION WHEEL */
	gkmodwhl	init	0
	if changed(gkmodwhlFLTK)==1 then							; IF FLTK MOD. WHEEL IS MOVED...
	 FLprintk2	127-gkmodwhlFLTK,gidmodwhl						; ... PRINT TO GUI VALUE BOX
	 gkmodwhl	=	(127-gkmodwhlFLTK)/127						; MOD. WHEEL VALUE SET TO FLTK WIDGET
	endif
	kmodwhl		ctrl7	1,1,0,1								; HARDWARE MOD. WHEEL
	gkmodwhl	=	changed(kmodwhl)==1?kmodwhl:gkmodwhl				; IF HARDWARE MOD.WHEEL IS MOVED SET MOD. WHEEL VALUE TO THIS

;CREATE A MACRO WITH VARIABLE TO PREVENT CODE REPETITION 
#define	UPDATE_WIDGET(NAME'CNUM'MIN'MAX)
	#
	k$NAME		ctrl7		1,$CNUM,0,1			;READ MIDI CONTROLLER
	k$NAME		scale		k$NAME,$MAX,$MIN		;RESCALE CONTROLLER VALUE
	ktrig$NAME	changed		k$NAME				;CREATE A TRIGGER PULSE IF MIDI CONTROLLER IS MOVED
			FLsetVal	ktrig$NAME, k$NAME, gih$NAME	;UPDATE FLTK VALUATOR IF MIDI CONTROLLER HAS BEEN MOVED
	#
	
	kmetro	metro	ksmps	;SLOW THE RATE OF FLTK UPDATES - THIS IS PARTICULARLY NECESSARY ON THE MAC OS IN ORDER THAT FLTK UPDATES DO NOT INTERFERE WITH REALTIME PERFORMANCE
	if kmetro=1 then	;IF METRO TICK IS RECEIVED...
	  ;EXPAND MACRO MULTIPLE TIMES TO SYNCHRONIZE EACH FLTK WIDGET TO ITS CORRESPONDING MIDI CONTROLLER (IF CHANGED)
	  $UPDATE_WIDGET(modfreq'2'0'20)
	  $UPDATE_WIDGET(BaseFrq'3'0'14)
	  $UPDATE_WIDGET(Res'4'0'1)
	  $UPDATE_WIDGET(pw'5'0.01'0.99)
	  $UPDATE_WIDGET(DlyTim'6'0.01'2)
	  $UPDATE_WIDGET(amp'7'0'1)
	endif
	
	/* SHOW/HIDE WIDGETS */
	ktrig	changed	gkFiltType
	if ktrig==1 then
	 reinit SHOW_HIDE
	endif
	SHOW_HIDE:
	 if i(gkFiltType)==0 then
	  FLhide	gihDist
	  FLhide	gidDist
	  FLhide	gihNPoles
	 elseif i(gkFiltType)==1 then
	  FLhide	gihDist
	  FLhide	gidDist
	  FLhide	gihNPoles
	 elseif i(gkFiltType)==2 then
	  FLhide	gihDist
	  FLhide	gidDist
	  FLhide	gihNPoles
	 elseif i(gkFiltType)==3 then	; lpf18
	  FLshow	gihDist
	  FLshow	gidDist
	  FLhide	gihNPoles
	 elseif i(gkFiltType)==4 then	; chebyshev I
	  FLhide	gihDist
	  FLhide	gidDist
	  FLshow	gihNPoles
	 endif
	rireturn	

	; SHOW/HIDE OSCILLATOR WIDGETS FOR OSCILLATOR 1
	ktrig	changed	gkwave
	if ktrig==1 then
	 reinit SHOW_HIDE2
	endif
	SHOW_HIDE2:
	 if i(gkwave)==1 then		; vco saw
	  FLhide	gihpw
	  FLhide	gidpw
	  FLhide	gihmul
	  FLhide	gidmul
	  FLhide	gihharm
	  FLhide	gihlh
	  FLhide	gihfmd
	  FLhide	gihmvt
	  FLhide	gihNOsc
	  FLsetText	"Saw",gihWaveName1
	 elseif i(gkwave)==2 then	; vco square
	  FLshow	gihpw
	  FLshow	gidpw
	  FLhide	gihmul
	  FLhide	gidmul
	  FLhide	gihharm
	  FLhide	gihlh
	  FLhide	gihfmd
	  FLhide	gihmvt
	  FLhide	gihNOsc
	  FLsetText	"Square",gihWaveName1
	 elseif i(gkwave)==3 then	; vco tri
	  FLshow	gihpw
	  FLshow	gidpw
	  FLhide	gihmul
	  FLhide	gidmul
	  FLhide	gihharm
	  FLhide	gihlh
	  FLhide	gihfmd
	  FLhide	gihmvt
	  FLhide	gihNOsc
	  FLsetText	"Triangle",gihWaveName1
	 elseif i(gkwave)==4 then	; buzz
	  FLhide	gihpw
	  FLhide	gidpw
	  FLshow	gihmul
	  FLshow	gidmul
	  FLshow	gihharm
	  FLshow	gihlh
	  FLhide	gihfmd
	  FLhide	gihmvt
	  FLhide	gihNOsc
	  FLsetText	"Buzz",gihWaveName1
	 elseif i(gkwave)==5 then	; oscbnk saw
	  FLhide	gihpw
	  FLhide	gidpw
	  FLhide	gihmul
	  FLhide	gidmul
	  FLhide	gihharm
	  FLhide	gihlh
	  FLshow	gihfmd
	  FLshow	gihmvt
	  FLshow	gihNOsc
	  FLsetText	"Cl.Saw",gihWaveName1
	 elseif i(gkwave)==6 then	; oscbnk square
	  FLhide	gihpw
	  FLhide	gidpw
	  FLhide	gihmul
	  FLhide	gidmul
	  FLhide	gihharm
	  FLhide	gihlh
	  FLshow	gihfmd
	  FLshow	gihmvt
	  FLshow	gihNOsc
	  FLsetText	"Cl.Square",gihWaveName1
	 elseif i(gkwave)==7 then	; oscbnk pulse
	  FLhide	gihpw
	  FLhide	gidpw
	  FLhide	gihmul
	  FLhide	gidmul
	  FLhide	gihharm
	  FLhide	gihlh
	  FLshow	gihfmd
	  FLshow	gihmvt
	  FLshow	gihNOsc
	  FLsetText	"Cl.Pulse",gihWaveName1
	 elseif i(gkwave)==8 then	; noise
	  FLhide	gihpw
	  FLhide	gidpw
	  FLhide	gihmul
	  FLhide	gidmul
	  FLhide	gihharm
	  FLhide	gihlh
	  FLhide	gihfmd
	  FLhide	gihmvt
	  FLhide	gihNOsc
	  FLsetText	"Noise",gihWaveName1
	 endif
	rireturn	

	; SHOW/HIDE OSCILLATOR WIDGETS FOR OSCILLATOR 2
	ktrig	changed	gkwave2
	if ktrig==1 then
	 reinit SHOW_HIDE3
	endif
	SHOW_HIDE3:
	 if i(gkwave2)==1 then		; vco saw
	  FLhide	gihpw2
	  FLhide	gidpw2
	  FLhide	gihmul2
	  FLhide	gidmul2
	  FLhide	gihharm2
	  FLhide	gihlh2
	  FLhide	gihfmd2
	  FLhide	gihmvt2
	  FLhide	gihNOsc2
	  FLsetText	"Saw",gihWaveName2
	 elseif i(gkwave2)==2 then	; vco square
	  FLshow	gihpw2
	  FLshow	gidpw2
	  FLhide	gihmul2
	  FLhide	gidmul2
	  FLhide	gihharm2
	  FLhide	gihlh2
	  FLhide	gihfmd2
	  FLhide	gihmvt2
	  FLhide	gihNOsc2
	  FLsetText	"Square",gihWaveName2
	 elseif i(gkwave2)==3 then	; vco tri
	  FLshow	gihpw2
	  FLshow	gidpw2
	  FLhide	gihmul2
	  FLhide	gidmul2
	  FLhide	gihharm2
	  FLhide	gihlh2
	  FLhide	gihfmd2
	  FLhide	gihmvt2
	  FLhide	gihNOsc2
	  FLsetText	"Triangle",gihWaveName2
	 elseif i(gkwave2)==4 then	; buzz
	  FLhide	gihpw2
	  FLhide	gidpw2
	  FLshow	gihmul2
	  FLshow	gidmul2
	  FLshow	gihharm2
	  FLshow	gihlh2
	  FLhide	gihfmd2
	  FLhide	gihmvt2
	  FLhide	gihNOsc2
	  FLsetText	"Buzz",gihWaveName2
	 elseif i(gkwave2)==5 then	; oscbnk saw
	  FLhide	gihpw2
	  FLhide	gidpw2
	  FLhide	gihmul2
	  FLhide	gidmul2
	  FLhide	gihharm2
	  FLhide	gihlh2
	  FLshow	gihfmd2
	  FLshow	gihmvt2
	  FLshow	gihNOsc2
	  FLsetText	"Cl.Saw",gihWaveName2
	 elseif i(gkwave2)==6 then	; oscbnk square
	  FLhide	gihpw2
	  FLhide	gidpw2
	  FLhide	gihmul2
	  FLhide	gidmul2
	  FLhide	gihharm2
	  FLhide	gihlh2
	  FLshow	gihfmd2
	  FLshow	gihmvt2
	  FLshow	gihNOsc2
	  FLsetText	"Cl.Square",gihWaveName2
	 elseif i(gkwave2)==7 then	; oscbnk pulse
	  FLhide	gihpw2
	  FLhide	gidpw2
	  FLhide	gihmul2
	  FLhide	gidmul2
	  FLhide	gihharm2
	  FLhide	gihlh2
	  FLshow	gihfmd2
	  FLshow	gihmvt2
	  FLshow	gihNOsc2
	  FLsetText	"Cl.Pulse",gihWaveName2
	 elseif i(gkwave2)==8 then	; noise
	  FLhide	gihpw2
	  FLhide	gidpw2
	  FLhide	gihmul2
	  FLhide	gidmul2
	  FLhide	gihharm2
	  FLhide	gihlh2
	  FLhide	gihfmd2
	  FLhide	gihmvt2
	  FLhide	gihNOsc2
	  FLsetText	"Noise",gihWaveName2
	 endif
	rireturn	

endin

	
instr	1	;RECEIVES MIDI NOTE INPUT
	icps		cpsmidi							; READ IN MIDI PITCH VALUES
	ivel		ampmidi	1,giLin+i(gkVelCurve)				; READ IN MIDI VELOCITY
	inum		notnum							; READ IN MIDI NOTE NUMBER VALUES
	if i(gkMonoPoly)==0 then							; IF MONOPHONIC/POLYPHONIC SWITCH IS ON MONOPHONIC...
	 gkcps	=	icps							; ...CREATE A K-RATE GLOBAL VARIABLE VERSION OF MIDI PITCH THAT WILL BE USED IN INSTRUMENT 2.
	 gkvel	init	ivel
	 gkNoteOn	init	1						; A FLAG TO INDICATE WHEN A NEW NOTE HAS BEEN PLAYED. THIS FLAG IS CLEARED (RESET TO ZERO) AT THE BOTTOM OF INSTR 2.
	 if active(p1)==1 then
	  event_i	"i",2,0,3600						; THE VERY FIRST MIDI NOTE PLAYED WILL TRIGGER A LONG HELD NOTE IN INSTR 2. THE maxalloc SETTING IN THE ORCHESTRA HEADER WILL PREVENT ANY FURTHER TRIGGERINGS. 
	 endif
	elseif i(gkMonoPoly)==1 then						; POLYPHONIC (I)
	 turnoff2	2,0,0							; TURN OFF INSTR 2 (THE MONOPHONIC INSTRUMENT)
	 gkHeldNotes	init	i(gkHeldNotes)+1				; INCREMENT HELD NOTES COUNTER
	 krelease	release							; SENSE NOTE RELEASE
	 xtratim	8/kr							; EXTEND NOTE DURATION (PREVENT STUCK NOTES)
	 krelease	delayk	krelease,4/kr					; DELAY RELEASE FLAG VALUE (PREVENT STUCK NOTES)
 			tableiw		1,inum,giActiveNotes			; WRITE STATUS TO ACTIVE NOTES TABLE
 			tablew		1-krelease,inum,giActiveNotes		; WRITE STATUS TO ACTIVE NOTES TABLE
 	 		event_i		"i",3+(inum*0.001),0,3600,icps,inum,ivel	; START A LONG NOTE
	else 									; OTHERWISE POLYPHONIC(II)
	 turnoff2	2,0,0							; TURN OFF INSTR 2 (THE MONOPHONIC INSTRUMENT)
	 gkHeldNotes	init	i(gkHeldNotes)+1				; INCREMENT HELD NOTES COUNTER
	 krelease	release							; SENSE NOTE RELEASE
	 xtratim	8/kr							; EXTEND NOTE DURATION (PREVENT STUCK NOTES)
	 krelease	delayk	krelease,4/kr					; DELAY RELEASE FLAG VALUE (PREVENT STUCK NOTES)
 			tableiw		1,inum,giActiveNotes			; WRITE STATUS TO ACTIVE NOTES TABLE
 			tablew		1-krelease,inum,giActiveNotes		; WRITE STATUS TO ACTIVE NOTES TABLE
 	 		event_i		"i",4+(inum*0.001),0,3600,icps,inum,i(gkcps),ivel	; START A LONG NOTE
	 gkcps		init		icps					; ...CREATE A K-RATE GLOBAL VARIABLE VERSION OF STARTING MIDI PITCH IN INSTRUMENT 4
	endif									; END OF CONDITIONAL BRANCH
	;PITCH BEND INFORMATION IS READ                                 	
	kbend		pchbend	0, 1						; PITCH BEND VARIABLE (IN SEMITONES)
	gkbendmlt	=	semitone(kbend*gkBendRnge)			; CREATE A MULTIPLIER THAT WHEN MULTIPLIED TO THE FREQUENCY OF AN OSCILLATOR WILL IMPLEMENT PITCH BEND
endin



#define	SYNTH
#
	/* PITCH WOBBLE FUNCTION */
	if gkPWobAmt>0 then
	 kPWob	jspline	gkPWobAmt,gkPWobRte*0.75,gkPWobRte*1.25
	 if gkOsc2OnOff==1 then
	  kPWob2	jspline	gkPWobAmt,gkPWobRte*0.75,gkPWobRte*1.25
	 endif
	else 
	 kPWob	=	0
	endif

	/* MODULATION WHEEL FUNCTION */
	if gkModShape==0 then						; SINE LFO
	 kmod	lfo	1, gkmodfreq, 0
	elseif gkModShape==1 then						; TRI LFO
	 kmod	lfo	1, gkmodfreq, 1
	elseif gkModShape==2 then						; RANDOM SPLINE LFO
	 kmod	jspline	1, gkmodfreq*0.75, gkmodfreq*1.25
	elseif gkModShape==3 then						; SQUARE LFO
	 kmod	lfo	1, gkmodfreq, 2
	 kmod	port	kmod,0.001
	elseif gkModShape==4 then						; S&H I LFO
	 kmod	randomh	-1, 1, gkmodfreq
	 kmod	port	kmod,0.001
	elseif gkModShape==5 then						; S&H II LFO
	 kmod	init	0
	 kmod	trandom	changed(kmod),gkmodfreq*0.25,gkmodfreq*4
	 kmod	randomh	-1, 1, gkmodfreq
	 kmod	port	kmod,0.001
	endif
	gkvib		=	(kmod * gkmodwhl * gkvibdep) + 1			;CREATE VIBRATO (PITCH MODULATION) FROM GENERAL MODULATION FUNCTION
	gktrm		=	1-(kmod*0.5*gktrmdep*gkmodwhl)-(gktrmdep*0.5*gkmodwhl)	;CREATE TREMOLO (AMPLITUDE MODULATION) FROM GENERAL MODULATION FUNCTION


	/* OSCILLATOR 1 */
	if gkwave=4 then	; buzz
	  kmul		portk		gkmul,ksmoothtime
	  ;OUTPUT	OPCODE	AMPLITUDE    |         FREQUENCY                     | NO.OF_HARMONICS | LOWEST_HARMONIC | POWER | FUNCTION_TABLE
	  asig		gbuzz 	gktrm*gkOsc1Lev,    kcps*gkvib*kPEnv*gkbendmlt*semitone(kPWob),      gkharm,            gklh,        kmul,      gicos
	elseif gkwave>=5 && gkwave<=7  then	; oscbank / cluster oscillator
	 knum	=	(octcps(kcps)-3)*12
	 kcps	=	kcps*gkvib*kPEnv*gkbendmlt;*semitone(kPWob)
	 kwave	=	knum + ((gkwave-4)*1000)
	 ktrig	changed	gkNOsc
	 if ktrig==1 then
	  reinit REINIT_OSCBNK
	 endif
	 REINIT_OSCBNK:
	 ;OUTPUT	OPCODE  CPS  | AMD  |    FMD     | PMD | OVERLAPS   | SEED  | L1MINF  | L1MAXF  | L2MINF  | L2MAXF  | LFOMODE | EQMINF  | EQMAXF | EQMINL | EQMAXL | EQMINQ | EQMAXQ  | EQMODE | KFN  | L1FN | L2FN | EQFFN  | EQLF   |  EQQFN |  TABL  | OUTFN	 
	 asig		oscbnk	kcps,   0,    gkfmd*kcps,   0,  i(gkNOsc),     0,      0,       gkmvt,      0,        0,       238,      0,       8000,      1,       1,       1,       1,       -1,    kwave, gicos, gicos, gieqffn, gieqlfn, gieqqfn
	 asig		=	(asig*gktrm*gkOsc1Lev) / (i(gkNOsc)^0.5)
	elseif gkwave==8  then	; noise
	 asig		pinkish	gktrm*2*gkOsc1Lev
	else
	 kpw		portk	gkpw, ksmoothtime				;PORTAMENTO IS APPLIED TO gkpw VARIABLE
	 ktrig	changed	gkwave
	 if ktrig==1 then
	   reinit	UPDATE
	 endif
	 UPDATE:
	  iwave	limit	 (i(gkwave)-1)*2,0,4
	 asig	vco2	gktrm*gkOsc1Lev, kcps*gkvib*kPEnv*gkbendmlt*semitone(kPWob), iwave, kpw
	endif

	/* OSCILLATOR 2 */
	if gkOsc2OnOff==1 then
	 kcps2	=	kcps * semitone(gksemis) * cent(gkcents)
	 if gkwave2=4 then
	   kmul2	portk		gkmul2,ksmoothtime
	   ;OUTPUT	OPCODE	AMPLITUDE    |         FREQUENCY                     | NO.OF_HARMONICS | LOWEST_HARMONIC | POWER | FUNCTION_TABLE
	   asig2	gbuzz 	gktrm*gkOsc2Lev,    kcps2*gkvib*kPEnv*gkbendmlt*semitone(kPWob2),      gkharm2,            gklh2,       kmul2,      gicos
	 elseif gkwave2>=5 && gkwave2<=7  then	; oscbank / cluster oscillator
	  knum	=	(octcps(kcps)-3)*12
	  kcps2	=	kcps2*gkvib*kPEnv*gkbendmlt;*semitone(kPWob)
	  kwave	=	knum + ((gkwave2-4)*1000)
	  ktrig	changed	gkNOsc2
	  if ktrig==1 then
	   reinit REINIT_OSCBNK2
	  endif
	  REINIT_OSCBNK2:
	  ;OUTPUT	OPCODE  CPS  | AMD  |    FMD     | PMD | OVERLAPS   | SEED  | L1MINF  | L1MAXF  | L2MINF  | L2MAXF  | LFOMODE | EQMINF  | EQMAXF | EQMINL | EQMAXL | EQMINQ | EQMAXQ  | EQMODE | KFN  | L1FN | L2FN | EQFFN  | EQLF   |  EQQFN |  TABL  | OUTFN	 
	  asig2		oscbnk	kcps2,  0,   gkfmd2*kcps2,  0,  i(gkNOsc2),    0,      0,       gkmvt2,     0,        0,       238,      0,       8000,      1,       1,       1,       1,       -1,    kwave, gicos, gicos, gieqffn, gieqlfn, gieqqfn
	  asig2		=	(asig2*gktrm*gkOsc2Lev) / (i(gkNOsc2)^0.5)
	 elseif gkwave2==8  then	; noise
	  asig2		pinkish	gktrm*2*gkOsc2Lev
	 else
	  kpw	portk	gkpw2, ksmoothtime				;PORTAMENTO IS APPLIED TO gkpw VARIABLE
	  ktrig	changed	gkwave2
	  if ktrig=1 then
	    reinit	UPDATE2
	  endif
	  UPDATE2:
	  iwave2	limit	 (i(gkwave2)-1)*2,0,4
	  asig2	vco2	gktrm*gkOsc2Lev, kcps2*gkvib*kPEnv*gkbendmlt*semitone(kPWob2),iwave2, kpw
	 endif
	 asig	=	asig + asig2
	endif

	rireturn

	/*SUB OSCILLATOR */	
	if gkSubOsc>0 then
	 aSub	poscil	gktrm*gkSubOsc,kcps*gkvib*kPEnv*gkbendmlt*semitone(kPWob)*0.5,gisine
	 asig	=	asig + aSub
	endif
	
	kBaseFrq	portk	gkBaseFrq, ksmoothtime				;APPLY PORTAMNETO SMOOTHING TO gkBaseFrq (CUTOFF FREQUENCY) VARIABLE
	
	/* FILTER LFO */
	if gkFiltLFOType==0 then						; SINE LFO
	 kFLFO	lfo	gkFLFOAmt, gkFLFORte, 0
	elseif gkFiltLFOType==1 then						; TRI LFO
	 kFLFO	lfo	gkFLFOAmt, gkFLFORte, 1
	elseif gkFiltLFOType==2 then						; RANDOM SPLINE LFO
	 kFLFO	jspline	gkFLFOAmt, gkFLFORte*0.75, gkFLFORte*1.25
	elseif gkFiltLFOType==3 then						; SQUARE LFO
	 kFLFO	lfo	gkFLFOAmt, gkFLFORte, 2
	 kFLFO	port	kFLFO,0.001
	elseif gkFiltLFOType==4 then						; S&H I LFO
	 kFLFO	randomh	-gkFLFOAmt, gkFLFOAmt, gkFLFORte
	 kFLFO	port	kFLFO,0.001
	elseif gkFiltLFOType==5 then						; S&H II LFO
	 kFLFO	init	0
	 kFLFORte	trandom	changed(kFLFO),gkFLFORte*0.25,gkFLFORte*4
	 kFLFO	randomh	-gkFLFOAmt, gkFLFOAmt, kFLFORte
	 kFLFO	port	kFLFO,0.001
	endif
	
	kCFoct		=	(kFEnv*gkFEnvAmt) + kBaseFrq + kFLFO		;FINAL FILTER CUTOFF VALUE INCORPORATING THE FILTER ENVELOPE AND THE FILTER BASE LEVEL
	kCFoct		-=	i(gkFiltVel)*(1-ivel)*8				;FILTER VELOCITY
	kCFoct		limit	kCFoct, 2, 13					;LIMIT FILTER CUTOFF RANGE - THIS PREVENTS THE POSSIBILITY OF AN EXPLODING FILTER GIVEN CUTOFF FREQUENCIES BEYOND THE NYQUIST FREQUENCY
	kCFcps		=	cpsoct(kCFoct)					;CONVERT CUTOFF VALUE FROM AN OCT FORMAT VALUE INTO A CPS VALUE

	/* FILTER */
	if gkFiltType==0 then
	 kres		scale		gkRes,0.95,0
	 aFilt		moogladder 	asig, kCFcps, kres			;APPLY FILTER (MOOGLADDER - CPU INTENSIVE - MORE LIMITED POLYPHONY)
	elseif gkFiltType==1 then
	 kres	scale	gkRes,10,1
	 alow, aFilt, aband svfilter  asig, kCFcps, kres
	elseif gkFiltType==2 then
	 kres	expcurve	gkRes,0.125
	 kbw	scale	kres,0.01,0.5
	 aFilt	reson  asig*0.3, kCFcps, kCFcps*kbw,2
	elseif gkFiltType==3 then
	 kres		scale		gkRes,1,0
	 aFilt	lpf18	asig, kCFcps, kres,gkDist
	 kScale	table	gkDist/10, giLPF18Scale, 1			;READ GAIN VALUE FROM RESCALING CURVE
	 aFilt	*=	kScale
	elseif gkFiltType==4 then			; chebyshev I
	 ikind	=	1	 
	 ktrig	changed	gkRes,gkNPoles
	 if ktrig==1 then
	  reinit CHEBYSHEV_I
	 endif
	 CHEBYSHEV_I:
	 ipbr	=	(i(gkRes)*(20-0.1))+0.1
	 aFilt	clfilt	asig, kCFcps, 0, i(gkNPoles), ikind, ipbr	;] [, isba] 
	 rireturn
	endif
	
	aFilt	=	aFilt * aAEnv * gkamp * (1-((1-ivel)*i(gkAmpVel)))	;APPLY AMPLITUDE MOFIFIERS
	
	;SEND FILTERED SIGNAL TO OUTPUT
	gaSend		=	gaSend + aFilt
#
				
instr	2	;MONOPHONIC
	kactive1	active	1
	if kactive1==0 then
	 turnoff
	endif
	
	ivel	=	i(gkvel)

	;CREATE PORTAMENTO ON PITCH PARAMETER
	kporttime	linseg	0,0.01,1					;PORTAMENTO TIME RISES QUICKLY TO A HELD VALUE OF '1'
	kglisstime	=	kporttime*gkgliss				;PORTAMENTO TIME FUNCTION SCALED BY VALUE OUTPUT BY FLTK SLIDER
	ksmoothtime	=	kporttime*0.1					;SMOOTHING OF FLTK CONTROLS
	kcps		portk	gkcps, kglisstime				;APPLY PORTAMENTO TO PITCH CHANGES
	
	kAmpEnv		init	0						;INITIALISE AMPLITUDE ENVELOPE STATE
	kFEnv		init	0						;INITIALISE FILTER ENVELOPE STATE
	
	if gkNoteOn==1&&kactive1==1 then					;IF A NEW LEGATO PHRASE IS BEGUN (I.E. A NEW NOTE HAS BEEN PRESSED AND NO OTHER PREVIOUS NOTES ARE BEING HELD)...
	  reinit	RestartLegEnvs						;RESTART THE 'LEGATO PHRASE' ENVELOPES (IN THIS CASE AMPLITUDE AND FILTER)
	elseif gkNoteOn==1&&gkMRetrig==1 then
	  reinit	RestartLegEnvs	
	endif									;END OF THIS CONDITIONAL BRANCH
	RestartLegEnvs:								;A LABEL: BEGIN A REINITIALISATION PASS FROM HERE TO RESTART THE LEGATO PHRASE ENVELOPES		
	kAmpEnv			linsegr		i(kAmpEnv),i(gkAAttTim),i(gkAAttLev),i(gkADecTim),i(gkASusLev),i(gkARelTim),0	;MOVE THROUGH AMPLITUDE ATTACK (NOTE ON) ENVELOPE. IT WILL HOLD THE FINAL VALUE
	kPEnv			linsegr		i(gkPStrLev),i(gkPAttTim),i(gkPAttLev),i(gkPDecTim),1,i(gkPRelTim),i(gkPRelLev)	;MOVE THROUGH PITCH ATTACK (NOTE ON) ENVELOPE. IT WILL HOLD THE FINAL VALUE
	kFEnv			linsegr		i(kFEnv),i(gkFAttTim),i(gkFAttLev),i(gkFDecTim),i(gkFSusLev),i(gkFRelTim),i(gkFRelLev)	;MOVE THROUGH FILTER ATTACK (NOTE ON) ENVELOPE. IT WILL HOLD THE FINAL VALUE
	rireturn								;RETURN FROM REINITIALISATION PASS
	
	aAEnv		interp	kAmpEnv						;SMOOTHER A-RATE AMPLITUDE ENVELOPE - MAY PROVE BENEFICIAL IF THERE ARE FAST CHANGING ENVELOPE SEGMENTS 
		
	$SYNTH

	gkNoteOn	=	0						;CLEAR NOTE-ON FLAG
endin

instr	3	;POLYPHONIC I
	ivel		=	p6
	
	;CREATE PORTAMENTO FUNCTION
	kporttime	linseg	0,0.01,1						;PORTAMENTO TIME RISES QUICKLY TO A HELD VALUE OF '1'
	ksmoothtime	=	kporttime*0.1						;SMOOTHING OF FLTK CONTROLS
	kcps		init	p4

	kAct	table	p5,giActiveNotes						; ACTIVITY INDICATOR FOR THIS NOTE (0=RELEASED 1=HELD)
	
	kEnvStage	init	0							; FLAG FOR ENVELOPE STAGE 0=ATT/SUS 1=REL 2=INTERRUPT
	
	if changed(kAct)==1&&timeinstk()>1 then						; IF ACTIVITY INDICATOR HAS CHANGED
	 if kAct==0 then								; IF NOTE HAS BEEN RELEASED
	  kEnvStage	=	1
	 endif
	 if kAct==1 then								; IF NOTE HAS BEEN RESTARTED...
	  gkHeldNotes	limit	gkHeldNotes-1,0,128
	  kEnvStage	=	2
	 endif
	endif

	if gkHeldNotes>gkPolyLimit&&gkPolyLimit>0&&(kAct*gkPLimitMode)==0 then				; IF WE HAVE EXCEEDED POLYPHONY LIMIT (AND POLYPHONY LIMIT MODE IS ACTIVATED/I.E. NON-ZERO)...
	 gkHeldNotes	limit	gkHeldNotes-1,0,128					; DECREMENT HELD NOTES COUNTER
	 kEnvStage	=	2							; ENTER ENVELOPE INTERRUPT STAGE
	endif
		
	kAmpAttEnv,kAmpRelEnv,kAmpIntrpEnv,kPAttEnv,kPRelEnv,kFAttEnv,kFRelEnv	init	1	; INITIALISE ENVELOPE START VALUES
	
	if kEnvStage==0 then								; ATTACK/SUSTAIN STAGE ENVELOPE(S)
 	 kAmpAttEnv	linseg	0,i(gkAAttTim),i(gkAAttLev),i(gkADecTim),i(gkASusLev)
 	 kPAttEnv	linseg	i(gkPStrLev),i(gkPAttTim),i(gkPAttLev),i(gkPDecTim),1
 	 kFAttEnv	linseg	0,i(gkFAttTim),i(gkFAttLev),i(gkFDecTim),i(gkFSusLev)
	elseif kEnvStage==1 then							; NORMAL RELEASE STAGE ENVELOPE(S)
	 kAmpRelEnv	linseg	1,i(gkARelTim)+0.005,0					
	 kPRelEnv	linseg	1,i(gkPRelTim),i(gkPRelLev)
	 kFRelEnv	linseg	1,i(gkFRelTim),i(gkFRelLev)
	 if kAmpRelEnv==0 then								; IF NORMAL RELEASE ENVELOPE HAS COMPLETED...
	  gkHeldNotes	limit	gkHeldNotes-1,0,128					; DECREMENT HELD NOTES COUNTER
	  turnoff
	 endif
	elseif kEnvStage==2 then							; INTERRUPT STAGE ENVELOPE(S)
	 kAmpIntrpEnv	linseg	1,0.005,0
	 if kAmpIntrpEnv==0 then							; IF INTERRUPT ENVELOPE HAS COMPLETED...
	  turnoff
	 endif
	endif
		kmod		oscil	1,gkmodfreq,gisine					;CREATE GENERAL MODULATION FUNCTION
	gkvib		=	(kmod * gkmodwhl * gkvibdep) + 1			;CREATE VIBRATO (PITCH MODULATION) FROM GENERAL MODULATION FUNCTION
	gktrm		=	1-(kmod*0.5*gktrmdep*gkmodwhl)-(gktrmdep*0.5*gkmodwhl)	;CREATE TREMOLO (AMPLITUDE MODULATION) FROM GENERAL MODULATION FUNCTION

	kAmpEnv	=	kAmpAttEnv * kAmpRelEnv * kAmpIntrpEnv
	kPEnv	=	kPAttEnv * kPRelEnv * kAmpIntrpEnv			;linsegr	i(gkPStrLev),i(gkPAttTim),i(gkPAttLev),i(gkPDecTim),1,i(gkPRelTim),i(gkPRelLev) 		;CREATE PITCH ENVELOPE
	kFEnv	=	kFAttEnv * kFRelEnv * kAmpIntrpEnv			;linsegr	0,i(gkFAttTim),i(gkFAttLev),i(gkFDecTim),i(gkFSusLev),i(gkFRelTim),i(gkFRelLev)			;CREATE FILTER ENVELOPE

	aAEnv		interp	kAmpEnv						;SMOOTHER A-RATE AMPLITUDE ENVELOPE - MAY PROVE BENEFICIAL IF THERE ARE FAST CHANGING ENVELOPE SEGMENTS 
	
	$SYNTH
endin

instr	4	;POLYPHONIC II
	ivel	=	p7
	
	;CREATE PORTAMENTO ON PITCH PARAMETER
	kporttime	linseg	0,0.01,1					;PORTAMENTO TIME RISES QUICKLY TO A HELD VALUE OF '1'
	ksmoothtime	=	kporttime*0.1					;SMOOTHING OF FLTK CONTROLS
	iglisstime	=	active:i(1)==1?0:i(gkgliss)

	if i(gkPolyIIMode)==0 then
	 kcps		cosseg	p6,iglisstime+0.00001,p4	
	else
	 kcps		cosseg	p6,(iglisstime*abs((p6-p4)/60))+0.00001,p4	
	endif
	
	kAct	table	p5,giActiveNotes						; ACTIVITY INDICATOR FOR THIS NOTE (0=RELEASED 1=HELD)
	
	kEnvStage	init	0							; FLAG FOR ENVELOPE STAGE 0=ATT/SUS 1=REL 2=INTERRUPT
	
	if changed(kAct)==1&&timeinstk()>1 then						; IF ACTIVITY INDICATOR HAS CHANGED
	 if kAct==0 then								; IF NOTE HAS BEEN RELEASED
	  kEnvStage	=	1
	 endif
	 if kAct==1 then								; IF NOTE HAS BEEN RESTARTED...
	  gkHeldNotes	limit	gkHeldNotes-1,0,128
	  kEnvStage	=	2
	 endif
	endif

	if gkHeldNotes>gkPolyLimit&&gkPolyLimit>0&&(kAct*gkPLimitMode)==0 then				; IF WE HAVE EXCEEDED POLYPHONY LIMIT (AND POLYPHONY LIMIT MODE IS ACTIVATED/I.E. NON-ZERO)...
	 gkHeldNotes	limit	gkHeldNotes-1,0,128					; DECREMENT HELD NOTES COUNTER
	 kEnvStage	=	2							; ENTER ENVELOPE INTERRUPT STAGE
	endif
		
	kAmpAttEnv,kAmpRelEnv,kAmpIntrpEnv,kPAttEnv,kPRelEnv,kFAttEnv,kFRelEnv	init	1	; INITIALISE ENVELOPE START VALUES
	
	if kEnvStage==0 then								; ATTACK/SUSTAIN STAGE ENVELOPE(S)
 	 kAmpAttEnv	linseg	0,i(gkAAttTim),i(gkAAttLev),i(gkADecTim),i(gkASusLev)
 	 kPAttEnv	linseg	i(gkPStrLev),i(gkPAttTim),i(gkPAttLev),i(gkPDecTim),1
 	 kFAttEnv	linseg	0,i(gkFAttTim),i(gkFAttLev),i(gkFDecTim),i(gkFSusLev)
	elseif kEnvStage==1 then							; NORMAL RELEASE STAGE ENVELOPE(S)
	 kAmpRelEnv	linseg	1,i(gkARelTim)+0.005,0					
	 kPRelEnv	linseg	1,i(gkPRelTim),i(gkPRelLev)
	 kFRelEnv	linseg	1,i(gkFRelTim),i(gkFRelLev)
	 if kAmpRelEnv==0 then								; IF NORMAL RELEASE ENVELOPE HAS COMPLETED...
	  gkHeldNotes	limit	gkHeldNotes-1,0,128					; DECREMENT HELD NOTES COUNTER
	  turnoff
	 endif
	elseif kEnvStage==2 then							; INTERRUPT STAGE ENVELOPE(S)
	 kAmpIntrpEnv	linseg	1,0.005,0
	 if kAmpIntrpEnv==0 then							; IF INTERRUPT ENVELOPE HAS COMPLETED...
	  turnoff
	 endif
	endif
	
	kAmpEnv	=	kAmpAttEnv * kAmpRelEnv * kAmpIntrpEnv
	kPEnv	=	kPAttEnv * kPRelEnv * kAmpIntrpEnv			;linsegr	i(gkPStrLev),i(gkPAttTim),i(gkPAttLev),i(gkPDecTim),1,i(gkPRelTim),i(gkPRelLev) 		;CREATE PITCH ENVELOPE
	kFEnv	=	kFAttEnv * kFRelEnv * kAmpIntrpEnv			;linsegr	0,i(gkFAttTim),i(gkFAttLev),i(gkFDecTim),i(gkFSusLev),i(gkFRelTim),i(gkFRelLev)			;CREATE FILTER ENVELOPE

	aAEnv		interp	kAmpEnv						;SMOOTHER A-RATE AMPLITUDE ENVELOPE - MAY PROVE BENEFICIAL IF THERE ARE FAST CHANGING ENVELOPE SEGMENTS 
	
	$SYNTH
endin

instr	11	; EFFECTS: DISTORTION - CHORUS - PING PONG DELAY
	
	if gkDstAmt>0 then
	 gaSend	clip	gaSend*(1+(gkDstAmt*5)),0,0.15
	 gaSend	tone	gaSend,gkDstTon
	endif

	;CHORUS
	if gkChoAmt>0 then
	 aMod		oscili	gkChoDep,gkChoRte,giChoShape
	 aMod		=	((aMod*0.5)+(0.5*gkChoDep))
	 aMod		=	(aMod*0.01) + 0.0001
	 aCho		vdelay	gaSend,aMod*1000,0.0101*1000
	 gaSend		=	gaSend+(aCho*gkChoAmt)	
	endif

	kporttime	linseg	0,0.001,0.05

	if gkSpatMix>0 then
	 kSpatWidth	portk	gkSpatWidth,kporttime
	 aCL		vcomb	gaSend, 0.01, 0.03*kSpatWidth		,0.1
	 aCR		vcomb	gaSend, 0.01, 0.03*kSpatWidth*1.5	,0.1
	 aCL		ntrpol	gaSend,aCL,gkSpatMix
	 aCR		ntrpol	gaSend,aCR,gkSpatMix
			outs	aCL,aCR
	endif

		outs	gaSend,gaSend

	gaRvbSndL	=	gaRvbSndL+(gaSend*gkRvbAmt)
	gaRvbSndR	=	gaRvbSndR+(gaSend*gkRvbAmt)	

	
	if gkDlyAmt>0 then
	 imaxdelay	=	2		;MAXIMUM DELAY TIME
	 kDlyTim		portk	gkDlyTim,kporttime	;SMOOTH DELAY TIME CHANGES
	 aDlyTim		interp	kDlyTim		;INTERPOLATE TO CREATE A-RATE VERSION
	 
	 ;LEFT CHANNEL OFFSETTING DELAY (NO FEEDBACK!)
	 aBuffer		delayr	imaxdelay*.5	;ESTABLISH DELAY BUFFER
	 aLeftOffset	deltap3	aDlyTim*.5		;TAP BUFFER
	 		delayw	(gaSend*gkDlyAmt)	;WRITE AUDIO INTO BUFFER
	 		
	 ;LEFT CHANNEL DELAY WITH FEEDBACK
	 aBuffer		delayr	imaxdelay		;ESTABLISH DELAY BUFFER
	 aDlySigL	deltap3	aDlyTim                         ;TAP BUFFER
	 		delayw	aLeftOffset+(aDlySigL*gkDlyFB)  ;WRITE AUDIO INTO BUFFER (ADD IN FEEDBACK SIGNAL)
	 
	 ;RIGHT CHANNEL DELAY WITH FEEDBACK
	 aBuffer		delayr	imaxdelay			;ESTABLISH DELAY BUFFER
	 aDlySigR	deltap3	aDlyTim                         	;TAP BUFFER
	 		delayw	(gaSend*gkDlyAmt)+(aDlySigR*gkDlyFB)	;WRITE AUDIO INTO BUFFER (ADD IN FEEDBACK SIGNAL)
	 
	 		outs	aDlySigL+aLeftOffset, aDlySigR	;SEND DELAY OUTPUT SIGNALS TO THE SPEAKERS
	 gaRvbSndL	=	gaRvbSndL+((aDlySigL+aLeftOffset)*gkRvbAmt)
	 gaRvbSndR	=	gaRvbSndR+(aDlySigR*gkRvbAmt)	
	endif

	gaSend		=	0				;RESET EFFECTS SEND GLOBAL AUDIO VARIABLE TO PREVENT STUCK VALUES WHEN INSTR 1 STOPS PLAYING
endin

instr	12	; REVERB
	if gkRvbAmt>0 then
	 aL,aR	reverbsc	gaRvbSndL,gaRvbSndR,gkRvbTim,10000
		outs		aL,aR
		clear		gaRvbSndL,gaRvbSndR
	endif
	
	if changed(gkPreset)==1 then	; update GUI preset name if counter is changed
	 event	"i",109,0,0.01
	endif
	
	if changed(gkPolyLimit)==1 then	; RESET HELD NOTES COUNTER IF POLYPHONY LIMIT IS CHANGED IN ORDER TO PREVENT STUCK NOTES
	 gkHeldNotes	=	0
	endif
	
;	printk2	gkHeldNotes
endin



instr	101	; save preset
 i_		ftgen	i(gkPreset)+1,0,giPresetSize,-2,i(gkgliss),i(gkBendRnge),i(gkpw),i(gkwave),i(gkmul),i(gkharm),i(gklh),i(gkamp),i(gktrmdep),i(gkvibdep),i(gkmodfreq),i(gkMonoPoly),i(gkPStrLev),i(gkPAttTim),i(gkPAttLev),i(gkPDecTim),i(gkPRelTim),i(gkPRelLev),i(gkFAttTim),i(gkFAttLev),i(gkFDecTim),i(gkFSusLev),i(gkFRelTim),i(gkFRelLev),i(gkFEnvAmt),i(gkAAttTim),i(gkAAttLev),i(gkADecTim),i(gkASusLev),i(gkARelTim),i(gkBaseFrq),i(gkRes),i(gkFiltType),i(gkDist),i(gkNPoles),i(gkDstAmt),i(gkDstTon),i(gkChoAmt),i(gkChoDep),i(gkChoRte),i(gkDlyAmt),i(gkDlyTim),i(gkDlyFB),i(gkRvbAmt),i(gkRvbTim),i(gkMRetrig), i(gkSubOsc), i(gkPWobAmt), i(gkPWobRte), i(gkFiltLFOType), i(gkFLFOAmt), i(gkFLFORte), i(gkwave2),i(gkOsc2OnOff),i(gkpw2),i(gksemis),i(gkcents),i(gkmul2),i(gkharm2),i(gklh2),i(gkfmd2),i(gkmvt2),i(gkNOsc2),i(gkSpatMix),i(gkSpatWidth),i(gkfmd),i(gkmvt),i(gkNOsc),i(gkOsc1Lev),i(gkOsc2Lev),i(gkPolyLimit),i(gkPLimitMode),i(gkAmpVel),i(gkFiltVel),i(gkVelCurve),i(gkModShape),i(gkPolyIIMode)

 event_i	"i", 103, 0, 0.001	; CALL INSTRUMENT THAT SAVES ALL PRESETS TO DISK IN A SINGLE TEXT FILE
endin

instr	102	; load preset
 igliss   	table	0,i(gkPreset) + 1
 iBendRnge       table	1,i(gkPreset) + 1
 ipw             table	2,i(gkPreset) + 1
 iwave           table	3,i(gkPreset) + 1
 imul            table	4,i(gkPreset) + 1
 iharm           table	5,i(gkPreset) + 1
 ilh             table	6,i(gkPreset) + 1
 iamp            table	7,i(gkPreset) + 1
 itrmdep         table	8,i(gkPreset) + 1
 ivibdep         table	9,i(gkPreset) + 1
 imodfreq        table	10,i(gkPreset) + 1
 iMonoPoly       table	11,i(gkPreset) + 1
 iPStrLev        table	12,i(gkPreset) + 1
 iPAttTim        table	13,i(gkPreset) + 1
 iPAttLev        table	14,i(gkPreset) + 1
 iPDecTim        table	15,i(gkPreset) + 1
 iPRelTim        table	16,i(gkPreset) + 1
 iPRelLev        table	17,i(gkPreset) + 1
 iFAttTim        table	18,i(gkPreset) + 1
 iFAttLev        table	19,i(gkPreset) + 1
 iFDecTim        table	20,i(gkPreset) + 1
 iFSusLev        table	21,i(gkPreset) + 1
 iFRelTim        table	22,i(gkPreset) + 1
 iFRelLev        table	23,i(gkPreset) + 1
 iFEnvAmt        table	24,i(gkPreset) + 1
 iAAttTim        table	25,i(gkPreset) + 1
 iAAttLev        table	26,i(gkPreset) + 1
 iADecTim        table	27,i(gkPreset) + 1
 iASusLev        table	28,i(gkPreset) + 1
 iARelTim        table	29,i(gkPreset) + 1
 iBaseFrq        table	30,i(gkPreset) + 1
 iRes            table	31,i(gkPreset) + 1
 iFiltType	 table	32,i(gkPreset) + 1
 iDist	 	 table	33,i(gkPreset) + 1
 iNPoles	 table	34,i(gkPreset) + 1
 iDstAmt         table	35,i(gkPreset) + 1
 iDstTon         table	36,i(gkPreset) + 1
 iChoAmt         table	37,i(gkPreset) + 1
 iChoDep         table	38,i(gkPreset) + 1
 iChoRte         table	39,i(gkPreset) + 1
 iDlyAmt         table	40,i(gkPreset) + 1
 iDlyTim         table	41,i(gkPreset) + 1
 iDlyFB          table	42,i(gkPreset) + 1
 iRvbAmt         table	43,i(gkPreset) + 1
 iRvbTim         table	44,i(gkPreset) + 1
 iMRetrig        table	45,i(gkPreset) + 1
 iSubOsc 	 table	46,i(gkPreset) + 1
 iPWobAmt 	 table	47,i(gkPreset) + 1 
 iPWobRte 	 table	48,i(gkPreset) + 1 
 iFiltLFOType 	 table	49,i(gkPreset) + 1 
 iFLFOAmt 	 table	50,i(gkPreset) + 1
 iFLFORte 	 table	51,i(gkPreset) + 1

 iwave2		table	52,i(gkPreset) + 1
 iOsc2OnOff	table	53,i(gkPreset) + 1
 ipw2		table	54,i(gkPreset) + 1
 isemis		table	55,i(gkPreset) + 1
 icents		table	56,i(gkPreset) + 1
 imul2		table	57,i(gkPreset) + 1
 iharm2		table	58,i(gkPreset) + 1
 ilh2		table	59,i(gkPreset) + 1
 ifmd2		table	60,i(gkPreset) + 1
 imvt2		table	61,i(gkPreset) + 1
 iNOsc2		table	62,i(gkPreset) + 1

 iSpatMix	table	63,i(gkPreset) + 1
 iSpatWidth	table	64,i(gkPreset) + 1

 ifmd		table	65,i(gkPreset) + 1
 imvt           table	66,i(gkPreset) + 1
 iNOsc          table	67,i(gkPreset) + 1

 iOsc1Lev       table	68,i(gkPreset) + 1
 iOsc2Lev       table	69,i(gkPreset) + 1

 iPolyLimit	table	70,i(gkPreset) + 1
 iPLimitMode	table	71,i(gkPreset) + 1
 iAmpVel	table	72,i(gkPreset) + 1
 iFiltVel	table	73,i(gkPreset) + 1
 iVelCurve	table	74,i(gkPreset) + 1
 iModShape	table	75,i(gkPreset) + 1
 iPolyIIMode	table	76,i(gkPreset) + 1

	FLsetVal_i	igliss   ,gihgliss
	FLsetVal_i	iBendRnge,gihBendRnge
	FLsetVal_i	ipw      ,gihpw
	FLsetVal_i	iwave    ,gihwave
	FLsetVal_i	imul     ,gihmul
	FLsetVal_i	iharm    ,gihharm
	FLsetVal_i	ilh      ,gihlh
	FLsetVal_i	iamp     ,gihamp
	FLsetVal_i	itrmdep  ,gihtrmdep
	FLsetVal_i	ivibdep  ,gihvibdep
	FLsetVal_i	imodfreq ,gihmodfreq
	FLsetVal_i	iMonoPoly,gihMonoPoly
	FLsetVal_i	iPStrLev ,gihPStrLev
	FLsetVal_i	iPAttTim ,gihPAttTim
	FLsetVal_i	iPAttLev ,gihPAttLev
	FLsetVal_i	iPDecTim ,gihPDecTim
	FLsetVal_i	iPRelTim ,gihPRelTim
	FLsetVal_i	iPRelLev ,gihPRelLev
	FLsetVal_i	iFAttTim ,gihFAttTim
	FLsetVal_i	iFAttLev ,gihFAttLev
	FLsetVal_i	iFDecTim ,gihFDecTim
	FLsetVal_i	iFSusLev ,gihFSusLev
	FLsetVal_i	iFRelTim ,gihFRelTim
	FLsetVal_i	iFRelLev ,gihFRelLev
	FLsetVal_i	iFEnvAmt ,gihFEnvAmt

	FLsetVal_i	iAAttTim ,gihAAttTim
	FLsetVal_i	iAAttLev ,gihAAttLev
	FLsetVal_i	iADecTim ,gihADecTim
	FLsetVal_i	iASusLev ,gihASusLev
	FLsetVal_i	iARelTim ,gihARelTim

	FLsetVal_i	iBaseFrq ,gihBaseFrq
	FLsetVal_i	iFiltType,gihFiltType
	FLsetVal_i	iRes     ,gihRes
	FLsetVal_i	iDist	 , gihDist
	FLsetVal_i	iNPoles	 , gihNPoles

	FLsetVal_i	iDstAmt  ,gihDstAmt
	FLsetVal_i	iDstTon  ,gihDstTon

	FLsetVal_i	iChoAmt  ,gihChoAmt
	FLsetVal_i	iChoDep  ,gihChoDep
	FLsetVal_i	iChoRte  ,gihChoRte

	FLsetVal_i	iDlyAmt  ,gihDlyAmt
	FLsetVal_i	iDlyTim  ,gihDlyTim
	FLsetVal_i	iDlyFB   ,gihDlyFB

	FLsetVal_i	iRvbAmt  ,gihRvbAmt
	FLsetVal_i	iRvbTim  ,gihRvbTim
	
	FLsetVal_i	iMRetrig ,gihMRetrig

 	FLsetVal_i	iSubOsc		,gihSubOsc		
 	FLsetVal_i	iPWobAmt        ,gihPWobAmt         
 	FLsetVal_i	iPWobRte        ,gihPWobRte         
 	FLsetVal_i	iFiltLFOType    ,gihFiltLFOType     
 	FLsetVal_i	iFLFOAmt        ,gihFLFOAmt         
 	FLsetVal_i	iFLFORte        ,gihFLFORte         

  	FLsetVal_i	iwave2		,gihwave2
  	FLsetVal_i	iOsc2OnOff	,gihOsc2OnOff
  	FLsetVal_i	ipw2		,gihpw2
  	FLsetVal_i	isemis		,gihsemis
  	FLsetVal_i	icents		,gihcents
  	FLsetVal_i	imul2		,gihmul2
  	FLsetVal_i	iharm2		,gihharm2
  	FLsetVal_i	ilh2		,gihlh2
  	FLsetVal_i	ifmd2		,gihfmd2
  	FLsetVal_i	imvt2		,gihmvt2
  	FLsetVal_i	iNOsc2		,gihNOsc2

  	FLsetVal_i	iSpatMix	,gihSpatMix
  	FLsetVal_i	iSpatWidth	,gihSpatWidth

  	FLsetVal_i	ifmd	,gihfmd
  	FLsetVal_i	imvt	,gihmvt
  	FLsetVal_i	iNOsc	,gihNOsc

  	FLsetVal_i	iOsc1Lev	,gihOsc1Lev
  	FLsetVal_i	iOsc2Lev	,gihOsc2Lev

	FLsetVal_i	iPolyLimit	,gihPolyLimit	
	FLsetVal_i	iPLimitMode	,gihPLimitMode	
	FLsetVal_i	iAmpVel	        ,gihAmpVel	
	FLsetVal_i	iFiltVel	,gihFiltVel	
	FLsetVal_i	iVelCurve	,gihVelCurve	
	FLsetVal_i	iModShape	,gihModShape	
	FLsetVal_i	iPolyIIMode	,gihPolyIIMode		

	event_i	"i",109,0.01,0.01	;read and write preset name
endin


instr	103	; save bank
	ftsave "MonoPolySynthIIPresetsBank.txt", 1, 	1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,\
101,\
102,\
103,\
104,\
105,\
106,\
107,\
108,\
109,\
110,\
111,\
112,\
113,\
114,\
115,\
116,\
117,\
118,\
119,\
120,\
121,\
122,\
123,\
124,\
125,\
126,\
127,\
128,\
129,\
130,\
131,\
132,\
133,\
134,\
135,\
136,\
137,\
138,\
139,\
140,\
141,\
142,\
143,\
144,\
145,\
146,\
147,\
148,\
149,\
150,\
151,\
152,\
153,\
154,\
155,\
156,\
157,\
158,\
159,\
160,\
161,\
162,\
163,\
164,\
165,\
166,\
167,\
168,\
169,\
170,\
171,\
172,\
173,\
174,\
175,\
176,\
177,\
178,\
179,\
180,\
181,\
182,\
183,\
184,\
185,\
186,\
187,\
188,\
189,\
190,\
191,\
192,\
193,\
194,\
195,\
196,\
197,\
198,\
199,\
200,\
201,\
202,\
203,\
204,\
205,\
206,\
207,\
208,\
209,\
210,\
211,\
212,\
213,\
214,\
215,\
216,\
217,\
218,\
219,\
220,\
221,\
222,\
223,\
224,\
225,\
226,\
227,\
228,\
229,\
230,\
231,\
232,\
233,\
234,\
235,\
236,\
237,\
238,\
239,\
240,\
241,\
242,\
243,\
244,\
245,\
246,\
247,\
248,\
249,\
250,\
251,\
252,\
253,\
254,\
255,\
256,\
257,\
258,\
259,\
260,\
261,\
262,\
263,\
264,\
265,\
266,\
267,\
268,\
269,\
270,\
271,\
272,\
273,\
274,\
275,\
276,\
277,\
278,\
279,\
280,\
281,\
282,\
283,\
284,\
285,\
286,\
287,\
288,\
289,\
290,\
291,\
292,\
293,\
294,\
295,\
296,\
297,\
298,\
299,\
300,\
301,\
302,\
303,\
304,\
305,\
306,\
307,\
308,\
309,\
310,\
311,\
312,\
313,\
314,\
315,\
316,\
317,\
318,\
319,\
320,\
321,\
322,\
323,\
324,\
325,\
326,\
327,\
328,\
329,\
330,\
331,\
332,\
333,\
334,\
335,\
336,\
337,\
338,\
339,\
340,\
341,\
342,\
343,\
344,\
345,\
346,\
347,\
348,\
349,\
350,\
351,\
352,\
353,\
354,\
355,\
356,\
357,\
358,\
359,\
360,\
361,\
362,\
363,\
364,\
365,\
366,\
367,\
368,\
369,\
370,\
371,\
372,\
373,\
374,\
375,\
376,\
377,\
378,\
379,\
380,\
381,\
382,\
383,\
384,\
385,\
386,\
387,\
388,\
389,\
390,\
391,\
392,\
393,\
394,\
395,\
396,\
397,\
398,\
399,\
400,\
401,\
402,\
403,\
404,\
405,\
406,\
407,\
408,\
409,\
410,\
411,\
412,\
413,\
414,\
415,\
416,\
417,\
418,\
419,\
420,\
421,\
422,\
423,\
424,\
425,\
426,\
427,\
428,\
429,\
430,\
431,\
432,\
433,\
434,\
435,\
436,\
437,\
438,\
439,\
440,\
441,\
442,\
443,\
444,\
445,\
446,\
447,\
448,\
449,\
450,\
451,\
452,\
453,\
454,\
455,\
456,\
457,\
458,\
459,\
460,\
461,\
462,\
463,\
464,\
465,\
466,\
467,\
468,\
469,\
470,\
471,\
472,\
473,\
474,\
475,\
476,\
477,\
478,\
479,\
480,\
481,\
482,\
483,\
484,\
485,\
486,\
487,\
488,\
489,\
490,\
491,\
492,\
493,\
494,\
495,\
496,\
497,\
498,\
499,\
500
endin


instr	104	; load bank
	ftload "MonoPolySynthIIPresetsBank.txt", 1, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,\
101,\
102,\
103,\
104,\
105,\
106,\
107,\
108,\
109,\
110,\
111,\
112,\
113,\
114,\
115,\
116,\
117,\
118,\
119,\
120,\
121,\
122,\
123,\
124,\
125,\
126,\
127,\
128,\
129,\
130,\
131,\
132,\
133,\
134,\
135,\
136,\
137,\
138,\
139,\
140,\
141,\
142,\
143,\
144,\
145,\
146,\
147,\
148,\
149,\
150,\
151,\
152,\
153,\
154,\
155,\
156,\
157,\
158,\
159,\
160,\
161,\
162,\
163,\
164,\
165,\
166,\
167,\
168,\
169,\
170,\
171,\
172,\
173,\
174,\
175,\
176,\
177,\
178,\
179,\
180,\
181,\
182,\
183,\
184,\
185,\
186,\
187,\
188,\
189,\
190,\
191,\
192,\
193,\
194,\
195,\
196,\
197,\
198,\
199,\
200,\
201,\
202,\
203,\
204,\
205,\
206,\
207,\
208,\
209,\
210,\
211,\
212,\
213,\
214,\
215,\
216,\
217,\
218,\
219,\
220,\
221,\
222,\
223,\
224,\
225,\
226,\
227,\
228,\
229,\
230,\
231,\
232,\
233,\
234,\
235,\
236,\
237,\
238,\
239,\
240,\
241,\
242,\
243,\
244,\
245,\
246,\
247,\
248,\
249,\
250,\
251,\
252,\
253,\
254,\
255,\
256,\
257,\
258,\
259,\
260,\
261,\
262,\
263,\
264,\
265,\
266,\
267,\
268,\
269,\
270,\
271,\
272,\
273,\
274,\
275,\
276,\
277,\
278,\
279,\
280,\
281,\
282,\
283,\
284,\
285,\
286,\
287,\
288,\
289,\
290,\
291,\
292,\
293,\
294,\
295,\
296,\
297,\
298,\
299,\
300,\
301,\
302,\
303,\
304,\
305,\
306,\
307,\
308,\
309,\
310,\
311,\
312,\
313,\
314,\
315,\
316,\
317,\
318,\
319,\
320,\
321,\
322,\
323,\
324,\
325,\
326,\
327,\
328,\
329,\
330,\
331,\
332,\
333,\
334,\
335,\
336,\
337,\
338,\
339,\
340,\
341,\
342,\
343,\
344,\
345,\
346,\
347,\
348,\
349,\
350,\
351,\
352,\
353,\
354,\
355,\
356,\
357,\
358,\
359,\
360,\
361,\
362,\
363,\
364,\
365,\
366,\
367,\
368,\
369,\
370,\
371,\
372,\
373,\
374,\
375,\
376,\
377,\
378,\
379,\
380,\
381,\
382,\
383,\
384,\
385,\
386,\
387,\
388,\
389,\
390,\
391,\
392,\
393,\
394,\
395,\
396,\
397,\
398,\
399,\
400,\
401,\
402,\
403,\
404,\
405,\
406,\
407,\
408,\
409,\
410,\
411,\
412,\
413,\
414,\
415,\
416,\
417,\
418,\
419,\
420,\
421,\
422,\
423,\
424,\
425,\
426,\
427,\
428,\
429,\
430,\
431,\
432,\
433,\
434,\
435,\
436,\
437,\
438,\
439,\
440,\
441,\
442,\
443,\
444,\
445,\
446,\
447,\
448,\
449,\
450,\
451,\
452,\
453,\
454,\
455,\
456,\
457,\
458,\
459,\
460,\
461,\
462,\
463,\
464,\
465,\
466,\
467,\
468,\
469,\
470,\
471,\
472,\
473,\
474,\
475,\
476,\
477,\
478,\
479,\
480,\
481,\
482,\
483,\
484,\
485,\
486,\
487,\
488,\
489,\
490,\
491,\
492,\
493,\
494,\
495,\
496,\
497,\
498,\
499,\
500
endin

instr	106	; instant load preset (integer buttons)
 iPreset	limit	(int(i(gkPreset)/10)*10) + p4, 0, 499 
 FLsetVal_i	iPreset, gihPreset
 event_i	"i",102,0,0.01
endin

instr	107	; instant load preset (integer buttons)
 iPreset	limit	i(gkPreset) + p4, 0, 499 
 FLsetVal_i	iPreset, gihPreset
 event_i	"i",102,0,0.01
endin

/*
instr	108	; FOR WRITING NAMES USING FLTK
	kKey	FLkeyIn	;SENSE ALPHANUMERIC KEYBOARD INPUT

	;UNCOMMENT THE FOLLOWING LINE IF YOU WANT ALL KEY PRESS VALUES OUTPUT TO THE TERMINAL
		printk2	kKey
	;
	
	kChanged	changed	kKey			;SENSE WHEN A KEY HAS BEEN PRESSED FOR T
	if kKey=112&&kChanged=1 then			;IF ASCCI VALUE OF 112 IS OUTPUT, I.E. 'p' HAS BEEN PRESSED...
	  event	"i", 2, 0, -1				;START INSTRUMENT 2
	elseif kKey=115&&kChanged=1 then		;IF ASCII VALUE OF 115 IS OUTPUT, I.E. 's' HAS BEEN PRESSED...
	  turnoff2	2,0,0				;STOP INSTRUMENT 2
	elseif kKey=61&&kChanged=1 then			;IF ASCII VALUE OF 43 IS OUTPUT, I.E. '+' HAS BEEN PRESSED...
	  gkMIDInote limit gkMIDInote + 1, 0, 127	;INCREMENT MIDI NOTE NUMBER UP ONE STEP
	elseif kKey=45&&kChanged=1 then			;IF ASCII VALUE OF 43 IS OUTPUT, I.E. '-' HAS BEEN PRESSED...
	  gkMIDInote limit gkMIDInote - 1, 0, 127	;DECREMENT MIDI NOTE NUMBER DOWN ONE STEP
	endif						;END OF CONDITIONAL BRANCH
endin
*/

instr	109	; write preset name to GUI 
	/* read preset name */
	repeat:
	Sname,iline	readfi "PresetNames.txt"
	if iline==i(gkPreset) + 1 then
	 gSname	=	Sname
	 FLsetText	"                     ",gihPreset	; first erase
	 FLsetText	gSname, gihPreset			; then write the new name
	 FLhide		gihPreset
	 FLshow		gihPreset

	endif
	if iline!=-1 then
	 igoto repeat
	endif
endin

instr	110	; initial setting of FLTK widgets that are also controllable via MIDI
 FLsetVal_i	0.5,gihpw
endin


</CsInstruments>

<CsScore>
i 11 0 [3600*24*7]	;INSTRUMENT 4 (PING-PONG DELAY)
i 12 0 [3600*24*7]	;INSTRUMENT 5 (REVERB)
i 99 0 [3600*24*7]	;INSTRUMENT 99 (UPDATES FLTK-MIDI SYNC). UPDATES PRESET NAME ON GUI IF PRESET COUNTER IS CHANGED
i 104 0 0.001		;LOAD PRESETS FROM DISK
i 102 0.01 0.001	;LOAD THE FIRST PRESET
i 110 0.001 0.1		;INITIAL SETTING OF FLTK WIDGETS THAT ARE ALSO CONTROLLABLE VIA MIDI
</CsScore>

</CsoundSynthesizer>
