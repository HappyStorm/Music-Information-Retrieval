# Key-Finding Algorithm

## Abstract (assignment spec)
The “**key**” is one of the most important attribute in the music. Given a musical scale, the key defines the “**tonality**”, namely the tonic note and the tonic chord, and the “mode”: whether it is a major key or a minor key.

Usually (but not always), the tonic note is recognized as “**the first note**” or “**the last note**” in a music piece. Moreover, if the chord corresponding to the tonic (i.e. the tonic chord) is a major triad, then the key should be a major key. On the other hand, if the tonic chord is a minor triad, then the key should be a minor key. 

However, in real-world musical data processing we might not know when the first or the last note appears, because sometimes we are given only a fragment of a song. This is the case we meet for the music dataset (GTZAN) provided in this assignment.

## Task### Method 1: Binary template matching, with tonic note obtained from the term frequency
In this method, we assume that the tonic pitch is the one which appears most often. Therefore, a simple idea of finding the tonic pitch is to:
  
  1. **Summing up all the chroma features of the whole music piece into one chroma vector** (this process is usually referred to as **sum pooling**)

  2. Finding the **maximal value in the chroma vector**

  3. Considering the note name corresponding to the maximal value as the tonic pitch. Given a **chromagram C = [c1, c2,...,c𝑁], ci ∈ 𝑅12**

  where **𝑁** is the number of frames, the **summed chroma vector**:
  
  ![x] (./figures/x.png)
  Knowing the tonic, the next step is to find the diatonic scale “embedded” in the music piece. Based on the idea of template matching, this can be done by finding the correlation coefficient between the summed chroma features and the template for the diatonic scale. For example, if we have found that the tonic is C, then we generate **two templates**, one for **C major key** and the other for **c minor key**:
  ![binary_template] (./figures/binary_template_1.png)While the first index is for C note, the second for C# note, ..., and the last index for B note. The **correlation coefficient** is:

  ![R] (./figures/R.png)
where **𝑥** is the **summed chroma vector** and **𝑦** is the **template for a key**. There are 24 possible keys, and according to Alexander Lerch’s annotation, they are indexed as(upper case means major key and lower case means minor key):

  ![key_table] (./figures/key_table.png)
If the tonic number is given as 0 ≤ 𝑗 ≤ 11, we only have to compare the correlation coefficients between 𝑅(𝑥, 𝑦(𝑗)) (major key) and 𝑅(𝑥, 𝑦(𝑗+12)) (minor key). If 𝑅(𝑥, 𝑦(𝑗)) > 𝑅(𝑥, 𝑦(𝑗+12)), we say the music piece is in the j major key, otherwise it is in j minor key. A music piece only has one key. The accuracy of key finding can therefore be define as:
  ![ACC] (./figures/ACC.png)
  
### Method 2: Krumhansl-Schmuckler Key-Finding Algorithm
A more advanced set of templates for key detection is the **Krumhansl-Schmuckler (K-S)** profile. Instead of using a binary (0 or 1) templates as we did before, we assign numerical values to the template according to the profile numbers shown in the following Table:

  ![ks_table] (./figures/ks_table.png)

These values came from an experiment of human perception. The experiment is done by playing a set of context tones or chords, then playing a probe tone, and asking a listener to rate how well the probe tone fit with the context.
Therefore, in Method 2, we consider using the correlation coefficient between the input chroma features and the K-S profile for key detection. Notice that the major and minor profiles are rendered by different values. In this task we don’t need to probe the tonic first, but just need to find the maximal correlation coefficient among the major profile, minor profile, and the 12 circular shifts of them, respectively. A web resource [http://rnhart.net/articles/key-finding/] (http://rnhart.net/articles/key-finding/) nicely demonstrates this idea.

## Prerequisite
  - [GTZAN dataset] (http://marsyas.info/downloads/datasets.html)
  - [Alexander Lerch’s annotation of key on the GTZAN dataset] (https://github.com/alexanderlerch/gtzan_key)
  - For MATLAB users, Matlab Toolbox (**essential**)
	* [Chroma Toolbox](http://resources.mpi-inf.mpg.de/MIR/chromatoolbox/)

## References
  - Ching-Hua Chuan and Elaine Chew. "Audio Key Finding Using the Spiral Array CEG Algorithm". In Pro-ceedings of International Conference on Multimedia
and Expo, 2005.