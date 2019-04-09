import Foundation

class Trie {
 
    private var children = [Character: Trie]()
    private var holdsCompleteWord = false
    
    /** Initialize your data structure here. */
    init() {}
    
    private func subTrie(_ word: String) -> Trie? {
        // End of word is successfully reached
        guard let firstCharacter = word.first else { return self }
        
        // Get child
        let child: Trie
        if let existingChild = children[firstCharacter] {
            child = existingChild
        } else {
            return nil
        }
        
        // Ask child
        let remainingWord = String(word.suffix(from: String.Index(encodedOffset: 1)))
        return child.subTrie(remainingWord)
    }
    
    /** Inserts a word into the trie. */
    func insert(_ word: String) {
        guard let firstCharacter = word.first else {
            holdsCompleteWord = true
            return
        }

        // Get or create child trie
        let child: Trie
        if let existingChild = children[firstCharacter] {
            child = existingChild
        } else {
            child = Trie()
            children[firstCharacter] = child
        }
        
        // Insert into child
        let remainingWord = String(word.suffix(from: String.Index(encodedOffset: 1)))
        child.insert(remainingWord)
    }
    
    /** Returns if the word is in the trie. */
    func search(_ word: String) -> Bool {
        guard let subTrie = self.subTrie(word) else { return false }
        return subTrie.holdsCompleteWord
    }
    
    /** Returns if there is any word in the trie that starts with the given prefix. */
    func startsWith(_ prefix: String) -> Bool {
        guard let _ = self.subTrie(prefix) else { return false }
        return true
    }
}

class MapSum {
    
    private var children = [Character: MapSum]()
    private var val = 0
    private var holdsCompleteKey = false
    
    /** Initialize your data structure here. */
    init() {}
    
    private func subMapSum(_ key: String) -> MapSum? {
        // End of word is successfully reached
        guard let firstCharacter = key.first else { return self }
        
        // Get child
        let child: MapSum
        if let existingChild = children[firstCharacter] {
            child = existingChild
        } else {
            return nil
        }
        
        // Ask child
        let remainingKey = String(key.suffix(from: String.Index(encodedOffset: 1)))
        return child.subMapSum(remainingKey)
    }
    
    func insert(_ key: String, _ val: Int) {
        var resetChildren = false
        if let subMapSum = self.subMapSum(key), subMapSum.holdsCompleteKey {
            resetChildren = true
        }
        
        var child = self
        for c in key {
            if let existingChild = child.children[c] {
                child = existingChild
            } else {
                let newChild = MapSum()
                child.children[c] = newChild
                child = newChild
            }
            
            if resetChildren {
                child.val = val
            } else {
                child.val += val
            }
        }
        child.holdsCompleteKey = true
    }
    
    func sum(_ prefix: String) -> Int {
        if let subMapSum = self.subMapSum(prefix) {
            return subMapSum.val
        }
        return 0
    }
}

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
