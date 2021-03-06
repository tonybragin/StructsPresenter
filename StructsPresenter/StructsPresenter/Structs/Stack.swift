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
