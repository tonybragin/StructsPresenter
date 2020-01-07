//
//  Stack.swift
//  StructsPresenter
//
//  Created by Tony on 05/01/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

struct Stack<Element> {
    private var stack = [Element]()
    var count: Int {
        return stack.count
    }
    init () {}
    init(element: Element) {
        push(element)
    }
    init(array: [Element]) {
        for item in array {
            push(item)
        }
    }
    mutating func push(_ element: Element) {
        stack.append(element)
    }
    mutating func pop() -> Element {
        return stack.removeLast()
    }
    mutating func clear() {
        stack = []
    }
}
