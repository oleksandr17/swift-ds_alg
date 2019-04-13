import Foundation

class HRArrays {
    /*
     https://www.hackerrank.com/challenges/ctci-array-left-rotation/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=arrays
     */
    func rotLeft(a: [Int], d: Int) -> [Int] {
        guard !a.isEmpty, d > 0 else { return a }
        let shift = d % a.count
        guard shift > 0 else { return a }
        return Array(a[shift..<a.count]) + Array(a[0..<shift])
    }
    
    /*
     https://www.hackerrank.com/challenges/new-year-chaos/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=arrays
     */
    private func shiftMinimumBribesIndex(index: Int, shifts: Int) -> Int {
        guard shifts > 0 else { fatalError("Incorrect amount of shifts") }
        let result = index - shifts
        return (result >= 0) ? result : 0
    }
    
    func minimumBribes(q: [Int]) -> Void {
        var arr = q
        var count = 0
        for index in (0..<q.count).reversed() {
            let expectedValue = index + 1
            let actualValue = arr[index]
            guard expectedValue != actualValue else { continue }
            
            var found = false
            for shifts in 1...2 { // FIXME: check index==1, two shifts are unnecessary
                let newIndex = shiftMinimumBribesIndex(index: index, shifts: shifts)
                guard newIndex != index else { break }
                let newValue = arr[newIndex]
                if newValue == expectedValue {
                    arr.remove(at: newIndex)
                    arr.insert(expectedValue, at: index)
                    count += shifts
                    found = true
                    break
                }
            }
            
            if !found {
                print("Too chaotic")
                return
            }
        }
        print(count)
    }
    
    /*
     https://www.hackerrank.com/challenges/minimum-swaps-2/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=arrays
     */
    func minimumSwaps(arr: [Int]) -> Int {
        var tmp = arr
        var count = 0
        while true {
            var inOrder = true
            for i in 0..<arr.count {
                let value = tmp[i]
                let expectedValue = i + 1
                guard value != expectedValue else { continue }
                
                tmp[i] = tmp[value-1]
                tmp[value-1] = value
                count += 1
                inOrder = false
            }
            if inOrder {
                break
            }
        }
        return count
    }
}
