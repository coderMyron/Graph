//
//  Vertex.swift
//  Graph
//
//  Created by Myron on 2019/8/11.
//  Copyright © 2019 Myron. All rights reserved.
//

struct Vertex<T> {
    let index: Int
    let value: T
}

extension Vertex: Hashable {
    var hashValue: Int {
        return index.hashValue
    }
    
    
    
    static func == (lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
        return lhs.index == rhs.index
    }
}

extension Vertex: CustomStringConvertible {
    var description: String {
        return "\(index): \(value)"
    }
}
