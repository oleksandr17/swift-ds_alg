import Foundation

extension Array where Element == Int {
    init(number: Int) {
        var value = number
        var result = [Int]()
        while value > 0 {
            let digit = value % 10
            result.insert(digit, at: 0)
            value = value / 10
        }
        self = result
    }
    
    func toNumber() -> Int {
        return reduce((0, count-1), { (result, val) -> (Int, Int) in
            let value = result.0 + val * Int(pow(Float(10), Float(result.1)))
            return (value, result.1 - 1)
        }).0
    }
    
    func sum(other: [Int]) -> [Int] {
        var result = [Int]()
        var remainder = 0
        for i in 0..<Swift.max(count, other.count) {
            var value = remainder
            let index = count - i - 1
            if index >= 0 {
                value += self[index]
            }
            let indexOther = other.count - i - 1
            if indexOther >= 0 {
                value += other[indexOther]
            }
            
            let digit = value % 10
            result.insert(digit, at: 0)
            
            remainder = value / 10
        }
        
        if remainder > 0 {
            result.insert(remainder, at: 0)
        }
        
        return result
    }
}
