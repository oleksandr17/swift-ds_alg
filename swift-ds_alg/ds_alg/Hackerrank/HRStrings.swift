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
}
