//
//  Rectangle.swift
//  PathTools
//
//  Created by James Bean on 6/3/17.
//
//

import Collections
import ArithmeticTools



/// A structure that contains the location and dimensions of a rectangle.
///
/// - TODO: Consider storing vertices as with `Polygon`, as opposed to being computed.
///
public struct Rectangle: ConvexPolygonProtocol {
    
    public enum ScaleAnchor {
        case origin, center
    }
    
    // MARK: - Type Properties
    
    /// `Rectangle` with `origin` and `size` values of zero.
    public static let zero = Rectangle()
    
    // MARK: - Instance Properties
    
    /// Vertices comprising `Rectangle`.
    public var vertices: VertexCollection {
        let topLeft = Point(x: minX, y: maxY)
        let bottomLeft = Point(x: minX, y: minY)
        let bottomRight = Point(x: maxX, y: minY)
        let topRight = Point(x: maxX, y: maxY)
        return VertexCollection([topLeft, bottomLeft, bottomRight, topRight])
    }

    /// Minimum X value.
    public var minX: Double {
        return (size.width < 0) ? origin.x + size.width : origin.x
    }
    
    /// Horizontal midpoint.
    public var midX: Double {
        return origin.x + (size.width / 2.0)
    }
    
    /// Maximum X value.
    public var maxX: Double {
        return (size.width < 0) ? origin.x : origin.x + size.width
    }
    
    /// Minimum Y value.
    public var minY: Double {
        return (size.height < 0) ? origin.y + size.height : origin.y
    }
    
    /// Vertical midpoint.
    public var midY: Double {
        return origin.y + (size.height / 2.0)
    }
    
    /// Maximum Y value.
    public var maxY: Double {
        return (size.height < 0) ? origin.y : origin.y + size.height
    }
    
    /// - Returns: `true` if the `height` or `width` properties of `size` are `0`. Otherwise,
    /// false.
    public var isEmpty: Bool {
        return size.width == 0 || size.height == 0
    }
    
    /// Center point.
    public var center: Point {
        return Point(x: midX, y: midY)
    }
    
    /// Origin.
    public let origin: Point
    
    /// Size.
    public let size: Size
    
    // MARK: - Initializers
    
    /// Creates a `Rectangle` with the given `origin` and the given `size`.
    public init(origin: Point = Point(), size: Size = Size()) {
        self.origin = origin
        self.size = size
    }
    
    /// Creates a `Rectangle` with the given `center` and the given `size`.
    public init(center: Point, size: Size) {
        self.origin = Point(x: center.x - 0.5 * size.width, y: center.y + 0.5 * size.height)
        self.size = size
    }
    
    /// Creates a `Rectangle` with the given `x`, `y`, `width`, and `height` values.
    public init(x: Double, y: Double, width: Double, height: Double) {
        self.origin = Point(x: x, y: y)
        self.size = Size(width: width, height: height)
    }
    
    /// Creates a `Rectangle` with the given `width` and `height`, with an origin of `Point()`.
    public init(width: Double, height: Double) {
        self.init(x: 0, y: 0, width: width, height: height)
    }
    
    /// Creates a `Rectangle` with the given `minX`, `minY`, `maxX`, and `maxY` values.
    public init(minX: Double, minY: Double, maxX: Double, maxY: Double) {
        precondition(maxX >= minX)
        precondition(maxY >= minY)
        let origin = Point(x: minX, y: minY)
        let width = maxX - minX
        let height = maxY - minY
        self.init(origin: origin, size: Size(width: width, height: height))
    }
    
    /// Creates a `Rectangle` with the given `vertices`.
    ///
    /// - Warning: Will crash if given invalid vertices.
    ///
    public init <S: Sequence> (vertices: S) where S.Iterator.Element == Point {
        try! self.init(Polygon(vertices: VertexCollection(vertices)))
    }
    
    /// Creates a `Rectangle` with the given `polygon`.
    ///
    /// - Throws: `PolygonError` if the given `polygon` is not rectangular.
    ///
    public init(_ polygon: Polygon) throws {
        
        guard polygon.vertices.count == 4 else {
            
            throw PolygonError.invalidVertices(
                polygon.vertices,
                Rectangle.self,
                "A Rectangle must have four vertices!"
            )
        }
        
        guard polygon.angles.allSatisfy({ $0 == Angle(degrees: 90) }) else {
            
            throw PolygonError.invalidVertices(
                polygon.vertices,
                Rectangle.self,
                "A Rectangle must have only right angles!"
            )
        }
        
        // FIXME: Use less expensive method!
        let minX = polygon.vertices.map { $0.x }.min()!
        let maxX = polygon.vertices.map { $0.x }.max()!
        let minY = polygon.vertices.map { $0.y }.min()!
        let maxY = polygon.vertices.map { $0.y }.max()!
        
        self.init(x: minX, y: minY, width: maxX - maxX, height: maxY - minY)
    }

    // MARK: - Instance Methods
    
    /// - Returns: `true` if the given `point` is contained herein. Otherwise, `false`.
    public func contains(_ point: Point) -> Bool {
        return (minX...maxX).contains(point.x) && (minY...maxY).contains(point.y)
    }

    /// - Returns: `Rectangle` translated by the given `x` and `y` values.
    public func translatedBy(x: Double = 0, y: Double = 0) -> Rectangle {
        return translated(by: Point(x: x, y: 0))
    }

    /// - Returns: `Rectangle` translated by the given `point`.
    public func translated(by point: Point) -> Rectangle {
        let origin = self.origin.translated(by: point)
        return Rectangle(origin: origin, size: size)
    }

    /// - Returns: `Rectangle` with dimensions scaled by the given `value` around the given 
    /// `anchor`.
    public func scaled(by value: Double, around anchor: ScaleAnchor) -> Rectangle {
        switch anchor {
        case .origin:
            return Rectangle(origin: origin, size: size.scaled(by: value))
        case .center:
            let size = self.size.scaled(by: value)
            return Rectangle(
                origin: Point(x: center.x - 0.5 * size.width, y: center.y + 0.5 * size.height),
                size: size.scaled(by: value)
            )
        }
    }
}

extension Rectangle: Equatable {
    
    // MARK: - Equatable
    
    /// - Returns: `true` if values are equivalent. Otherwise, `false`.
    public static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
        return lhs.origin == rhs.origin && lhs.size == rhs.size
    }
}

extension Array where Iterator.Element == Rectangle {
    
    public var sum: Rectangle {
        
        guard !self.isEmpty else {
            return .zero
        }
        
        let (first,rest) = self.destructured!
        var minX = first.minX
        var minY = first.minY
        var maxX = first.maxX
        var maxY = first.maxY
        for rect in rest {
            if rect.minX < minX { minX = rect.minX }
            if rect.maxX > maxX { maxX = rect.maxX }
            if rect.minY < minY { minY = rect.minY }
            if rect.maxY > maxY { maxY = rect.maxY }
        }
        let width = maxX - minX
        let height = maxY - minY
        return Rectangle(x: minX, y: minY, width: width, height: height)
    }
}

extension Rectangle: CustomStringConvertible {

    // MARK: CustomStringConvertible

    public var description: String {
        return "Rectangle[ origin: \(origin), width: \(size.width), height: \(size.height) ]"
    }
}
