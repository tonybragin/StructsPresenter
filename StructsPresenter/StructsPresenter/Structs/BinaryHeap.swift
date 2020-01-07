//
//  BinaryHeap.swift
//  StructsPresenter
//
//  Created by Tony on 06/01/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

struct BinaryHeap<Element: Comparable> {
    private let decreasing: Bool
    private var heap = [Element]()
    var count: Int {
        return heap.count
    }
    var max: Element? {
        return heap.first
    }
    init(decreasing: Bool) {
        self.decreasing = decreasing
    }
    init(decreasing: Bool, element: Element) {
        self.decreasing = decreasing
        add(element)
    }
    init(decreasing: Bool, array: [Element]) {
        self.decreasing = decreasing
        for item in array {
            add(item)
        }
    }
    // MARK: - Static Methods
    static func sort(decreasing: Bool, array: [Element]) -> [Element] {
        var newHeap = BinaryHeap(decreasing: decreasing, array: array)
        var sorted = [Element]()
        while let maxElement = newHeap.removeHead() {
            sorted.append(maxElement)
        }
        return sorted
    }
    // MARK: - Public Methods
    mutating func clear() {
        heap = []
    }
    mutating func add(_ element: Element) {
        heap.append(element)
        var index = count
        while index > 1 && compare(first: heap[index-1], second: heap[index / 2 - 1]) {
            swap(between: index-1, and: index / 2 - 1)
            index /= 2
        }
    }
    mutating func removeHead() -> Element? {
        if let max = max {
            swap(between: 0, and: count-1)
            heap.removeLast()
            heapify()
            return max
        } else {
            return nil
        }
    }
    // MARK: - Private Methods
    private func compare(first: Element, second: Element) -> Bool {
        if decreasing {
            return first > second
        } else {
            return first < second
        }
    }
    private mutating func swap(between firstIndex: Int,
                               and secondIndex: Int) {
        let first = heap[firstIndex]
        heap[firstIndex] = heap[secondIndex]
        heap[secondIndex] = first
    }
    private mutating func heapify() {
        var index = 1
        while true {
            let left = 2*index
            let right = 2*index + 1
            var largest = index
            
            if left <= count && compare(first: heap[left-1], second: heap[index-1]) {
                largest = left
            }
            if right <= count && compare(first: heap[right-1], second: heap[largest-1]) {
                largest = right
            }
            if largest == index {
                break
            }
            swap(between: index-1, and: largest-1)
            index = largest
        }
    }
}
