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

    public func scaled(by value: Double) -> Size {
        return Size(width: width * value, height: height * value)
    }
}

extension Size: Equatable {

    // MARK: - Equatable

    /// - Returns: `true` if both `Size` values are equivalent. Otherwise, `false`.
    public static func == (lhs: Size, rhs: Size) -> Bool {
        return lhs.width == rhs.width && lhs.height == rhs.height
    }
}

/// - Returns: `Size` scaled by the given right-hand-side value.
public func * (lhs: Size, rhs: Double) -> Size {
    return Size(width: lhs.width * rhs, height: lhs.height * rhs)
}

/// - Returns: `Size` scaled by the given left-hand-side value.
public func * (lhs: Double, rhs: Size) -> Size {
    return Size(width: rhs.width * lhs, height: rhs.height * lhs)
}
