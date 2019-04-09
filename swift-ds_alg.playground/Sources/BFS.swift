import Foundation

public class ZeroOneMatrixSolution {
    /*
     01 Matrix

     Given a matrix consists of 0 and 1, find the distance of the nearest 0 for each cell.
     The distance between two adjacent cells is 1.
     
     Example 1:
     Input:
     0 0 0
     0 1 0
     0 0 0
     Output:
     0 0 0
     0 1 0
     0 0 0
     
     Example 2:
     Input:
     0 0 0
     0 1 0
     1 1 1
     Output:
     0 0 0
     0 1 0
     1 2 1
     
     Note:
     The number of elements of the given matrix will not exceed 10,000.
     There are at least one 0 in the given matrix.
     The cells are adjacent in only four directions: up, down, left and right.
     */
    public func updateMatrix(_ matrix: [[Int]]) -> [[Int]] {
        var result = matrix
        
        let rowsCount = matrix.count
        guard rowsCount > 0 else { return result }
        let columnsCount = matrix[0].count
        
        for row in 0..<rowsCount {
            for column in 0..<columnsCount {
                let value = matrix[row][column]
                guard value != 0 else { continue }
                
                var depth = 0
                var elements = [Coordinate(row: row, column: column)]
                var size = 1
                var visited = Array(repeating: Array(repeating: false, count: columnsCount), count: rowsCount)
                
                while !elements.isEmpty {
                    size -= 1
                    defer {
                        if size == 0 {
                            depth += 1
                            size = elements.count
                        }
                    }
                    
                    let element = elements[0]
                    elements.remove(at: 0)
                    
                    guard !visited[element.row][element.column] else { continue }
                    visited[element.row][element.column] = true
                    
                    guard matrix[element.row][element.column] != 0 else {
                        result[row][column] = depth
                        break
                    }
                    
                    let neighbours = element.neighbours(rowsCount: rowsCount, columnsCount: columnsCount)
                    elements.append(contentsOf: neighbours)
                }
            }
        }
        return result
    }
}
