import Foundation

class LCArray {
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/727/
     */
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        guard var prev = nums.first else { return 0 }
        
        var i = 1
        while i < nums.count {
            if nums[i] == prev {
                nums.remove(at: i)
            } else {
                prev = nums[i]
                i += 1
            }
        }
        
        return nums.count
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/564/
     */
    func maxProfit(_ prices: [Int]) -> Int {
        guard prices.count >= 2 else { return 0 }
        
        var profit = 0
        var left = 0
        var right = 0
        for i in 1..<prices.count {
            if prices[right] < prices[i] {
                right = i
            } else {
                profit += prices[right] - prices[left]
                left = i
                right = i
            }
        }
        profit += prices[right] - prices[left]
        
        return profit
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/646/
     */
    func rotate(_ nums: inout [Int], _ k: Int) {
        guard nums.count >= 1, k >= 1 else { return }
        let rotations = k % nums.count
        guard rotations >= 1 else { return }
        let arr1 = nums[nums.count-rotations..<nums.count]
        let arr2 = nums[0..<nums.count-rotations]
        nums = Array(arr1) + Array(arr2)
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/578/
     */
    func containsDuplicate(_ nums: [Int]) -> Bool {
        let set = Set<Int>(nums)
        return nums.count != set.count
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/549/
     */
    func singleNumber(_ nums: [Int]) -> Int {
        let counts = nums.reduce(into: [Int: Int]()) { (result, item) in
            result[item, default: 0] += 1
        }
        for (key, value) in counts {
            guard value != 2 else { continue }
            return key
        }
        return -1
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/674/
     */
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let counts1 = nums1.reduce(into: [Int: Int]()) { (result, item) in
            result[item, default: 0] += 1
        }
        let counts2 = nums2.reduce(into: [Int: Int]()) { (result, item) in
            result[item, default: 0] += 1
        }
        
        var result = [Int]()
        for (key1, value1) in counts1 {
            guard let value2 = counts2[key1] else { continue }
            result.append(contentsOf: Array<Int>(repeating: key1, count: min(value1, value2)))
        }
        return result
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/559/
     */
    func plusOne(_ digits: [Int]) -> [Int] {
        var result = [Int]()
        var remainder = 1
        for i in (0..<digits.count).reversed() {
            let digit = digits[i]
            let value = digit + remainder
            let newDigit = value % 10
            result.insert(newDigit, at: 0)
            remainder = value / 10
        }
        
        if remainder > 0 {
            result.insert(remainder, at: 0)
        }
        
        return result
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/567/
     */
    func moveZeroes(_ nums: inout [Int]) {
        // Find indices of zeros
        var indices  = [Int]()
        var index = 0
        for num in nums {
            if num == 0 {
                indices.append(index)
            }
            index += 1
        }
        
        // Modify `nums`
        var shiftsCount = 0
        for index in indices {
            let newIndex = index - shiftsCount
            nums.remove(at: newIndex)
            nums.append(0)
            shiftsCount += 1
        }
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/546/
     */
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        if true {
            /*
             Complexity Analysis:
             Time complexity : O(n). We traverse the list containing n elements only once. Each look up in the table costs only O(1) time.
             Space complexity : O(n). The extra space required depends on the number of items stored in the hash table, which stores at most nn elements.
             */
            var dict = [Int: Int]()
            for index in 0..<nums.count {
                let value = nums[index]
                let remainder = target - value
                if let anotherIndex = dict[remainder] {
                    return [anotherIndex, index]
                }
                dict[value] = index
            }
            return [-1, -1]
        }
        else { // Brute force
            /*
             Complexity Analysis:
             Time complexity : O(n^2)
             Space complexity : O(1)
             */
            for i in 0..<(nums.count-1) {
                for j in i+1..<nums.count {
                    if nums[i] + nums[j] == target {
                        return [i, j]
                    }
                }
            }
            return [-1, -1]
        }
    }
}
