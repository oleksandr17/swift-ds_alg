import Foundation

/*
 https://leetcode.com/explore/learn/card/hash-table/182/practical-applications/1139/
 */
class HashSet {
    func add(_ key: Int) {
        guard !contains(key) else { return }
        let hashValue = hash(key: key)
        array[hashValue].append(key)
    }
    
    func remove(_ key: Int) {
        guard contains(key) else { return }
        let hashValue = hash(key: key)
        array[hashValue].removeAll { (val) -> Bool in
            val == key
        }
    }
    
    /** Returns true if this set contains the specified element */
    func contains(_ key: Int) -> Bool {
        let hashValue = hash(key: key)
        let first = array[hashValue].first { (val) -> Bool in
            val == key
        }
        return first != nil
    }
    
    // MARK: Private
    
    private static let kBuckets = 1000
    
    private var array = [[Int]](repeating: [Int](), count: HashSet.kBuckets)
    
    private func hash(key: Int) -> Int {
        return key % HashSet.kBuckets
    }
}
