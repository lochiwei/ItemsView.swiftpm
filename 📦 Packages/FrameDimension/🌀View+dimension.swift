// 2022.02.13

import SwiftUI

extension View {
    func dimension(
        //           ╭──👔 OptionSet──╮ 
        _ positions: DimensionPositions = [.bottom],   // ⭐️ 標示的位置
        arrow: Color = .secondary,                     // ⭐️ 箭頭顏色
        label: Color = .primary                        // ⭐️ 數字顏色
    ) -> some View 
    {
        overlay(alignment: .top) {
            // 👔 DimensionPositions
            if positions.contains(.top) {
                // 👔 WidthDimension
                WidthDimension(label: label, arrow: arrow).offset(y: -25)
            }
        }
        .overlay(alignment: .bottom){
            if positions.contains(.bottom){
                WidthDimension(label: label, arrow: arrow).offset(y: 25)
            }
        }
        .overlay {
            if positions.contains(.vcenter){
                WidthDimension(label: label, arrow: arrow)
            }
        }
        .overlay(alignment: .leading) {
            if positions.contains(.leading) {
                // 👔 HeightDimension
                HeightDimension(label: label, arrow: arrow).offset(x: -25)
            }
        }
        .overlay(alignment: .trailing) {
            if positions.contains(.trailing) {
                HeightDimension(label: label, arrow: arrow).offset(x: 25)
            }
        }
        .overlay {
            if positions.contains(.hcenter) {
                HeightDimension(label: label, arrow: arrow)
            }
        }
    }
}
