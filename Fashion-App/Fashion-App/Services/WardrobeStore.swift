import SwiftUI

class WardrobeStore: ObservableObject {
    
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
}