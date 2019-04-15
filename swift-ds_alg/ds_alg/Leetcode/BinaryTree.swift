import Foundation

class BinaryTreeSolution {
    // Traversal
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let r = root else { return [] }
        let elements = [r.val]
        let leftElements = preorderTraversal(r.left)
        let rightElements = preorderTraversal(r.right)
        return elements + leftElements + rightElements
    }
    
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let r = root else { return [] }
        let leftElements = inorderTraversal(r.left)
        let elements = [r.val]
        let rightElements = inorderTraversal(r.right)
        return leftElements + elements + rightElements
    }
    
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        guard let r = root else { return [] }
        let leftElements = postorderTraversal(r.left)
        let rightElements = postorderTraversal(r.right)
        let elements = [r.val]
        return leftElements + rightElements + elements
    }
    
    // Max depth
    func maxDepth(_ root: TreeNode?) -> Int {
        return maxDepth(root, 0)
    }
    
    private func maxDepth(_ root: TreeNode?, _ maxValue: Int) -> Int {
        guard let r = root else { return maxValue }
        let newMaxValue = maxValue + 1
        return max(maxDepth(r.left, newMaxValue), maxDepth(r.right, newMaxValue))
    }
    
    // Bredth first seaerch
    private func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        guard let r = root else { return result }
        _levelOrder([r], &result)
        return result
    }
    
    private func _levelOrder(_ nodes: [TreeNode], _ result: inout [[Int]]) {
        guard !nodes.isEmpty else { return }
        
        let values = nodes.map { $0.val }
        result.append(values)
        
        let childNodes = nodes.flatMap { (node) -> [TreeNode] in
            var childNodes = [TreeNode]()
            if let l = node.left {
                childNodes.append(l)
            }
            if let r = node.right {
                childNodes.append(r)
            }
            return childNodes
        }
        
        _levelOrder(childNodes, &result)
    }
    
    // Symmetric
    func isSymmetric(_ root: TreeNode?) -> Bool {
        return _isSymmetric([root])
    }
    
    private func _isSymmetric(_ nodes: [TreeNode?]) -> Bool {
        // Handle case when `nodes` contains just NULL values
        let nonNilNode = nodes.first { (node) -> Bool in
            return node != nil
        }
        guard let _ = nonNilNode else { return true }
        
        var start = 0
        var end = nodes.count - 1
        while start < end {
            if nodes[start]?.val != nodes[end]?.val {
                return false
            }
            start += 1
            end -= 1
        }
        
        let childNodes = nodes.flatMap { [$0?.left, $0?.right] }
        
        return _isSymmetric(childNodes)
    }
    
    /*
     Given a binary tree and a sum, determine if the tree has a root-to-leaf path such that adding up all the values along the path equals the given sum.
     
     Note: A leaf is a node with no children.
     */
    func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
        return _hasPathSum(root, sum, 0)
    }
    
    func _hasPathSum(_ root: TreeNode?, _ sum: Int, _ currentSum: Int) -> Bool {
        guard let r = root else { return false }
        
        let newCurrentSum = r.val + currentSum
        if r.left == nil, r.right == nil, newCurrentSum == sum {
            return true
        }
        
        if let left = r.left, _hasPathSum(left, sum, newCurrentSum) {
            return true
        }
        if let right = r.right, _hasPathSum(right, sum, newCurrentSum) {
            return true
        }
        return false
    }
}

class BinarySearchTreeSolution {
    /*
     Implement an iterator over a binary search tree (BST). Your iterator will be initialized with the root node of a BST.
     Calling next() will return the next smallest number in the BST.
     */
    class BSTIterator {
        
        private var values = [Int]()
        
        init(_ root: TreeNode?) {
            BSTIterator.setupValuesInOrder(root, &values)
        }
        
        private static func setupValuesInOrder(_ node: TreeNode?, _ values: inout [Int]) {
            guard let n = node else { return }
            BSTIterator.setupValuesInOrder(node?.left, &values)
            values.append(n.val)
            BSTIterator.setupValuesInOrder(node?.right, &values)
        }
        
        /** @return the next smallest number */
        func next() -> Int {
            guard let first = values.first else { fatalError() }
            values.remove(at: 0)
            return first
        }
        
