import Foundation

class HRSearch {
    /*
     https://www.hackerrank.com/challenges/ctci-ice-cream-parlor/problem?h_l=interview&playlist_slugs%5B%5D=interview-preparation-kit&playlist_slugs%5B%5D=search
     */
    func whatFlavors(cost: [Int], money: Int) -> Void {
        if true { // Too slow
            let newCost = cost.sorted { $0 < $1 }
            
            var left = 0
            var right = newCost.count - 1
            while left < right {
                let value = newCost[left] + newCost[right]
                if value == money {
                    break
                } else if value < money {
                    left += 1
                } else {
                    right -= 1
                }
            }
            
            guard newCost[left] + newCost[right] == money else { return }
            
            var newLeft = -1
            for i in 0..<cost.count {
                if cost[i] == newCost[left] {
                    newLeft = i
                    break
                }
            }
            
            var newRight = -1
            for i in 0..<cost.count {
                if cost[i] == newCost[right] {
                    newRight = i
                    break
                }
            }
            
            if newRight == newLeft {
                newRight = newRight + 1
            }
            
            (newLeft, newRight) = (min(newLeft, newRight), max(newLeft, newRight))
            
            print("\(newLeft+1) \(newRight+1)")
        } else { // TODO: doesn't work
            guard !cost.isEmpty else { return }
            let newCost = cost.sorted { $0 < $1 }
            
            let rightIndex = whatFlavorsBinarySearch(cost: newCost, money: money, start: 0, end: newCost.count-1)
            guard rightIndex >= 0 else { return }
            let right = newCost[rightIndex]
            
            let leftIndex = binarySearch(arr: newCost, target: money-right, start: 0, end: rightIndex-1)
            guard leftIndex >= 0 else { return }
            let left = newCost[leftIndex]
            
            var l = -1
            var r = -1
            for i in 0..<cost.count-1 {
                if cost[i] == left { l = i }
                if cost[i] == right { r = i }
            }
            
            if r == l {
                r -= 1
            }
            
            (l, r) = (min(l,r), max(l,r))
            
            print("\(l+1) \(r+1)")
        }
    }
    
    private func whatFlavorsBinarySearch(cost: [Int], money: Int, start: Int, end: Int) -> Int {
        guard start <= end else { return -1 }
        
        let index = start + (end - start) / 2
        if cost[index] >= money {
            return whatFlavorsBinarySearch(cost: cost, money: money, start: start, end: index-1)
        }
        else if cost[index] < money, index+1 < cost.count {
            if cost[index+1] >= money {
                return index
            } else {
                return whatFlavorsBinarySearch(cost: cost, money: money, start: index+1, end: end)
            }
        }
        return -1
    }
    
    private func binarySearch(arr: [Int], target: Int, start: Int, end: Int) -> Int {
        guard start <= end else { return -1 }
        
        let index = start + (end - start) / 2
        let value = arr[index]
        
        if value == target {
            return index
        } else if value < target {
            return binarySearch(arr:arr, target:target, start: index+1, end: end)
        } else {
            return binarySearch(arr:arr, target:target, start: start, end: index-1)
        }
    }
}
