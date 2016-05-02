import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;


class Vertex {

    public int value;
    public Vertex parent;

    public Vertex(int value) {
        this.value = value;
        this.parent = this;
    }

    public Vertex(int value, Vertex parent) {
        this.value = value;
        this.parent = parent;
    }

    public Vertex getRoot() {
        return this.parent == this ? this : this.parent.getRoot();
    }

}
class Edge implements Comparable<Edge>{

    public Vertex u, v;
    public int weight;

    Edge(Vertex u, Vertex v, int weight)
    {
        this.u = u;
        this.v = v;
        this.weight = weight;
    }

    public int compareTo(Edge e) {
        return this.weight - e.weight;
    }

}

class Main {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        for(int test = scanner.nextInt(); test > 0; test--) {

            int numVertices = scanner.nextInt();
            int numEdges = scanner.nextInt();

            Vertex[] vertices = new Vertex[numVertices];
            ArrayList<Edge> edges = new ArrayList<Edge>();

            for(int i = 0; i < numEdges; ++i) {

                int uValue = scanner.nextInt() - 1;
                int vValue = scanner.nextInt() - 1;

                if (vertices[uValue] == null) {
                    vertices[uValue] = new Vertex(uValue);
                }

                if (vertices[vValue] == null) {
                    vertices[vValue] = new Vertex(vValue);
                }

                edges.add( new Edge( vertices[uValue], vertices[vValue], scanner.nextInt() ) );

            }

            Collections.sort(edges);

            int totalWeight = 0;

            for (Edge edge : edges) {
                if (edge.u.getRoot() != edge.v.getRoot()) {
                    edge.v.getRoot().parent = edge.u.getRoot();
                    totalWeight += edge.weight;
                }
            }

            System.out.println(totalWeight);

        //
        }
    }
}
