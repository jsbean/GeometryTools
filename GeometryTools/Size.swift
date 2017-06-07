//
//  Size.swift
//  PathTools
//
//  Created by James Bean on 6/3/17.
//
//

/// Model of rectangular size.
public struct Size {
    
    // MARK: - Instance Properties
    
    /// Width.
    public let width: Double
    
    /// Height.
    public let height: Double
    
    // MARK: - Initializers
    
    /// Creates a `Size` with the given `width` and `height`.
    public init(width: Double = 0, height: Double = 0) {
        self.width = width
        self.height = height
    }
}

extension Size: Equatable {
    
    // MARK: - Equatable
    
    /// - Returns: `true` if both `Size` values are equivalent. Otherwise, `false`.
    public static func == (lhs: Size, rhs: Size) -> Bool {
        return lhs.width == rhs.width && lhs.height == rhs.height
    }
}
