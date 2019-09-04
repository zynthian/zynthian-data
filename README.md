# zynthian-data

[Zynthian](http://zynthian.org) is an Open Synth Platform based in Raspberry Pi, Linux (Raspbian) and Open Software Synthesizers.

![Image of Zynthian Box Design](http://zynthian.org/img/github/zynthian_v3_backside.jpg)

This repository contains configuration files, presets, samples, ... for the different synth engines used in Zynthian.

You have to put your samples in "zynthian-data/soundfonts", organized by type, in three subdirectories:

```
cd zynthian-data/soundfonts
mkdir gig
mkdir sfz
mkdir sf2
```
 
Also, you have to create a symlink to your ZynAddSubFX bank directory:

```
cd zynthian-data
ln -s your/zasfx/bankdir/path zynbanks
```

You can learn more about the Zynthian Project reading [the blog](http://blog.zynthian.org) or visiting [the website](http://zynthian.org). Also, you can join the conversation in [the forum](https://discourse.zynthian.org).
