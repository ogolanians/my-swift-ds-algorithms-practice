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
// Time: O(m*n) which is same as O(n^2)
// Space: O(n)
// Go through each node in first list and compare with all nodes in second list
func findMergeBrute(_ headA: Node?,_ headB: Node? ) -> Int? {
    let lenA = length(headA) // O(m)
    let lenB = length(headB) // O(n)
    
    var currentA = headA
    for _ in 0...lenA - 1 { // O(m)
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

// Second solution: using dictionaries
// Assign second list's data to a dict's keys and set true for that key's value
// Then go through each element in first list and check if exists in dict
// This is a trade-off for time instead of space
// Time: O(m+n) which is same as O(n)
// Space: O(n^2)
func findMergePointDict(_ headA: Node?,_ headB: Node?) -> Int? {
    let lenA = length(headA) // O(m)
    let lenB = length(headB) // O(n)
    
    var dictB = [Int? : Bool]()
    var currentB = headB
    // Assign second list's data to dict's key with true as the value
    for _ in 0...lenB - 1 { // O(m)
        let B = currentB?.data
        dictB[B] = true
        currentB = currentB?.next
    }
    
    var currentA = headA
    for _ in 0...lenA - 1 { // O(n)
        let A = currentA?.data
        if dictB[A] == true {
            return A
        }
        currentA = currentA?.next
    }
    
    return nil
    
}

// Most optimized
// Make both lists start same n elements before the merge point by finding the difference between the lists' lenghts
// This allows us to only go through the list once since both lists indexes match
// Time: O(n)
// Space: O(n)
func findMergePoint(_ headA: Node?, _ headB: Node?) -> Int? {
    let lenA = length(headA)
    let lenB = length(headB)
    
    var currentA = headA
    var currentB = headB
    
    // Check for longer list to know which one to flush out
    // Move d elements over in longer list
    if lenB > lenA {
        let temp = currentA
        currentA = currentB
        currentB = temp
    }
    
    let d = abs(lenA - lenB)
    
    for _ in 1...d {
        currentA = currentA?.next
    }
    
    // It doesn't matter which length we use here
    // We will get to our merge point regardless
    for _ in 0...lenA - 1 {
        let A = currentA?.data
        let B = currentB?.data
        if A == B {
            return A
        }
        currentA = currentA?.next
        currentB = currentB?.next
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
findMergePointDict(node1, node10)
findMergePoint(node1, node10)

// 7 8 9 10
let node15 = Node(10)
let node14 = Node(9, node15)
let node13 = Node(8, node14)
let node12 = Node(7, node13)

// 1 2 3 4 5 6 7 8 9 10
let node21 = Node(6, node12)
let node20 = Node(5, node21)
let node19 = Node(4, node20)
let node18 = Node(3, node19)
let node17 = Node(2, node18)
let node16 = Node(1, node17)

findMergeBrute(node12, node16)
findMergePointDict(node12, node16)
findMergePoint(node12, node16)







