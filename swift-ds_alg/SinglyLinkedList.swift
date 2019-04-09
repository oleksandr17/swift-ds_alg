import Foundation


// Definition for singly-linked list.
class ListNode {
    
    var val: Int
    var next: ListNode?
    
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    func values() -> [Int] {
        return [val] + (next?.values() ?? [Int]())
    }
    
    /*
     Given a linked list, swap every two adjacent nodes and return its head.
     You may not modify the values in the list's nodes, only nodes itself may be changed.
     
     Example:
     Given 1->2->3->4, you should return the list as 2->1->4->3.
     */
    func swapPairs() -> ListNode {
        let first = self
        guard let second = first.next else { return first }
        let third = second.next // optional
        
        second.next = first
        first.next = third?.swapPairs()
        return second
    }
    
    /*
     Reverse a singly linked list.
     
     Example:
     Input: 1->2->3->4->5->NULL
     Output: 5->4->3->2->1->NULL
     */
    func reverseList() -> ListNode {
        return reversed(first: nil, second: self)
    }
    
    private func reversed(first: ListNode?, second: ListNode) -> ListNode {
        let third = second.next
        second.next = first
        guard let newSecond = third else { return second }
        return reversed(first: second, second: newSecond)
    }
    
    /*
     Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.
     
     Example:
     Input: 1->2->4, 1->3->4
     Output: 1->1->2->3->4->4
     */
    static func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var list1 = l1
        var list2 = l2
        
        guard let firstNode = merge(&list1, &list2) else { return nil }
        
        var node: ListNode? = firstNode
        while node != nil {
            if let n = merge(&list1, &list2) {
                node?.next = n
                node = n
            } else {
                break
            }
        }
        
        return firstNode
    }
    
    private static func merge(_ l1: inout ListNode?, _ l2: inout ListNode?) -> ListNode? {
        switch (l1, l2) {
        case (.none, .none):
            return nil
            
        case let (.some(left), .none):
            l1 = l1?.next
            return left
            
        case let (.none, .some(right)):
            l2 = l2?.next
            return right
            
        case let (.some(left), .some(right)):
            if left.val <= right.val {
                l1 = l1?.next
                return left
            } else {
                l2 = l2?.next
                return right
            }
        }
    }
}
