import SwiftUI

struct ItemsView: View {
    
    @State private var size = CGSize(300, 300)   // proposed size
    
    @State private var rows = 0                  // current # of rows
    @State private var cols = 0                  // current # of cols
    @State private var ratio: CGFloat = 1        // current cell aspect ratio
    @State private var idealRatio: CGFloat = 1   // ideal cell aspect ratio
    
    let items = Array(1...20)
    
    var body: some View {
        VStack {
            ScrollView {
                itemsView   // view for layed out items
            }
            controls        // control size, cell ratio
        }
        .padding()
    }
}

extension ItemsView {
    
    /// a view with layed out item views
    var itemsView: some View {
        // layout item views
        items.itemsView { size in               // Array+ .itemsView()
            // ⭐ inject layout instance
            RatioRetainingLayout(               // RatioRetainingLayout
                idealRatio,
                count: items.count,
                in: size
            )
        } itemView: { i in
            // ⭐ inject view builder
            Color(hue: 0.8, saturation: 0.8, brightness: 0.5)
                .padding(1)
                .overlay {
                    Text("\(i)").shadow(radius: 2)
                }
        }
        // ⭐ get proposed size from parent
        .getSize { proposedSize in              // 🌀View+ .getSize()
            // ⭐ recompute layout
            let layout = RatioRetainingLayout(  // 👔 RatioRetainingLayout
                idealRatio,
                count: items.count,
                in: proposedSize
            )
            // ⭐ update view states
            rows = layout.rows
            cols = layout.cols
            ratio = layout.cellSize.aspectRatio // 🅿️ Vector2D: CGSize+ .aspectRatio
        }
        // ⭐ proposed size
        .frame(size)                            // 🌀View+ .frame(size), .dimension()
        .dimension(.topLeading, arrow: .blue, label: .orange)
        .padding(4)
        .shadowedBorder()                       // 🌀View+ .shadowedBorder()
        .padding(40)
    }
    
    /// sliders to control proposed size, ideal ratio
    var controls: some View {
        SizeRatioControl(                       // 👔 SizeRatioControl
            size: $size,
            rows: $rows,
            cols: $cols,
            idealRatio: $idealRatio,
            ratio: $ratio
        )
    }
}

struct LayoutItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
            .preferredColorScheme(.dark)
    }
}
