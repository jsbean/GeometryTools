//
//  RectangleTests.swift
//  GeometryTools
//
//  Created by Brian Heim on 7/9/17.
//
//


import XCTest
import GeometryTools

class RectangleTests {

    func testNormalized() {
        let r = Rectangle(origin: Point(x: 0, y: 5), size: Size(width: -1, height: -2))
        let expected = Rectangle(origin: Point(x: -1, y: 3), size: Size(width: 1, height: 2))
        XCTAssertEqual(r, expected)
    }
}
