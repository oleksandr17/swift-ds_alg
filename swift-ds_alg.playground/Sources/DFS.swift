import Foundation

public class NumIslandsSolution {
    
    /*
     Number of Islands
     
     Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.
     
     Example 1:
     Input:
     11110
     11010
     11000
     00000
     Output: 1
     
     Example 2:
     Input:
     11000
     11000
     00100
     00011
     Output: 3
     */
    public func numIslands(_ grid: [[Character]]) -> Int {
        let rowsCount = grid.count
        guard rowsCount > 0 else { return 0 }
        let columnsCount = grid[0].count
        var visited = Array(repeating: Array(repeating: false, count: columnsCount), count: rowsCount)
        
        var count = 0
        for row in 0..<rowsCount {
            for column in 0..<columnsCount {
                if isIsland(grid: grid, row: row, column: column, rowsCount: rowsCount, columnsCount: columnsCount,visited: &visited) {
                    count += 1
                }
            }
        }
        
        return count
    }
    
    private func isIsland(grid: [[Character]],
                          row: Int,
                          column: Int,
                          rowsCount: Int,
                          columnsCount: Int,
                          visited: inout [[Bool]]) -> Bool {
        
        guard !visited[row][column] else { return false }
        visited[row][column] = true
        guard grid[row][column] == "1" else { return false }
        
        let coordinate = Coordinate(row: row, column: column)
        _ = coordinate.neighbours(rowsCount: rowsCount, columnsCount: columnsCount)
            .forEach { (c) in
                _ = isIsland(grid: grid, row: c.row, column: c.column, rowsCount: rowsCount, columnsCount: columnsCount, visited: &visited)
        }
        
        return true
    }
}

/*
 You are given a list of non-negative integers, a1, a2, ..., an, and a target, S. Now you have 2 symbols + and -. For each integer, you should choose one from + and - as its new symbol.
 
 Find out how many ways to assign symbols to make sum of integers equal to target S.
 
 Example 1:
 Input: nums is [1, 1, 1, 1, 1], S is 3.
 Output: 5
 
 Explanation:
 -1+1+1+1+1 = 3
 +1-1+1+1+1 = 3
 +1+1-1+1+1 = 3
 +1+1+1-1+1 = 3
 +1+1+1+1-1 = 3
 
 There are 5 ways to assign symbols to make the sum of nums be target 3.
 */
public class TargetSumSolution {
    private enum Operation {
        case plus
        case minus
    }
    
    public func findTargetSumWays(_ nums: [Int], _ S: Int) -> Int {
        guard !nums.isEmpty else { return 0 }
        return findTargetSumWays(nums, 0, .plus, S, 0) + findTargetSumWays(nums, 0, .minus, S, 0)
    }
    
    private func findTargetSumWays(_ nums: [Int], _ index: Int, _ operation: Operation, _ target: Int, _ currentSum: Int) -> Int {
        let value: Int
        switch operation {
        case .plus:
            value = currentSum + nums[index]
        case .minus:
            value = currentSum - nums[index]
        }
        
        guard index < (nums.count - 1) else { // last item
            return (value == target) ? 1 : 0
        }
        
        return findTargetSumWays(nums, index + 1, .plus, target, value) + findTargetSumWays(nums, index + 1, .minus, target, value)
    }
}
