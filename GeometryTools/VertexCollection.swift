//
//  VertexCollection.swift
//  PathTools
//
//  Created by James Bean on 6/7/17.
//
//

import Collections
import ArithmeticTools

/// Circular collection of `Point` values.
public typealias VertexCollection = CircularArray<Point>

/// - Note: One day, we will be able to say: `extension VertexCollection`.
extension CircularArray where Element == Point {
    
//    public func sorted(by areInIncreasingOrder: (Point, Point) -> Bool) -> CircularArray {
//        // TODO: Inject this into `CircularArray` in `dn-m/Collections`
//        return CircularArray(self.map { $0 }.sorted(by: areInIncreasingOrder))
//    }
    
    /// - Note: Uses gift wrapping algorithm
    public var convexHull: CircularArray {
        
        guard count > 3 else {
            return self
        }
        
        // TODO: Implement functional / recursive solution

        // Sort vertices lexicographically (first by x, then by y in a tie)
        let vertices = sorted { $0.x < $1.x || ($0.x == $1.x && $0.y < $1.y) }

        var lowerHull: [Point] = []
        for i in 0..<vertices.count {
            while lowerHull.count >= 2 &&
                zCrossProduct(
                    p1: lowerHull[lowerHull.count - 2],
                    center: lowerHull[lowerHull.count - 1],
                    p2: vertices[i]) <= 0
            {
                _ = lowerHull.popLast()!
            }
            lowerHull.append(vertices[i])
        }
        
        var upperHull: [Point] = []
        var i = vertices.count - 1
        while i >= 0 {
            while upperHull.count >= 2 &&
                zCrossProduct(
                    p1: upperHull[upperHull.count - 2],
                    center: upperHull[upperHull.count - 1],
                    p2: vertices[i]) <= 0
            {
                _ = upperHull.popLast()!
            }
            upperHull.append(vertices[i])
            i -= 1
        }

        return VertexCollection(lowerHull + upperHull.dropFirst())
    }
    
    /// - returns: Array of the line values comprising the edges of the `PolygonProtocol`-
    /// conforming type.
    public var edges: [Line] {
        return indices.map { index in
            Line(points: self[from: index, through: index + 1])
        }
    }
    
    /// - Returns: The two-dimensional vector of each axis created between each adjacent pair
    /// of vertices.
    public var axes: [Vector2] {
        return edges.map { $0.vector }
    }
    
    /// - Returns: Array of triangles created with each adjacent triple of vertices.
    public var triangles: [Triangle] {
        return indices.map { index in
            Triangle(vertices: self[from: index - 1, through: index + 1])
        }
    }
    
    /// - Returns: Array of the angles of each adjacent triple of vertices.
    public var angles: [Angle] {
        return triangles.map { $0.angle }
    }
    
    /// - Returns: `true` if the vertices contained herein form a convex polygon. Otherwise,
    /// `false`.
    public var formConvexPolygon: Bool {
        return indices
            .lazy
            .map { index in self[from: index - 1, through: index + 1] }
            .map { zCrossProduct(p1: $0[0], center: $0[1], p2: $0[2]) }
            .map { $0.sign }
            .isHomogeneous
    }
    
    /// - Returns: Wheter vertices are arranged in a clockwise or counterclockwise fasion.
    public var rotation: Rotation {
        let sum = edges.reduce(Double(0)) { accum, cur in
            let (a,b) = (cur.start, cur.end)
            return accum + (b.x - a.x) * (b.y + a.y)
        }
        return sum > 0 ? .clockwise : .counterClockwise
    }
}

private func zCrossProduct(p1: Point, center: Point, p2: Point) -> Double {
    return (p1.x - center.x) * (center.y - p2.y) - (p1.y - center.y) * (center.x - p2.x)
}
