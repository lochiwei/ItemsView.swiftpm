// 2022.02.13 

import SwiftUI

//import Vector2D                        // ⭐️ support vector operations

struct LeftArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { p in
            let k: CGFloat = 5           // arrowhead scale
            let A = rect.left + [2,0]    // arrowhead point
            p.line(A, A + k * [1, -1])   // Vector2D, 🌀 Path+ .line()
            p.line(A, A + k * [1,  1])
            p.line(A, rect.right)
        }
    }
}
