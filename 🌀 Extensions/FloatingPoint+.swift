import Foundation        // for NSString: String(format:)

// 2022.02.15
extension FloatingPoint where Self: CVarArg {
    /// show a floating-point number to specified decimal places.
    /// ```
    /// (1.2345).decimalPlaces(3)  // "1.234"
    /// (1.2).decimalPlaces(3)     // "1.200"
    /// ```
    public func decimalPlaces(_ n: Int) -> String {
        return String(format: "%.\(n)f", self)
    }
}
