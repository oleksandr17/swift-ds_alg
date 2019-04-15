import Foundation

/*
 Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.
 
 push(x) -- Push element x onto stack.
 pop() -- Removes the element on top of the stack.
 top() -- Get the top element.
 getMin() -- Retrieve the minimum element in the stack.
 
 Example:
 MinStack minStack = new MinStack();
 minStack.push(-2);
 minStack.push(0);
 minStack.push(-3);
 minStack.getMin();   --> Returns -3.
 minStack.pop();
 minStack.top();      --> Returns 0.
 minStack.getMin();   --> Returns -2.
 */
class MinStack {
    private var values = [Int]()
    private var auxiliaryValues = [Int]()
    
    func push(_ x: Int) {
        values.append(x)
        
        if let lastAuxiliary = auxiliaryValues.last {
            if x < lastAuxiliary {
                auxiliaryValues.append(x)
            } else {
                auxiliaryValues.append(lastAuxiliary)
            }
        } else {
            auxiliaryValues.append(x)
        }
    }
    
    func pop() {
        _ = values.popLast()
        _ = auxiliaryValues.popLast()
    }
    
    func top() -> Int {
        guard let last = values.last else { return -1 }
        return last
    }
    
    func getMin() -> Int {
        guard let lastAuxiliary = auxiliaryValues.last else { return -1 }
        return lastAuxiliary
    }
}
