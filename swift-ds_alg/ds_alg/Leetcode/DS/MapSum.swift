import Foundation

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
