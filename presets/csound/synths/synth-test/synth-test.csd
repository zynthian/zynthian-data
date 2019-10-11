<CsoundSynthesizer>
<CsOptions>
-Ma --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>

instr 1
iFreq = p4
iAmp = p5
iAtt = 0.1
iDec = 0.4
iSus = 0.6
iRel = 0.7
iCutoff = 5000
iRes = .4
kEnv madsr iAtt, iDec, iSus, iRel 
aVco vco2 iAmp, iFreq
aLp moogladder aVco, iCutoff*kEnv, iRes
out aLp*kEnv
endin

</CsInstruments>
<CsScore>
f0 3600
</CsScore>
</CsoundSynthesizer>
