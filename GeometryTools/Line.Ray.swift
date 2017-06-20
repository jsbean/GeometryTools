//
//  Line.Ray.swift
//  GeometryTools
//
//  Created by James Bean on 6/20/17.
//
//

import Foundation

extension Line {
    
    public struct Ray {
        
        public let point: Point
        public let slope: Double
        
        public init(point: Point, slope: Double) {
            self.point = point
            self.slope = slope
        }
        
        public init(_ segment: Segment) {
            let slope = (segment.end.y - segment.start.y) / (segment.end.x - segment.start.x)
            self.init(point: segment.start, slope: slope)
        }
        
        public func point(at distance: Double) -> Point {
            let r = sqrt(1 + pow(slope,2))
            return Point(x: point.x + distance / r, y: point.y + (distance * slope) / r)
        }
    }
}
