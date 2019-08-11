//
//  ViewController.swift
//  Graph
//
//  Created by Myron on 2019/8/11.
//  Copyright © 2019 Myron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("邻接表")
        let graph = AdjacencyList<String>()
        
        let wuHan = graph.createVertex(value: "武汉")
        let shangHai = graph.createVertex(value: "上海")
        let shenZhen = graph.createVertex(value: "深圳")
        let beiJing = graph.createVertex(value: "北京")
        let hongKong = graph.createVertex(value: "香港")
        let newYork = graph.createVertex(value: "纽约")
        
        graph.addEdge(.undirected, from: wuHan, to: shangHai, weight: 300)
        graph.addEdge(.undirected, from: wuHan, to: shenZhen, weight: 500)
        graph.addEdge(.undirected, from: shangHai, to: shenZhen, weight: 700)
        graph.addEdge(.undirected, from: shangHai, to: beiJing, weight: 600)
        graph.addEdge(.undirected, from: shenZhen, to: beiJing, weight: 1000)
        graph.addEdge(.undirected, from: shenZhen, to: hongKong, weight: 200)
        graph.addEdge(.undirected, from: beiJing, to: newYork, weight: 6000)
        graph.addEdge(.undirected, from: hongKong, to: newYork, weight: 5000)
        
        print(graph)
        
        print("-------------")
        print("邻接矩阵")
        
        let graph2 = AdjacencyMatrix<String>()
        
        let wuHan2 = graph2.createVertex(value: "武汉")
        let shangHai2 = graph2.createVertex(value: "上海")
        let shenZhen2 = graph2.createVertex(value: "深圳")
        let beiJing2 = graph2.createVertex(value: "北京")
        
        graph2.addDirectedEdge(from: wuHan2, to: shangHai2, weight: 300)
        graph2.addDirectedEdge(from: wuHan2, to: shenZhen2, weight: 500)
        graph2.addDirectedEdge(from: shangHai2, to: beiJing2, weight: 600)
        graph2.addDirectedEdge(from: shenZhen2, to: shangHai2, weight: 700)
        graph2.addUndirectedEdge(between: shenZhen2, and: beiJing2, weight: 1000)
        
        print(graph2)
        
        print("-------------")
        print("广度优先搜索")
        
        let vertices = graph.breadthFirstSearch(from: wuHan)
        vertices.forEach { print($0) }
        
        print("-------------")
        print("深度优先搜索")

        let vertices2 = graph.depthFirstSearch(from: wuHan)
        vertices2.forEach { print($0) }
        
        print("-------------")
        print("迪克斯特拉 (Dijkstra)算法")
        
        let graph3 = AdjacencyList<String>()
        
        let a = graph3.createVertex(value: "A")
        let b = graph3.createVertex(value: "B")
        let c = graph3.createVertex(value: "C")
        let d = graph3.createVertex(value: "D")
        let e = graph3.createVertex(value: "E")
        let f = graph3.createVertex(value: "F")
        let g = graph3.createVertex(value: "G")
        let h = graph3.createVertex(value: "H")
        
        graph3.addDirectedEdge(from: a, to: b, weight: 1)
        graph3.addDirectedEdge(from: a, to: d, weight: 9)
        graph3.addDirectedEdge(from: a, to: c, weight: 2)
        graph3.addDirectedEdge(from: b, to: d, weight: 2)
        graph3.addDirectedEdge(from: c, to: d, weight: 8)
        graph3.addDirectedEdge(from: c, to: f, weight: 5)
        graph3.addDirectedEdge(from: d, to: g, weight: 9)
        graph3.addDirectedEdge(from: d, to: e, weight: 7)
        graph3.addDirectedEdge(from: e, to: d, weight: 5)
        graph3.addUndirectedEdge(between: e, and: f, weight: 4)
        graph3.addDirectedEdge(from: e, to: h, weight: 3)
        
        let dijkstra = Dijkstra(graph: graph3)
        let pathsFromA = dijkstra.paths(from: a)
        let path = dijkstra.shortestPath(to: e, with: pathsFromA)
        for edge in path {
            print("\(edge.source) -- \(edge.weight ?? 0) -- > \(edge.destination)")
        }

        
    }


}

