import UIKit

/*
 Find Merge Point of Two Lists

 Given pointers to the head nodes of 2 linked lists that merge together at some point, find the node where the two lists merge. The merge point is where both lists point to the same node, i.e. they reference the same memory location. It is guaranteed that the two head nodes will be different, and neither will be NULL. If the lists share a common node, return that node's data value.

 Note: After the merge point, both lists will share the same node pointers.
 
 */

class Node {
    var data: Int
    var next: Node?
    
    init(_ data: Int, _ next: Node? = nil) {
        self.data = data
        self.next = next
    }
}

// helper function to find length of linked list
func length(_ head: Node?) -> Int {
    if head == nil {
        return 0
    }
    var current = head
    var count = 0
    while (current?.next != nil) {
        count += 1
        current = current?.next
    }
    
    return count
}

// helper function print
func printLinkedList(_ head: Node?) {
    if head == nil {
        return
    }
    var result = [Int]()
    var node = head
    result.append(node!.data)
    
    while (node?.next != nil) {
        result.append(node!.next!.data)
        node = node?.next
    }
    print(result)
}

// First solution: brute force
// Time: O(n^2)
// Space: O(n^2)
// Go through each node in first list and compare with all nodes in second list
func findMergeBrute(_ headA: Node?, _ headB: Node? ) -> Int? {
    let lenA = length(headA) // O(n)
    let lenB = length(headB) // O(n)
    
    var currentA = headA
    for _ in 0...lenA - 1 { // O(n)
        let A = currentA?.data
        var currentB = headB
        for _ in 0...lenB - 1 { // O(n)
            let B = currentB?.data
            if A == B {
                return A
            }
            currentB = currentB?.next
        }
        currentA = currentA?.next
    }
    
    return nil
}

// 1 2 3 4 5 6
let node6 = Node(6)
let node5 = Node(5, node6)
let node4 = Node(4, node5)
let node3 = Node(3, node4)
let node2 = Node(2, node3)
let node1 = Node(1, node2)

// 11 10 4 5 6
let node11 = Node(11, node4)
let node10 = Node(10, node11)

//printLinkedList(node1)
findMergeBrute(node1, node10)




