//
//  BinarySearchTree.swift
//  StructsPresenter
//
//  Created by Tony on 05/01/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

struct BinarySearchTree<Key: Comparable, Value> {
    private class BinarySearchTreeNode {
        var key: Key
        var value: Value?
        var left: BinarySearchTreeNode?
        var right: BinarySearchTreeNode?
        init(key: Key, value: Value?) {
            self.key = key
            self.value = value
        }
    }
    private enum NodeType {
        case head
        case left(BinarySearchTreeNode)
        case right(BinarySearchTreeNode)
    }
    private enum RemoveType {
        case noChild
        case left
        case right
        case both
    }
    private var head: BinarySearchTreeNode?
    init() {}
    init(key: Key, value: Value?) {
        head = BinarySearchTreeNode(key: key, value: value)
    }
    // MARK: - Public Methods
    subscript(key: Key) -> Value? {
        get {
            return valueForKey(key)
        }
        set {
            addValue(newValue, for: key)
        }
    }
    mutating func addValue(_ value: Value?, for key: Key) {
        if let item = item(for: key) {
            switch item {
            case .head:
                head?.value = value
            case .left(let node):
                node.left?.value = value
            case .right(let node):
                node.right?.value = value
            }
        } else {
            add(key: key, value: value)
        }
    }
    func valueForKey(_ key: Key) -> Value? {
        switch item(for: key) {
        case .head:
            return head?.value
        case .left(let node):
            return node.left?.value
        case .right(let node):
            return node.right?.value
        case nil:
            return nil
        }
    }
    mutating func removeItem(for key: Key) -> Value? {
        var resultValue: Value?
        if let resultItem = item(for: key) {
            switch resultItem {
            case .head:
                resultValue = head?.value
            case .left(let node):
                resultValue = node.left?.value
            case .right(let node):
                resultValue = node.right?.value
            }
            removeItem(with: resultItem)
        }
        return resultValue
    }
    // MARK: - Private Methods -> NodeType
    private func addingItem(for key: Key) -> NodeType {
        if var node = head {
            while true {
                if node.key < key {
                    if let leftNode = node.left {
                        node = leftNode
                    } else {
                        return .left(node)
                    }
                } else {
                    if let rightNode = node.right {
                        node = rightNode
                    } else {
                        return .right(node)
                    }
                }
            }
        } else {
            return .head
        }
    }
    private func item(for key: Key) -> NodeType? {
        if var node = head {
            if node.key == key {
                return .head
            }
            while true {
                if node.key < key {
                    if let leftNode = node.left {
                        if leftNode.key == key {
                            return .left(node)
                        } else {
                            node = leftNode
                        }
                    } else {
                        return nil
                    }
                } else {
                    if let rightNode = node.right {
                        if rightNode.key == key {
                            return .right(node)
                        } else {
                            node = rightNode
                        }
                    } else {
                        return nil
                    }
                }
            }
        }
        return nil
    }
    private func itemWithMinKey(for head: BinarySearchTreeNode) -> NodeType {
        var node = head
        if node.left == nil {
            return .head
        }
        while node.left?.left != nil {
            node = node.left!
        }
        return .left(node)
    }
    // MARK: - Private Methods Addition
    private mutating func add(key: Key, value: Value?) {
        let newNode = BinarySearchTreeNode(key: key, value: value)
        switch addingItem(for: key) {
        case .head:
            head = newNode
        case .left(let leftNode):
            leftNode.left = newNode
        case .right(let rightNode):
            rightNode.right = newNode
        }
    }
    // MARK: - Private Methods Removal
    private func removeType(for node: BinarySearchTreeNode) -> RemoveType {
        if node.left == nil && node.right == nil {
            return .noChild
        } else if node.left != nil && node.right != nil {
            return .both
        } else if node.left != nil {
            return .left
        } else {
            return .right
        }
    }
    private mutating func removeItem(with type: NodeType) {
        switch type {
        case .head:
            switch removeType(for: head!) {
            case .noChild:
                head = nil
            case .left:
                head = head?.left
            case .right:
                head = head?.right
            case .both:
                let minKeyNodeType = itemWithMinKey(for: head!.right!)
                switch minKeyNodeType {
                case .head:
                    head = head?.right
                case .left(let minNode):
                    head = minNode.left
                    removeItem(with: .left(minNode))
                default:
                    assert(false, "itemWithMinKey error")
                }
            }
        case .left(let node):
            switch removeType(for: node.left!) {
            case .noChild:
                node.left = nil
            case .left:
                node.left = node.left?.left
            case .right:
                node.left = node.left?.right
            case .both:
                let minKeyNodeType = itemWithMinKey(for: node.left!.right!)
                switch minKeyNodeType {
                case .head:
                    node.left = node.left?.right
                case .left(let minNode):
                    node.left = minNode.left
                    removeItem(with: .left(minNode))
                default:
                    assert(false, "itemWithMinKey error")
                }
            }
        case .right(let node):
            switch removeType(for: node.right!) {
            case .noChild:
                node.right = nil
            case .left:
                node.right = node.right?.left
            case .right:
                node.right = node.right?.right
            case .both:
                let minKeyNodeType = itemWithMinKey(for: node.right!.right!)
                switch minKeyNodeType {
                case .head:
                    node.right = node.right?.right
                case .left(let minNode):
                    node.right = minNode.left
                    removeItem(with: .left(minNode))
                default:
                    assert(false, "itemWithMinKey error")
                }
            }
        }
    }
}
