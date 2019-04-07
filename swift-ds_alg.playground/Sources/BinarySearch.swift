import Foundation

public class BinarySearch {
    
    /*
     Given a sorted (in ascending order) integer array nums of n elements and a target value, write a function to search target in nums. If target exists, then return its index, otherwise return -1.
     
     Example 1:
     Input: nums = [-1,0,3,5,9,12], target = 9
     Output: 4
     Explanation: 9 exists in nums and its index is 4
     
     Example 2:
     Input: nums = [-1,0,3,5,9,12], target = 2
     Output: -1
     Explanation: 2 does not exist in nums so return -1
     */
    public static func search(_ nums: [Int], _ target: Int) -> Int {
        return _search(nums, target, 0, nums.count-1)
    }
    
    private static func _search( _ nums: [Int], _ target: Int, _ start: Int, _ end: Int) -> Int {
        guard start <= end else { return -1 }
        
        let middle = start + (end - start) / 2
        let value = nums[middle]
        if value == target {
            return middle
        } else if value < target {
            return _search(nums, target, middle + 1, end)
        } else {
            return _search(nums, target, start, middle - 1)
        }
    }
    
    /*
     Search in Rotated Sorted Array

     Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.
     (i.e., [0,1,2,4,5,6,7] might become [4,5,6,7,0,1,2]).
     
     You are given a target value to search. If found in the array return its index, otherwise return -1.
     You may assume no duplicate exists in the array.
     
     Your algorithm's runtime complexity must be in the order of O(log n).
     
     Example 1:
     Input: nums = [4,5,6,7,0,1,2], target = 0
     Output: 4
     
     Example 2:
     Input: nums = [4,5,6,7,0,1,2], target = 3
     Output: -1
     
     Solution reference: https://www.geeksforgeeks.org/search-an-element-in-a-sorted-and-pivoted-array/
     */
    public static func searchInRotatedArray(_ nums: [Int], _ target: Int) -> Int {
        guard !nums.isEmpty else { return -1 }
        
        let pivot = _findPivotInRotatedArray(nums, 0, nums.count-1)
        
        if pivot == -1 { // there is no pivot - array is sorted
            return _search(nums, target, 0, nums.count-1)
        } else {
            if target == nums[pivot] {
                return pivot
            }
            if nums[0] <= target {
                return _search(nums, target, 0, pivot-1)
            }
            return _search(nums, target, pivot+1, nums.count-1)
        }
    }
    
    private static func _findPivotInRotatedArray( _ nums: [Int], _ start: Int, _ end: Int) -> Int {
        guard start <= end else { return -1 }
        
        let middle = start + (end - start) / 2
        let middleValue = nums[middle]
        
        if start < middle, middleValue < nums[middle-1] {
            return middle
        }
        if end > middle, middleValue > nums[middle+1] {
            return middle
        }
        if middleValue <= nums[start] { // pivot in left half
            return _findPivotInRotatedArray(nums, start, middle-1)
        }
        return _findPivotInRotatedArray(nums, middle+1, end)
    }
    
    /*
     A peak element is an element that is greater than its neighbors.
     Given an input array nums, where nums[i] ≠ nums[i+1], find a peak element and return its index.
     The array may contain multiple peaks, in that case return the index to any one of the peaks is fine.
     You may imagine that nums[-1] = nums[n] = -∞.
     
     Example 1:
     Input: nums = [1,2,3,1]
     Output: 2
     Explanation: 3 is a peak element and your function should return the index number 2.
     
     Example 2:
     Input: nums = [1,2,1,3,5,6,4]
     Output: 1 or 5
     Explanation: Your function can return either index number 1 where the peak element is 2,
     or index number 5 where the peak element is 6.
     Note:
     
     Your solution should be in logarithmic complexity.
     */
    public static func findPeakElement(_ nums: [Int]) -> Int {
        return _findPeakElement(nums, 0, nums.count-1)
    }
    
    private static  func _findPeakElement(_ nums: [Int], _ start: Int, _ end: Int) -> Int {
        guard start <= end else { return -1 }
        
        let middle = start + (end - start) / 2
        let middleValue = nums[middle]
        
        if _isPeakElement(nums, middle) {
            return middle
        } else if middleValue < nums[middle+1] {
            return _findPeakElement(nums, middle+1, end)
        } else {
            return _findPeakElement(nums, start, middle-1)
        }
    }
    
    private static  func _isPeakElement(_ nums: [Int], _ index: Int) -> Bool {
        let value = nums[index]
        let prev = index - 1
        let next = index + 1
        
        var prevIsSmaller = true
        if index > 0 {
            prevIsSmaller = (value > nums[prev])
        }
        
        var nextIsSmaller = true
        if index < nums.count-1 {
            nextIsSmaller = value > nums[next]
        }
        
        return prevIsSmaller && nextIsSmaller
    }
    
    /*
     Given an array of integers nums sorted in ascending order, find the starting and ending position of a given target value.
     Your algorithm's runtime complexity must be in the order of O(log n).
     If the target is not found in the array, return [-1, -1].
     
     Example 1:
     Input: nums = [5,7,7,8,8,10], target = 8
     Output: [3,4]
     
     Example 2:
     Input: nums = [5,7,7,8,8,10], target = 6
     Output: [-1,-1]
     */
    public static func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        return _searchRange(nums, target, 0, nums.count-1)
    }
    
    private static func _searchRange(_ nums: [Int], _ target: Int, _ start: Int, _ end: Int) -> [Int] {
        guard start <= end else { return [-1, -1] }
        
        let middle = start + (end - start) / 2
        let middleValue = nums[middle]
        
        if middleValue == target {
            var prev = middle - 1
            var next = middle + 1
            var (isPrevSame, isNextSame) = _isInRange(nums, middle, prev, next)
            
            while isPrevSame || isNextSame {
                if isPrevSame {
                    prev -= 1
                }
                if isNextSame {
                    next += 1
                }
                (isPrevSame, isNextSame) = _isInRange(nums, middle, prev, next)
            }
            
            prev = isPrevSame ? prev : prev+1
            next = isNextSame ? next : next-1
            
            return [prev, next]
        } else if target > middleValue {
            return _searchRange(nums, target, middle+1, end)
        } else {
            return _searchRange(nums, target, start, middle-1)
        }
    }
    
    private static func _isInRange(_ nums: [Int], _ index: Int, _ prev: Int, _ next: Int) -> (Bool, Bool) {
        let value = nums[index]
        
        var isPrevSame = false
        if prev >= 0 {
            isPrevSame = (nums[prev] == value)
        }
        
        var isNextSame = false
        if next <= nums.count - 1 {
            isNextSame = (nums[next] == value)
        }
        
        return (isPrevSame, isNextSame)
    }
    
    // Square root
    public static func sqrt(_ x: Int) -> Int {
        if x == 1 || x == 0 {
            return x
        }
        
        var left = 1
        var right = x
        while left < right {
            let mid = left + (right - left + 1) / 2
            if mid <= x / mid {
                left = mid
            } else {
                right = mid - 1
            }
        }
        return left
    }
    
    // Power
    public static func pow(_ x: Double, _ n: Int) -> Double {
        var result = _pow(x, UInt(abs(n)))
        if n <= 0 {
            result = 1 / result
        }
        return result
    }
    
    private static func _pow(_ x: Double, _ n: UInt) -> Double {
        switch n {
        case 0:
            return 1
        case 1:
            return x
        default:
            let newN = UInt(floor(Double(n) / 2.0))
            if n % 2 == 1 {
                return x * _pow(x * x, newN)
            } else {
                return _pow(x * x, newN)
            }
        }
    }
}
