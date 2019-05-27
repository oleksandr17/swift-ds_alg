import Foundation

class TriesSolution {
    func replaceWords(_ dict: [String], _ sentence: String) -> String {
        let trie = Trie()
        for item in dict {
            trie.insert(item)
        }
        
        var result = [String]()
        for word in sentence.split(separator: " ") {
            var foundRoot = false
            for i in 1 ..< word.count {
                let subword = word.substring(to: String.Index(encodedOffset: i))
                if trie.search(subword) {
                    foundRoot = true
                    result.append(subword)
                    break
                }
            }
            if !foundRoot {
                result.append(String(word))
            }
        }
        
        return result.joined(separator: " ")
    }
}
