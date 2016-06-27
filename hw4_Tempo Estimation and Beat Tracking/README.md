# Tempo Estimation and Beat Tracking

## Abstract (assignment spec)
In this homework we will implement algorithms for the following tasks:

  1. Compute the tempo for a given song
  2. Identify every beat position for a given song
  3. Get familiar with the evaluation of these tasks in the MIR field

## Task### Evaluate tempo estimation algorithm on the Ballroom dataset using the Fourier tempogram
Your algorithm should generate two predominant tempo values, 𝑇1 (the slower one) and 𝑇2 (the faster one). Then you also need to compute a “relative saliency of 𝑇1” defined by the strength of 𝑇1 relative to 𝑇2. It is to say, for the Fourier tempogram, we have the saliency 𝑆1 = 𝐹(𝑛, 𝑇1) / (𝐹(𝑛, 𝑇1) + 𝐹(𝑛, 𝑇2)) for a specific time at n. For an excerpt with ground-truth tempo G, the P-score of the excerpt is defined as:
  ![p_score] (./figures/p_score.png)Another score function is the “at least one tempo correct” (ALOTC) score, defined as:
  ![alotc] (./figures/alotc.png)Compute the average P-scores and the ALOTC scores of the eight genres (Cha Cha, Jive, Quickstep, Rumba, Samba, Tango, Viennese Waltz and Slow Waltz) in the Ballroom dataset using your algorithm.

## Prerequisite
  - [Ballroom Dataset and Annotation] (http://mtg.upf.edu/ismir2004/contest/tempoContest/node5.html)
  - For MATLAB users, Matlab Toolbox (**essential**)
	* [Tempogram Toolbox](http://resources.mpi-inf.mpg.de/MIR/tempogramtoolbox/)

## References
  - CS 591 S1 – Computational Audio, W. Snyder, Computer Science Department Boston University