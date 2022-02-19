//
//  SwiftUIView.swift
//  
//
//  Created by CHI-WEI LO on 2022/2/19.
//

import SwiftUI

struct SizeRatioControl: View {
    
    @Binding var size: CGSize               // proposed size
    @Binding var rows: Int                  // current # of cell rows
    @Binding var cols: Int                  // current # of cell cols
    @Binding var idealRatio: CGFloat        // ideal cell aspect ratio
    @Binding var ratio: CGFloat             // current cell aspect ratio
    
    var body: some View {
        VStack {
            Text("Cells try to maintain their aspect ratio.")
                .font(.title3)
            Group {
                Text("ideal cell aspect ratio = \(idealRatio.decimalPlaces(2))")
                    .foregroundColor(.secondary)
                VStack {
                    Text("current cell aspect ratio = \(ratio.decimalPlaces(2))")
                    Text("rows: \(rows), cols: \(cols)")
                }
                .padding(4)
                .border(.red)
                .overlay {
                    Image(systemName: "line.diagonal.arrow")
                        .font(.system(size: 40))
                        .foregroundColor(.red)
                        .rotationEffect(.degrees(-45))
                        .scaleEffect(y: 1.5, anchor: .top)
//                        .border(.blue)
                        .overlay {
                            Text("Not updated in the built app")
                                .font(.title3)
                                .bold()
//                                .fixedSize()
//                                .border(.blue)
                                .foregroundColor(.red)
                                .frame(width: 180, height: 120)
                                .offset(x: -70, y: 80)
                        }
                        .offset(y: 50)
                        
                }
            }
            .font(.caption)
//            .foregroundColor(.secondary)
            
            HStack(alignment: .top, spacing: 40) {
                // control ideal cell aspect ratio
                SliderWithSubtitle(
                    value: $idealRatio,
                    range: 0.3...3, step: 0.01,
                    subtitle: "ideal ratio",
                    decimalPlaces: 2,
                    tint: .green
                )
                // control proposed size
                SlidersForSize($size)
            }
            
        }
        .padding()
    }
}

struct RatioControl_Previews: PreviewProvider {
    static var previews: some View {
        SizeRatioControl(size: .constant(CGSize(x: 300, y: 200)), rows: .constant(4), cols: .constant(3), idealRatio: .constant(1), ratio: .constant(0.8))
            .preferredColorScheme(.dark)
    }
}
