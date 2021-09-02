# Introduction to genome assembly {#introduction}

Genome assembly has been regarded as one of the most important and most challenging problems in bioinformatics, at least since the late 80's, when the Human Genome Project was announced.

Genomes tend to be almost inconceivably long. Human DNA for example is approximately thousand times longer than the Bible, and some species have their genome even dozens times longer than ours. Yet the algorithmic part of the problem arises not mainly because of their length. This was definitely the case for the biotechnologicians, who few decades ago were constrained within insufficiently effective sequencing techniques. From bioinformaticians perspective though the core of the problem is located deeper.

A good analogy, explaining the nature of the challenge, is a schredded newspaper. De novo assembly resembles reconstruction of the original document from a set of its unarranged pieces, like on the figure below. 

<img src="img/intro_assembly.png" width="80%" style="display: block; margin: auto;" />

As one can imagine the problem is difficult, but not because the newspaper has twenty or fourty pages. If we had just one the assembly still wouldn't be easy. The length of the genome, although far from being irrelevant, is for us more of a secondary issue. On the other hand, repetitive patterns, which for biotechnologicians are not a problem at all, will complicate our journey substantially. Reader will perhaps come up to the very similar conclusions as the succeeding topics will uncover.

One should also underline the fact that transcriptome assembly is not the same as the genome assembly. Read coverage of the latter is relatively uniform, whereas transcriptome can be differentially expressed and therefore the frequency of its reads can vary a lot. In genome assembly non-uniform abundance of the reads simply indicates existence of repetitions. In the case of transcription product it is much less straightforward. Methods that overcome this issue exist but they are beyond of the scope of this textbook.

