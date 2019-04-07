import Foundation

/*
 Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.
 
 push(x) -- Push element x onto stack.
 pop() -- Removes the element on top of the stack.
 top() -- Get the top element.
 getMin() -- Retrieve the minimum element in the stack.
 
 Example:
 MinStack minStack = new MinStack();
 minStack.push(-2);
 minStack.push(0);
 minStack.push(-3);
 minStack.getMin();   --> Returns -3.
 minStack.pop();
 minStack.top();      --> Returns 0.
 minStack.getMin();   --> Returns -2.
 */
public class MinStack {
    private var values = [Int]()
    private var auxiliaryValues = [Int]()
    
    public func push(_ x: Int) {
        values.append(x)
        
        if let lastAuxiliary = auxiliaryValues.last {
            if x < lastAuxiliary {
                auxiliaryValues.append(x)
            } else {
                auxiliaryValues.append(lastAuxiliary)
            }
        } else {
            auxiliaryValues.append(x)
        }
    }
    
    public func pop() {
        _ = values.popLast()
        _ = auxiliaryValues.popLast()
    }
    
    public func top() -> Int {
        guard let last = values.last else { return -1 }
        return last
    }
    
    public func getMin() -> Int {
        guard let lastAuxiliary = auxiliaryValues.last else { return -1 }
        return lastAuxiliary
    }
}

/*
 Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
 
 An input string is valid if:
 1. Open brackets must be closed by the same type of brackets.
 2. Open brackets must be closed in the correct order.
 
 Note that an empty string is also considered valid.
 
 Example 1:
 Input: "()"
 Output: true
 
 Example 2:
 Input: "()[]{}"
 Output: true
 
 Example 3:
 Input: "(]"
 Output: false
 
 Example 4:
 Input: "([)]"
 Output: false
 
 Example 5:
 Input: "{[]}"
 Output: true
 */
public class ValidParenthesesSolution {
    
    static private let couples = [("(",")"), ("{","}"), ("[","]")]
    
    public func isValid(_ s: String) -> Bool {
        var stack = [Character]()
        for c in s {
            if isStart(c: c) {
                stack.append(c)
            } else if isEnd(c: c) {
                guard let start = stack.popLast() else { return false } // no leading start
                for couple in ValidParenthesesSolution.couples {
                    if couple.0 == String(start) {
                        guard couple.1 == String(c) else { return false } // incorrect couple
                        break
                    }
                }
            } else {
                fatalError("Unknown character")
            }
        }
        return stack.isEmpty
    }
    
    private func  isStart(c: Character) -> Bool {
        for couple in ValidParenthesesSolution.couples {
            if couple.0 == String(c) {
                return true
            }
        }
        return false
    }
    
    private func  isEnd(c: Character) -> Bool {
        for couple in ValidParenthesesSolution.couples {
            if couple.1 == String(c) {
                return true
            }
        }
        return false
    }
}

/*
 You are given a list of non-negative integers, a1, a2, ..., an, and a target, S. Now you have 2 symbols + and -. For each integer, you should choose one from + and - as its new symbol.
 
 Find out how many ways to assign symbols to make sum of integers equal to target S.
 
 Example 1:
 Input: nums is [1, 1, 1, 1, 1], S is 3.
 Output: 5
 
 Explanation:
 -1+1+1+1+1 = 3
 +1-1+1+1+1 = 3
 +1+1-1+1+1 = 3
 +1+1+1-1+1 = 3
 +1+1+1+1-1 = 3
 
 There are 5 ways to assign symbols to make the sum of nums be target 3.
 */
public class TargetSumSolution {
    private enum Operation {
        case plus
        case minus
    }
    
    public func findTargetSumWays(_ nums: [Int], _ S: Int) -> Int {
        guard !nums.isEmpty else { return 0 }
        return findTargetSumWays(nums, 0, .plus, S, 0) + findTargetSumWays(nums, 0, .minus, S, 0)
    }
    
    private func findTargetSumWays(_ nums: [Int], _ index: Int, _ operation: Operation, _ target: Int, _ currentSum: Int) -> Int {
        let value: Int
        switch operation {
        case .plus:
            value = currentSum + nums[index]
        case .minus:
            value = currentSum - nums[index]
        }
        
        guard index < (nums.count - 1) else { // last item
            return (value == target) ? 1 : 0
        }
        
        return findTargetSumWays(nums, index + 1, .plus, target, value) + findTargetSumWays(nums, index + 1, .minus, target, value)
    }
}

/*
 Given an encoded string, return it's decoded string.
 
 The encoding rule is: k[encoded_string], where the encoded_string inside the square brackets is being repeated exactly k times. Note that k is guaranteed to be a positive integer.
 
 You may assume that the input string is always valid; No extra white spaces, square brackets are well-formed, etc.
 
 Furthermore, you may assume that the original data does not contain any digits and that digits are only for those repeat numbers, k. For example, there won't be input like 3a or 2[4].
 
 Examples:
 s = "3[a]2[bc]", return "aaabcbc".
 s = "3[a2[c]]", return "accaccacc".
 s = "2[abc]3[cd]ef", return "abcabccdcdcdef".
 */
public class DecodeStringSolution {
    public func decodeString(_ s: String) -> String {
        let allowedDigits = Set(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"])
        var digits = [Int]()
        var symbols = [String]()
        
        var digitsCumulator = ""
        for c in s {
            let str = String(c)
            if allowedDigits.contains(str) {
                digitsCumulator += str
            } else if str == "]" {
                var temp = ""
                while true {
                    guard let lastSymbol = symbols.popLast()
                        else { fatalError("Something went wrong") }
                    
                    if lastSymbol == "[" {
                        break
                    } else {
                        temp = lastSymbol + temp
                    }
                }
                guard let lastDigit = digits.popLast()
                    else { fatalError("Something went wrong") }
                temp = String(repeating: temp, count: lastDigit)
                symbols.append(temp)
            } else {
                symbols.append(str)
                if !digitsCumulator.isEmpty {
                    digits.append(Int(digitsCumulator)!)
                    digitsCumulator = ""
                }
            }
        }
        
        return symbols.reduce("", { (result, symbol) -> String in
            return result + symbol
        })
    }
}
