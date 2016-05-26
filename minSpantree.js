process.stdin.resume();
process.stdin.setEncoding('ascii');

var stdIn = "",
    inputData = [];

process.stdin.on('data', function (data) {
    stdIn += data;
});

process.stdin.on('end', function () {
    inputData = stdIn.split(/[\s\r\n]+/g);
    minSpantree();
});

function nextInt() {
    return parseInt(inputData.shift());
}

function Vertex(value) {
    return {
        "value": value,
        "parent": null,
        "getRoot": function () {
            return this.parent == null ? this : this.parent.getRoot()
        }
    }
}

function minSpantree() {

    for (var test = nextInt(); test > 0; test--) {

        var numVertices = nextInt();
        var numEdges = nextInt();

        var vertices = [];
        for (var i = 0; i < numVertices; i++) {
            vertices[i] = new Vertex(i);
        }

        var edges = [];

        for (var i = 0; i < numEdges; i++) {

            var uValue = nextInt() - 1;
            var vValue = nextInt() - 1;

            edges.push({
                "u": vertices[uValue],
                "v": vertices[vValue],
                "weight": nextInt()
            });

        }

        edges.sort(function (a, b) {
            return a.weight - b.weight;
        })

        var totalWeight = 0;

        edges.forEach(function (edge) {
            if (edge.u.getRoot() != edge.v.getRoot()) {
                edge.v.getRoot().parent = edge.u.getRoot();
                totalWeight += edge.weight;
            }
        });

        console.log(totalWeight);

    }

}