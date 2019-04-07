import Foundation

public class Memoization {
    
    /*
     The Fibonacci numbers, commonly denoted F(n) form a sequence, called the Fibonacci sequence, such that each number is the sum of the two preceding ones, starting from 0 and 1. That is,
     F(0) = 0,   F(1) = 1
     F(N) = F(N - 1) + F(N - 2), for N > 1.
     Given N, calculate F(N).
     
     Example 1:
     Input: 2
     Output: 1
     Explanation: F(2) = F(1) + F(0) = 1 + 0 = 1.
     
     Example 2:
     Input: 3
     Output: 2
     Explanation: F(3) = F(2) + F(1) = 1 + 1 = 2.
     
     Example 3:
     Input: 4
     Output: 3
     Explanation: F(4) = F(3) + F(2) = 2 + 1 = 3.
     */
    public static func fib(_ N: Int) -> Int {
        var cache = [Int: Int]()
        return fib(N, &cache)
    }
    
    private static func fib(_ N: Int, _ cache: inout [Int: Int]) -> Int {
        switch N {
        case 0:
            return 0
        case 1...2:
            return 1
        default:
            if let value = cache[N] {
                return value
            }
            let value = fib(N-1, &cache) + fib(N-2, &cache)
            cache[N] = value
            return value
        }
    }
    
    /*
     You are climbing a stair case. It takes n steps to reach to the top.
     Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
     Note: Given n will be a positive integer.
     
     Example 1:
     Input: 2
     Output: 2
     Explanation: There are two ways to climb to the top.
     1. 1 step + 1 step
     2. 2 steps
     
     Example 2:
     Input: 3
     Output: 3
     Explanation: There are three ways to climb to the top.
     1. 1 step + 1 step + 1 step
     2. 1 step + 2 steps
     3. 2 steps + 1 step
     */
    public static func climbStairs(_ n: Int) -> Int {
        var cache = [Int: Int]()
        return climbStairs(n, &cache)
    }
    
    private static func climbStairs(_ n: Int,  _ cache: inout [Int: Int]) -> Int {
        switch n {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 2
        default:
            if let value = cache[n] {
                return value
            }
            let value = climbStairs(n-1, &cache) + climbStairs(n-2, &cache)
            cache[n] = value
            return value
        }
    }
}
