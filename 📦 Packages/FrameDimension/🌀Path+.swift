// 2022.02.10

import SwiftUI

extension Path {
    /// draw a line from A to B.
    /// ```
    /// path.line(A, B)
    /// ```
    mutating public func line(_ A: CGPoint, _ B: CGPoint) {
        move(to: A)
        addLine(to: B)
    }
}
