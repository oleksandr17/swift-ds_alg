import Foundation

public class PascalsTriangle {
    
    // Generate
    public static func generate(_ numRows: Int) -> [[Int]] {
        var result = [[Int]]()
        var parentRowItems: [Int]?
        for row in 0..<numRows {
            let items = generate(rowIndex: row, parentRowItems: parentRowItems)
            result.append(items)
            parentRowItems = items
        }
        return result
    }
    
    private static func generate(rowIndex: Int, parentRowItems: [Int]?) -> [Int] {
        switch rowIndex {
        case 0:
            return [1]
        case 1:
            return [1,1]
        default:
            guard let parentItems = parentRowItems else { fatalError() }
            var result = [Int]()
            result.append(1)
            for row in 1..<rowIndex {
                result.append(parentItems[row-1] + parentItems[row])
            }
            result.append(1)
            return result
        }
    }
    
    // Get row
    public static func getRowElements(_ row: Int) -> [Int] {
        var result = [Int]()
        var cache = [String: Int]()
        for column in 0...row {
            result.append(getValue(row, column, &cache))
        }
        return result
    }
    
    private static func getValue(_ row: Int, _ column: Int, _ cache: inout [String: Int]) -> Int {
        if column <= 0 {
            return 1
        }
        if row == column {
            return 1
        }
        
        // Parent left
        let a: Int
        let aKey = "\(row-1)-\(column-1)"
        if let value = cache[aKey] {
            a = value
        } else {
            a = getValue(row-1, column-1, &cache)
            cache[aKey] = a
        }
        
        // Parent right
        let b: Int
        let bKey = "\(row-1)-\(column)"
        if let value = cache[bKey] {
            b = value
        } else {
            b = getValue(row-1, column, &cache)
            cache[bKey] = b
        }
        
        return a + b
    }
}
