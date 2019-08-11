//
//  Stack.swift
//  Stack
//
//  Created by Myron on 2019/8/3.
//  Copyright © 2019 Myron. All rights reserved.
//

//MARK: - LIFO(last in first out) 
struct Stack<Element> {
    private var elements: [Element] = []
    init() { }
}

extension Stack: CustomStringConvertible {
    var description: String {
        let topDivider = "====top====\n"
        let bottomDivider = "\n====bottom====\n"
        let stackElements = elements
            .reversed()
            .map { "\($0)" }
            .joined(separator: "\n")
        return topDivider + stackElements + bottomDivider
    }
}

// MARK: - 进s栈Push & 出栈Pop
extension Stack {
    mutating func push(_ element: Element) {
        elements.append(element)
    }
    
    @discardableResult
    mutating func pop() -> Element? {
        return elements.popLast()
    }
}

// MARK: - Getters
extension Stack {
    var top: Element? {
        return elements.last
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
}
