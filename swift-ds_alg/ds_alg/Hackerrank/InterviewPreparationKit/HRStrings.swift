import Foundation

class HRStrings {
    /*
     https://www.hackerrank.com/challenges/ctci-making-anagrams/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=strings
     */
    func makeAnagram(a: String, b: String) -> Int {
        var aDict = a.reduce(into: [Character: Int]()) { (result, c) in
            result[c, default: 0] += 1
        }
        var bDict = b.reduce(into: [Character: Int]()) { (result, c) in
            result[c, default: 0] += 1
        }
        let commonCharacters = Set<Character>(aDict.keys).intersection(Set<Character>(bDict.keys))
        
        var count = 0
        for cc in commonCharacters {
            guard let a = aDict[cc], let b = bDict[cc] else { fatalError() }
            count += abs(a - b)
            aDict.removeValue(forKey: cc)
            bDict.removeValue(forKey: cc)
        }
        
        for (_, value) in aDict {
            count += value
        }
        for (_, value) in bDict {
            count += value
        }
        
        return count
    }
    
    /*
     https://www.hackerrank.com/challenges/sherlock-and-valid-string/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=strings
     */
    func isValid(s: String) -> String {
        let occurences = s.reduce(into: [Character: Int]()) { (result, c) in
            result[c, default: 0] += 1
        }
        let counts = occurences.reduce(into: [Int: Int]()) { (result, keyValue) in
            result[keyValue.value, default: 0] += 1
        }
        
        switch counts.count {
        case 0:
            return "YES"
        case 1:
            return "YES"
        case 2: // FIXME: refactor
            var key0: Int!
            var key1: Int!
            var value0: Int!
            var value1: Int!
            
            var index = 0
            for (key, value) in counts {
                switch index {
                case 0:
                    key0 = key
                    value0 = value
                case 1:
                    key1 = key
                    value1 = value
                default:
                    fatalError()
                }
                index += 1
            }
            
            if value0 == 1 {
                if (key0 - 1) == key1 {
                    return "YES"
                } else if (key0 - 1) == 0 {
                    return "YES"
                }
                return "NO"
            } else if value1 == 1 {
                if (key1 - 1) == key0 {
                    return "YES"
                } else if (key1 - 1) == 0 {
                    return "YES"
                }
                return "NO"
            } else {
                return "NO"
            }
        default:
            return "NO"
        }
    }
}
