/*
 Last-in first-out stack (LIFO)
 Push and pop are O(1) operations.
 */

import Foundation

public class Stack<T>: AdvancedCollection {
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public func push(_ element: T) {
        array.append(element)
    }
    
    public func pop() -> T? {
        return array.popLast()
    }
    
    public func peek() -> T? {
        return array.last
    }
}

//extension Stack: Sequence {
//    public func makeIterator() -> AnyIterator<T> {
//        return AnyIterator {
//            return self.pop()
//        }
//    }
//}
