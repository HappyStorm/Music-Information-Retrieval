# Source Separation

## Abstract (assignment spec)
This assignment provides some hands-on experience in music source separation, using the **Supervised Non-negative Matrix Factorization (NMF)** approach. The goal is to separate violin and clarinet sounds from their mixtures.


See the following link if you need more information about MIDI numbers: [https://newt.phys.unsw.edu.au/jw/notes.html] (https://newt.phys.unsw.edu.au/jw/notes.html)


## Task

```matlab
• a = wavread('01 vio.wav');
```

```matlab
• SDR = bss eval sources((a+0.01*n)',a');
• SDR = bss eval sources((a+n)',a');
• SDR = bss eval sources((a+0.1*b)',a');
• SDR = bss eval sources((a+b)',a');
```
### Inverse STFT
This time, we want to compute the STFT of ‘vio 64.wav’ from the train set, manipulate the spectrogram, and then generate the time-domain signal using inverse STFT (ISTFT). Specifically, use whatever window size and hop size you like to compute the STFT of ‘vio 64.wav’ and then do the following things:

  1. Set all the frequency components under 1,200 Hz to zero in the spectrogram, and then create the time-domain signal by ISTFT (this is equivalent to applying a high- pass filter with cutoff frequency 1,200 Hz). Save the file as ‘vio 64 hp.wav.’

### NMF
Let’s address the following three sub-questions using the Euclidean distance as the cost function for NMF and random initialization for ‘W’ and ‘H.’ First, use NMF to learn three templates from the music clip ‘vio 64.wav’ with whatever window size and hop size you like (e.g. window size 2,048 samples and 50% overlaps). What do the three templates look like in the spectrum? Do they correspond to the pitch of ‘vio 64.wav’? Moreover, use ISTFT to get the time-domain signals of the three templates and plot them.
Second, use NMF to learn another three templates from ‘vio 88.wav’ and compare these templates with the templates learned from ‘vio 64.wav.’


## Prerequisite
  - For MATLAB users, Matlab Toolbox (**essential**)
	* [BSS Eval Toolbox] (http://bass-db. gforge.inria.fr/bss_eval)
	* [Chroma Toolbox] (http://resources.mpi-inf.mpg.de/MIR/chromatoolbox/)
	* [MIR-Toolbox] (https://www.jyu.fi/hum/laitokset/musiikki/en/research/coe/materials/mirtoolbox)
	* [Short-Time Fourier Transform with MATLAB Implementation] (https://www.mathworks.com/matlabcentral/fileexchange/45197-short-time-fourier-transformation--stft--with-matlab-implementation/content/stft.m)
	* [Inverse Short-Time Fourier Transform with MATLAB Implementation] (https://www.mathworks.com/matlabcentral/fileexchange/45577-inverse-short-time-fourier-transformation--istft--with-matlab-implementation/content/istft.m)
	
	
## References
  - C.-J. Lin. Projected gradient methods for non-negative matrix factorization.
    Neural Computation, 19(2007), 2756-2779. [https://www.csie.ntu.edu.tw/~cjlin/nmf/] (https://www.csie.ntu.edu.tw/~cjlin/nmf/)
  - Smith, J.O. Spectral Audio Signal Processing, [http://ccrma.stanford.edu/~jos/sasp/] (http://ccrma.stanford.edu/~jos/sasp/), online book, 2011 edition, accessed <date>.
  - Source Separation Tutorial Mini-Series II: Introduction to Non-Negative Matrix Factorization, N. Bryan, D. Sun, Center for Computer Research in Music and Acoustics, Stanford University, DSP Seminar, April 9th, 2013 [https://ccrma.stanford.edu/~njb/teaching/sstutorial/part2.pdf] (https://ccrma.stanford.edu/~njb/teaching/sstutorial/part2.pdf)
  - Source Separation Tutorial Mini-Series III: Introduction to Non-Negative Matrix Factorization, N. Bryan, D. Sun, Center for Computer Research in Music and Acoustics, Stanford University, DSP Seminar, April 9th, 2013 [https://ccrma.stanford.edu/~njb/teaching/sstutorial/part3.pdf] (https://ccrma.stanford.edu/~njb/teaching/sstutorial/part3.pdf)

