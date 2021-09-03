import UIKit

/*
 We are given a string S representing a phone number, which we would like to reformat. String S consists of N characters: digits, spaces, and/or dashes. It contains at least two digits.
 
 Spaces and dashes in string S can be ignored. We want to reformat the given phone number is such a way that the digits are grouped in blocks of length three, separated by single dashes. If necessary, the final block or the last two blocks can be of length two.
 
 For example:
 
 S = "00-44   48 5555 8361" should become
     "004-448-555-583-61"
 
 Assume:
 - S consists only of digits (0-9), spaces, and/or dashses (-)
 - S containts at least two digits
 
 Translate:
 
 Would like to reformat a phone number string so that:
 - every third char is a "-"
 - spaces and dashes don't matter
 - if the block ends in anything other than -xxx or -xx reformat to a block of two like xx-xx (not obvious)
 
 */

// Time: O(n)
func addPhoneNumDashes(_ S: String) -> String {
    let noSpace = S.replacingOccurrences(of: " ", with: "")
    let noSpaceNoDash = noSpace.replacingOccurrences(of: "-", with: "")
    
    var count = -2
    var result = ""
    for i in noSpaceNoDash { // O(n)
        result.append(i)
        if count % 3 == 0 {
            result.append("-")
        }
        count += 1
    }
    
    // If last char is a dash, remove the lingering dash
    if result.last == "-" {
        result.dropLast()
    }
    
    // If second to last char is a dash like xxx-x
    // then we need to break this up so it ends with 2 chars xx-xx
    
    // First, convert to array
    var anArr = Array(result)
    let secondLastPtr = result.count - 2
    if anArr[secondLastPtr] == "-" {
        anArr[secondLastPtr] = anArr[secondLastPtr - 1]
        anArr[secondLastPtr - 1] = "-"
    }
    
    result = String(anArr)
    
    return result
}

addPhoneNumDashes("918293094")
addPhoneNumDashes("83819393481")
addPhoneNumDashes("0 - 22 1985--324")


// 918293094 -> 918-293-094
// 83819393481 -> 838-193-934-81
// 0 - 22 1985--324 -> 022-198-532-4 -> 022-198-53-24
