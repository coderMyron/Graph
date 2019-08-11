//
//  Heap.swift
//  Heap
//
//  Created by Myron on 2019/8/10.
//  Copyright © 2019 Myron. All rights reserved.
//

// 虽然堆本质上是属于二叉树，但是我们不实用节点来实现，而是使用数组。
struct Heap<Element: Equatable> {
    private(set) var elements: [Element] = []
    private let order: (Element, Element) -> Bool
    
    init(order: @escaping (Element, Element) -> Bool) {
        self.order = order
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    var peek: Element? {
        return elements.first
    }
    
    // 这个元素的左子节点索引为 2 * i + 1
    func leftChildIndex(ofParentAt index: Int) -> Int {
        return 2 * index + 1
    }
    
    // 这个元素的右子节点索引为 2 * i + 2
    func rightChildIndex(ofParentAt index: Int) -> Int {
        return 2 * index + 2
    }
    
    // 这个元素的父节点索引为 (i - 1) / 2
    func parentIndex(ofChildAt index: Int) -> Int {
        return (index - 1) / 2
    }
}

extension Heap: CustomStringConvertible {
    var description: String {
        return elements.description
    }
}

// MARK: - 删除Remove & 插入Insert
extension Heap {
    // 移除根部元素 调换根元素和最后一个元素 再向下比较调整
    @discardableResult
    mutating func removePeek() -> Element? {
        guard !isEmpty else {
            return nil
        }
        elements.swapAt(0, count - 1)
        defer {
            validateDown(from: 0)
        }
        return elements.removeLast()
    }
    
    // 移除任意位置的元素 同样把要移除的元素跟最后一个元素调换 再向下比较调整和向上比较调整
    @discardableResult
    mutating func remove(at index: Int) -> Element? {
        guard index < elements.count else {
            return nil
        }
        if index == elements.count - 1 {
            return elements.removeLast()
        } else {
            elements.swapAt(index, elements.count - 1)
            defer {
                validateDown(from: index)
                validateUp(from: index)
            }
            return elements.removeLast()
        }
    }
    
    // 插入到最后 再向上比较调整
    mutating func insert(_ element: Element) {
        elements.append(element)
        validateUp(from: elements.count - 1)
    }
    
    // 往上比较调整
    private mutating func validateUp(from index: Int) {
        var childIndex = index
        var parentIndex = self.parentIndex(ofChildAt: childIndex)
        
        while childIndex > 0 &&
            order(elements[childIndex], elements[parentIndex]) {
                elements.swapAt(childIndex, parentIndex)
                childIndex = parentIndex
                parentIndex = self.parentIndex(ofChildAt: childIndex)
        }
    }
    
    // 往下比较调整
    private mutating func validateDown(from index: Int) {
        var parentIndex = index
        while true {
            let leftIndex = leftChildIndex(ofParentAt: parentIndex)
            let rightIndex = rightChildIndex(ofParentAt: parentIndex)
            var targetParentIndex = parentIndex
            
            if leftIndex < count &&
                order(elements[leftIndex], elements[targetParentIndex]) {
                targetParentIndex = leftIndex
            }
            
            if rightIndex < count &&
                order(elements[rightIndex], elements[targetParentIndex]) {
                targetParentIndex = rightIndex
            }
            
            if targetParentIndex == parentIndex {
                return
            }
            
            elements.swapAt(parentIndex, targetParentIndex)
            parentIndex = targetParentIndex
        }
    }
}

// MARK: - 查找Search
extension Heap {
    // 查找元素在哪个位置
    func index(of element: Element,
               searchingFrom index: Int = 0) -> Int? {
        if index >= count {
            return nil
        }
        if order(element, elements[index]) {
            return nil
        }
        if element == elements[index] {
            return index
        }
        
        let leftIndex = leftChildIndex(ofParentAt: index)
        if let i = self.index(of: element,
                              searchingFrom: leftIndex) {
            return i
        }
        
        let rightIndex = rightChildIndex(ofParentAt: index)
        if let i = self.index(of: element,
                              searchingFrom: rightIndex) {
            return i
        }
        
        return nil
    }
}
