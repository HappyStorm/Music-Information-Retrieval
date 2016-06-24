# Source Separation

## Abstract (assignment spec)
This assignment provides some hands-on experience in music source separation, using the **Supervised Non-negative Matrix Factorization (NMF)** approach. The goal is to separate violin and clarinet sounds from their mixtures.
For the training set, there are clean source signals of single notes of the violin and the clarinet, in the train sub-folder of the audio folder. There are 45 clips for the violin (from MIDI number 55 to 99; in the vio sub-folder), and 40 clips for the clarinet (from MIDI number 50 to 89; in the cla sub-folder).

See the following link if you need more information about MIDI numbers: [https://newt.phys.unsw.edu.au/jw/notes.html] (https://newt.phys.unsw.edu.au/jw/notes.html)The validation set in the validation sub-folder contains the groundtruth source signals of five 5-second violin clips (e.g. '01 vio.wav'), clarinet clips (e.g. '01 cla.wav') and their mixtures (e.g. '01 mix.wav'). The goal of source separation is to recover the source signals of the two instrument from a mixture signal. You can use the validation set to compare the performance of different algorithms.
The test set in the test sub-folder contains another five mixtures of violin and clarinet signals.

## Task### BSS EvalThis task leads you to get familiar with the [BSS Eval toolbox] (http://bass-db. gforge.inria.fr/bss_eval) for assessing the performance of source separation. Here, we are going to use three audio files from the validation set: '01 vio.wav,' '01 cla.wav,' and '01 mix.wav.' First, use Matlab (or Python) to load the audio files:

```matlab
• a = wavread('01 vio.wav');• b = wavread('01 cla.wav');• c = wavread('01 mix.wav');• n = randn(length(a), 1); % normally distributed pseudorandom numbers
```Then, compute the source-to-distortion ratio (SDR) for the following inputs:

```matlab• SDR = bss eval sources([c'; c']/2,[a'; b']);• SDR = bss eval sources([a'; b'],[a'; b']);• SDR = bss eval sources([b'; a'],[a'; b']);• SDR = bss eval sources([2*a'; 2*b'],[a'; b']);
• SDR = bss eval sources((a+0.01*n)',a');• SDR = bss eval sources((a+0.1*n)',a');
• SDR = bss eval sources((a+n)',a');• SDR = bss eval sources((a+0.01*b)',a');
• SDR = bss eval sources((a+0.1*b)',a');
• SDR = bss eval sources((a+b)',a');
```
### Inverse STFT
This time, we want to compute the STFT of ‘vio 64.wav’ from the train set, manipulate the spectrogram, and then generate the time-domain signal using inverse STFT (ISTFT). Specifically, use whatever window size and hop size you like to compute the STFT of ‘vio 64.wav’ and then do the following things:

  1. Set all the frequency components under 1,200 Hz to zero in the spectrogram, and then create the time-domain signal by ISTFT (this is equivalent to applying a high- pass filter with cutoff frequency 1,200 Hz). Save the file as ‘vio 64 hp.wav.’  2. Set all the frequency components over 1,200 Hz to zero in the spectrogram, and then create the time-domain signal by ISTFT (this is equivalent to applying a low-pass filter). Save the file as ‘vio 64 lp.wav.’  3. Plot the spectrogram of ‘vio 64.wav,’ ‘vio 64 hp.wav,’ and ‘vio 64 lp.wav’ and dis- cuss their differences.  4. Listen to the three files and discuss their differences.  5. Compute the SDR between ‘vio 64.wav’ and ‘vio 64 lp.wav,’ by using the former one as the true source and the latter as the estimated source.

### NMF
Let’s address the following three sub-questions using the Euclidean distance as the cost function for NMF and random initialization for ‘W’ and ‘H.’ First, use NMF to learn three templates from the music clip ‘vio 64.wav’ with whatever window size and hop size you like (e.g. window size 2,048 samples and 50% overlaps). What do the three templates look like in the spectrum? Do they correspond to the pitch of ‘vio 64.wav’? Moreover, use ISTFT to get the time-domain signals of the three templates and plot them.
Second, use NMF to learn another three templates from ‘vio 88.wav’ and compare these templates with the templates learned from ‘vio 64.wav.’Finally, use NMF to learn another three templates from ‘cla 64.wav’ and compare these templates with the templates learned from ‘vio 64.wav.’


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


