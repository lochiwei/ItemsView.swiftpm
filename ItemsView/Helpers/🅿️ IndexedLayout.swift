import SwiftUI

protocol IndexedLayout {
    // item view size
    var cellSize: CGSize { get }
    // item view's center point
    func cellCenter(at index: Int) -> CGPoint
}
