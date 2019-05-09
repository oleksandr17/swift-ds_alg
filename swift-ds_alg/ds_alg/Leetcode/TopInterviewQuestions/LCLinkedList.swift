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
}
