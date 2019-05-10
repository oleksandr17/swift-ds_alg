import Foundation

class LCLinkedList {
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/93/linked-list/603/
     */
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        /*
         Complexity Analysis
         
         Time complexity : O(L)O(L).
         The algorithm makes two traversal of the list, first to calculate list length LL and second to find the (L - n)(L−n) th node. There are 2L-n2L−n operations and time complexity is O(L)O(L).
         
         Space complexity : O(1)O(1).
         We only used constant extra space.
         */
        guard let head = head else { return nil }

        // Get count of nodes
        var node: ListNode? = head
        var nodesCount = 0
        while node != nil {
            nodesCount += 1
            node = node?.next
        }
        
        // Remove node
        guard n <= nodesCount else { return nil }
        
        let nodeIndex = nodesCount - n
        guard nodeIndex != 0 else { return head.next } // remove header
        
        let prevNodeIndex = nodeIndex - 1
        node = head
        for _ in 0..<prevNodeIndex {
            node = node?.next
        }
        
        node?.next = node?.next?.next
        
        return head
    }
    
    /*
     https://leetcode.com/explore/interview/card/top-interview-questions-easy/93/linked-list/772/
     */
    func isPalindrome(_ head: ListNode?) -> Bool {
        guard let head = head else { return true }
        guard head.next != nil else { return true }
        
        let middle = findMiddleNode(head)
        let anotherHead = reverseList(middle.next!)
        middle.next = nil
        
        return compare(head1: head, head2: anotherHead)
    }
    
    private func findMiddleNode(_ head: ListNode) -> ListNode {
        var slow = head
        var fast = head
        while fast.next?.next != nil {
            slow = slow.next!
            fast = fast.next!.next!
        }
        return slow
    }
    
    private func reverseList(_ head: ListNode) -> ListNode {
        var node: ListNode? = head
        var next = head.next
        node?.next = nil
        
        while next != nil {
            let tmp = next?.next
            next?.next = node
            node = next
            next = tmp
        }
        return node!
    }
    
    private func compare(head1: ListNode, head2: ListNode) -> Bool {
        var node1: ListNode? = head1
        var node2: ListNode? = head2
        
        while node2 != nil {
            guard let val1 = node1?.val, let val2 = node2?.val else { fatalError("Nodes can't be NULL") }
            guard val1 == val2 else { return false }
            node1 = node1?.next
            node2 = node2?.next
        }
        
        return true
    }
}
