//
//  Line.swift
//  PathTools
//
//  Created by James Bean on 6/6/17.
//
//

import Darwin
import Collections
import ArithmeticTools

public struct Line {
    
    public var length: Double {
        return vector.length
    }
    
    public var vector: Vector2 {
        return Vector2(x: end.x - start.x, y: end.y - start.y)
    }
    
    public let start: Point
    public let end: Point
    
    public init(start: Point, end: Point) {
        self.start = start
        self.end = end
    }
    
    public init(points: [Point]) {
        
        guard points.count == 2 else {
            fatalError("A triangle must have three vertices!")
        }
        
        self.start = points[0]
        self.end = points[1]
    }
    
    public func y(x: Double) -> Double? {
        
        // Ensure line is positive
        let (a,b,_) = ensuring(start, end) { start.x <= end.x }
        
        // Ensure x value is in domain
        guard (a.x...b.x).contains(x) else {
            return nil
        }
        
        return x * (b.y - a.y) / (b.x - a.x) + a.y
    }
    
    public func x(y: Double) -> Double? {
        
        // Ensure line is positive
        let (a,b,_) = swapped(start,end) { start.y > end.y }
        
        // Ensure y value is in range of line
        guard (a.y...b.y).contains(y) else {
            return nil
        }
        
        return (b.x - a.x) * (y - a.y) / (b.y - a.y) + a.x
    }
}

/// - returns: If the given `predicate` is `true`, a tuple of `(b, a, true)`
/// Otherwise, `(a, b, false)`
public func ensuring <T> (_ a: T, _ b: T, that predicate: () -> Bool) -> (T, T, Bool) {
    return predicate() ? (a, b, false) : (b, a, true)
}
