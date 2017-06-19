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
    
    /// - Returns: `Point` scaled by the given `amount` from the given `reference` point.
    public func scaled(by amount: Double, from reference: Point = Point()) -> Point {
        return (self - reference) * amount + reference
    }
    
    /// - Returns: `Point` rotated by the given `angle` around the given `reference` point.
    public func rotated(by angle: Angle, around reference: Point = Point()) -> Point {
        let p = self - reference
        let radius = hypot(p.x, p.y)
        let azimuth = atan2(p.x, p.y) + angle.radians
        let rotated = Point(x: radius * cos(azimuth), y: radius * sin(azimuth))
        return rotated + reference
    }
    
    public func reflected(over line: Line) -> Point {
        return self
    }
}

extension Point {
    
    // MARK: - Point Arithmetic
    
    /// - Returns: The value contained herein for the given `axis`.
    public subscript (axis: Axis) -> Double {
        return axis == .horizontal ? x : y
    }
    
    /// - Returns: `Point` value containing sums of their respective x- and y-values.
    public static func + (lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    /// - Returns: `Point` value containing differences of their respective x- and y-values.
    public static func - (lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}

/// - Returns: `Point` value containing the values of the given `point` each multiplied by the
/// given `multiplier`.
public func * (point: Point, multiplier: Double) -> Point {
    return Point(x: point.x * multiplier, y: point.y * multiplier)
}

/// - Returns: `Point` value containing the values of the given `point` each multiplied by the
/// given `multiplier`.
public func * (multiplicand: Double, point: Point) -> Point {
    return Point(x: point.x * multiplicand, y: point.y * multiplicand)
}

/// - Returns: `Point` value containing the values of the given `point` each divided by the
/// given `divisor`.
public func / (point: Point, divisor: Double) -> Point {
    return Point(x: point.x / divisor, y: point.y / divisor)
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
