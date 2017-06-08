//
//  Point.swift
//  PathTools
//
//  Created by James Bean on 1/7/17.
//
//

import Darwin

/// Representation of a point.
public struct Point {
    
    // MARK: - Instance Properties
    
    /// Horizontal position.
    public let x: Double
    
    /// Vertical position.
    public let y: Double
    
    // MARK: - Initializers
    
    /// Creates a `Point` with the given `x` and `y` values.
    public init(x: Double = 0, y: Double = 0) {
        self.x = x
        self.y = y
    }
    
    // MARK: - Instance Properties
    
    /// - returns: The distance to the given `other` point.
    public func distance(to other: Point) -> Double {
        return hypot(other.x - self.x, other.y - self.y)
    }
    
    /// - returns: `Point` translated by the given `x` and `y` values.
    public func translatedBy(x ΔX: Double, y ΔY: Double) -> Point {
        return Point(x: x + ΔX, y: y + ΔY)
    }
}

extension Point: Equatable {
    
    // MARK: - Equatable
    
    /// - Returns `true` if both `Point` values are equivalent. Otherwise, `false`.
    public static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

extension Point: Hashable {
    
    // MARK: - Hashable
    
    public var hashValue: Int {
        return "\(x)\(y)".hashValue
    }
}

extension Point: CustomStringConvertible {
    
    // MARK: - CustomStringConvertible
    
    /// Printed description.
    public var description: String {
        return "(\(x),\(y))"
    }
}
