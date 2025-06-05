What is UPAW?

The Waldorf Microwave synthesizers have beside the 'classic'  wavetables made from short
samples/waves also the possibility to use so called 'algorithmic' wavetables. Some of these 
wavetables can be programmed by the user (for that reason called 'User Programmable 
Algorithmic Wavetables', UPAW), though at this moment this has to be done on a computer and 
transmitted to the MW.

The algorithmes/models that are accessible are:
- 4 Operator FM
- Waveshaping
- Envelope Mode , this is the model closest related to the standard wavetablemechanism,
  only simple shapes, but you can define your own interpolationscheme (sort of ...)
- Sync/Pulsewidth mode

With some programming switching from one model to another  in one wavetable is possible!
Documentation on UPAW is available on the Waldorf FTP site on
ftp://ftp.waldorf-gmbh.de/pub/waldorf/microwave/microwave2_0/doc/

Why using UPAW?

The interpolation method as used for 'classic' wavetables uses the amplitudes of waves for 
calculation, which gives you less control over the frequency spectrum morphing (or you must 
be a master in fourier transforms!). On the other hand most of the UPAW tables the 
interpolation is more based on controlled frequency spectrum changes, which result in 
another sonic taste of the wavetables.
Beside the mathematic argument you can generate some really cool wavetables!!!

How to UPAW?

At this moment only Emagic Sounddiver has a workbench for making UPAW's.

UPAW Bank

As a 'and now for something completely different' project I decided to make a bank for the 
MWII/XT with sounds made of UPAW tables. This set contains 21 UPAW tables and 128 single 
sounds:

UserWavetables

Loc.	Wavetables		User#
107	F24OCTWON		11
108	F24OCTWOFF		12
109	FMSWEEP1		13
110	FWSWEEP2		14
111	Shapeswp		15	
112	Waveshape		16
113	Sync1			17
114	envel1			18
115	env PWM			19
116	envLFOIDS		20
117	FM BASS			21
118	FM SHP Mix		22
119	Env swpje		23
120	FM Mod swp		24
121	FM Harsh		25
122	Bass swp		26
123	Random1			27
124	Waveshap2		28
125	Switch Env/ FM		29
126	Shape+Scan		30
127	Env Echo		31

Patches (Single Sound)

Loc.	Patchname

B001	Tablescan11 HH
B002	Bass1 U11
B003	Pad1 UP11
B004	Pad2 UP11
B005	Pad3 UP11
B006	Pad4 Up11
B007	Tablescan12 HH
B008	Arpp1 U12
B009	Pad1 UP12
B010	RingMod UP12
B011	Pad2 UP12
B012	Pad3 UP12
B013	Pad4 UP12
B014	Tablescan13 HH
B015	waterysaw up13
B016	Sweep UP13
B017	Sweep2 UP13
B018	Pad UP13
B019	Tablescan14 HH
B020	Pad UP14
B021	MwheelPad UP14
B022	Pad2 UP14
B023	Pluck up14
B024	NOT a Multi UP14
B025	Tablescan15 HH
B026	Pad1 UP15
B027	Pad2 UP15
B028	Pad3 UP15
B029	Pluck up15
B030	Pluck2 up15
B031	Bass UP15
B032	Tablescan16 HH
B033	StenzelGeiger 16
B034	SambaWhstle up16
B035	ArpClose UP16
B036	Tungstenstrngs16
B037	Tablescan17 HH
B038	UPAWCHOIR UP17
B039	Rezzz  UP17
B040	Pad UP17
B041	Dbl Sync UP17
B042	PanPad UP17
B043	WooferTest UP17
B044	Tablescan18 HH
B045	BassPad up18
B046	ScanPad Up18
B047	Pad1 UP18
B048	Scarlatti UP18
B049	Pad2 UP18
B050	Tablescan19 HH
B051	Pad1 Up19
B052	NiceArp UP19
B053	Bass up19
B054	Bass2 UP19
B055	Alta Pd UP19
B056	Tablescan20 HH
B057	Chowing UP20
B058	Hop OP OP UP20
B059	Bass1 UP20
B060	Eysbout UP20
B061	Wavedrum up20
B062	Tablescan21 HH
B063	Organ UP21
B064	WavePiano up21
B065	Bass1 Up21
B066	Bass2 up21
B067	Pad UP21
B068	Tablescan22 HH
B069	SampleHldPd Up22
B070	HonkyTonk UP22
B071	Bass Up22
B072	Whaling UP22
B073	Waterdome   UP22
B074	Wve Drops UP22
B075	Tablescan23 HH
B076	Pad UP23
B077	SuperFM UP23
B078	Organ UP23
B079	Pluck UP23
B080	Waldhorn UP23
B081	Tablescan24 HH
B082	DistOrg UP24
B083	SeqNotes UP24
B084	Sweep UP24
B085	NotchChoir UP24
B086	RichPad UP24
B087	LateWave UP24
B088	Tablescan25 HH
B089	SandHPad UP25
B090	EvoPad UP25
B091	Friendly Bass 25
B092	Tablescan26 HH
B093	DistBass UP26
B094	KarlHeinz UP26
B095	BasSwirl UP26
B096	No Res StllFun26
B097	ArpShape UP26
B098	Tablescan27 HH
B099	ChopSticks UP27
B100	MetalPlck UP27
B101	HitIt Up27
B102	Sharp Metal Up27
B103	GaCHAGA UP27
B104	Tablescan28 HH
B105	WaveWood UP28
B106	Pad1 UP28
B107	FM Arp Up28
B108	Sizzle Up28
B109	Pad2 Up28
B110	SHPAD UP28
B111	Tablescan29 HH
B112	Pad1 Up29
B113	PolyRythm UP29
B114	MetalPad UP29
B115	RotterARP UP29
B116	1950Tapes UP29
B117	Tablescan30 HH
B118	UPAW Robots UP30
B119	PercusKIT UP30
B120	Pad1 UP30
B121	Pad2 UP30
B122	UPAWARP UP30
B123	Tablescan31 HH
B124	Titanic UP31
B125	EchoPad Up31
B126	Metal UP31
B127	Bass UP31
B128	Triolish UP31

WARNING : If you load this file you'll loose the former patches in bank B and 
userwavetables 11 to 31 !

The wavetables are made using different models. The structure of the bank is : patch 
TABLESCANnn : A slow waveenvelopescan of userwavetable nn. This shows the 'mood' of the 
wavetable, and is a good base to start your own programming . This patch is followed by a 
couple of patches using this wavetable. The number of the wavetable is also in the patchname 
(UPnn). The names of the patches are sometimes selfexplaining, sometimes not. Often a 
factorypatch of the MWII or the MWI is used as base for the patch . I have tried to cover a 
broad range of sounds : from nearly FM Soundblasterlike GM ('B034 SambaWhstle up16' or 'B070 
HonkyTonk UP22' ) to experimental stuff like 'B094 KarlHeinz UP26' . ALL the patches use 
some kind of Waveposition modulation! 

I hope these sounds are useful for your music!


Hans Heerooms
hansh@simplex.nl

April 1999

Files : 
UPAWBNK.MID (midifile)
UPAWBNK.LIB (Sounddiver library file)



