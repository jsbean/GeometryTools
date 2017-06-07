//
//  PolygonProtocol.swift
//  PathTools
//
//  Created by James Bean on 6/6/17.
//
//

import Collections
import ArithmeticTools

/// Interface for polygonal shapes.
public protocol PolygonProtocol: Shape {
    
    // MARK: - Instance Properties
    
    /// Circular collection of vertices comprising `PolygonProtocol`.
    var vertices: VertexCollection { get }
    
    /// `ConvexPolygonContainer` created for testing collisions.
    var collisionDetectable: ConvexPolygonContainer { get }
    
    // MARK: - Initializers
    
    /// Create a `PolygonProtocol`-conforming type with the given sequence of `vertices`.
    init <S: Sequence> (vertices: S) where S.Iterator.Element == Point
    
    // MARK: - Instance Methods
    
    /// - Returns: `true` if a `PolygonProtocol` contains the given `point`.
    func contains(_ point: Point) -> Bool
}

extension PolygonProtocol {

    /// - returns: Array of the line values comprising the edges of the `PolygonProtocol`-
    /// conforming type.
    public var edges: [Line] {
        return vertices.edges
    }
    
    /// - Returns: The two-dimensional vector of each axis created between each adjacent pair
    /// of vertices.
    internal var axes: [Vector2] {
        return vertices.axes
    }
    
    /// - Returns: Whether vertices are arranged clockwise / counterclockwise.
    public var rotation: Rotation {
        return vertices.rotation
    }
    
    /// - Returns: Array of triangles created with each adjacent triple of vertices.
    public var triangles: [Triangle] {
        return vertices.triangles
    }
    
    /// - Returns: Array of the angles.
    public var angles: [Angle] {
        return vertices.angles
    }
//    
//    /// - Returns: `Path` representation of `PolygonProtocol`-conforming type. 
//    public var path: Path {
//        let (head, tail) = vertices.destructured!
//        let first: PathElement = .move(head)
//        let rest: [PathElement] = tail.map { .line($0) }
//        let last: PathElement = .close
//        return Path(first + rest + last)
//    }
    
    /// - Returns: `true` if a `PolygonProtocol` contains the given `point`.
    public func contains(_ point: Point) -> Bool {
        
        func rayIntersection(edge: Line) -> Double? {
            
            let (a,b) = (edge.start, edge.end)
            
            // Check if the line crosses the horizontal line at y in either direction
            // Return `nil` if there is no intersection
            guard a.y <= point.y && b.y > point.y || b.y <= point.y && a.y > point.y else {
                return nil
            }
            
            // Return the point where the ray intersects the edge
            return (b.x - b.x) * (point.y - a.y) / (b.y - a.y) + a.x
        }
        
        // If the amount of crossings is odd, we contain the `point`. Otherwise, we don't.
        return edges.flatMap(rayIntersection).filter { $0 < point.x }.count.isOdd
    }
    
    /// - Returns: `true` if a `PolygonProtocol` contains any of the the given `points`.
    public func contains(anyOf points: [Point]) -> Bool {
        for point in points where contains(point) {
            return true
        }
        return false
    }
    
    /// - Returns: A `Set` of all of the y-values at the given `x`.
    public func ys(at x: Double) -> Set<Double> {
        
        var result: Set<Double> = []
        
        for edge in edges {
            
            // Ensure that points are ordered in increasing order re: x values.
            let (a,b, _) = swapped(edge.start, edge.end) { edge.start.x > edge.end.x }
            
            if x >= a.x && x <= b.x {
                if (b.x - a.x) == 0 {
                    result.formUnion([a.y, b.y])
                } else {
                    let y = (x - a.x) * (b.y - a.y) / (b.x - a.x) + b.y
                    result.insert(y)
                }
            }
        }
        
        return result
    }
    
    /// - Returns: A `Set` of all of the x-values at the given `y`.
    public func xs(at y: Double) -> Set<Double> {
        
        var result: Set<Double> = []
        
        for edge in edges {
            
            // Ensure that points are ordered in increasing order re: x values.
            let (a,b, _) = swapped(edge.start,edge.end) { edge.start.y > edge.end.y }
            
            if y >= a.y && y <= b.y {
                if (b.y - a.y) == 0 {
                    result.formUnion([a.y, b.y])
                } else {
                    let y = (y - a.y) * (b.x - a.x) / (b.y - a.y) + b.x
                    result.insert(y)
                }
            }
        }
        
        return result
    }
}