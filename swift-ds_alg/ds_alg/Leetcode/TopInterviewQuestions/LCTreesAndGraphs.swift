import Foundation

class LCTreesAndGraphs {
    
    // MARK: - Easy
    
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
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-medium/108/trees-and-graphs/787/
     */
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        guard let r = root else { return result }
        zigzagLevelOrder(nodes: [r], leftToRightDirection: true, result: &result)
        return result
    }
    
    private func zigzagLevelOrder(nodes: [TreeNode], leftToRightDirection: Bool, result: inout [[Int]]) {
        guard !nodes.isEmpty else { return  }
        
        var row = [Int]()
        var nextLevelNodes = [TreeNode]()
        for i in (0..<nodes.count).reversed() {
            let node = nodes[i]
            row.append(node.val)
            if leftToRightDirection {
                if let left = node.left {
                    nextLevelNodes.append(left)
                }
                if let right = node.right {
                    nextLevelNodes.append(right)
                }
            } else {
                if let right = node.right {
                    nextLevelNodes.append(right)
                }
                if let left = node.left {
                    nextLevelNodes.append(left)
                }
            }
        }
        result.append(row)
        zigzagLevelOrder(nodes: nextLevelNodes, leftToRightDirection: !leftToRightDirection, result: &result)
    }
}
