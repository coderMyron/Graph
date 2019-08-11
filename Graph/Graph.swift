//
//  Graph.swift
//  Graph
//
//  Created by Myron on 2019/8/11.
//  Copyright © 2019 Myron. All rights reserved.
//

enum EdgeType {
    case directed
    case undirected
}

protocol Graph {
    associatedtype Element
    
    // 创建顶点
    func createVertex(value: Element) -> Vertex<Element>
    
    // 在两个顶点中添加有向的边
    func addDirectedEdge(from source: Vertex<Element>,
                         to destination: Vertex<Element>,
                         weight: Double?)
    
    // 在两个顶点中添加无向的边
    func addUndirectedEdge(between source: Vertex<Element>,
                           and destination: Vertex<Element>,
                           weight: Double?)
    
    // 根据边的类型在两个顶点中添加边
    func addEdge(_ edge: EdgeType,
                 from source: Vertex<Element>,
                 to destination: Vertex<Element>,
                 weight: Double?)
    
    // 返回从某个顶点发出去的所有边
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    
    // 返回从一个顶点到另个顶点的边的权重
    func weight(from source: Vertex<Element>,
                to destination: Vertex<Element>) -> Double?
}

extension Graph {
    // 在两个顶点中添加无向的边，也就相当于在两个顶点之间互相添加有向图
    func addUndirectedEdge(between source: Vertex<Element>,
                           and destination: Vertex<Element>,
                           weight: Double?) {
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
    
    // 根据边的类型在两个顶点中添加边，可以直接根据边的类型调用协议里的其他方法来实现
    func addEdge(_ edge: EdgeType,
                 from source: Vertex<Element>,
                 to destination: Vertex<Element>,
                 weight: Double?) {
        switch edge {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(between: source, and: destination, weight: weight)
        }
    }
}

// MARK: - 搜索
extension Graph {
    // MARK: 广度优先搜索
    func breadthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
        var queue = Queue<Vertex<Element>>()
        var enqueued: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []
        
        queue.enqueue(source)
        enqueued.insert(source)
        
        while let vertex = queue.dequeue() {
            visited.append(vertex)
            let neighborEdges = edges(from: vertex)
            for edge in neighborEdges
                where !enqueued.contains(edge.destination) {
                    queue.enqueue(edge.destination)
                    enqueued.insert(edge.destination)
            }
        }
        
        return visited
    }
    
    // MARK: 深度优先搜索
    func depthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
        var stack = Stack<Vertex<Element>>()
        var pushed: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []
        
        stack.push(source)
        pushed.insert(source)
        visited.append(source)
        
        outer: while let vertex = stack.top {
            let neighborEdges = edges(from: vertex)
            guard !neighborEdges.isEmpty else {
                stack.pop()
                continue
            }
            for edge in neighborEdges {
                if !pushed.contains(edge.destination) {
                    stack.push(edge.destination)
                    pushed.insert(edge.destination)
                    visited.append(edge.destination)
                    continue outer
                }
            }
            stack.pop()
        }
        
        return visited
    }
}
