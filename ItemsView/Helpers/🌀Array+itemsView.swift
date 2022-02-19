// 2022.02.19 (*) .itemsView()

import SwiftUI

extension Array where Element: Identifiable 
{
    /// help to layout views in `.itemsView()` method.
    /// ```
    /// layoutItems(with: layout, itemView: itemView) 
    /// ```
    private func layoutItems<L: IndexedLayout, ItemView: View>(
        with layout: L, 
        @ViewBuilder itemView: @escaping (Element) -> ItemView
    ) -> some View
    {
        ForEach(self) { item in
            let i = self.index(of: item)!    // Array+ .index(of:)
            let size = layout.cellSize       // IndexedLayout
            itemView(item)
                .frame(width: size.width, height: size.height)
                .position(layout.cellCenter(at: i))
        }
    }
    
    /// layout item views in the offered size
    /// ```
    /// items.itemsView { size in
    ///     // inject layout instance
    /// } itemView: { i in
    ///     // inject view builder
    /// }
    /// ```
    func itemsView<L: IndexedLayout, ItemView: View>(
        // inject layout
        layout: @escaping (CGSize) -> L,
        // inject view builder
        @ViewBuilder itemView: @escaping (Element) -> ItemView
    ) -> some View {
        GeometryReader { geo in
            let layout = layout(geo.size)    // layout instance
            layoutItems(with: layout, itemView: itemView)
        }
    }
}
