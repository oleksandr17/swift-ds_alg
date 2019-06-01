import Foundation

class LCBacktracking {
    
    // MARK: Medium
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-medium/109/backtracking/793/
     */
    func letterCombinations(_ digits: String) -> [String] {
        var result = [String]()
        guard !digits.isEmpty else { return result }
        letterCombinations(digits: digits, depth: 0, input: "", result: &result)
        return result
    }
    
    private func letterCombinations(digits: String, depth: Int, input: String, result: inout [String]) {
        guard depth < digits.count else {
            result.append(input)
            return
        }
        let numbers = ["2": "abc", "3": "def", "4": "ghi", "5": "jkl", "6": "mno", "7": "pqrs", "8": "tuv", "9": "wxyz", "0": " "]
        let digit = String(digits[String.Index(encodedOffset: depth)])
        guard let letters = numbers[digit] else { fatalError("Can't find letters for the digit \(digit)") }
        
        for letter in letters {
            let newInput = input + String(letter)
            letterCombinations(digits: digits, depth: depth+1, input: newInput, result: &result)
        }
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-medium/109/backtracking/796/
     */
    func subsets(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        guard !nums.isEmpty else { return result }
        subsets(nums: nums, depth: 0, subset: [], result: &result)
        return result
    }
    
    private func subsets(nums: [Int], depth: Int, subset: [Int], result: inout [[Int]]) {
        guard depth < nums.count else {
            result.append(subset)
            return
        }
        do {
            let number = nums[depth]
            var newSubset = Array<Int>(subset)
            newSubset.append(number)
            subsets(nums: nums, depth: depth+1, subset: newSubset, result: &result)
        }
        subsets(nums: nums, depth: depth+1, subset: subset, result: &result)
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-medium/110/sorting-and-searching/803/
     */
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        /*
         Complexity Analysis:
         
         Time complexity: O(n*logn) due to sorting
         Space complexity: O(n) due to additional array for sorted intervals
         */
        var result = [[Int]]()
        // Validate input
        guard !intervals.isEmpty else { return result }
        guard intervals.count > 1 else { return intervals }
        
        // Simplify algorithm by sorting intervals by start value
        let intervalsSorted = intervals.sorted { (item1, item2) -> Bool in
            return item1[0] < item2[0]
        }
        
        // Merge overlapping intervals and store in-place
        result.append(intervalsSorted[0])
        for i in 1..<intervalsSorted.count {
            let interval = intervalsSorted[i]
            let lastInterval = result.last!
            if interval[0] >= lastInterval[0] && interval[0] <= lastInterval[1] { // check if intervals overlap
                _ = result.popLast()
                let newInterval = [min(interval[0], lastInterval[0]), max(interval[1], lastInterval[1])]
                result.append(newInterval)
            } else {
                result.append(interval)
            }
        }
        
        return result
    }
}
