//
//  Edge.swift
//  Graph
//
//  Created by Myron on 2019/8/11.
//  Copyright © 2019 Myron. All rights reserved.
//

struct Edge<T> {
    let source: Vertex<T>
    let destination: Vertex<T>
    let weight: Double?
}

extension Edge: Equatable {
    static public func ==(lhs: Edge<T>, rhs: Edge<T>) -> Bool {
        return lhs.source == rhs.source &&
            lhs.destination == rhs.destination &&
            lhs.weight == rhs.weight
    }
}
