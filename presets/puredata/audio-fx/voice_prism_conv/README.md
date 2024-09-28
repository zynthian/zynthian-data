# voice_prism_conv

is a [PureData](https://puredata.info/) patch that performs convolution on an icoming audio signal with synth signal. The frequency of the synth and the resulting signal can be controlled with midi notes.  
It is possible to split up (like a prism) the incoming audio signal up to 4 convoluted signals. Thus it is possible to generate chords out one voice.  

Convolution algorithm:  
http://www.pd-tutorial.com/english/ch03s08.html#id432343  


This path has been developed on and for [Zynthian](https://zynthian.org/). On the zynthian it is possible to control
- the output level of the incoming signal
- the output level of the convoluted signal
- squelch (check [this](http://www.pd-tutorial.com/english/ch03s08.html#id432343) for more information)
