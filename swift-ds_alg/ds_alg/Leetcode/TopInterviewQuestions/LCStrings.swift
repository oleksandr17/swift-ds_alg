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
}
