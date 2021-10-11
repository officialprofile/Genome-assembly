# Graph theory {#graph}

Graph can be simply regarded as a set of vertices and edges connecting them. One can define this structure in a various ways, but for us graph will virtually always be represented by a square matrix called adjacency matrix. Each row/column of the matrix represents a given vertice and its connections to remaining ones. Consider for example a following adjacency matrix:


```r
adjacency_matrix <- matrix(0, 3, 3)
adjacency_matrix[1, 2] <- 1
adjacency_matrix[1, 3] <- 1
adjacency_matrix[3, 2] <- 1

adjacency_matrix
#>      [,1] [,2] [,3]
#> [1,]    0    1    1
#> [2,]    0    0    0
#> [3,]    0    1    0
```

Now we are going to convert the matrix to a form of complex list. This step is not required in general. We will do this only for the sake of visualization.


```r
graph <- igraph::graph.adjacency(adjacency_matrix, mode = 'directed', weighted = TRUE)

plot(graph)
```

![](05-Graph_files/figure-epub3/unnamed-chunk-2-1.png)<!-- -->

Notice the relationship between direction of the vertices and their position in the adjacency matrix. Row represents vertice from which edge begins and the column where it ends. This is only the case when we deal with directed graphs, for the undirected ones we have symmetrix matrix or deal only with its lower or upper part.  

For us the most fundamental part of graph theory is related to path finding. Let's consider the following, randomly generated graph (each edge is of length 1):


```r
random_edges <- sample(c(0,1), 100, replace = TRUE, prob = c(0.9, 0.1))
adjacency_matrix <- matrix(random_edges, 10, 10)
rownames(adjacency_matrix) = LETTERS[1:10]
colnames(adjacency_matrix) = LETTERS[1:10]
graph <- igraph::graph.adjacency(adjacency_matrix, mode = 'undirected', 
                                 diag = FALSE)

plot(graph)
```

![](05-Graph_files/figure-epub3/unnamed-chunk-3-1.png)<!-- -->

Having such graph we want to be able to answer few questions. 

 1. Is there a path connecting vertice A with B?
 2. How many paths with such connection exist?
 3. Which one has the shortest distance?
 4. Is there a path from A to B within which one can visit every vertice?
 5. Is there a path from A to B within which one can visit every vertice exactly once?
