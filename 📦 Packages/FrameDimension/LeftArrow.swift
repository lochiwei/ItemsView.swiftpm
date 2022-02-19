import SwiftUI

struct LeftArrow: View {
    var color: Color = .secondary
    var body: some View {
        LeftArrowShape()                // LeftArrowShape
            .stroke(lineWidth: 1)
            .foregroundColor(color)
    }
}
