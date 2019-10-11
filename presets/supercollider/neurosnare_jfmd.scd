(
SynthDef(\neurosnare, {
    var snd;
    // a percussive click to give it some attack
    snd = LPF.ar(HPF.ar(WhiteNoise.ar, 300), 8000) * Env.linen(0.001, 0.01, 0.001).ar;
    // sine sweep body. very important!
	snd = snd + (SinOsc.ar(Env([400, 1.4 * \freq.kr, 160], [0.04, 0.2], \exp).ar) * Env.perc(0.04, 0.2).ar * 6.dbamp).tanh;
    // sound of snare coils rattling
    snd = snd + (HPF.ar(BPeakEQ.ar(WhiteNoise.ar, 4000, 0.5, 3), 300) * Env.perc(0.05, 0.2).delay(0.01).ar(2) * -3.dbamp);
    // another sound sweep to improve the attack, optional
    snd = snd + (SinOsc.ar(XLine.kr(3000, 1500, 0.01)) * Env.perc(0.001, 0.02).ar);
    // distortion helps glue everything together and acts as a compressor
    snd = (snd * 1.4).tanh;
    snd = Pan2.ar(snd, \pan.kr(0), \amp.kr(0.1) * \volume.kr);
    Out.ar(\out.kr(0), snd);
}).add;
)

​
(
var notes, on, off, cc1, cc7;
MIDIClient.init;
MIDIIn.connectAll;

cc1 = MIDIFunc.cc({arg ...args; args.postln}, 1); // match cc 1

~volume = 1;
cc7 = MIDIFunc.cc({ |value, num, chan, src|
    ~volume = value.linlin(0, 127, 0, 1)
}, 7);

p = Pbind(
    \volume, Pfunc { ~volume }    // retrieves value set by MIDI control
);

notes = Array.newClear(128);    // array has one slot per possible MIDI note

on = MIDIFunc.noteOn({ |veloc, num, chan, src|
    notes[num] = Synth(\neurosnare, [\freq, num.midicps,
        \amp, veloc * 0.00315, \volume, Pfunc { ~volume }]);
});

off = MIDIFunc.noteOff({ |veloc, num, chan, src|
    notes[num].release;

});

q = { on.free; off.free; cc1.free; cc7.free; };
)

Synth(\neurosnare, [amp: 0.4]);

~volume.postln;