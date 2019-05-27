import Foundation

class CircularQueue {
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
