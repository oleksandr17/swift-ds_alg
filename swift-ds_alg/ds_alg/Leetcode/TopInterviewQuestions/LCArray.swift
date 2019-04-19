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
        var didAddOne = false
        var remainder = 0
        for i in (0..<digits.count).reversed() {
            let digit = digits[i]
            let value = digit + remainder + (didAddOne ? 0 : 1)
            remainder = 0
            didAddOne = true
            let newDigit = value % 10
            remainder = value / 10
            result.insert(newDigit, at: 0)
        }
        
        if remainder > 0 {
            result.insert(remainder, at: 0)
        }
        
        return result
    }
}
