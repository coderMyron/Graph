//
//  Queue.swift
//  Queue
//
//  Created by Myron on 2019/8/3.
//  Copyright © 2019 Myron. All rights reserved.
//

//MARK: - FIFO 利用的数组来实现
struct Queue<Element> {
    
    private var elements: [Element] = []
    
    init() { }
    
    // MARK: - Getters
    var count: Int {
        return elements.count
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var peek: Element? {
        return elements.first
    }
}

// MARK: - 入队Enqueue & 出队Dequeue
extension Queue {
    mutating func enqueue(_ element: Element) {
        elements.append(element)
    }
    
    @discardableResult
    mutating func dequeue() -> Element? {
        return isEmpty ? nil : elements.removeFirst()
    }
}

extension Queue: CustomStringConvertible {
    var description: String {
        return elements.description
    }
}
