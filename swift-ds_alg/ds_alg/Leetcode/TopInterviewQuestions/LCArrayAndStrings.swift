import Foundation

class LCArrayAndStrings {
    
    // MARK: - Easy
    
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
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/769/
     */
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        let length = 9
        guard board.count == length, board[0].count == length else { return false }
        
        // Validate rows
        for row in 0..<length {
            var counts = [Character: Int]()
            for column in 0..<length {
                counts[board[row][column], default: 0] += 1
            }
            guard isSudokuCountsValid(counts: counts) else { return false }
        }
        
        // Validate columns
        for column in 0..<length {
            var counts = [Character: Int]()
            for row in 0..<length {
                counts[board[row][column], default: 0] += 1
            }
            guard isSudokuCountsValid(counts: counts) else { return false }
        }
        
        guard isSudokuSectionValid(board: board, rows: 0...2, columns: 0...2) else { return false }
        guard isSudokuSectionValid(board: board, rows: 0...2, columns: 3...5) else { return false }
        guard isSudokuSectionValid(board: board, rows: 0...2, columns: 6...8) else { return false }
        
        guard isSudokuSectionValid(board: board, rows: 3...5, columns: 0...2) else { return false }
        guard isSudokuSectionValid(board: board, rows: 3...5, columns: 3...5) else { return false }
        guard isSudokuSectionValid(board: board, rows: 3...5, columns: 6...8) else { return false }
        
        guard isSudokuSectionValid(board: board, rows: 6...8, columns: 0...2) else { return false }
        guard isSudokuSectionValid(board: board, rows: 6...8, columns: 3...5) else { return false }
        guard isSudokuSectionValid(board: board, rows: 6...8, columns: 6...8) else { return false }
        
        return true
    }
    
    private func isSudokuSectionValid(board: [[Character]], rows: ClosedRange<Int>, columns: ClosedRange<Int>) -> Bool {
        var counts = [Character: Int]()
        for row in rows {
            for column in columns {
                counts[board[row][column], default: 0] += 1
            }
        }
        return isSudokuCountsValid(counts: counts)
    }
    
    private func isSudokuCountsValid(counts: [Character: Int]) -> Bool {
        for (value, count) in counts {
            guard value != "." else { continue }
            guard count == 1 else { return false }
        }
        return true
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/770/
     */
    func rotate(_ matrix: inout [[Int]]) {
        let count = matrix.count
        guard count > 1 else { return } // minimum matrix must be 2 x 2
        
        var depth = 0
        while true {
            guard depth <= Int(floor(Float(count - 1) / Float(2))) else { break }
            
            let swapsCount = count - 1 - 2*depth
            for swapIndex in 0..<swapsCount {
                let first = matrix[depth][depth + swapIndex]
                let second = matrix[depth + swapIndex][depth + swapsCount]
                let third = matrix[depth + swapsCount][depth + swapsCount - swapIndex]
                let fourth = matrix[depth + swapsCount - swapIndex][depth]
                
                matrix[depth][depth + swapIndex] = fourth
                matrix[depth + swapIndex][depth + swapsCount] = first
                matrix[depth + swapsCount][depth + swapsCount - swapIndex] = second
                matrix[depth + swapsCount - swapIndex][depth] = third
            }
            depth += 1
        }
    }
    
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
    
    // MARK: - Medium
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-medium/103/array-and-strings/778/
     */
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var values = [String: Array<String>]()
        for str in strs {
            values[String(str.sorted()), default: Array<String>()].append(str)
        }
        
        var result = [[String]]()
        for (_, value) in values {
            result.append(value)
        }
        return result
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-medium/103/array-and-strings/776/
     Explanation: https://fizzbuzzed.com/top-interview-questions-1/
     */
    func threeSum(_ nums: [Int]) -> [[Int]] {
        if true {
            // Time complexity: O(N^2)
            guard nums.count >= 3 else { return [[Int]]() }
            let sorted = nums.sorted()
            var result = [[Int]]()
            for i in 0..<sorted.count {
                // Don't allow `i` to point to same element
                if i > 0, sorted[i] == sorted[i-1] {
                    continue
                }
                var j = i + 1
                var k = sorted.count-1
                while j < k {
                    // Don't allow `j` to point to same element
                    if j > (i + 1), sorted[j] == sorted[j-1] {
                        j += 1
                        continue
                    }
                    let sum = sorted[i] + sorted[j] + sorted[k]
                    if sum == 0 {
                        result.append([sorted[i], sorted[j], sorted[k]])
                        j += 1
                    } else if sum < 0 {
                        j += 1
                    } else {
                        k -= 1
                    }
                }
            }
            return result
        } else {
            // Time complexity: O(N^3)
            guard nums.count >= 3 else { return [[Int]]() }
            var result = [[Int: Int]: [Int]]() // key -> occurences, value -> array
            for i in 0..<nums.count-2 {
                for j in i+1..<nums.count-1 {
                    for k in j+1..<nums.count {
                        if nums[i] + nums[j] + nums[k] == 0 {
                            var occurences = [Int: Int]()
                            occurences[nums[i], default: 0] += 1
                            occurences[nums[j], default: 0] += 1
                            occurences[nums[k], default: 0] += 1
                            result[occurences] = [nums[i], nums[j], nums[k]]
                        }
                    }
                }
            }
            return Array(result.values)
        }
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-medium/103/array-and-strings/777/
     */
    func setZeroes(_ matrix: inout [[Int]]) {
        /*
         Time Complexity: O(M*N)
         Space Complexity: O(1)
         */
        
        // Input validation
        let rows = matrix.count
        guard rows > 0 else { return }
        let columns = matrix[0].count
        
        // Use the first column and the first row to track if a row/column should be set to 0.
        var resetFirstRow = false
        var resetFirstColumn = false
        
        for row in 0..<rows {
            for column in 0..<columns {
                guard matrix[row][column] == 0 else { continue }
                matrix[row][0] = 0
                matrix[0][column] = 0
                if row == 0 {
                    resetFirstRow = true
                }
                if column == 0 {
                    resetFirstColumn = true
                }
            }
        }
        
        // Set values to 0
        for row in 1..<rows {
            guard matrix[row][0] == 0 else { continue }
            for column in 0..<columns {
                matrix[row][column] = 0
            }
        }
        
        for column in 1..<columns {
            guard matrix[0][column] == 0 else { continue }
            for row in 0..<rows {
                matrix[row][column] = 0
            }
        }
        
        if resetFirstColumn {
            for row in 0..<rows {
                matrix[row][0] = 0
            }
        }
        
        if resetFirstRow {
            for column in 0..<columns {
                matrix[0][column] = 0
            }
        }
    }
}
