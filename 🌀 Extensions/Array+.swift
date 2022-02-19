// 2022.02.15

// 🌀Array + .index(of:)
extension Array where Element: Identifiable {
    /// find index of element in array.
    /// (available when `Element` comforms to `Identifiable`)
    /// ```
    /// array.index(of: element)    // could be nil
    /// ```
    public func index(of element: Element) -> Int? {
        for i in 0..<count {
            if self[i].id == element.id { return i }
        }
        return nil
    }
}
