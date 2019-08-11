//
//  AdjacencyMatrix.swift
//  Graph
//
//  Created by Myron on 2019/8/11.
//  Copyright © 2019 Myron. All rights reserved.
//

// 邻接矩阵
final class AdjacencyMatrix<T> {
    // vertices 存储所有的顶点
    private var vertices: [Vertex<T>] = []
    // weights 存储所有边的权重
    private var weights: [[Double?]] = []
    init() { }
}

extension AdjacencyMatrix: Graph {
    func createVertex(value: T) -> Vertex<T> {
        let vertex = Vertex(index: vertices.count, value: value)
        vertices.append(vertex)
        for i in 0..<weights.count {
            weights[i].append(nil)
        }
        let row = [Double?](repeating: nil, count: vertices.count)
        weights.append(row)
        return vertex
    }
    
    func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        weights[source.index][destination.index] = weight
    }
    
    func edges(from source: Vertex<T>) -> [Edge<T>] {
        var edges: [Edge<T>] = []
        for column in 0..<weights.count {
            guard let weight = weights[source.index][column] else {
                continue
            }
            let edge = Edge(source: source,
                            destination: vertices[column],
                            weight: weight)
            edges.append(edge)
        }
        return edges
    }
    
    func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        return weights[source.index][destination.index]
    }
}

extension AdjacencyMatrix: CustomStringConvertible {
    var description: String {
        let verticesDes = vertices.map { "\($0)" }
            .joined(separator: "\n")
        var grid: [String] = []
        for i in 0..<weights.count {
            var row = ""
            for j in 0..<weights.count {
                if let value = weights[i][j] {
                    row += "\(value)\t"
                } else {
                    row += "ø\t\t"
                }
            }
            grid.append(row)
        }
        let edgesDes = grid.joined(separator: "\n")
        return "\(verticesDes)\n\n\(edgesDes)"
    }
}
