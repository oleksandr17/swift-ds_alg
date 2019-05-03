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
}
