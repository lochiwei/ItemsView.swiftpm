import SwiftUI

struct HeightDimension: View {
    // view properties
    var label: Color = .primary
    var arrow: Color = .secondary
    // view body
    var body: some View {
        GeometryReader { geo in 
            // ⭐️ interchange width/height
            let w = geo.size.height
            let h = geo.size.width
            // ⭐️ use WidthDimension & rotate it
            WidthDimension(label: label, arrow: arrow)
            // interchange width/height (⭐️ origin unchanged)
                .frame(width: w, height: h)
            // ⭐️ rotate 90 degrees
                .rotationEffect(.degrees(90), anchor: .zero)
            // ⭐️ move it to where it should be
                .offset(x: h)
        }.frame(width: 25)    // ⭐️⭐️⭐️ 這裡指定「寬度」很重要❗️
    }
}
