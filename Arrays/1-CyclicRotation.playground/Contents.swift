import UIKit

/*
 Rotate array to right N times.
 https://app.codility.com/programmers/lessons/2-arrays/cyclic_rotation/
 
 For example, given

     A = [3, 8, 9, 7, 6]
     K = 3
 the function should return [9, 7, 6, 3, 8]. Three rotations were made:

     [3, 8, 9, 7, 6] -> [6, 3, 8, 9, 7]
     [6, 3, 8, 9, 7] -> [7, 6, 3, 8, 9]
     [7, 6, 3, 8, 9] -> [9, 7, 6, 3, 8]

 */

// Time: O(n^2)
func solution(A: [Int], K: Int) -> [Int] {
    guard !A.isEmpty else { return [] }
    guard K > 0 else { return A }
    
    var result = A
    for _ in 0...K-1 { // O(n)
        result = rotateArrByOne(result)
    }
    return result
}

func rotateArrByOne(_ A: [Int]) -> [Int] {
    var newArr = Array<Int>(repeating: 0, count: A.count)
    // First iteration we will have 0,3,0,0,0
    // We will use original array A to fill up remaining elements in newArr
    for i in 0..<newArr.count - 1 { // O(n)
        newArr[i+1] = A[i]
    }
    // Due to array size, the last index gets overriden
    // We can simply use original array to assign it to 1st element in newArr
    newArr[0] = A.last!
    
    return newArr
}
solution(A: [], K: 0)
solution(A: [], K: 1)
solution(A: [-4], K: 0)
solution(A: [-4], K: 1)
solution(A: [1, 2, 3], K: 4)

solution(A: [1, 2, 3, 4, 5], K: 1)
solution(A: [1, 2, 3, 4, 5], K: 2)
solution(A: [1, 2, 3, 4, 5], K: 3)

solution(A: [3, 8, 9, 7, 6], K: 3)


