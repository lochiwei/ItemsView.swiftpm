// 2021.11.24 + conform  : 🌀CGPoint + 🅿️ Rectangular
// 2021.11.25 / fix      : rect.inscribedSquare
//            + property : rect.unitSquare (CGRect)
//            + conform  : 🌀UnitPoint + 🅿️ Rectangular
// 2022.02.09 + subscript: rect[unitPoint]

// ------------------------
//      🅿️ Rectangular
// ------------------------

import SwiftUI

// 🅿️ Rectangular
public protocol Rectangular {
    var origin: CGPoint { get }
    var size  : CGSize  { get }
}

// default behaviors
extension Rectangular {
    
    // MARK: - Bounds -
    
    /// the bounds (x-coordinates) of the range of width
    public var boundsX: (CGFloat, CGFloat) {
        let x1 = origin.x
        let x2 = x1 + size.width
        return (x1, x2)
    }
    
    /// the bounds (y-coordinates) of the range of height
    public var boundsY: (CGFloat, CGFloat) {
        let y1 = origin.y
        let y2 = y1 + size.height
        return (y1, y2)
    }
    
    // MARK: - Coordinates -
    
    /// lower bound (x-coordinate) of the width
    public var minX: CGFloat {
        return min(boundsX.0, boundsX.1)
    }
    
    /// upper bound (x-coordinate) of the width
    public var maxX: CGFloat {
        return max(boundsX.0, boundsX.1)
    }
    
    /// midpoint (x-coordinate) of the width
    public var midX: CGFloat {
        origin.x + size.width / 2
    }
    
    /// lower bound (y-coordinate) of the height
    public var minY: CGFloat {
        return min(boundsY.0, boundsY.1)
    }
    
    /// upper bound (y-coordinate) of the height
    public var maxY: CGFloat {
        return max(boundsY.0, boundsY.1)
    }
    
    /// midpoint (y-coordinate) of the height
    public var midY: CGFloat {
        origin.y + size.height / 2
    }
    
    // MARK: - Points -
    
    // rect.top, ...
    public var top        : CGPoint { CGPoint(x: midX, y: minY) }
    public var bottom     : CGPoint { CGPoint(x: midX, y: maxY) }
    public var left       : CGPoint { CGPoint(x: minX, y: midY) }
    public var right      : CGPoint { CGPoint(x: maxX, y: midY) }
    public var center     : CGPoint { CGPoint(x: midX, y: midY) }
    public var bottomLeft : CGPoint { CGPoint(x: minX, y: maxY) }
    public var bottomRight: CGPoint { CGPoint(x: maxX, y: maxY) }
    public var topLeft    : CGPoint { CGPoint(x: minX, y: minY) }
    public var topRight   : CGPoint { CGPoint(x: maxX, y: minY) }
    
    /// 4 corner points of a rect
    public var corners: [CGPoint] { [bottomLeft, bottomRight, topRight, topLeft] }
    
    /// a point relative to the rect
    /// ```
    /// rect[1,0] == rect.topRight
    /// rect[0,1] == rect.bottomLeft
    /// ```
    public subscript(_ s: CGFloat, _ t: CGFloat) -> CGPoint {
        let x = minX + s * abs(width)
        let y = minY + t * abs(height)
        return CGPoint(x: x, y: y)
    }
    
    /// a relative point in rect
    /// ```
    /// rect[unitPoint]
    /// ```
    public subscript(p: UnitPoint) -> CGPoint {
        self[p.x, p.y]
    }
    
    // MARK: - Dimensions -
    
    // ⚠️ abs() 的設定對已經有 width 屬性的類別應該無效❗️
    public var width  : CGFloat { abs(size.width)  }    
    public var height : CGFloat { abs(size.height) }
    public var minSide: CGFloat { min(abs(width), abs(height)) }
    public var maxSide: CGFloat { max(abs(width), abs(height)) }
    
    public var aspectRatio: CGFloat { abs(width/height) }
    
    // MARK: - Rect -
    
    /// unit square of conforming type
    public static var unitSquare: CGRect {
        CGRect(origin: [0.0, 0.0], size: [1.0, 1.0])
    }
    
    public var rect: CGRect {
        CGRect(origin: origin, size: size)
    }
    
    public var boundingSquare: CGRect {
        let d = maxSide / 2
        let x = midX - d
        let y = midY - d
        return CGRect(x: x, y: y, width: maxSide, height: maxSide)
    }
    
    public var inscribedSquare: CGRect {
        let d = minSide / 2
        let x = midX - d
        let y = midY - d
        return CGRect(x: x, y: y, width: minSide, height: minSide)
    }
    
}

// MARK: - Conforming Types -

// 🌀CGRect + 🅿️ Rectangular
extension CGRect: Rectangular { }

// 🌀GeometryProxy + Rectangular
@available(iOS 13, macOS 10.15, *)
extension GeometryProxy: Rectangular {
    public var origin: CGPoint { .zero }
}

// the following conforms to `Rectangular` automatically
// 🌀CGSize + 🅿️ Rectangular
// 🌀CGPoint + 🅿️ Rectangular
// 🌀UnitPoint + 🅿️ Rectangular
