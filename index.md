--- 
title: "Genome Assembly"
author: "officialprofile"
date: "2021-08-18"
site: bookdown::bookdown_site
documentclass: book
bibliography: [book.bib, packages.bib]
url: https://github.com/officialprofile/Genome-assembly/
description: "Low-level approach to genome de novo assembly"
biblio-style: apalike
csl: chicago-fullnote-bibliography.csl
---

# Preface

This mini textbook describes selected algorithms that play a vital role in the *de novo* genome assembly or in some related areas. The premise of this book is to construct these algorithms from the very bottom along with brief explanation of their gists. Naturally, the applications are included as well.

By default the code is written in R, but python and shell can appear at some point as well  (not very likely though).

<img src="img/cover.png" width="80%" style="display: block; margin: auto;" />
<font size="1">A HiFi De Bruijn graph for a pile of reads from Drosophila genome sequencing. Each dot represents a k-mer (k=23), the edges denote neighboring k-mers. The larger red dots mark the head of heterozygous bubbles. Source: pacb.com.</font> 

## Prerequisites

It is assumed that the reader:

1. Has a basic understanding of genetics.

2. Has some experience with programming in R (is familiar with pipe syntax, etc.)

3. Had some contact with higher mathematics, e.g. statistics, graph theory. 

Throughout the book the following libraries are being used and it is assumed that the reader has them loaded.

```r
library(stringr)
library(dplyr)
```
 

