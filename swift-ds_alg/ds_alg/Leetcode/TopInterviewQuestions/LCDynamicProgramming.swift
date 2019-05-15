import Foundation

class LCDynamicProgramming {
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/97/dynamic-programming/572/
     */
    func maxProfit(_ prices: [Int]) -> Int {
        guard prices.count >= 1 else { return 0 }
        
        var profit = 0
        var left = 0
        var right = 0
        for i in 1..<prices.count {
            if prices[i] < prices[right] {
                left = (prices[left] < prices[i]) ? left : i
                right = i
            } else {
                right = i
                profit = max(profit, prices[right]-prices[left])
            }
        }
        
        profit = max(profit, prices[right]-prices[left])
        
        return profit
    }
}
