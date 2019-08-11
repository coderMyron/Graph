//
//  Dijkstra.swift
//  Graph
//
//  Created by Myron on 2019/8/11.
//  Copyright © 2019 Myron. All rights reserved.
//

enum Visit<T: Hashable> {
    case start // 顶点是起点
    case edge(Edge<T>) // 顶点关联着通往它的边
}

class Dijkstra<T: Hashable> {
    typealias Graph = AdjacencyList<T>
    
    let graph: Graph
    
    init(graph: Graph) {
        self.graph = graph
    }
    
    /// 找出从某个顶点开始的所有路径
    func paths(from start: Vertex<T>) -> [Vertex<T>: Visit<T>] {
        // 用一个字典来记录每一步的数据，
        // key 是顶点，value 是顶点类型或者是关联着通往这个顶点的边
        var paths: [Vertex<T>: Visit<T>] = [start: .start]
        // 创建最小优先队列，`order` 闭包队列中元素排序的条件，总权重最小的优先
        var priorityQueue = PriorityQueue<Vertex<T>>(order: {
            self.distance(to: $0, with: paths) <
                self.distance(to: $1, with: paths)
        })
        priorityQueue.enqueue(start)
        
        while let vertex = priorityQueue.dequeue() { // 取出队列当前最小权重的顶点
            for edge in graph.edges(from: vertex) { // 遍历从这个顶点出发的边
                guard let weight = edge.weight else {
                    continue
                }
                // 如果边的终点不在字典中，
                // 或者从当前顶点出发达到边的终点总权重小于之前的路径，
                // 更新路径，并把邻居加入到队列中
                if paths[edge.destination] == nil ||
                    distance(to: vertex, with: paths) + weight <
                    distance(to: edge.destination, with: paths) {
                    
                    paths[edge.destination] = .edge(edge)
                    priorityQueue.enqueue(edge.destination)
                }
            }
        }
        
        return paths
    }
    
    /// 根据记录着每一步数据的字典，找到到达某个终点的最小路径，
    // 返回由边组成的有序数组
    func shortestPath(to destination: Vertex<T>,
                      with paths: [Vertex<T>: Visit<T>]) -> [Edge<T>] {
        var vertex = destination
        var path: [Edge<T>] = []
        while let visit = paths[vertex], case .edge(let edge) = visit {
            path = [edge] + path
            vertex = edge.source
        }
        return path
    }
    
    // MARK: - Private
    
    // 根据记录着每一步数据的字典中的数据，计算到达某一个终点的总权重
    private func distance(to destination: Vertex<T>,
                          with paths: [Vertex<T>: Visit<T>]) -> Double {
        let path = shortestPath(to: destination, with: paths)
        return path.compactMap { $0.weight }
            .reduce(0, +)
    }
}
