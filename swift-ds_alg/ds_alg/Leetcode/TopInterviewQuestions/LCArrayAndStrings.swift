import Foundation

class LCArrayAndStrings {
    
    // MARK: - Medium
    
    /*
     /Users/oleksandr/Documents/ELEMENTS/PROJECTS/_PERSONAL/Xcode/swift-ds_alg/swift-ds_alg.xcodeprojhttps://leetcode.com/explore/interview/card/top-interview-questions-medium/103/array-and-strings/778/
     */
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var values = [String: Array<String>]()
        for str in strs {
            values[String(str.sorted()), default: Array<String>()].append(str)
        }
        
        var result = [[String]]()
        for (_, value) in values {
            result.append(value)
        }
        return result
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-medium/103/array-and-strings/776/
     Explanation: https://fizzbuzzed.com/top-interview-questions-1/
     */
    func threeSum(_ nums: [Int]) -> [[Int]] {
        if true {
            // Time complexity: O(N^2)
            guard nums.count >= 3 else { return [[Int]]() }
            let sorted = nums.sorted()
            var result = [[Int]]()
            for i in 0..<sorted.count {
                // Don't allow `i` to point to same element
                if i != 0, sorted[i] == sorted[i-1] { continue }
                var j = i + 1
                var k = sorted.count-1
                while j < k {
                    let sum = sorted[i] + sorted[j] + sorted[k]
                    if sum == 0 {
                        result.append([sorted[i], sorted[j], sorted[k]])
                        j += 1
                        // Don't allow `j` to point to same element
                        while j < k, sorted[j] == sorted[j-1] {
                            j += 1
                        }
                    } else if sum < 0 {
                        j += 1
                    } else {
                        k -= 1
                    }
                }
            }
            return result
        }
        else {
            // Time complexity: O(N^3)
            guard nums.count >= 3 else { return [[Int]]() }
            var result = [[Int: Int]: [Int]]() // key -> occurences, value -> array
            for i in 0..<nums.count-2 {
                for j in i+1..<nums.count-1 {
                    for k in j+1..<nums.count {
                        if nums[i] + nums[j] + nums[k] == 0 {
                            var occurences = [Int: Int]()
                            occurences[nums[i], default: 0] += 1
                            occurences[nums[j], default: 0] += 1
                            occurences[nums[k], default: 0] += 1
                            result[occurences] = [nums[i], nums[j], nums[k]]
                        }
                    }
                }
            }
            return Array(result.values)
        }
    }
}
