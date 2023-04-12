// Notification.swift
// Written by Alexandra Rivera

import SwiftUI

struct Notification: Identifiable {
    let id: UUID = UUID()
    var top: ClothingItem
    var bottom: ClothingItem
}

extension Notification {
    static let previewData: [Notification] = [
        Notification(top: ClothingItem.previewData[7], bottom: ClothingItem.previewData[2])
    ]
}
