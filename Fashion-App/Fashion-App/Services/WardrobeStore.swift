import SwiftUI

class WardrobeStore: ObservableObject {
    
    @Published var clothes: [ClothingItem] = ClothingItem.previewData // starting state
    @Published var clothes_dynamic: [ClothingItem] = ClothingItem.previewData // used in donate
    @Published var clothes_donate = [ClothingItem]()
    
  func addClothingItem(_ clothingItem: ClothingItem) { clothes.append(clothingItem) }
  
  func addDonate(_ clothingItem: ClothingItem) { clothes_donate.append(clothingItem) }
  
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
}
