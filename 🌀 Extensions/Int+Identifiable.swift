// ⭐️ required when [Int] wants to use `.itemsView()` method
//    defined in 🌀Array+itemsView.swift
extension Int: Identifiable {
    public var id: Int { self }
}
