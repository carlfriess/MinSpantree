#include <stdio.h>
#include <stdlib.h>

struct Vertex {
    int value;
    struct Vertex *parent;
};

struct Vertex* getRoot(struct Vertex *node) {
    return node->parent == node ? node : getRoot(node->parent);
}

struct Edge {
    struct Vertex *u;
    struct Vertex *v;
    int weight;
};

int edgeCompare(const void * a, const void * b) {
    return ( (*(struct Edge*)a).weight - (*(struct Edge*)b).weight );
}

int main(int argc, const char * argv[]) {
    
    int test;
    scanf("%d", &test);
    for (; test > 0; test--) {
        
        int numVertices;
        scanf("%d", &numVertices);
        int numEdges;
        scanf("%d", &numEdges);
        
        struct Vertex vertices[numVertices];
        struct Edge edges[numEdges];
        
        for (int i = 0; i < numVertices; i++) {
            vertices[i].value = i;
            vertices[i].parent = &vertices[i];
        }
        
        for (int i = 0; i < numEdges; i++) {
            int uValue;
            scanf("%d", &uValue);
            uValue--;
            int vValue;
            scanf("%d", &vValue);
            vValue--;
            edges[i].u = &vertices[uValue];
            edges[i].v = &vertices[vValue];
            scanf("%d", &edges[i].weight);
        }
        
        qsort(edges, numEdges, sizeof(edges[0]), edgeCompare);
        
        int totalWeight = 0;
        
        for (int i = 0; i < numEdges; i++) {
            if (getRoot(edges[i].u) != getRoot(edges[i].v)) {
                getRoot(edges[i].v)->parent = getRoot(edges[i].u);
                totalWeight += edges[i].weight;
            }
        }
        
        printf("%d\n", totalWeight);
        
    }
    
    return 0;
}
