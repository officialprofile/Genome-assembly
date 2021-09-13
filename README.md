## Genome Assembly Cookbook. Low-level Recipes with R 

[**Read the textbook online**](https://officialprofile.github.io/GenomeAssembly/) | **Download** [**PDF**](https://raw.githubusercontent.com/officialprofile/GenomeAssembly/main/Genome-Assembly.pdf) **or** [**epub**](https://raw.githubusercontent.com/officialprofile/GenomeAssembly/main/Genome-Assembly.epub) **version** | [Track the progress of this project](https://github.com/users/officialprofile/projects/2)

This mini textbook describes selected algorithms that play a fundamental role in genome assembly. The premise of this book is to construct the algorithms from the very bottom and explain step by step main ideas that stand behind them.

We will try to avoid as much as possible ready-to-use implementations, which are of course available and of good quality, but their use wouldn't serve the educational purpose. Naturally, many applications are included as well.

By default the code is written in R, but at certain points python is also being mentioned.

It is assumed that the reader:
1. Has a basic understanding of genetics;
2. Has some experience with programming in R (is familiar with loops, data structures, etc.).
3. Had some contact with higher mathematics, e.g. statistics, graph theory. Expertise in this field is by no means required though.

Throughout the book the following libraries are being used and it is assumed that the reader has them loaded.

```r
library(stringr)
library(dplyr)
library(igraph)
```