        /** @return whether we have a next smallest number */
        func hasNext() -> Bool {
            return !values.isEmpty
        }
    }
    
    /*
     Search in a Binary Search Tree
     Given the root node of a binary search tree (BST) and a value. You need to find the node in the BST that the node's value equals the given value. Return the subtree rooted with that node. If such node doesn't exist, you should return NULL.
     
     For example,
     Given the tree:
     4
     / \
     2   7
     / \
     1   3
     And the value to search: 2
     You should return this subtree:
     2
     / \
     1   3
     In the example above, if we want to search the value 5, since there is no node with value 5, we should return NULL.
     
     Note that an empty tree is represented by NULL, therefore you would see the expected output (serialized tree format) as [], not null.
     */
    func searchBST(_ node: TreeNode?, _ val: Int) -> TreeNode? {
        guard let n = node else { return nil }
        
        if n.val == val {
            return n
        } else if n.val > val, let l = n.left {
            return searchBST(l, val)
        } else if n.val < val, let r = n.right {
            return searchBST(r, val)
        }
        return nil
    }
    
    /*
     Insert into a Binary Search Tree

     Given the root node of a binary search tree (BST) and a value to be inserted into the tree, insert the value into the BST. Return the root node of the BST after the insertion. It is guaranteed that the new value does not exist in the original BST.
     
     Note that there may exist multiple valid ways for the insertion, as long as the tree remains a BST after insertion. You can return any of them.
     */
    func insertIntoBST(_ node: TreeNode?, _ val: Int) -> TreeNode? {
        guard let n = node else { return node }
        guard n.val != val else { return node }
        
        if val < n.val {
            if let l = n.left {
                let _ = insertIntoBST(l, val)
            } else {
                let newNode = TreeNode(val)
                n.left = newNode
            }
        } else {
            if let r = n.right {
                let _ = insertIntoBST(r, val)
            } else {
                let newNode = TreeNode(val)
                n.right = newNode
            }
        }
        return n
    }
    
    /*
     Given a root node reference of a BST and a key, delete the node with the given key in the BST. Return the root node reference (possibly updated) of the BST.
     
     Basically, the deletion can be divided into two stages:
     Search for a node to remove.
     If the node is found, delete the node.
     
     Note: Time complexity should be O(height of tree).
     */
    func deleteNode(_ node: TreeNode?, _ key: Int) -> TreeNode? {
        guard let n = node else { return nil }
        return _deleteNode(n, nil, key)
    }
    
    @discardableResult
    private func _deleteNode(_ node: TreeNode, _ parent: TreeNode?, _ key: Int) -> TreeNode? {
        if node.val == key {
            // Get amount of children
            var childrenCount = 0
            if node.left != nil {
                childrenCount += 1
            }
            if node.right != nil {
                childrenCount += 1
            }
            
            // Handle
            switch childrenCount {
            case 0:
                if let parentLeft = parent?.left, parentLeft.val == node.val {
                    parent?.left = nil
                } else if let parentRight = parent?.right, parentRight.val == key {
                    parent?.right = nil
                }
                return parent
                
            case 1:
                if let childLeft = node.left {
                    if let parentLeft = parent?.left, parentLeft.val == node.val {
                        parent?.left = childLeft
                    } else if let parentRight = parent?.right, parentRight.val == node.val {
                        parent?.right = childLeft
                    }
                    return parent ?? childLeft
                } else if let childRight = node.right {
                    if let parentLeft = parent?.left, parentLeft.val == node.val {
                        parent?.left = childRight
                    } else if let parentRight = parent?.right, parentRight.val == node.val {
                        parent?.right = childRight
                    }
                    return parent ?? childRight
                } else {
                    fatalError("There must be 1 child")
                }
                return parent
                
            default: // 2 child nodes
                guard let childRight = node.right else { fatalError("There must be right child") }
                
                var targetNode = childRight
                while targetNode.left != nil {
                    if let left = targetNode.left {
                        targetNode = left
                    }
                }
                
                node.val = targetNode.val
                targetNode.val = key
                _deleteNode(childRight, node, key)
                return parent ?? node
            }
        }
        
        if node.val > key, let childLeft = node.left {
            _deleteNode(childLeft, node, key)
        } else if let childRight = node.right {
            _deleteNode(childRight, node, key)
        }
        return parent ?? node
    }
}
