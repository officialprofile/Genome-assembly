# Graph theory {#graph}

Graph can be regarded simply as a set of vertices and edges connecting them. Although this mathematical structure can be defined in a various ways, for us graph will virtually always be a square matrix called adjacency matrix. Each row and column of the matrix represents a given vertex and its connections to remaining ones. Consider for example a following adjacency matrix:


```r
adjacency_matrix <- matrix(0, 3, 3)
adjacency_matrix[1, 2] <- 1
adjacency_matrix[1, 3] <- 1
adjacency_matrix[3, 2] <- 1
adjacency_matrix[3, 3] <- 1

adjacency_matrix
#>      [,1] [,2] [,3]
#> [1,]    0    1    1
#> [2,]    0    0    0
#> [3,]    0    1    1
```

From the matrix above we can deduce that, for example, vertex 1 is adjacent to vertex 2 and 3, or that vertex 3 is connected to itself. Please note that this matrix is not symmetric. This implies that we can go from one vertex to another, albeit walk in the opposite direction may not be possible.

Now we are going to convert our adjacency matrix. This step is not required in general, we do this only for the sake of visualization.


```r
graph <- igraph::graph.adjacency(adjacency_matrix, mode = 'directed', weighted = TRUE)

igraph::plot.igraph(graph, vertex.size = 30, vertex.color = 'lightblue')
```

![](05-Graph_files/figure-epub3/unnamed-chunk-2-1.png)<!-- -->

Notice the relationship between direction of the vertices and their position in the adjacency matrix. Row represents vertex from which the edge begins, while the column is the place of its ending. This is the case only for the directed graphs, for the undirected ones we have symmetric matrix or we deal either with its lower or upper part.  

For our needs the most fundamental part of graph theory concerns path finding. Let's consider the following, randomly generated graph (each edge is of length 1):


```r
random_edges <- sample(c(0,1), 100, replace = TRUE, prob = c(0.9, 0.1))
adjacency_matrix <- matrix(random_edges, 10, 10)
rownames(adjacency_matrix) = LETTERS[1:10]
colnames(adjacency_matrix) = LETTERS[1:10]
graph <- igraph::graph.adjacency(adjacency_matrix, mode = 'undirected', 
                                 diag = FALSE)

igraph::plot.igraph(graph, vertex.size = 30, vertex.color = 'lightblue')
```

![](05-Graph_files/figure-epub3/unnamed-chunk-3-1.png)<!-- -->

Having such graph we want to be able to answer few questions. 

 1. Is there a path connecting vertex A with B?
 2. How many paths with such connection exist?
 3. Which one has the shortest distance?
 4. Is there a path from A to B within which one can visit every vertex?
 5. Is there a path from A to B within which one can visit every vertex exactly once?
