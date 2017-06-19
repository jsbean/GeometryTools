//
//  LineTests.swift
//  PathTools
//
//  Created by James Bean on 6/6/17.
//
//

import XCTest
import GeometryTools

class LineTests: XCTestCase {
    
    func testLineLengthHorizontal() {
        let line = Line.Segment(start: Point(), end: Point(x: 1, y: 0))
        XCTAssertEqual(line.length, 1)
    }
    
    func testLineLengthVertical() {
        let line = Line.Segment(start: Point(), end: Point(x: 0, y: 1))
        XCTAssertEqual(line.length, 1)
    }
    
    func testLineLengthPositiveDiagonal() {
        let line = Line.Segment(start: Point(), end: Point(x: 1, y: -1))
        XCTAssertEqual(line.length, sqrt(2))
    }
    
    func testHorizontalLinePerpendicular() {
        let line = Line.horizontal(5)
        let point = Point(x: 100, y: 100)
        let result = line.perpendicular(containing: point)
        let expected = Line.vertical(100)
        XCTAssertEqual(result, expected)
    }
    
    func testVerticalLinePerpendicular() {
        let line = Line.vertical(5)
        let point = Point(x: 100, y: 100)
        let result = line.perpendicular(containing: point)
        let expected = Line.horizontal(100)
        XCTAssertEqual(result, expected)
    }
    
    func testSlantedLinePerpendicular() {
        let line = Line(slope: 2, intercept: 1)
        let point = Point(x: 0, y: 1)
        let result = line.perpendicular(containing: point)
        let expected = Line(slope: -1/2, intercept: 1)
        XCTAssertEqual(result, expected)
    }
}
