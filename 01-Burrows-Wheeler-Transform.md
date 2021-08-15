# Burrows-Wheeler transform {#bwt}



## Introduction
[Description]

## Burrows-Wheeler matrix

Consider the following sequence:

```r
sequence <- 'GATTACA'
```

In order to create the Burrows-Wheeler matrix for the given string we at first add the dollar sign $ at the end of the sequence.


```r
sequence  <- str_c(sequence, '$')
```

Afterwards we perform a series of shifts 

```r
sequences <- c(sequence)
n         <- nchar(sequence)

for (i in 1:(n-1)){
  sequence <- str_c(str_sub(sequence, 2, n),
                    str_sub(sequence, 1, 1))
  
  sequences <- c(sequences, sequence)
}

cat(sequences, sep = '\n')
#> GATTACA$
#> ATTACA$G
#> TTACA$GA
#> TACA$GAT
#> ACA$GATT
#> CA$GATTA
#> A$GATTAC
#> $GATTACA
```

Then we sort these sequences with the assumption that the dollar sign precedes lexicographically every symbol.


```r
sequences <- sort(sequences) 
cat(sequences, sep = '\n')
#> $GATTACA
#> A$GATTAC
#> ACA$GATT
#> ATTACA$G
#> CA$GATTA
#> GATTACA$
#> TACA$GAT
#> TTACA$GA
```

By putting every letter 


```r
bw.matrix           <- data.frame(matrix(, n, n))
colnames(bw.matrix) <- 1:n

for (i in 1:n){
  bw.matrix[i, ] <- strsplit(sequences[i], split = '')[[1]]
}

knitr::kable(bw.matrix)
```



|1  |2  |3  |4  |5  |6  |7  |8  |
|:--|:--|:--|:--|:--|:--|:--|:--|
|$  |G  |A  |T  |T  |A  |C  |A  |
|A  |$  |G  |A  |T  |T  |A  |C  |
|A  |C  |A  |$  |G  |A  |T  |T  |
|A  |T  |T  |A  |C  |A  |$  |G  |
|C  |A  |$  |G  |A  |T  |T  |A  |
|G  |A  |T  |T  |A  |C  |A  |$  |
|T  |A  |C  |A  |$  |G  |A  |T  |
|T  |T  |A  |C  |A  |$  |G  |A  |

Sequence at the very bottom of the Burrows-Wheeler matrix is called **Burrows-Wheeler transform**.


```r
transform <- paste(bw.matrix[,n], collapse = '')

cat('The Burrows-Wheeler transform of', 
    str_sub(sequence, 2, n), 'is', transform)
#> The Burrows-Wheeler transform of GATTACA is ACTGA$TA
```

## Inverse transform

We are going to reconstruct the Burrows-Wheeler matrix and initial sequence itself. In order to do so one as first has to sort the transformed sequence.


```r
first.sequence <- strsplit(transform, split = '')[[1]] %>% sort
paste(first.sequence, collapse = '')
#> [1] "$AAACGTT"
```

Note that this string is equal to the first column of the Burrrows-Wheeler transform. Also keep in mind that the characters from last and the first column are adjacent. 


```r
bw.inverse           <- data.frame(matrix(, n, 2))
colnames(bw.inverse) <- c(n, 1)

bw.inverse[, 1] <- strsplit(transform, split = '')[[1]]
bw.inverse[ ,2] <- first.sequence

knitr::kable(bw.inverse)
```



|8  |1  |
|:--|:--|
|A  |$  |
|C  |A  |
|T  |A  |
|G  |A  |
|A  |C  |
|$  |G  |
|T  |T  |
|A  |T  |

In other words, a this point we have a set of 2-mers.


```r
kmers <- apply(bw.inverse, 1, 
               function(x) paste(x, collapse = ''))
kmers
#> [1] "A$" "CA" "TA" "GA" "AC" "$G" "TT" "AT"
```

Once again, we strictly rely on the fact that Burrows-Wheeler matrix is sorted lexicographically. This allows us to reconstruct the remaining columns.


```r
kmers <- sort(kmers)
kmers
#> [1] "$G" "A$" "AC" "AT" "CA" "GA" "TA" "TT"
```

