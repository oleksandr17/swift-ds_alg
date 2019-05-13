import Foundation

class LCTrees {
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/94/trees/631/
     */
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        guard !nums.isEmpty else { return nil }
        let root = bst(nums, start: 0, end: nums.count-1)
        return root
    }
    
    private func bst(_ nums: [Int], start: Int, end: Int) -> TreeNode? {
        guard start <= end else {
            return nil
        }
        
        let rootIndex = start + (end - start)/2
        let rootNode = TreeNode(nums[rootIndex])
        rootNode.left = bst(nums, start: start, end: rootIndex-1)
        rootNode.right = bst(nums, start: rootIndex+1, end: end)
        
        return rootNode
    }
}
