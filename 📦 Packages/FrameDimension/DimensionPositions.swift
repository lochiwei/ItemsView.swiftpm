// 2022.02.13

struct DimensionPositions: OptionSet {
    
    let rawValue: Int
    
    // ⭐️ unit sets (containing only one element)
    static let leading  = DimensionPositions(rawValue: 1 << 0)
    static let trailing = DimensionPositions(rawValue: 1 << 1)
    static let top      = DimensionPositions(rawValue: 1 << 2)
    static let bottom   = DimensionPositions(rawValue: 1 << 3)
    static let vcenter  = DimensionPositions(rawValue: 1 << 4)
    static let hcenter  = DimensionPositions(rawValue: 1 << 5)
    
    // ⭐️ useful sets (containing multiple elements)
    // ⭐️ can be initialized by array literal (ExpressibleByArrayLiteral)
    static let topLeading    : DimensionPositions = [.top, .leading]
    static let topTrailing   : DimensionPositions = [.top, .trailing]
    static let bottomLeading : DimensionPositions = [.bottom, .leading]
    static let bottomTrailing: DimensionPositions = [.bottom, .trailing]
    
    static let all: DimensionPositions = [.leading, .trailing, .top, .bottom]
}
