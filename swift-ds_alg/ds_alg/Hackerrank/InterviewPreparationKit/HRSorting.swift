import Foundation

class HRSorting {    
    /*
     https://www.hackerrank.com/challenges/ctci-bubble-sort/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=sorting
     */
    func countSwaps(a: [Int]) -> Void {
        var count = 0
        var arr = a
        for _ in 0..<(a.count - 1) {
            for j in 0..<(a.count - 1) {
                if arr[j] > arr[j+1] {
                    (arr[j], arr[j+1]) = (arr[j+1], arr[j])
                    count += 1
                }
            }
        }
        print("Array is sorted in \(count) swaps.")
        print("First Element: \(arr.first!)")
        print("Last Element: \(arr.last!)")
    }
    
    /*
     https://www.hackerrank.com/challenges/mark-and-toys/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=sorting&h_r=next-challenge&h_v=zen
     */
    func maximumToys(prices: [Int], k: Int) -> Int {
        let newPrices = prices.sorted { $0 < $1 }
        var count = 0
        var remainer = k
        for price in newPrices {
            if price <= remainer {
                remainer -= price
                count += 1
            }
        }
        return count
    }
}
