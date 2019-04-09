import Foundation

class KthGrammarSolution {
    
    /*
     Examples:
     Input: N = 1, K = 1
     Output: 0
     
     Input: N = 2, K = 1
     Output: 0
     
     Input: N = 2, K = 2
     Output: 1
     
     Input: N = 4, K = 5
     Output: 1
     
     Explanation:
     row 1: 0
     row 2: 01
     row 3: 0110
     row 4: 01101001
     */
    static func kthGrammarSlow(_ N: Int, _ K: Int) -> Int {
        return sequence(N)[K-1]
    }
    
    private static func sequence(_ N: Int) -> [Int] {
        switch N {
        case 0:
            return []
        case 1:
            return [0]
        default:
            return sequence(N-1).flatMap({ (value) -> [Int] in
                switch value {
                case 0:
                    return [0,1]
                default:
                    return [1,0]
                }
            })
        }
    }
    
    //
    static func kthGrammarFast(_ N: Int, _ K: Int) -> Int {
        let indices = getIndices(N, K)
        var previousSymbol = 0
        for index in indices {
            if index == 0 {
                continue
            }
            let symbols = (previousSymbol == 0) ? [0,1] : [1,0]
            previousSymbol = symbols[index % 2]
        }
        return previousSymbol
    }
    
    private static func getIndices(_ N: Int, _ K: Int) -> [Int] {
        var indices = [Int]()
        var value = K
        for _ in 1...N {
            indices.append((value % 2 == 0) ? 1 : 0)
            value = Int(ceil(Double(value) / Double(2)))
        }
        return indices.reduce(into: [Int](), { (result, value) in
            result.insert(value, at: 0)
        })
    }
}
