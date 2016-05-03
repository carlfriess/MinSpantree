//
//  main.swift
//  MinSpantreeSwift
//
//  Created by Carl Friess on 03/05/16.
//  Copyright © 2016 Carl Friess. All rights reserved.
//

import Foundation

class Scanner {
    let source = NSFileHandle.fileHandleWithStandardInput()
    var buffer: NSScanner?
    func nextInt() -> Int {
        if buffer == nil || buffer!.atEnd {
            if let nextInput = NSString(data: source.availableData, encoding: NSUTF8StringEncoding) {
                buffer = NSScanner(string: nextInput as String)
            }
        }
        var value: Int = -1;
        buffer!.scanInteger(&value)
        return value
    }
}

class Vertex {
    var value: Int = 0
    var parent: Vertex? = nil
    
    init(value: Int) {
        self.value = value
        parent = self
    }
    
    func getRoot() -> Vertex {
        return self.parent === self ? self : self.parent!.getRoot()
    }
    
}

class Edge {
    var u: Vertex? = nil
    var v: Vertex? = nil
    var weight = 0
    
    init(u: Vertex, v: Vertex, weight: Int) {
        self.u = u
        self.v = v
        self.weight = weight
    }
    
}

let scanner = Scanner()
let numTests: Int = scanner.nextInt()

for test in 0..<numTests {
    
    var numVertices = scanner.nextInt()
    var numEdges = scanner.nextInt()
    
    var vertices = [Vertex?](count: numVertices, repeatedValue: nil)
    var edges = [Edge]()
    
    for i in 0..<numEdges {
        
        let uValue = scanner.nextInt() - 1
        let vValue = scanner.nextInt() - 1
        
        if vertices[uValue] == nil {
            vertices[uValue] = Vertex(value: uValue)
        }
        
        if vertices[vValue] == nil {
            vertices[vValue] = Vertex(value: vValue)
        }
        
        edges.append(Edge(u: vertices[uValue]!, v: vertices[vValue]!, weight: scanner.nextInt()))
        
    }
    
    edges.sortInPlace({ $0.weight < $1.weight })
    
    var totalWeight = 0
    
    for edge in edges {
        if edge.u!.getRoot() !== edge.v!.getRoot() {
            edge.v!.getRoot().parent = edge.u!.getRoot()
            totalWeight += edge.weight
        }
    }
    
    print(totalWeight)
    
}
