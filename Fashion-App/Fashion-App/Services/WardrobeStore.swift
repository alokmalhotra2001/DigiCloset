import SwiftUI

class WardrobeStore: ObservableObject {
    
    // === MY CLOSET === //
    @Published var clothes: [ClothingItem] = ClothingItem.previewData // starting state
    
    func addClothingItem(_ clothingItem: ClothingItem) { clothes.append(clothingItem) }
    func updateClothingItem(_ clothingItem: ClothingItem) {
        if let index = clothes.firstIndex(where: { $0.id == clothingItem.id }) {
            clothes[index] = clothingItem
        }
    }
    func deleteClothingItem(_ clothingItem: ClothingItem) {
        if let index = clothes.firstIndex(where: { $0.id == clothingItem.id }) {
            clothes.remove(at: index)
        }
    }
    
    func cleanAllClothes(){
        for index in (0 ..< clothes.count) {
            clothes[index].clean = true
        }
    }
    func getDirtyClothes() -> [ClothingItem] {
        return clothes.filter{ $0.clean == false }
    }
    
    func getCleanTops() -> [ClothingItem] { return clothes.filter{ $0.category == .top && $0.clean == true } }
    func getCleanBottoms() -> [ClothingItem] { return clothes.filter{ $0.category == .bottom && $0.clean == true } }
    
    
    // === NOTIFICATIONS === //
    @Published var notifications: [Notification] = Notification.previewData
    
    func addNotification(notif: Notification) {notifications.insert(notif, at:0)}
    
    func removeLastNotification() {
        notifications.remove(at: 0) }
    
    func getNotifications() -> [Notification] {
        return notifications.filter{ $0.completed == false }
    }
}
