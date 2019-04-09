import Foundation

/*
 https://www.hackerrank.com/challenges/counting-valleys/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=warmup
 */
private enum StepDirection: String {
    case up = "U"
    case down = "D"
}

func countingValleys(n: Int, s: String) -> Int {
    var result = 0
    var attitude = 0
    for c in s {
        let substr = String(c)
        guard let direction = StepDirection(rawValue: substr) else {
            fatalError("Unknown step direction: \(substr)")
        }
        
        switch direction {
        case .up:
            attitude += 1
        case .down:
            attitude -= 1
        }
        
        if attitude == 0, case .up = direction {
            result += 1
        }
    }
    return result
}

/*
 https://www.hackerrank.com/challenges/repeated-string/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=warmup
 */
func repeatedString(s: String, n: Int) -> Int {
    let count: (_ str: String) -> Int = { str in
        return str.reduce(0) { (result, c) -> Int in
            return (c == "a") ? (result + 1) : result
        }
    }
    // Create new string of `n` lenght
    if s.count == n {
        return count(s)
    } else if s.count > n { // truncate
        return count(String(s.prefix(n)))
    } else { // extend
        let newLength = n / s.count
        return count(s) * newLength + count(String(s.prefix(n % newLength)))
    }
}
