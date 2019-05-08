import Foundation

class LCStrings {
    
    // MARK: - Easy
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/127/strings/880/
     */
    func reverse(_ x: Int) -> Int {
        guard x != 0 else { return x }
        
        let allowedRange = Int(Int32.min)...Int(Int32.max)
        guard allowedRange.contains(x) else { return 0 }
        
        // Turn integer value to array
        var digits = [Int]()
        var remainder = abs(x)
        while remainder > 0 {
            let digit = remainder % 10
            digits.append(digit)
            remainder = remainder / 10
        }
        
        // Remove leading zero
        if let first = digits.first, first == 0 {
            digits.remove(at: 0)
        }
        
        // Compose result
        var result = 0
        var multiplier = Int(pow(Float(10), Float(digits.count - 1)))
        for digit in digits {
            result += digit * multiplier
            multiplier = multiplier / 10
        }
        
        guard allowedRange.contains(result) else { return 0 }
        
        return x < 0 ? -result : result
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/127/strings/881/
     */
    func firstUniqChar(_ s: String) -> Int {
        let counts = s.reduce(into: [Character: Int]()) { (result, c) in
            result[c, default: 0] += 1
        }
        
        for i in 0..<s.count {
            let index = String.Index(encodedOffset: i)
            let character = s[index]
            guard let count = counts[character] else { fatalError() }
            if count == 1 {
                return i
            }
        }
        return -1
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/127/strings/882/
     */
    func isAnagram(_ s: String, _ t: String) -> Bool {
        return anagramSignature(s) == anagramSignature(t)
    }
    
    private func anagramSignature(_ s: String) -> [Character: Int] {
        return s.reduce(into: [Character: Int]()) { (result, c) in
            result[c, default: 0] += 1
        }
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/127/strings/883/
     */
    func isPalindrome(_ s: String) -> Bool {
        guard !s.isEmpty else { return true }
        
        let str = s.filter { (c) -> Bool in
            return "abcdefghijklmnopqrstuvwxyz0123456789".contains(String(c).lowercased())
            }.lowercased()
        
        var start = 0
        var end = str.count - 1
        while start <= end {
            guard str[String.Index(encodedOffset: start)] == str[String.Index(encodedOffset: end)] else { return false }
            start += 1
            end -= 1
        }
        return true
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/127/strings/884/
     */
    func myAtoi(_ str: String) -> Int {
        // Skip leading spaces
        var index = 0
        for c in str {
            guard c == " " else { break }
            index += 1
        }
        
        guard index < str.count else { return 0 }
        
        // Define sign
        let isPositive: Bool
        let sign = str[String.Index(encodedOffset: index)]
        switch sign {
        case "-":
            isPositive = false
            index += 1
        case "+":
            isPositive = true
            index += 1
        default:
            isPositive = true
        }
        
        // Convert string to digits
        var digits = [Int]()
        while index < str.count {
            guard let digit = charToDigit(str: str[String.Index(encodedOffset: index)]) else { break } // non digit character occured
            digits.append(digit)
            index += 1
        }
        
        // Validate amount of detected digits
        guard !digits.isEmpty else { return 0 }
        
        // Convert digits to number
        var number = 0
        for digit in digits {
            if number > (Int32.max - Int32(digit)) / 10  {
                return isPositive ? Int(Int32.max) : Int(Int32.min)
            }
            number = number * 10 + digit
        }
        
        return isPositive ? number : -number
    }
    
    private func charToDigit(str: Character) -> Int? {
        switch str {
        case "0": return 0
        case "1": return 1
        case "2": return 2
        case "3": return 3
        case "4": return 4
        case "5": return 5
        case "6": return 6
        case "7": return 7
        case "8": return 8
        case "9": return 9
        default: return nil
        }
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/127/strings/885/
     */
    func strStr(_ haystack: String, _ needle: String) -> Int {
        /*
         Time complexity: O((n-m) * m)
         Space complexity: O(1)
         
         KMP is more efficient approach (https://en.wikipedia.org/wiki/Knuth–Morris–Pratt_algorithm), it allows to achive O(n) time complexity.
         */
        guard !needle.isEmpty else { return 0 }
        guard haystack.count >= needle.count else { return -1 }
        
        let shiftsCount = haystack.count - needle.count + 1
        for shift in 0..<shiftsCount {
            var isSubstring = true
            for offset in 0..<needle.count {
                let haystackCharacter = haystack[String.Index(encodedOffset: shift + offset)]
                let needleCharacter = needle[String.Index(encodedOffset: offset)]
                guard haystackCharacter == needleCharacter else {
                    isSubstring = false
                    break
                }
            }
            if isSubstring {
                return shift
            }
        }
        
        return -1
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/127/strings/886/
     */
    func countAndSay(_ n: Int) -> String {
        guard n > 0 else { return "" }
        
        var result = "1"
        for _ in 1..<n {
            let tmpResult = result
            result = ""
            
            var currentDigitCounter = 1
            var currentDigit = tmpResult[String.Index(encodedOffset: 0)]
            for i in 1..<tmpResult.count {
                let digit = tmpResult[String.Index(encodedOffset: i)]
                if currentDigit == digit {
                    currentDigitCounter += 1
                } else {
                    result += "\(currentDigitCounter)\(currentDigit)"
                    currentDigit = digit
                    currentDigitCounter = 1
                }
            }
            result += "\(currentDigitCounter)\(currentDigit)"
        }
        
        return result
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/127/strings/887/
     */
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard strs.count > 0 else { return "" }
        
        let length = strs.reduce(strs[0].count) { (result, str) -> Int in
            return min(result, str.count)
        }
        
        var prefix = ""
        for i in 0..<length {
            let charIndex = String.Index(encodedOffset: i)
            let firstStrChar = strs[0][charIndex]
            for j in 1..<strs.count {
                guard strs[j][charIndex] == firstStrChar else { return prefix }
            }
            prefix += String(firstStrChar)
        }
        
        return prefix
    }
}
