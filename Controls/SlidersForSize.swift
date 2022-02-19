// 2022.02.15
// 2022.02.17 (+) struct: SliderWithSubtitle
//            (f) bug   : step can be < 1

import SwiftUI

// ┌──────────────────────────┐
// │    SliderWithSubtitle    │
// └──────────────────────────┘

/// slider with subtitle below it.
/// ```
/// SliderWithSubtitle(
///    value   : $size.width, 
///    subtitle: "width"
/// )
/// 
/// // with all parameters
/// SliderWithSubtitle(
///    value   : $size.height, 
///    range   : 100...300,
///    subtitle: "height", 
///    tint    : .blue
/// )
struct SliderWithSubtitle: View {
    
    // ⭐️ Binding variable
    @Binding var value: CGFloat
    var range: ClosedRange<CGFloat> = 20...500
    var step: CGFloat = 1
    let subtitle: String
    var decimalPlaces = 0
    var tint: Color = .pink
    
    var body: some View {
        VStack {
            // 🎛 `Slider` to control the `value`
            Slider(value: $value, in: range, step: step)
                .tint(tint)
            // subtitle for slider
            Text("\(subtitle): \(value.decimalPlaces(decimalPlaces))")
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(.secondary)
        }
    }
}

// ┌──────────────────────┐
// │    SlidersForSize    │
// └──────────────────────┘

/// 🎛 sliders to control width/height
/// ```
/// SlidersForSize($size)
/// ```
struct SlidersForSize: View {
    
    // ⭐️ Binding variable
    @Binding var size: CGSize
    
    var body: some View {
        VStack(spacing: 20) {
            // 🎛 Slider: control offered width
            SliderWithSubtitle(
                value   : $size.width,
                range   : 50...300,
                subtitle: "width"
            )
            // 🎛 Slider: control offered height
            SliderWithSubtitle(
                value   : $size.height, 
                range   : 100...500,
                subtitle: "height", 
                tint    : .blue
            )
        }
    }
}

// convenience init
extension SlidersForSize {
    /// convenience init.
    /// ```
    /// SlidersForSize($size)
    /// ```
    init(_ size: Binding<CGSize>) {
        // ⭐️ 注意：不是 `self.size = size` ❗️❗️❗️
        self._size = size
    }
}

// ┌────────────────┐
// │    Previews    │
// └────────────────┘

struct SlidersForSize_Previews: PreviewProvider {
    static var previews: some View {
        SlidersForSize(size: .constant(.init(300,200)))
    }
}
