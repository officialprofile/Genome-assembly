--- 
title: "Genome Assembly"
subtitle: "Low-level approach with R"
author: "officialprofile"
date: "2021-08-15"
site: bookdown::bookdown_site
documentclass: book
bibliography: [book.bib, packages.bib]
url: https://officialprofile.github.io/Genome-assembly/
description: "Low-level approach to genome assembly"
biblio-style: apalike
csl: chicago-fullnote-bibliography.csl
---

# Introduction

This mini textbook describes (or perhaps one should say "will describe") selected algorithms that play a vital role in the *de novo* genome assembly or in some related areas.

The premise of this book is to construct these algorithms from the very bottom along with explaining their gists. Naturally, the applications are included as well.

By default the code is written in R, but python and shell can appear at some point as well.

## Prerequisites

It is assumed that the reader

1. has a basic understanding of genetics,

2. has some experience with programming in R,

3. had some contact with higher mathematics, e.g. probability, statistics, graph theory. 

Reader should also be familiar with the pipe %>% syntax that is derived from dplyr package. 

Throughout the book the following libraries are being used and it is assumed that the reader has them loaded.

```r
library(stringr)
library(dplyr)
```
 

