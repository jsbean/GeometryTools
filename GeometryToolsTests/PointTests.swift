//
//  PointTests.swift
//  GeometryTools
//
//  Created by James Bean on 6/9/17.
//
//

import XCTest
import GeometryTools

class PointTests: XCTestCase {
    
    func testDistanceTo() {
        let a = Point(x: 400, y: 600)
        let b = Point(x: 13, y: 31)
        XCTAssertEqual(a.distance(to: b), sqrt(pow(387,2) + pow(569,2)))
    }
    
    func testValueForAxis() {
        let point = Point(x: 25, y: 75)
        XCTAssertEqual(point[.horizontal], 25)
        XCTAssertEqual(point[.vertical], 75)
    }
    
    func testPointAddition() {
        let a = Point(x: 100, y: 10)
        let b = Point(x: 25, y: 30)
        XCTAssertEqual(a + b, Point(x: 125, y: 40))
    }
    
    func testPointSubtraction() {
        let a = Point(x: 100, y: 10)
        let b = Point(x: 25, y: 30)
        XCTAssertEqual(a - b, Point(x: 75, y: -20))
    }
    
    func testPointMultiply() {
        let point = Point(x: 200, y: 3)
        XCTAssertEqual(point * 3, Point(x: 600, y: 9))
        XCTAssertEqual(3 * point, Point(x: 600, y: 9))
    }
    
    func testPointDivision() {
        let point = Point(x: 200, y: 3)
        XCTAssertEqual(point / 2, Point(x: 100, y: 1.5))
    }
}
