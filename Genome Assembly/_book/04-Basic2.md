# More advanced problems {#advanced}

This chapter is devoted to a little more specific problems, like managing fasta or fastq files. Throughout the section we will operate on three different files which are available on NCBI, but are also included in the `files` directory:

1. MK028861.fasta - Zika virus

2. NC_001416.fasta - Enterobacteria phage lambda

## Read fasta file

Fasta file consist of two parts - header, that describes the sequence, and sequence itself. In order to load the first file we will use a very basic `leadLines()` function. 


```r
zika <- readLines('files/MK028861.fasta')

zika[1:4]
#> [1] ">MK028861.1 Zika virus isolate Zika virus/H.sapiens-tc/Panama/2015/259359 polyprotein gene, complete cds"
#> [2] "TGACTAAGACTGCGACAGTTCGAGTTTGAAGCGAAAGCTAGCAACAGTATCAACAGGTTTTATTTTGGAT"                                  
#> [3] "TTGGAAACGAGAGTTTCTGGTCATGAAAAACCCAAAAAAGAAATCCGGAGGATTCCGGATTGTCAATATG"                                  
#> [4] "CTAAAACGCGGAGTAGCCCGTGTGAGCCCCTTTGGGGGCTTGAAGAGGCTGCCAGCCGGACTTCTGCTGG"

length(zika)
#> [1] 151
```

As one can see at this point we have a vector of 151 elements. Each entry represents a single line in from the loaded file. We are going to remold our output to more convenient form, namely to a list of two elements (header and sequence).


```r
zika <- list('header' = substr(zika[1], 2, nchar(zika[1])), 
             'sequence' = do.call(paste0, as.list(zika[2:length(zika)])))
```

Let's talk trough `substr(zika[1], 2, nchar(zika[1]))` and `do.call(paste0, as.list(zika[2:length(zika)]))`. We create a header on the basis of initial line of the fasta file, i.e. first element of our vector. One could simply write `'header' = zika[1]` but we also want to remove `>` character from the very beginning. Therefore we take a substring that starting from the second character and ends at the end (position equal to the number of characters). 

The second part, which is `do.call(paste0, as.list(zika[2:length(zika)]))`, needs a little more explanation. As we know one can use the paste0 function to concatenate strings. Unfortunately, imputing a vector of strings won't concatenate all element together. For paste0 this vector is simply a one element.


```r
paste0('A', 'B', 'C')
#> [1] "ABC"

paste0(c('A', 'B', 'C'))
#> [1] "A" "B" "C"
```
This is the reason for employing `do.call()`. The function takes two arguments - name of function to execute and __list__ of elements. 

Fortunately, there is a smoother to solve this exercise - `str_c()` function the the stringr package.


```r
stringr::str_c(c('A', 'B', 'C'), collapse = '')
#> [1] "ABC"
```


```r
zika$header
#> [1] "MK028861.1 Zika virus isolate Zika virus/H.sapiens-tc/Panama/2015/259359 polyprotein gene, complete cds"

substr(zika$sequence, 1, 100)
#> [1] "TGACTAAGACTGCGACAGTTCGAGTTTGAAGCGAAAGCTAGCAACAGTATCAACAGGTTTTATTTTGGATTTGGAAACGAGAGTTTCTGGTCATGAAAAA"
```


