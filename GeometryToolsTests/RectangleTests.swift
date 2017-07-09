//
//  RectangleTests.swift
//  GeometryTools
//
//  Created by Brian Heim on 7/9/17.
//
//


import XCTest
import GeometryTools

class RectangleTests: XCTestCase {

    func testNormalizedIdentity() {
        let r = Rectangle(origin: Point(x: 0, y: 5), size: Size(width: 1, height: 2))
        let expected = r
        XCTAssertEqual(r.normalized, expected)
    }

    func testNormalizedFlipX() {
        let r = Rectangle(origin: Point(x: 0, y: 5), size: Size(width: -1, height: 2))
        let expected = Rectangle(origin: Point(x: -1, y: 5), size: Size(width: 1, height: 2))
        XCTAssertEqual(r.normalized, expected)
    }

    func testNormalizedFlipY() {
        let r = Rectangle(origin: Point(x: 0, y: 5), size: Size(width: 1, height: -2))
        let expected = Rectangle(origin: Point(x: 0, y: 3), size: Size(width: 1, height: 2))
        XCTAssertEqual(r.normalized, expected)
    }

    func testNormalizedFlipXAndY() {
        let r = Rectangle(origin: Point(x: 0, y: 5), size: Size(width: -1, height: -2))
        let expected = Rectangle(origin: Point(x: -1, y: 3), size: Size(width: 1, height: 2))
        XCTAssertEqual(r.normalized, expected)
    }

}
