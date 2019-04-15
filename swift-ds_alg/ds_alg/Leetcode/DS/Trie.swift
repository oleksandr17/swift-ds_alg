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
