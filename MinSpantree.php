<?php

class Vertex {
    
    public $value;
    public $parent;

    function __construct($value) {
        $this->value = $value;
        $this->parent = $this;
    }

    public function getRoot() {
        return $this->parent == $this ? $this : $this->parent->getRoot();
    }

}

class Edge {

    public $u;
    public $v;
    public $weight = 0;

    function __construct($u, $v, $weight) {
        $this->u = $u;
        $this->v = $v;
        $this->weight = $weight;
    }

}

class Scanner
{

    private $buffer = array();

    public function nextInt(){
        if (count($this->buffer) <= 0) {
            $line = trim(fgets(STDIN));
            $this->buffer = preg_split('/\s+/', $line);
        }
        return array_shift($this->buffer);
    }

}

function cmp($a, $b) {
    return $a->weight > $b->weight;
}

$scanner = new Scanner();

for ($numTests = $scanner->nextInt(); $numTests > 0; $numTests--) { 
    
    $numVertices = $scanner->nextInt();
    $numEdges = $scanner->nextInt();

    $vertices = array();
    $edges = array();

    for ($i=0; $i < $numEdges; $i++) {

        $uValue = $scanner->nextInt() - 1; 
        $vValue = $scanner->nextInt() - 1;

        if (!array_key_exists($uValue, $vertices)) {
            $vertices[$uValue] = new Vertex($uValue);
        }

        if (!array_key_exists($vValue, $vertices)) {
            $vertices[$vValue] = new Vertex($vValue);
        }

        array_push($edges, new Edge($vertices[$uValue], $vertices[$vValue], $scanner->nextInt()));

    }

    usort($edges, "cmp");

    $totalWeight = 0;

    foreach ($edges as $edge) {
        
        if ($edge->u->getRoot() != $edge->v->getRoot()) {

            $edge->v->getRoot()->parent = $edge->u->getRoot();
            $totalWeight += $edge->weight;

        }

    }

    fwrite(STDOUT, $totalWeight . "\n");

}

?>
