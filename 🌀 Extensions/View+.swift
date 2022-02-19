

import SwiftUI

// 2022.02.09
extension View {
    /// usage: `view.offset(cgPoint)`
    public func offset(_ point: CGPoint) -> some View {
        offset(x: point.x, y: point.y)
    }
}

// 2022.02.14
extension View {
    /// ⭐️ a border with shadow
    /// ```
    /// view.shadowedBorder()
    /// view.shadowedBorder(.blue)
    /// ```
    func shadowedBorder(_ color: Color = .primary) -> some View {
        overlay {
            Rectangle()
                .stroke(color, lineWidth: 4)
                .shadow(radius: 4)
        }
    }
}

// 2022.02.14
extension View {
    /// `view.frame(size)`
    func frame(_ size: CGSize) -> some View {
        frame(width: size.width, height: size.height)
    }
    /// `view.frame(cgfloat)`
    func frame(_ size: CGFloat) -> some View {
        frame(width: size, height: size)
    }
}


// 2022.02.18
extension View {
    /// get view's size and do something with it.
    /// ```
    /// view.getSize { size in ... }
    /// ```
    func getSize(action: @escaping (CGSize) -> Void) -> some View {
        background(GeometryReader{ geo in
            emptyView(size: geo.size, action: action)
        })
    }
    
    // private empty view
    private func emptyView(
        size  : CGSize, 
        action: @escaping (CGSize) -> Void
    ) -> some View {
        action(size)        // ⭐️ side effect❗️
        return EmptyView()
    }
}
