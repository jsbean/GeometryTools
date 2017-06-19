//
//  Line.swift
//  PathTools
//
//  Created by James Bean on 6/6/17.
//
//

import Darwin
import Collections
import ArithmeticTools

/// Model of line.
public enum Line {

    case vertical(Double)
    case horizontal(Double)
    case slanted(slope: Double, intercept: Double)
    
    public init(slope: Double, intercept: Double) {
        self = .slanted(slope: slope, intercept: intercept)
    }
    
    public func y(x: Double) -> Double {
        switch self {
        case .vertical:
            return Double.nan
        case .horizontal(let y):
            return y
        case let .slanted(slope, intercept):
            return slope == .infinity ? x : slope * x + intercept
        }   
    }
}
