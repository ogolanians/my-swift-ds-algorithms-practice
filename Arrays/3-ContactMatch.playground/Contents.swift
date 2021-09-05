import Foundation

/*
 When someone searches their contacts based on a phone number, it's nice when a list
 of contact pops up.
 
 Write an algorithm that searches your contacts for phone number strings, and returns:
  - NO CONTACT if contact can't be found
  - A contact if a contact is found
  - The first alphabetized contact if there are multiple
 
 A = ["pim", "pom"]             // Contacts (return one of these)
 B = ["", "999999999777888999"] // Phone numbers for each contact A[i] = B[i]
 P = "88999"                    // Search phrase

 Answer should be correct. Don't worry about performance.
 */

// Time: O(n)
func contactMatch(_ A: [String], _ B: [String], _ P: String) -> String {
    var result = Array<String>()
    
    for i in 0..<B.count {
        if B[i].contains(P) {
            result.append(A[i]) // Add the matching names to result
        }
    }
    
    if result.count == 0 {
        return "NO CONTACT"
    } else if result.count == 1 {
        return result.first!
    }
    
    // If we get to this point then more than contact is found
    // Sort the list alphabetically and return first one
    
    return result.sorted().first!
}

let A = ["pim", "pom"]
let B = ["", "999999999777888999"]
let P = "88999"

let C = ["homie", "avocado", "brian"]
let D = ["1", "236371838", "371801932"]
let P1 = "3718"

let E = ["hayastan", "parskastan", "amerika"]
let F = ["123", "456", "789"]
let P2 = "101112"

contactMatch(A, B, P) // "pom"
contactMatch(C, D, P1) // "avocado"
contactMatch(E, F, P2) // "NO CONTACT"
