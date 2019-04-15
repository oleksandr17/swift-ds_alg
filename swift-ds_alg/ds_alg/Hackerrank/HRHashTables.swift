import Foundation

class HRHashTables {
    
    /*
     https://www.hackerrank.com/challenges/two-strings/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=dictionaries-hashmaps
     */
    func twoStrings(s1: String, s2: String) -> String {
        let set1 = s1.reduce(into: Set<Character>()) { (result, c) in
            result.insert(c)
        }
        let set2 = s2.reduce(into: Set<Character>()) { (result, c) in
            result.insert(c)
        }
        return set1.intersection(set2).isEmpty ? "NO" : "YES"
    }
    
    /*
     https://www.hackerrank.com/challenges/ctci-ransom-note/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=dictionaries-hashmaps
     */
    func checkMagazine(magazine: [String], note: [String]) -> Void {
        var magazineDict = magazine.reduce(into: [String: Int]()) { (result, item) in
            result[item] = (result[item] ?? 0) + 1
        }
        
        let notFoundNotes = note.filter { (item) -> Bool in
            if let count = magazineDict[item], count > 0 {
                magazineDict[item] = count - 1
                return false
            }
            return true
        }
        
        notFoundNotes.isEmpty ? print("Yes") : print("No")
    }
    
    /*
     https://www.hackerrank.com/challenges/sherlock-and-anagrams/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=dictionaries-hashmaps
     */
    func sherlockAndAnagrams(s: String) -> Int {
        var signatures = [[Int]: Int]() // signature: counter
        
        for start in 0..<s.count {
            for end in start..<s.count {
                let substring = s[String.Index(encodedOffset: start)...String.Index(encodedOffset: end)]
                var sig = Array<Int>(repeating: 0, count: 26)
                for c in substring {
                    sig[c.asciiValue - Character("a").asciiValue] += 1
                }
                signatures[sig, default: 0] += 1
            }
        }
        
        var count = 0
        for (_, value) in signatures where value > 1 {
            count += value * (value - 1) / 2
        }
        return count
    }
    
    /*
     https://www.hackerrank.com/challenges/count-triplets-1/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=dictionaries-hashmaps
     */
    func countTriplets(arr: [Int], r: Int) -> Int {
        if true { // TODO: doesn't work
            var options = [[Int]]()
            var counts  = [Int: Int]()
            var visitedValues = Set<Int>()
            for value in arr {
                counts[value, default: 0] += 1
                guard !visitedValues.contains(value) else { continue }
                visitedValues.insert(value)
                guard value % r == 0 else { continue }
                options.append([value / r, value, value * r])
            }
            
            if visitedValues.count == 1 { // all values are similar
                return arr.count * (arr.count - 1) * (arr.count - 2) / 6
            }
            
            var count = 0
            for option in options {
                guard let count0 = counts[option[0]], let count1 = counts[option[1]], let count2 = counts[option[2]] else { continue }
                count += (count0 * count1 * count2)
            }
            return count
        } else {
            // Brute force solution, too slow
            var count = 0
            for i in 0..<(arr.count-2) {
                let iValue = arr[i]
                if iValue != 1, iValue % r != 0 { continue }
                for j in (i+1)..<(arr.count-1) {
                    let jValue = arr[j]
                    guard jValue % r == 0, jValue / r == iValue else { continue }
                    for k in (j+1)..<arr.count {
                        let kValue = arr[k]
                        guard kValue % r == 0, kValue / r == jValue else { continue }
                        count += 1
                    }
                }
            }
            return count
        }
    }
}
