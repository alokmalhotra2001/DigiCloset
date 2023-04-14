import SwiftUI

class WardrobeStore: ObservableObject {
    
    @Published var clothes: [ClothingItem] = ClothingItem.previewData // starting state
    @Published var clothes_to_donate: [ClothingItem] = ClothingItem.previewData // starting state
    @Published var keep: [ClothingItem] = ClothingItem.previewData // starting state
    
    func addClothingItem(_ clothingItem: ClothingItem) { clothes.append(clothingItem) }
  
   // func addFinDonate(_ clothingItem: ClothingItem) { finalized_donate.append(clothingItem) }
  
  func remKeep(_ clothingItem: ClothingItem){
       if let index = keep.firstIndex(where: { $0.id == clothingItem.id }) {
          keep.remove(at: index)
       }
    }
  
  func removeToDonate(_ clothingItem: ClothingItem){
       if let index = clothes_to_donate.firstIndex(where: { $0.id == clothingItem.id }) {
          clothes_to_donate.remove(at: index)
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
