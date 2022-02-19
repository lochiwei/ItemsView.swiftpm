// 2022.02.15 (+) : operators +, -

import SwiftUI

/// `cgFloat + int`
public func + (a: CGFloat, n: Int) -> CGFloat {
    a + CGFloat(n)
}

/// `cgFloat - int`
public func - (a: CGFloat, n: Int) -> CGFloat {
    a - CGFloat(n)
}

/// `cgFloat * int`
public func * (a: CGFloat, n: Int) -> CGFloat {
    a * CGFloat(n)
}

/// `cgFloat / int`
public func / (a: CGFloat, n: Int) -> CGFloat {
    a / CGFloat(n)
}
