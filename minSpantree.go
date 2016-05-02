package main

import (
	"fmt"
	"bufio"
	"os"
	"strconv"
	"sort"
)

type Vertex struct {
	value int
	parent *Vertex
}

func (v *Vertex) getRoot() *Vertex {
	if v.parent == nil {
		return v;
	} else {
		return v.parent.getRoot()
	}
}

type Edge struct {
	u, v *Vertex
	weight int
}

type Edges []Edge

// Implement the sort.Interface for Edges
func (edges Edges) Len() int { return len(edges) }
func (edges Edges) Less(i, j int) bool { return edges[i].weight < edges[j].weight }
func (edges Edges) Swap(i, j int) { edges[i], edges[j] = edges[j], edges[i] }

func getNextInt(scanner *bufio.Scanner) int {
	scanner.Scan()
	i, _ := strconv.Atoi(scanner.Text());
	return i;
}

func main() {

	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	for test := getNextInt(scanner); test > 0; test-- {

		numVertices := getNextInt(scanner)
		numEdges := getNextInt(scanner)

		var vertices = make([]Vertex, numVertices)
		var edges Edges

		for i := 0; i < numEdges; i++ {

			uValue := getNextInt(scanner) - 1
			vValue := getNextInt(scanner) - 1
			vertices[uValue].value = uValue
			vertices[vValue].value = vValue

			edges = append(edges, Edge{ &vertices[uValue], &vertices[vValue], getNextInt(scanner) })

		}

		sort.Sort(edges)

		totalWeight := 0

		for _, edge := range edges {
			if edge.u.getRoot() != edge.v.getRoot() {
				edge.v.getRoot().parent = edge.u.getRoot();
				totalWeight += edge.weight;
			}
		}

		fmt.Println(totalWeight)

	}

}