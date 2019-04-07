import Foundation

class MyCircularQueue {
    
    private var values: [Int]
    private var capacity: Int
    private var head: Int
    private var tail: Int
    
    /** Initialize your data structure here. Set the size of the queue to be k. */
    init(_ k: Int) {
        values = [Int](repeating: -1, count: k)
        capacity = 0
        head = -1
        tail = -1
    }
    
    /** Insert an element into the circular queue. Return true if the operation is successful. */
    func enQueue(_ value: Int) -> Bool {
        guard !isFull() else { return false }
        tail = nextIndex(value: tail)
        values[tail] = value
        
        if isEmpty() {
            head = tail
        }
        
        capacity += 1
        return true
    }
    
    /** Delete an element from the circular queue. Return true if the operation is successful. */
    func deQueue() -> Bool {
        guard !isEmpty() else { return false }
        head = nextIndex(value: head)
        capacity -= 1
        return true
    }
    
    /** Get the front item from the queue. */
    func Front() -> Int {
        guard !isEmpty() else { return -1 }
        return values[head]
    }
    
    /** Get the last item from the queue. */
    func Rear() -> Int {
        guard !isEmpty() else { return -1 }
        return values[tail]
    }
    
    /** Checks whether the circular queue is empty or not. */
    func isEmpty() -> Bool {
        return capacity == 0
    }
    
    /** Checks whether the circular queue is full or not. */
    func isFull() -> Bool {
        return capacity >= values.count
    }
    
    private func nextIndex(value: Int) -> Int {
        if value >= (values.count - 1) {
            return 0
        }
        return (value + 1)
    }
}

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
    
    private struct Coordinate {
        let row: Int
        let column: Int
        
        init(row: Int, column: Int) {
            self.row = row
            self.column = column
        }
        
        func neighbours(rowsCount: Int, columnsCount: Int) -> [Coordinate] {
            var result = [Coordinate]()
            if let t = top() {
                result.append(t)
            }
            if let l = left() {
                result.append(l)
            }
            if let b = bottom(rowsCount: rowsCount) {
                result.append(b)
            }
            if let r = right(columnsCount: columnsCount ) {
                result.append(r)
            }
            return result
        }
        
        private func top() -> Coordinate? {
            guard row > 0 else { return nil }
            return Coordinate(row: row-1, column: column)
        }
        
        private func left() -> Coordinate? {
            guard column > 0 else { return nil }
            return Coordinate(row: row, column: column-1)
        }
        
        private func bottom(rowsCount: Int) -> Coordinate? {
            guard row < rowsCount - 1 else { return nil }
            return Coordinate(row: row+1, column: column)
        }
        
        private func right(columnsCount: Int) -> Coordinate? {
            guard column < columnsCount - 1 else { return nil }
            return Coordinate(row: row, column: column+1)
        }
    }
}
