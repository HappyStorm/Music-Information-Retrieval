# Instrument Classification

## Abstract (assignment spec)
Instrument **Recognition/Classification** is a fundamental task in music information retrieval (MIR). In this assignment, we would like to implement a classifier for that. While there are many instruments in the world, we consider the following four in this homework:

-	Acoustic Guitar
-	Violin
- 	Piano
-  	Human Singing Voice

## TaskFor the training set, there are 200 audio examples for each instrument, totalling 800 clips. These files are put under different subfolders in the audio folder, so we know their groundtruth labels. Besides, there are 200 non-labeled clips for testing and they are also in the audio folder. All of these 1,000 clips are sampled at 16kHz. Each clip is associated with only one instrument.
The task is to build a multi-class classifier from the training set to discriminate the four instruments, and then to apply the classifier to the test set.

## Prerequisite
  - Matlab Toolbox (**essential**)
	* [Auditory Toolbox](https://engineering.purdue.edu/~malcolm/interval/1998-010/)
	* [MIR-Toolbox] (https://www.jyu.fi/hum/laitokset/musiikki/en/research/coe/materials/mirtoolbox)
	* [LIBSVM -- A Library for Support Vector Machines] (https://www.csie.ntu.edu.tw/~cjlin/libsvm/)
	
## Relative Figures
  - Spectrum of Piano #19 (window size: 1024, hop size: 512)
  	![piano19_w1024_h512.jpg] (./figures/piano19_w1024_h512.jpg)
  - Spectrum of Piano #19 (window size: 2048, hop size: 1024)
  	![piano19_w1024_h512.jpg] (./figures/piano19_w2048_h1024.jpg)
  - Spectrum of Piano #69 (window size: 1024, hop size: 512)
  	![piano19_w1024_h512.jpg] (./figures/piano69_w1024_h512.jpg)
  - Spectrum of Piano #69 (window size: 2048, hop size: 1024)
  	![piano19_w1024_h512.jpg] (./figures/piano69_w1024_h512.jpg)
  - Spectrum of Violin #19 (window size: 1024, hop size: 512)
  	![piano19_w1024_h512.jpg] (./figures/violin19_w1024_h512.jpg)
  - Spectrum of Violin #83 (window size: 1024, hop size: 512)
  	![piano19_w1024_h512.jpg] (./figures/violin83_w1024_h512.jpg)	
  	
## References
  - Zhang, X. and Ras, Z.W. (2006A). “Differentiated Harmonic Feature Analysis on Music Information Retrieval For Instrument Recognition,” proceeding of IEEE International Conference on Granular Computing, May 10-12, Atlanta, Georgia, 578-581.
  - J. D. Deng, C. Simmermacher, and S. Cranefield, “A Study on Feature
Analysis for Musical Instrument Classification,” IEEE Trans. Syst., Man
Cybern. B: Cybern., vol. 38, no. 2, pp. 429–438, Apr. 2008.
  - M. Mandel and D. Ellis, “Song-Level Features and SVMs for Music Classification,” in Proc. ISMIR, 2005.