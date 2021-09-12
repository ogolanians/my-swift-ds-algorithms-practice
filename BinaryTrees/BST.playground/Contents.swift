import UIKit

class Node {
    var key: Int = 0
    var left: Node?
    var right: Node?
    
    init(_ key: Int) {
        self.key = key
    }
    
    // Keep recursing left until we hit a node's null value
    var min: Node {
        if left == nil {
            return self
        } else {
            return left!.min
        }
    }
}

let bst = BST()
bst.insert(key: 5)
bst.insert(key: 3)
bst.insert(key: 2)
bst.insert(key: 4)
bst.insert(key: 7)
bst.insert(key: 6)
bst.insert(key: 8)

class BST {
    var root: Node?
    
    func insert(key: Int) {
        root = insertItem(root, key)
    }
    
    private func insertItem(_ node: Node?, _ key: Int) -> Node {
        guard let node = node else {
            let node = Node(key)
            return node
        }
        if key < node.key {
            node.left = insertItem(node.left, key)
        }
        if key > node.key {
            node.right = insertItem(node.right, key)
        }
        return node
    }
    
    func find(key: Int) -> Int? {
        guard let root = root else { return nil }
        guard let node = find(root, key) else { return nil }
        return node.key
    }
    
    private func find(_ node: Node?, _ key: Int) -> Node? {
        guard let node = node else { return nil }
        
        if node.key == key {
            return node
        } else if key < node.key {
            return find(node.left, key)
        } else if key > node.key {
            return find(node.right, key)
        }
        return nil
    }
    
    func findMin() -> Int {
        guard let root = root else { return 0 }
        return findMin(root).key
    }
    
    private func findMin(_ node: Node) -> Node {
        // min closure handles this functionality
        return node.min
    }
    
    func delete(_ key: Int) {
        guard let _ = root else { return }
        root = delete(&root, key)
    }
    
    // To delete a node, there are 3 cases to handle
    // These cases depend on the number(s) of child(ren)
    // Case 0: No child
    // Case 1: 1 child
    // Case 2: 2 children
    // In below commentary, the "node" means the one selected to be deleted
    
    // In case of no child, set the node's reference to null
    
    // In case of 1 child, replace the node with its child
    
    // In case of 2 children, remember that a tree can be represented multiple ways
    // -- Arrange the tree so that each node has either no child or 1 child
    // -- Go as deep down the rhs of node and find the min
    // -- Replace the node with the min found from rhs
    // -- Remove the min to get rid of duplicates
    func delete(_ node: inout Node?, _ key: Int) -> Node? {
        guard let nd = node else { return nil }
        
        // Find the node that belongs to key passed in
        if key < nd.key {
            // Go left
            nd.left = delete(&nd.left, key)
        } else if key > nd.key {
            // Go right
            nd.right = delete(&nd.right, key)
        } else {
            // Found the node that must be deleted
            // Check for cases here
            
            // Case 0: No child
            if nd.left == nil && nd.right == nil {
                node = nil
            }
            // Case 1: 1 Child
            else if nd.left == nil {
                node = nd.right
            }
            else if nd.right == nil {
                node = nd.left
            }
            // Case 2: 2 Children
            else {
                // Find the min in deepest rhs
                let minRight = findMin(nd.right!)
                // Assign the rhs min value to value of node to be deleted
                node!.key = minRight.key
                // Delete the rhs min node to avoid duplicates in tree
                node!.right = delete(&node!.right, node!.key)
            }
        }
        
        return nil
    }
}

// No child deletion
bst.delete(8)
print(bst.find(key: 8) ?? "can't find 8") // can't find 8

// One child deletion
bst.delete(7)
print(bst.find(key: 7) ?? "can't find 7") // can't find 7

// Two children deletion
bst.delete(3)
print(bst.find(key: 3) ?? "can't find 3") // can't find 3
