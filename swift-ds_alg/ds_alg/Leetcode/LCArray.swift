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
}
