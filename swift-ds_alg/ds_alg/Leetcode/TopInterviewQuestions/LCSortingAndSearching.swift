import Foundation

class LCSortingAndSearching {
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/96/sorting-and-searching/587/
     */
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var index1 = m - 1
        var index2 = n - 1
        var targetIndex = nums1.count - 1
        while index1 >= 0 || index2 >= 0 {
            defer {
                targetIndex -= 1
            }
            
            if index2 < 0 {
                nums1[targetIndex] = nums1[index1]
                index1 -= 1
                continue
            }
            
            if index1 < 0 {
                nums1[targetIndex] = nums2[index2]
                index2 -= 1
                continue
            }
            
            if nums2[index2] >= nums1[index1] {
                nums1[targetIndex] = nums2[index2]
                index2 -= 1
                continue
            }
            
            nums1[targetIndex] = nums1[index1]
            index1 -= 1
        }
    }
}
