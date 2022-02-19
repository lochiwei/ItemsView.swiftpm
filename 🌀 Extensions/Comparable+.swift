// 2022.02.13 + (method) .clamped(in: 5...), .clamped(in: ...8)

// 🌀 Comparable + .clamped(in:)
extension Comparable {
    
    /// ⭐️ clamp a `Comparable` in a `ClosedRange` (lowerBound...upperBound).
    /// ```
    /// 3.clamped(in: 5...8)  // 5
    /// 6.clamped(in: 5...8)  // 6
    /// 9.clamped(in: 5...8)  // 8
    /// ```
    public func clamped(in range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
    
    /// ⭐️ clamp a `Comparable` in a `PartialRangeFrom` (lowerBound...).
    /// ```
    /// 3.clamped(in: 5...)        // 5
    /// 6.clamped(in: 5...)        // 6
    /// 9.clamped(in: 5...)        // 9
    /// Int.min.clamped(in: 5...)  // 5
    /// Int.max.clamped(in: 5...)  // 9223372036854775807
    /// ```
    public func clamped(in range: PartialRangeFrom<Self>) -> Self {
        range.contains(self) ? self : range.lowerBound
    }
    
    /// ⭐️ clamp a `Comparable` in a `PartialRangeThrough` (...upperBound).
    /// ```
    /// 3.clamped(in: ...8)        // 3
    /// 6.clamped(in: ...8)        // 6
    /// 9.clamped(in: ...8)        // 8
    /// Int.min.clamped(in: ...8)  // -9223372036854775808
    /// Int.max.clamped(in: ...8)  // 8
    /// ```
    public func clamped(in range: PartialRangeThrough<Self>) -> Self {
        range.contains(self) ? self : range.upperBound
    }
}
