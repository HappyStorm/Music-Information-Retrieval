# Key-Finding Algorithm

## Abstract (assignment spec)
The “**key**” is one of the most important attribute in the music. Given a musical scale, the key defines the “**tonality**”, namely the tonic note and the tonic chord, and the “mode”: whether it is a major key or a minor key.

Usually (but not always), the tonic note is recognized as “**the first note**” or “**the last note**” in a music piece. Moreover, if the chord corresponding to the tonic (i.e. the tonic chord) is a major triad, then the key should be a major key. On the other hand, if the tonic chord is a minor triad, then the key should be a minor key. 

However, in real-world musical data processing we might not know when the first or the last note appears, because sometimes we are given only a fragment of a song. This is the case we meet for the music dataset (GTZAN) provided in this assignment.

## Task

  
  1. **Summing up all the chroma features of the whole music piece into one chroma vector** (this process is usually referred to as **sum pooling**)

  2. Finding the **maximal value in the chroma vector**

  3. Considering the note name corresponding to the maximal value as the tonic pitch. Given a **chromagram C = [c1, c2,...,c𝑁], ci ∈ 𝑅12**

  where **𝑁** is the number of frames, the **summed chroma vector**:
  
  ![x] (./figures/x.png)
  


  ![R] (./figures/R.png)


  ![key_table] (./figures/key_table.png)


  
### Method 2: Krumhansl-Schmuckler Key-Finding Algorithm
A more advanced set of templates for key detection is the **Krumhansl-Schmuckler (K-S)** profile. Instead of using a binary (0 or 1) templates as we did before, we assign numerical values to the template according to the profile numbers shown in the following Table:

  ![ks_table] (./figures/ks_table.png)

These values came from an experiment of human perception. The experiment is done by playing a set of context tones or chords, then playing a probe tone, and asking a listener to rate how well the probe tone fit with the context.


## Prerequisite
  - [GTZAN dataset] (http://marsyas.info/downloads/datasets.html)
  - [Alexander Lerch’s annotation of key on the GTZAN dataset] (https://github.com/alexanderlerch/gtzan_key)
  - For MATLAB users, Matlab Toolbox (**essential**)
	* [Chroma Toolbox](http://resources.mpi-inf.mpg.de/MIR/chromatoolbox/)

## References
  - Ching-Hua Chuan and Elaine Chew. "Audio Key Finding Using the Spiral Array CEG Algorithm". In Pro-ceedings of International Conference on Multimedia
and Expo, 2005.