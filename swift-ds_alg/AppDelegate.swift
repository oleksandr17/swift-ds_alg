import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        do {
            var ints1 = [1,2,3,4,5]
            ReverseArray.reverseArray(&ints1)
            var ints2 = [1,2,3,4,5,6]
            ReverseArray.reverseArray(&ints2)
        }
        
        do {
            let node4 = ListNode(4)
            let node3 = ListNode(3)
            node3.next = node4
            let node2 = ListNode(2)
            node2.next = node3
            let node1 = ListNode(1)
            node1.next = node2
            
            let swappedNode = node1.swapPairs()
            _ = swappedNode.values()
        }
        
        do {
            let node4 = ListNode(4)
            let node3 = ListNode(3)
            node3.next = node4
            let node2 = ListNode(2)
            node2.next = node3
            let node1 = ListNode(1)
            node1.next = node2
            
            let reversedNode = node1.reverseList()
            _ = reversedNode.values()
        }
        
        do {
            _ = PascalsTriangle.generate(5)
            _ = PascalsTriangle.getRowElements(4)
        }
        
        do {
            _ = Memoization.fib(10)
            _ = Memoization.climbStairs(6)
        }
        
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
            _ = newRootNode?.values()
        }
        
        do {
            _ = KthGrammarSolution.kthGrammarSlow(3, 3)
            _ = KthGrammarSolution.kthGrammarFast(10000, 1)
        }
        
        do {
            _ = BinarySearch.pow(2, 10)
            _ = BinarySearch.sqrt(10)
            _ = BinarySearch.search([1,2,3,4,5,6,7,8,9], 5)
            _ = BinarySearch.searchInRotatedArray([6,7,8,9,1,2,3,4,5], 5)
            _ = BinarySearch.searchRange([1,2,3,3,3,3,4,5,9], 3)
        }
        
        do {
            _ = HRWarmUp().repeatedString(s: "a", n: 1000000000000)
        }
        
        do {
            print("sherlockAndAnagrams = ", HRHashTables().sherlockAndAnagrams(s: "abba"))
            
            print("countTriplets = ", HRHashTables().countTriplets(arr: [1, 5, 5, 25, 125], r: 5))
            print("countTriplets = ", HRHashTables().countTriplets(arr: [1, 3, 9, 9, 27, 81], r: 3))
            print("countTriplets = ", HRHashTables().countTriplets(arr: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], r: 1))
        }
        
        do {
            HRSorting().countSwaps(a: [3,2,1])
        }
        
        do {
            let arr1 = [15,3,9,8,5,2,7,1,6]
            let arr2 = arr1.quicksort()
            print("Quick sort: \(arr2)")
        }
        
        do {
            print("makeAnagram = ", HRStrings().makeAnagram(a: "fcrxzwscanmligyxyvym", b: "jxwtrhvujlmrpdoqbisbwhmgpmeoke"))
           
            print("isValid = ", HRStrings().isValid(s: "abcdefghhgfedecba"))
            print("isValid = ", HRStrings().isValid(s: "ibfdgaeadiaefgbhbdghhhbgdfgeiccbiehhfcggchgghadhdhagfbahhddgghbdehidbibaeaagaeeigffcebfbaieggabcfbiiedcabfihchdfabifahcbhagccbdfifhghcadfiadeeaheeddddiecaicbgigccageicehfdhdgafaddhffadigfhhcaedcedecafeacbdacgfgfeeibgaiffdehigebhhehiaahfidibccdcdagifgaihacihadecgifihbebffebdfbchbgigeccahgihbcbcaggebaaafgfedbfgagfediddghdgbgehhhifhgcedechahidcbchebheihaadbbbiaiccededchdagfhccfdefigfibifabeiaccghcegfbcghaefifbachebaacbhbfgfddeceababbacgffbagidebeadfihaefefegbghgddbbgddeehgfbhafbccidebgehifafgbghafacgfdccgifdcbbbidfifhdaibgigebigaedeaaiadegfefbhacgddhchgcbgcaeaieiegiffchbgbebgbehbbfcebciiagacaiechdigbgbghefcahgbhfibhedaeeiffebdiabcifgccdefabccdghehfibfiifdaicfedagahhdcbhbicdgibgcedieihcichadgchgbdcdagaihebbabhibcihicadgadfcihdheefbhffiageddhgahaidfdhhdbgciiaciegchiiebfbcbhaeagccfhbfhaddagnfieihghfbaggiffbbfbecgaiiidccdceadbbdfgigibgcgchafccdchgifdeieicbaididhfcfdedbhaadedfageigfdehgcdaecaebebebfcieaecfagfdieaefdiedbcadchabhebgehiidfcgahcdhcdhgchhiiheffiifeegcfdgbdeffhgeghdfhbfbifgidcafbfcd"))
        }
        
        do {
            HRSearch().whatFlavors(cost: [1, 4, 5, 3, 2], money: 4)
            HRSearch().whatFlavors(cost: [2, 2, 4, 3], money: 4)
            HRSearch().whatFlavors(cost: [4, 3, 2, 5, 7], money: 8)
        }
        
        do {
            print("minimumAbsoluteDifference = ", HRGreedyAlgorithms().minimumAbsoluteDifference(arr: [3, -7, 0]))
            
            print("maxMin = ", HRGreedyAlgorithms().maxMin(k: 3, arr: [10, 100, 300, 200, 1000, 20, 30]))
            print("maxMin = ", HRGreedyAlgorithms().maxMin(k: 4, arr: [1, 2, 3, 4, 10, 20, 30, 40, 100, 200]))
            print("maxMin = ", HRGreedyAlgorithms().maxMin(k: 3, arr: [100, 200, 300, 350, 400, 401, 402]))
        }
        
        do {
            let isValidSudoku = LCArray().isValidSudoku([
                ["8","3",".",".","7",".",".",".","."],
                ["6",".",".","1","9","5",".",".","."],
                [".","9","8",".",".",".",".","6","."],
                ["8",".",".",".","6",".",".",".","3"],
                ["4",".",".","8",".","3",".",".","1"],
                ["7",".",".",".","2",".",".",".","6"],
                [".","6",".",".",".",".","2","8","."],
                [".",".",".","4","1","9",".",".","5"],
                [".",".",".",".","8",".",".","7","9"]
                ]) // first section contains 8 twice
            print("Is valid sudoku: \(isValidSudoku)")
        }
        
        do {
            var matrix = [[1,2,3],[4,5,6],[7,8,9]]
            LCArray().rotate(&matrix)
            print("Rotated matrix: \(matrix)")
            
            matrix = [[2,29,20,26,16,28],[12,27,9,25,13,21],[32,33,32,2,28,14],[13,14,32,27,22,26],[33,1,20,7,21,7],[4,24,1,6,32,34]]
            LCArray().rotate(&matrix)
            print("Rotated matrix: \(matrix)")
            
            matrix = [[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]]
            LCArray().rotate(&matrix)
            print("Rotated matrix: \(matrix)")
            
            matrix = [[2,29,20,26,16,28],[12,27,9,25,13,21],[32,33,32,2,28,14],[13,14,32,27,22,26],[33,1,20,7,21,7],[4,24,1,6,32,34]]
            LCArray().rotate(&matrix)
            print("Rotated matrix: \(matrix)")
        }
        
        do {
            let value = -12345
            print("Reversed integer value \(value): \(LCStrings().reverse(value))")
        }

        do {
            let str = "A man, a plan, a canal: Panama"
            print("Is palindrome \(str): \(LCStrings().isPalindrome(str))")
        }
        
        do {
            var str = "42"
            print("My atoi `\(str)`: \(LCStrings().myAtoi(str))")
            
            str = "   -42"
            print("My atoi `\(str)`: \(LCStrings().myAtoi(str))")
            
            str = "4193 with words"
            print("My atoi `\(str)`: \(LCStrings().myAtoi(str))")
            
            str = "words and 987"
            print("My atoi `\(str)`: \(LCStrings().myAtoi(str))")
            
            str = "-91283472332"
            print("My atoi `\(str)`: \(LCStrings().myAtoi(str))")
            
            str = "+1"
            print("My atoi `\(str)`: \(LCStrings().myAtoi(str))")
            
            str = "2147483646"
            print("My atoi `\(str)`: \(LCStrings().myAtoi(str))")
        }
        
        do {
            var haystack = "a"
            var needle = "a"
            print("Index of `\(needle)` in `\(haystack)`: \(LCStrings().strStr(haystack, needle))")
            
            haystack = "mississippi"
            needle = "issip"
            print("Index of `\(needle)` in `\(haystack)`: \(LCStrings().strStr(haystack, needle))")
            
            haystack = "mississippi"
            needle = "issipi"
            print("Index of `\(needle)` in `\(haystack)`: \(LCStrings().strStr(haystack, needle))")
        }
        
        do {
            let n = 1
            print("Count and say `\(n)`: \(LCStrings().countAndSay(n))")
        }
        
        do {
            let strings = ["flower","flow","flight"]
            print("Longest common prefix of \(strings): \(LCStrings().longestCommonPrefix(strings))")
        }
        
        do {
            let head = ListNode(1)
            var node = head
            node.next = ListNode(0)
            node = node.next!
            node.next = ListNode(3)
            node = node.next!
            node.next = ListNode(0)
            node = node.next!
            node.next = ListNode(1)
            print("Is palindrome: \(LCLinkedList().isPalindrome(head))")
        }
        
        do {
            let arr = [-10,-3,0,5,9]
            print("Sorted array to BST \(arr): root is \(String(describing: LCTrees().sortedArrayToBST([-10,-3,0,5,9])?.val))")
        }
        
        do {
            var arr1 = [1,2,3,0,0,0]
            let arr2 = [2,5,6]
            print("Merge \(arr2) into \(arr1):")
            LCSortingAndSearching().merge(&arr1, 3, arr2, arr2.count)
            print("--> \(arr1)")
        }
        
        do {
            let arr = [7,1,5,3,6,4]
            print("Max profit of \(arr): \(LCDynamicProgramming().maxProfit(arr))")
        }
        
        exit(1)
    }
}
