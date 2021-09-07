# Basic string manipulations {#basic}

Before we dive into the main topics let's warm up with few basic exercises. On the one hand some of these problems might be regarded as a form of general familiarization with string manipulations. Being able to get through them is in a sense a must, at least from a perspective of algorithms that will be discussed later. On the other hand some of the problems, like generating k-mers or suffixes, are absolutely crucial in genome assembly and one has to know them to a tee. So, without further ado, let's do the warm up.

## Generae random DNA sequence

Let's start with writing a function that, for a given integer n > 0, returns randomly generated DNA sequence.


```r
random_sequence <- function(n){
  return(sample(c('A','C','G','T'), n, replace = TRUE))
}

random_sequence(10)
#>  [1] "A" "A" "G" "C" "C" "G" "G" "A" "T" "G"
```
If we want our returned sequence to be in a form of a single string we can use `paste()` function with collapse parameter equal to `''`.


```r
paste(random_sequence(10), collapse = '')
#> [1] "GTTGAGTTAC"
```

Unfortunately, there is no a convenient way of retrieving a substring. If a `DNA` variable is equal to `'ACGTG'` then we won't get a substring `'CG'` simply by writing `DNA[2:3]` (one could to this in python). One could do this by employing the `substr()` function, i.e. `substr(DNA, 2, 3)`. On the other hand, if DNA is a vector `c('A', 'C', 'G', 'T', 'G')` then `DNA[2:3]` will return `c('C', 'G')` that in turn can be merged into `'CG'` by `paste()`. Either way, one must use a certain function in order to glue the letters or to split the sequence.

## Find cDNA

To find the complementary sequence one must know that C (cytosine) is complementary to G (guanine), and A (adenine) is complementary to T (thymine). Also, before creating the cDNA we will at first construct a list (in Python it would be a dictionary) of complementary nucleobases.


```r
c_bases <- list('A' = 'T', 'C' = 'G', 'G' = 'C', 'T' = 'A')

c_bases['A'][[1]]
#> [1] "T"
```

This data structure allows us to directly access complementary bases. Let's build a function that utilizes this.


```r
complementary_sequence <- function(sequence){
  complementary = c()
  for (base in sequence){
    complementary = c(complementary, c_bases[base][[1]])
  }
  return(complementary)
}
```

Please note that we append complementary nucleobase in a seemingly non-optimal way, namely by writing `sequence = c(sequence, new_nucleobase)`. One could argue that this should be done with `append()`, i. e. `sequence = append(sequence, new_nucleobase)`, but in fact the append in R is regarded as a relatively slow function and our solution is usually more recommended (in python using append is fine). 


```r
seq <- random_sequence(20)
cat(' DNA =', seq, '\n')
#>  DNA = C G G A C A A T G A A C G A G A T G G G
cseq <- complementary_sequence(seq)
cat('cDNA =', cseq)
#> cDNA = G C C T G T T A C T T G C T C T A C C C
```

There is also a neater way to compute, and in a way avoid, these kind of loops. One can achieve this though functions like `apply()`, `sapply()` or `lapply()`.


```r
complementary_sequence <- function(sequence){
  sapply(seq, function(base) c_bases[base][[1]])
}
```

The clear downside of using functions like the one above is loss of legibility. Applying them can also be not as straightforward and intuitive as writing a conventional loop. Advanced programmers though find these functions very handy, fast and as readable as standard for or while loop. For that reason we will try to balance these two approaches out. We don't want our code to be too hermetic, but also we should not limit ourselves by deliberately avoiding legitimate solutions.

## Find reverse complementary

Obtaining reverse complementary is very similar. The only difference is that instead of appending complementary nucleobases we will prepend them.


```r
reverse_complementary <- function(sequence){
  reverse = c()
  for (base in sequence){
    reverse = c(c_bases[base][[1]], reverse)
  }
  return(reverse)
}
```



```r
seq <- random_sequence(20)
cat(' DNA =', seq, '\n')
#>  DNA = T A G G C A G G C C G A A G G C G A T C
rcseq <- reverse_complementary(seq)
cat('cDNA =', rcseq)
#> cDNA = G A T C G C C T T C G G C C T G C C T A
```

## Calculate frequency of the nucleobases


```r
frequency <- function(sequence, percents = FALSE){
  counts <- table(sequence)
  divide_counts <- ifelse(percents, sum(counts), 1)
  return (counts/divide_counts)
}
```


```r
frequency(seq, percents = TRUE)
#> sequence
#>    A    C    G    T 
#> 0.25 0.25 0.40 0.10
```

## Longest common prefix


```r
longest_common_prefix <- function(sequence1, sequence2){
  min_length = min(length(sequence1), length(sequence2))
  index = 0
  if (sequence1[1] != sequence2[1]){
    return ('No common prefix')
  }
  for (i in 2:min_length){
    if (sequence1[i] != sequence2[i]){
      return (sequence1[1:i-1])
    }
  }
  return (sequence1[1:min_length])
}
```


```r
longest_common_prefix(c('A','C','T','G'), c('A', 'C', 'T', 'T', 'T'))
#> [1] "A" "C" "T"

longest_common_prefix(c('C','C','T','G'), c('A', 'C', 'T', 'T', 'T'))
#> [1] "No common prefix"
```

Imputing strings that are in fact consisted of vectors of characters may not be particularly convenient. We will therefore add a functionally that detects type of inputs and converts them if it is needed.

Unfortunately, R does not differentiates between `c('a','c','t','g')` and `'ACTG'`, e.g.


```r
typeof(c('A', 'C', 'G', 'T'))
#> [1] "character"
typeof('ACGT')
#> [1] "character"

length(c('A', 'C', 'G', 'T'))
#> [1] 4
length('ACGT')
#> [1] 1
```

On this account we will simply add new boolean argument `glued` to our function.  This solution is far from perfect, but for now is good enough.


```r
longest_common_prefix <- function(sequence1, sequence2, glued = FALSE){
  if (glued){
    sequence1 <- strsplit(sequence1, '')[[1]]
    sequence2 <- strsplit(sequence2, '')[[1]]
  }
  min_length = min(length(sequence1), length(sequence2))
  index = 0
  if (sequence1[1] != sequence2[1]){
    return ('No common prefix')
  }
  for (i in 2:min_length){
    if (sequence1[i] != sequence2[i]){
      return (sequence1[1:i-1])
    }
  }
  return (sequence1[1:min_length])
}
```



```r
longest_common_prefix('ACTG', 'ACCC', glued = TRUE)
#> [1] "A" "C"
```

