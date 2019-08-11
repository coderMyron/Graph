//
//  PriorityQueue.swift
//  PriorityQueue
//
//  Created by Myron on 2019/8/10.
//  Copyright © 2019 Myron. All rights reserved.
//

// 优先队列
struct PriorityQueue<Element: Equatable> {
    private var heap: Heap<Element>
    
    init(order: @escaping (Element, Element) -> Bool) {
        heap = Heap(order: order)
    }
    
    var isEmpty: Bool {
        return heap.isEmpty
    }
    
    var peek: Element? {
        return heap.peek
    }
    
    // 入队
    mutating func enqueue(_ element: Element) {
        heap.insert(element)
    }
    
    // 出队
    mutating func dequeue() -> Element? {
        return heap.removePeek()
    }
}

extension PriorityQueue: CustomStringConvertible {
    var description: String {
        return heap.description
    }
}
