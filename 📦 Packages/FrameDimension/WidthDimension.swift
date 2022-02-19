import SwiftUI

struct WidthDimension: View {
    // view properties
    var label: Color = .primary
    var arrow: Color = .secondary
    // view body
    var body: some View {
        // ⭐️ 使用 GeometryReader 來讀取「寬度」
        GeometryReader { geo in 
            let width = geo.size.width
            HStack{
                // 👔 LeftArrow
                LeftArrow(color: arrow)
                // dimension
                Text("\(width, specifier: "%.0f")")   // ⭐️ no decimal places
                    .font(.system(size: 14)).bold()
                    .foregroundColor(label)
                    .fixedSize()                      // ⭐️ no wrap
                // 👔 LeftArrow
                LeftArrow(color: arrow)
                    .scaleEffect(-1, anchor: .center) // ⭐️ turn around
            }
        }.frame(height: 25)    // ⭐️⭐️⭐️ 這裡指定高度很重要❗️ 
    }                          // 不然 GeometryReader 會佔滿整個空間，
}                              // 造成外界使用 overlay 時對齊無效❗️
