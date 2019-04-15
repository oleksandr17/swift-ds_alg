import Foundation

class HRGreedyAlgorithms {
    /*
     https://www.hackerrank.com/challenges/minimum-absolute-difference-in-an-array/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=greedy-algorithms
     */
    func minimumAbsoluteDifference(arr: [Int]) -> Int {
        let sortedArr = arr.sorted { $0 < $1 }
        var diff = Int.max
        for i in 0..<sortedArr.count-1 {
            let newDiff = abs(sortedArr[i] - sortedArr[i+1])
            diff = min(diff, newDiff)
        }
        return diff
    }
    
    /*
     https://www.hackerrank.com/challenges/angry-children/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=greedy-algorithms
     */
    func maxMin(k: Int, arr: [Int]) -> Int {
        let sortedArr = arr.sorted { $0 < $1 }
        
        guard k < sortedArr.count else {
            return sortedArr.last! - sortedArr.first!
        }
        
        var diff = Int.max
        for i in 0..<sortedArr.count-k+1 {
            diff = min(diff, sortedArr[i+k-1] - sortedArr[i])
        }
        return diff
    }
}
