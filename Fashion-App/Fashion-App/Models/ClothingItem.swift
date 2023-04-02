import UIKit

struct ClothingItem: Identifiable {
    let id: UUID = UUID()
    var name: String
    var minTemp: Int
    var maxTemp: Int
    var category: Category
    // var imgURL: URL
}

enum Category: String, CaseIterable, Identifiable {
    var id: Self { self }
    case top
    case bottom
}

// Inclusive
func getAllInCategory(cat: Category, clothes: [ClothingItem]) -> [ClothingItem] {
    return clothes.filter{ $0.category == cat }
}

// Inclusive
func getAllAboveMinTemp(min: Int, clothes: [ClothingItem]) -> [ClothingItem] {
    return clothes.filter{ $0.minTemp >= min }
}

// Inclusive
func getAllBelowMaxTemp(max: Int, clothes: [ClothingItem]) -> [ClothingItem] {
    return clothes.filter{ $0.maxTemp <= max }
}

// Inclusive
func getAllInTempRange(min: Int, max: Int, clothes: [ClothingItem]) -> [ClothingItem] {
    return clothes.filter{ $0.minTemp >= min && $0.maxTemp >= max }
}

func printClothingItemInfo(item: ClothingItem) {
    print(item.name)
    print(item.minTemp)
    print(item.maxTemp)
    print(item.category.rawValue)
}

extension ClothingItem {
    struct FormData {
        var name: String = ""
        var minTemp: Int = 0
        var maxTemp: Int = 100
        var category: Category = .top
        // var imgURL: String = ""
    }
    
    var dataForForm: FormData {
        FormData(name: name, minTemp: minTemp, maxTemp: maxTemp, category: category)
    }
    
    static func create(from formData: FormData) -> ClothingItem {
        let clothingItem = ClothingItem(name: formData.name, minTemp: formData.minTemp,
                                        maxTemp: formData.maxTemp, category: formData.category)
        return ClothingItem.update(clothingItem, from: formData)
    }
    
    static func update(_ clothingItem: ClothingItem, from formData: FormData) -> ClothingItem {
        var clothingItem = clothingItem
        clothingItem.name = formData.name
        clothingItem.minTemp = formData.minTemp
        clothingItem.maxTemp = formData.maxTemp
        clothingItem.category = formData.category
        return clothingItem
    }
}

extension ClothingItem {
    static let previewData: [ClothingItem] = [
        ClothingItem(name: "Alok's Favorite Shirt", minTemp: 10, maxTemp: 90, category: .top),
        ClothingItem(name: "Alok's Favorite Shorts", minTemp: 20, maxTemp: 80, category: .bottom)
    ]
}
