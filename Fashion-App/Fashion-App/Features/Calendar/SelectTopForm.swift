import SwiftUI
import CoreLocation

struct SelectTopForm: View {
    let forecastSummary: [ForecastSummary]
    var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @EnvironmentObject var wardrobeStore: WardrobeStore
    @Binding var selectedDate: Date
    
    var body: some View {
        ScrollView {
            Text("Select Top for \(selectedDate.formatted(.dateTime.day().month(.wide)))")
                .padding()
                .font(.system(size: 23))
                .bold()
            
            ForecastBox(forecastSummary: forecastSummary, selectedDate: $selectedDate)
            
            LazyVGrid(columns: threeColumnGrid) {
                ForEach($wardrobeStore.clothes
                    .filter({ $0.category
                        .wrappedValue == .top})) { $clothingItem in
                            SelectTopCell(clothingItem: $clothingItem, selectedDate: $selectedDate)
                }
            }
       }
    }
}

struct SelectTopCell: View {
    @Binding var clothingItem: ClothingItem
    @EnvironmentObject var wardrobeStore: WardrobeStore
    @Binding var selectedDate: Date
    
    var body: some View {
            VStack {
                Button {
                    wardrobeStore.dictionaryTop[selectedDate] = clothingItem
                } label: {
                    clothingItem.img
                        .resizable()
                        .scaledToFit()
                }
            }
        
        Spacer()
    }
}
