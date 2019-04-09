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
class MinStack {
    private var values = [Int]()
    private var auxiliaryValues = [Int]()
    
    func push(_ x: Int) {
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
    
    func pop() {
        _ = values.popLast()
        _ = auxiliaryValues.popLast()
    }
    
    func top() -> Int {
        guard let last = values.last else { return -1 }
        return last
    }
    
    func getMin() -> Int {
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
class ValidParenthesesSolution {
    static private let couples = [("(",")"), ("{","}"), ("[","]")]
    
    func isValid(_ s: String) -> Bool {
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
 Given an encoded string, return it's decoded string.
 
 The encoding rule is: k[encoded_string], where the encoded_string inside the square brackets is being repeated exactly k times. Note that k is guaranteed to be a positive integer.
 
 You may assume that the input string is always valid; No extra white spaces, square brackets are well-formed, etc.
 
 Furthermore, you may assume that the original data does not contain any digits and that digits are only for those repeat numbers, k. For example, there won't be input like 3a or 2[4].
 
 Examples:
 s = "3[a]2[bc]", return "aaabcbc".
 s = "3[a2[c]]", return "accaccacc".
 s = "2[abc]3[cd]ef", return "abcabccdcdcdef".
 */
class DecodeStringSolution {
    func decodeString(_ s: String) -> String {
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