These 2-mers (k-mers in general) represent first two columns of the Burrows-Wheeler matrix.

We can derive last characters of the 2-mers in the following way:

```r
sapply(kmers, function(x) str_sub(x, 2, 2), 
       simplify = TRUE, USE.NAMES = FALSE)
#> [1] "G" "$" "C" "T" "A" "A" "A" "T"
```



```r
for (i in 2:(n-1)){
  kmers             <- apply(bw.inverse, 1, 
                             function(x) paste(x, collapse = ''))
  kmers             <- sort(kmers)
  bw.inverse[, i+1] <- sapply(kmers, function(x) str_sub(x, i, i), 
                              simplify = TRUE, USE.NAMES = FALSE)
  colnames(bw.inverse)[i+1] = i
}
knitr::kable(bw.inverse)
```



|8  |1  |2  |3  |4  |5  |6  |7  |
|:--|:--|:--|:--|:--|:--|:--|:--|
|A  |$  |G  |A  |T  |T  |A  |C  |
|C  |A  |$  |G  |A  |T  |T  |A  |
|T  |A  |C  |A  |$  |G  |A  |T  |
|G  |A  |T  |T  |A  |C  |A  |$  |
|A  |C  |A  |$  |G  |A  |T  |T  |
|$  |G  |A  |T  |T  |A  |C  |A  |
|T  |T  |A  |C  |A  |$  |G  |A  |
|A  |T  |T  |A  |C  |A  |$  |G  |

Finally we move first column to the very end


```r
bw.inverse[,n+1] <- bw.inverse[, 1]
bw.inverse       <- bw.inverse[,2:(n+1)]
colnames(bw.inverse)[n] = n

knitr::kable(bw.inverse)
```



|1  |2  |3  |4  |5  |6  |7  |8  |
|:--|:--|:--|:--|:--|:--|:--|:--|
|$  |G  |A  |T  |T  |A  |C  |A  |
|A  |$  |G  |A  |T  |T  |A  |C  |
|A  |C  |A  |$  |G  |A  |T  |T  |
|A  |T  |T  |A  |C  |A  |$  |G  |
|C  |A  |$  |G  |A  |T  |T  |A  |
|G  |A  |T  |T  |A  |C  |A  |$  |
|T  |A  |C  |A  |$  |G  |A  |T  |
|T  |T  |A  |C  |A  |$  |G  |A  |
One can also verify that bw.matrix and bw.inverse are in fact the same. 


```r
knitr::kable(bw.inverse == bw.matrix)
```



|1    |2    |3    |4    |5    |6    |7    |8    |
|:----|:----|:----|:----|:----|:----|:----|:----|
|TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |
|TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |
|TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |
|TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |
|TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |
|TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |
|TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |
|TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |TRUE |

Additionally we can encapsulate Burrows-Wheeler transform in a function


```r
BWT <- function(sequence){
  sequence  <- str_c(sequence, '$')
  sequences <- c(sequence)
  n         <- nchar(sequence)

  for (i in 1:(n-1)){
    sequence <- str_c(str_sub(sequence, 2, n),
                     str_sub(sequence, 1, 1))
    sequences <- c(sequences, sequence)
  }
  sequences <- sort(sequences) 
  
  bw.matrix           <- data.frame(matrix(, n, n))
  colnames(bw.matrix) <- 1:n

  for (i in 1:n){
    bw.matrix[i, ] <- strsplit(sequences[i], split = '')[[1]]
  }
  return(paste(bw.matrix[,n], collapse = ''))
}
```


```r
BWT('GATTACA')
#> [1] "ACTGA$TA"
```
One can verify that this output is equal to result we obteined earlier.

Out of pure curiosity lets check the Burrows-Wheeler transform for a longer sequence.


```r
BWT('ATGCTCGTGCCATCATATAGCGCGCGCGCGATCTCTACGCGCG')
#> [1] "GTTTCCG$TCGGGGGAGGGTTGTCCTCCCCCCATCCAAACCAGA"
```
Please note that the input string has no identical characters at adjacent positions whereas in the transformed sequence such situation appears quite often. These substrings of identical characters will allow us represent the sequence in a more condensed manner.

## Applications
