import Foundation

class LCArrayAndStrings {
    
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
}
