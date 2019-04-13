import Foundation

extension Array where Element == Int {
    func quicksort() -> [Int] {
        var arr = self
        quicksort(arr: &arr, left: 0, right: arr.count-1)
        return arr
    }
    
    private func quicksort(arr: inout [Int], left: Int, right: Int) {
        guard left < right else { return }

        let pivotIndex = left + (right - left) / 2
        let pivot = arr[pivotIndex]
        
        var _left = left
        var _right = right
        while _left <= _right {
            while arr[_left] < pivot {
                _left += 1
            }
            while arr[_right] > pivot {
                _right -= 1
            }
            if _left <= _right {
                (arr[_left], arr[_right]) = (arr[_right], arr[_left])
                _left += 1
                _right -= 1
            }
        }
        
        quicksort(arr: &arr, left: left, right: _left-1)
        quicksort(arr: &arr, left: _left, right: right)
    }
}
