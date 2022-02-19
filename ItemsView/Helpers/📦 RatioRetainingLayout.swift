import SwiftUI

// 根據項目數量、proposed size、與希望的 cell 比例，計算最佳的列數、行數。
// 如果切割出來的格子，其長寬比最接近使用者指定的比例，則為最佳排版方式。

/// help to compute layout informations for item views that
/// will try to maintain their aspect ratio.
/// ```
/// RatioRetainingLayout(itemCount: n, in: size, cellAspectRatio: r)
/// ```
struct RatioRetainingLayout: IndexedLayout {
    
    // ⭐ proposed size
    let size: CGSize
    
    // ⭐ best layout in rows x cols
    //   (to be calculated in `init`, with all available space taken)
    private(set) var rows: Int = 0   
    private(set) var cols: Int = 0
    
    init(
        _ idealCellAspectRatio: CGFloat = 1,   // ideal cell aspect ratio
        count n: Int,           // item count
        in size: CGSize         // proposed size
    ) {
        
        self.size = size
        
        // if zero width or height or itemCount is not > 0,
        // do nothing.
        guard 
            size.width > 0, size.height > 0, n > 0 
        else { return }
        
        // ⭐ find the bestLayout
        // -----------------------
        //    which results in cells whose `aspectRatio`
        //    has the `smallestVariance` from `idealAspectRatio`
        var bestLayout: (rows: Int, cols: Int) = (1, n)    // start from 1 row
        var smallestVariance: CGFloat?
        
        // start to find best layout from 1 column
        for cols in 1...n {
            
            // ⭐ calculate how many columns we need
            let rows = (n / cols) + (n % cols > 0 ? 1 : 0)
            
            // cellAspectRatio = (cell width) / (cell height)
            //                 = (width/cols) / (height/rows)
            //                 = (width/height) / (cols/rows)
            //                 = size.aspectRatio * rows/cols
            // -----------------------------------------------------------
            // ⭐️ rows: ↘ (decreasing)
            //    cols: ↗︎ (strictly increasing) 
            //    ⇒ cellAspectRatio: ↘ (strictly decreasing)
            // -----------------------------------------------------------
            // 🅿️ Vector2D (🌀CGSize + .aspectRatio)
            // 🌀CGFloat * Int (custom operator)
            let cellAspectRatio = size.aspectRatio * rows / cols
            
            // current variance with ideal aspect ratio
            let variance = self.variance(cellAspectRatio, idealCellAspectRatio)
            
            // ⭐️ if `smallestVariance` not set, or `variance` getting smaller,
            //    set new `smallestVariance` and new bestLayout
            if smallestVariance == nil || variance < smallestVariance! {
                smallestVariance = variance
                bestLayout = (rows: rows, cols: cols)
            } else { 
                // ⭐️ `smallVariance` is set, and `variance` is getting larger,
                //     break for loop
                break  
            }
        }
        
        // save best layout found
        self.rows = bestLayout.rows
        self.cols = bestLayout.cols
    }
}

extension RatioRetainingLayout {
    
    /// cell size
    public var cellSize: CGSize {
        (rows == 0 || cols == 0) 
        ? .zero 
        // 🅿️ Vector2D (🌀CGSize(w,h)), CGFloat / Int
        : CGSize(size.width  / cols, size.height / rows)
    }
    
    /// center point of cell at index `i`
    public func cellCenter(at i: Int) -> CGPoint {
        let rowIndex = i / cols
        let colIndex = i % cols
        return (rows == 0 || cols == 0) 
        ? .zero 
        // 🅿️ Vector2D, CGFloat + Int
        : cellSize.point ** [0.5 + colIndex, 0.5 + rowIndex]
    }
    
    /// variance between two aspect ratios
    func variance(_ r1: CGFloat, _ r2: CGFloat) -> CGFloat {
        precondition(r1 > 0 && r2 > 0)
        // ⭐️ 做對數計算，才不會造成 1:3 = 0.33 的比例
        //    比 2:1 = 2 的比例更接近 1:1 = 1
        return abs(log(r1) - log(r2))
    }
}
