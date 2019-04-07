import Foundation

// Reverse array
do {
    var ints1 = [1,2,3,4,5]
    ReverseArray.reverseArray(&ints1)
    var ints2 = [1,2,3,4,5,6]
    ReverseArray.reverseArray(&ints2)
}

// Swap pairs of list nodes
do {
    let node4 = ListNode(4)
    let node3 = ListNode(3)
    node3.next = node4
    let node2 = ListNode(2)
    node2.next = node3
    let node1 = ListNode(1)
    node1.next = node2
    
    let swappedNode = node1.swapPairs()
    swappedNode.values()
}

// Reverse list nodes
do {
    let node4 = ListNode(4)
    let node3 = ListNode(3)
    node3.next = node4
    let node2 = ListNode(2)
    node2.next = node3
    let node1 = ListNode(1)
    node1.next = node2
    
    let reversedNode = node1.reverseList()
    reversedNode.values()
}

// Pascal's Triangle
do {
    PascalsTriangle.generate(5)
    PascalsTriangle.getRowElements(4)
}

// Memoization
do {
    Memoization.fib(10)
    Memoization.climbStairs(6)
}

// Merge Two Sorted Lists
do {
    let node14 = ListNode(4)
    
    let node12 = ListNode(2)
    node12.next = node14
    
    let node11 = ListNode(1)
    node11.next = node12
    
    //
    let node24 = ListNode(4)
    
    let node23 = ListNode(3)
    node23.next = node24
    
    let node21 = ListNode(1)
    node21.next = node23
    
    let newRootNode = ListNode.mergeTwoLists(node11, node21)
    newRootNode?.values()
}

//  K-th Symbol in Grammar

do {
    KthGrammarSolution.kthGrammarSlow(3, 3)
    KthGrammarSolution.kthGrammarFast(10000, 1)
}

// Binary search
do {
    BinarySearch.pow(2, 10)
    BinarySearch.sqrt(10)
    BinarySearch.search([1,2,3,4,5,6,7,8,9], 5)
    BinarySearch.searchInRotatedArray([6,7,8,9,1,2,3,4,5], 5)
    BinarySearch.searchRange([1,2,3,3,3,3,4,5,9], 3)
}
