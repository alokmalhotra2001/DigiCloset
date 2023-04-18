import SwiftUI

struct SelectBottomForm: View {
    let forecastSummary: [ForecastSummary]
    var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @EnvironmentObject var wardrobeStore: WardrobeStore
    @Binding var selectedDate: Date
    
    var body: some View {
        
        ScrollView{
            //Display Selected Day and Daate
            Text("Select Bottoms for \(selectedDate.formatted(.dateTime.day().month(.wide)))")
                .padding()
                .font(.system(size: 23))
                .bold()
            
            //Display Weather Conditions
            ForecastBox(forecastSummary: forecastSummary, selectedDate: $selectedDate)
            
            //Display All Bottoms in Closet
            LazyVGrid(columns: threeColumnGrid) {
                ForEach($wardrobeStore.clothes
                    .filter({ $0.category
                        .wrappedValue == .bottom})) { $clothingItem in
               SelectBottomCell(clothingItem: $clothingItem, selectedDate: $selectedDate)
                }
            }
        }
        //.navigationTitle("Bottoms")
    }
}

struct SelectBottomCell: View {
    @Binding var clothingItem: ClothingItem
    @EnvironmentObject var wardrobeStore: WardrobeStore
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack {
            Button  {
                wardrobeStore.dictionaryBottoms[wardrobeStore.dateToStringCal(date: selectedDate)] = clothingItem
            }label: {
                clothingItem.img
                    .resizable()
                    .scaledToFit()
            }
            
        }
    }
}
