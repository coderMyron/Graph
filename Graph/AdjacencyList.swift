//
//  AdjacencyList.swift
//  Graph
//
//  Created by Myron on 2019/8/11.
//  Copyright © 2019 Myron. All rights reserved.
//

//邻接表
final class AdjacencyList<T> {
    
    private var adjacencies: [Vertex<T>: [Edge<T>]] = [:]
    
    init() { }
    
    var vertices: [Vertex<T>] {
        return Array(adjacencies.keys)
    }
}

extension AdjacencyList: Graph {
    @discardableResult
    func createVertex(value: T) -> Vertex<T> {
        let vertex = Vertex(index: adjacencies.count, value: value)
        adjacencies[vertex] = []
        return vertex
    }
    
    func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjacencies[source]?.append(edge)
    }
    
    func edges(from source: Vertex<T>) -> [Edge<T>] {
        return adjacencies[source] ?? []
    }
    
    func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        return edges(from: source)
            .first { $0.destination == destination }?
            .weight
    }
}

extension AdjacencyList: CustomStringConvertible {
    var description: String {
        var result = ""
        for (vertex, edges) in adjacencies {
            var edgeString = ""
            for (index, edge) in edges.enumerated() {
                if index < edges.count - 1 {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) --> [ \(edgeString) ]\n")
        }
        return result
    }
}
