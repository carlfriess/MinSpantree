#Kruskal's Algorithm - Java vs. Go vs. Swift

As part of my studies I implemented Kruskal's Algorithm in Java. To see how it would compare, I decided to implement the Algorithm in Go and Swift as well. On my system the Go implementation turned out to be the fastest.

The program accepts data in the `stdin` and returns its result to `stdout`. An example for input data is shown in `test.in` with the corresponding correct output in `test.out`.

The first integer is the number of problems. Each problem consists first of two integers 1 ≤ `n`,`m` indicating the number of vertices and edges respectively. Then follow `m` pairs of three integers representing an edge. The first two integers denote the vertices on each end of the edge, while the third integer denotes the edge's weight.

##Execution time
These are the execution times on my system for the test data included in `test.in`.

###Java:
```
real    0m0.279s
user    0m0.622s
sys     0m0.062s
```

###Go:
```
real    0m0.047s
user    0m0.039s
sys     0m0.006s
```

###Swift:
```
real    0m0.533s
user    0m0.524s
sys     0m0.007s
```
