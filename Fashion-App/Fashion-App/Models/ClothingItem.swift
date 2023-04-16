import SwiftUI
import PhotosUI
import UIKit

struct ClothingItem: Identifiable {
    let id: UUID = UUID()
    var name: String
    var tempRange: ClosedRange<Int>
    var category: Category
    var img: Image
    var clean: Bool
    var lastWornOn: Date? = nil
}

enum Category: String, CaseIterable, Identifiable {
    var id: Self { self }
    case top
    case bottom
    case other
}

// Inclusive
func getAllInCategory(cat: Category, clothes: [ClothingItem]) -> [ClothingItem] {
    return clothes.filter{ $0.category == cat }
}

// Inclusive
func getAllAboveMinTemp(min: Int, clothes: [ClothingItem]) -> [ClothingItem] {
    return clothes.filter{ $0.tempRange.lowerBound >= min }
}

// Inclusive
func getAllBelowMaxTemp(max: Int, clothes: [ClothingItem]) -> [ClothingItem] {
    return clothes.filter{ $0.tempRange.upperBound <= max }
}

// Inclusive
func getAllInTempRange(min: Int, max: Int, clothes: [ClothingItem]) -> [ClothingItem] {
    return clothes.filter{ $0.tempRange.lowerBound >= min && $0.tempRange.upperBound >= max }
}

func printClothingItemInfo(item: ClothingItem) {
    print(item.name)
    print(item.tempRange.lowerBound)
    print(item.tempRange.upperBound)
    print(item.category.rawValue)
}

func sortByTempDiff(i1: ClothingItem, i2: ClothingItem, currWeather: CurrentWeather) -> Bool {
    let currTemp = currWeather.data.temp
    let i1LBD = abs(Double(i1.tempRange.lowerBound) - currTemp)
    let i1UPD = abs(Double(i1.tempRange.upperBound) - currTemp)
    let i2LBD = abs(Double(i2.tempRange.lowerBound) - currTemp)
    let i2UPD = abs(Double(i2.tempRange.upperBound) - currTemp)
    return (i1LBD + i1UPD <= i2LBD + i2UPD)
}

func dateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/YY"
    return dateFormatter.string(from: date)
}

extension ClothingItem {
    struct FormData {
        var name: String = ""
        var tempRange: ClosedRange<Int> = 40...80
        var category: Category = .top
        var img: Image = Image(systemName: "photo")
    }
    
    var dataForForm: FormData {
        FormData(name: name, tempRange: tempRange, category: category, img: img)
    }
    
    static func create(from formData: FormData) -> ClothingItem {
        let clothingItem = ClothingItem(name: formData.name, tempRange: formData.tempRange,
                                        category: formData.category, img: formData.img, clean: true)
        return ClothingItem.update(clothingItem, from: formData)
    }
    
    static func update(_ clothingItem: ClothingItem, from formData: FormData) -> ClothingItem {
        var clothingItem = clothingItem
        clothingItem.name = formData.name
        clothingItem.tempRange = formData.tempRange.lowerBound...formData.tempRange.upperBound
        clothingItem.category = formData.category
        clothingItem.img = formData.img
        return clothingItem
    }
}

extension ClothingItem {
    static let previewData: [ClothingItem] = [
        ClothingItem(name: "Alok's Favorite Shirt", tempRange: 50...80,
                     category: .top, img: Image("alokshirt"), clean: true, lastWornOn: Date(timeIntervalSinceNow: -345600)),
        ClothingItem(name: "Alok's Favorite Shorts", tempRange: 40...60,
                     category: .bottom, img: Image("alokshorts"), clean: true, lastWornOn: Date(timeIntervalSinceNow: -345600)),
        ClothingItem(name: "Alexandra's Favorite Skirt", tempRange: 70...80,
                     category: .bottom, img: Image("alexandraskirt"), clean: false, lastWornOn: Date(timeIntervalSinceNow: -172800)),
        ClothingItem(name: "Alexandra's Favorite Sweater", tempRange: 40...50,
                     category: .top, img: Image("alexandrasweater"), clean: true),
        ClothingItem(name: "Aarzu's Favorite Jeans", tempRange: 40...60,
                     category: .bottom, img: Image("aarzujeans"), clean: true),
        ClothingItem(name: "Aarzu's Favorite Jacket", tempRange: 40...60,
                     category: .top, img: Image("aarzujacket"), clean: true),
        ClothingItem(name: "Deeya's Favorite Cargo Pants", tempRange: 30...40,
                     category: .bottom, img: Image("deeyacargopants"), clean: true, lastWornOn: Date(timeIntervalSinceNow: -691200)),
        ClothingItem(name: "Deeya's Favorite Crop Top", tempRange: 30...40,
                     category: .top, img: Image("deeyacroptop"), clean: false, lastWornOn: Date(timeIntervalSinceNow: -172800))
    ]
}
