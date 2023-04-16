// Notification.swift
// Written by Alexandra Rivera

import SwiftUI

struct Notification: Identifiable {
    let id: UUID = UUID()
    var top: ClothingItem
    var bottom: ClothingItem
    var timestamp: Date
    var topInDirtyBin = false
    var bottomInDirtyBin = false
    var completed: Bool = false
}

extension Notification {
    struct FormData {
        var topInDirtyBin: Bool = false
        var bottomInDirtyBin: Bool = false
    }
    
    var dataForForm: FormData {
        FormData(topInDirtyBin: topInDirtyBin, bottomInDirtyBin: bottomInDirtyBin)
    }
    
    static func updateTop(_ top: ClothingItem, from formData: FormData) -> ClothingItem {
        var top = top
        top.clean = !formData.topInDirtyBin
        return top
    }
    
    static func updateBottom(_ bottom: ClothingItem, from formData: FormData) -> ClothingItem {
        var bottom = bottom
        bottom.clean = !formData.bottomInDirtyBin
        return bottom
    }
}

extension Notification {
    static let previewData: [Notification] = [
        Notification(top: ClothingItem.previewData[3], bottom: ClothingItem.previewData[4], timestamp: Date(timeIntervalSinceNow: -86400), completed: false),
        Notification(top: ClothingItem.previewData[7], bottom: ClothingItem.previewData[2], timestamp: Date(timeIntervalSinceNow: -172800), completed: true)
    ]
}
