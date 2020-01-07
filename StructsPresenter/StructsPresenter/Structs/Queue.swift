//
//  Queue.swift
//  StructsPresenter
//
//  Created by Tony on 05/01/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

struct Queue<Element> {
    private var queue = [Element]()
    var count: Int {
        return queue.count
    }
    init () {}
    init(element: Element) {
        enqueue(element)
    }
    init(array: [Element]) {
        for item in array {
            enqueue(item)
        }
    }
    mutating func enqueue(_ element: Element) {
        queue.append(element)
    }
    mutating func dequeue() -> Element {
        return queue.removeFirst()
    }
    mutating func clear() {
        queue = []
    }
}

struct Deque<Element> {
    private var queue = [Element]()
    var count: Int {
        return queue.count
    }
    init () {}
    init(element: Element) {
        pushBack(element)
    }
    init(array: [Element]) {
        for item in array {
            pushBack(item)
        }
    }
    mutating func pushBack(_ element: Element) {
        queue.append(element)
    }
    mutating func popFront() -> Element {
        return queue.removeFirst()
    }
    mutating func pushFront(_ element: Element) {
        queue.insert(element, at: 0)
    }
    mutating func popBack() -> Element {
        return queue.removeLast()
    }
    mutating func clear() {
        queue = []
    }
}
