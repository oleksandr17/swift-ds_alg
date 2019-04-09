import Foundation

struct Coordinate {
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
