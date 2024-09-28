  ___        _            ____                       
 / _ \ _   _| |_ ___ _ __/ ___| _ __   __ _  ___ ___ 
| | | | | | | __/ _ \ '__\___ \| '_ \ / _` |/ __/ _ \
| |_| | |_| | ||  __/ |   ___) | |_) | (_| | (_|  __/
 \___/ \__,_|\__\___|_|  |____/| .__/ \__,_|\___\___|   v 1.0
                               |_|                    
                               
An Ambient Sound Generator for Pure Data. 

Alberto Zin, November 2007 

released under the Gnu Public License v. 2.0


--- DEPENDENCIES ---

OuterSpace depends from freeverb~. You can find it in the Extended 
Pure Data distributions by H. C. Steiner (http://at.or.at/hans/pd/installers.html) 
or in the Pure Data CVS Repository.

Moreover, if you want to use the GriPD graphical user interface (strongly suggested!) 
make sure you have GriPd working in your PD setup. 

OuterSpace was tested on the main platform (Windows, Linux and Mac).


--- INSTALL ---

Unpack the files into your selected directory, for example 
 ./<yourpddirectory>/extra/OuterSpace. 
Make sure that the freeverb~ external is in your PD path. 

In order to use the Gripd GUI you'll probably need to edit the path in the main file 
"OuterSpaceMainGriPDGui.pd" in the call to GriPd. The path is relative to the 
pd executable directory. For example, in my windows setup, Gripd is in ./<yourpddirectory>/Gripd

--- PLAY ---

In order to use the GriPD gui open:

  OuterSpaceMain_GriPDGui.pd

The plain native PD GUI version is:

  OuterSpaceMain_PDGui.pd



--- SOUND ENGINE ---

The main recipe is: a bit of white noise, some band-pass filters, everything
cooked with a lot of reverb. :-)
For mode information about the OuterSpace sound engine and
for the GUI controls see the "readme" and "readme_controls", "readme_controls2"
and "readme_controls3" subpatches in the main patch.
 


--- TIPS ---

0. Let the sound evolve a bit in order to catch all the evolution patterns

1. Change the sliders -> slowly <- in order to avoid sudden 
   frequency / amplitude variations. Pay particular attention  
   to the Volume / Gain and Q sliders. 

2. Try the presets first, then enjoy "Randomize" function.

3. You can Save / Load presets. Few examples in 
   ./<yourpddirectory>/extra/OuterSpace/data)


--- WARRANTY ---

No warranty at all. The patch is provided "as-is",
without any express or implied warranty. In no event shall the author
be held liable for any damages arising for use of this patch.


Enjoy OuterSpace !

Feedback (of every type) is strongly encouraged:

Alberto.Zin@poste.it

