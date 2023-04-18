import SwiftUI

class WardrobeStore: ObservableObject {
    
    // === MY CLOSET === //
    @Published var clothes: [ClothingItem] = ClothingItem.previewData // starting state
    @Published var clothes_dynamic: [ClothingItem] = ClothingItem.previewData // used in donate
    @Published var clothes_donate = [ClothingItem]()
    
    @Published var dictionaryTop: [String: ClothingItem] = [:]
    @Published var dictionaryBottoms: [String: ClothingItem] = [:]
    
//    @Published var dictionaryTop: [Date: ClothingItem] = [:]
//    @Published var dictionaryBottoms: [Date: ClothingItem] = [:]
    
  func addClothingItem(_ clothingItem: ClothingItem) { clothes.append(clothingItem) }
  
  func addDonate(_ clothingItem: ClothingItem) { clothes_donate.append(clothingItem) }
    
func dateToStringCal(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/YY"
    return dateFormatter.string(from: date)
}
  
  func removeDynamic(_ clothingItem: ClothingItem){
       if let index = clothes_dynamic.firstIndex(where: { $0.id == clothingItem.id }) {
         clothes_dynamic.remove(at: index)
       }
    }
    
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
    
    func getMostRecentNotif() -> String {
        if (!notifications.isEmpty) { return dateToString(date: notifications[0].timestamp) }
        return "NO NOTIFS"
    }
    
    // === TODAY === //
    @Published var todayTop: ClothingItem? = nil
    @Published var todayBottom: ClothingItem? = nil
    @Published var selectionConfirmed: Bool = false

    func confirmOutfitSelection(selectedTop: ClothingItem, selectedBottom: ClothingItem) {
        todayTop = selectedTop
        todayBottom = selectedBottom
        selectionConfirmed = true
    }
    
    func resetOutfitSelection() {
        todayTop = nil
        todayBottom = nil
        selectionConfirmed = false
    }
    
    func newDay() -> Bool {
        let dateMostRecent = getMostRecentNotif()
        if ( dateMostRecent != "NO NOTIFS" ) {
            if ( dateToString(date: Date.now) != dateMostRecent ) {
                // resetOutfitSelection()
                return true
            }
        }
        return false
    }
}
