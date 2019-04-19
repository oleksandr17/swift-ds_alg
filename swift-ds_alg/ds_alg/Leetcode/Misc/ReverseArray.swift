import Foundation

class ReverseArray {
    
    /*
     Reverse array.
     Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.
     */
    static func reverseArray(_ s: inout [Int]) {
        var start = 0
        var end = s.count - 1
        while start < end {
            (s[start], s[end]) = (s[end], s[start])
            start += 1; end -= 1
        }
    }
}
