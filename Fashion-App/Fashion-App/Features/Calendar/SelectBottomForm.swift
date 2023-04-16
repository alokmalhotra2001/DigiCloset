import SwiftUI

struct SelectBottomForm: View {
    let currWeather: CurrentWeather
    var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @EnvironmentObject var wardrobeStore: WardrobeStore
    @Binding var dict: [Date: ClothingItem]
    @Binding var selectedDate: Date
    
    var body: some View {
        
        ScrollView{
            //Display Selected Day and Daate
            Text("Select Bottoms for \(selectedDate.formatted(.dateTime.day().month(.wide).weekday(.wide)))")
                .padding()
                .font(.system(size: 23))
                .bold()
            
            //Display Weather Conditions
            TempBox(currWeather: currWeather)
            
            //Display All Bottoms in Closet
            LazyVGrid(columns: threeColumnGrid) {
                ForEach($wardrobeStore.clothes
                    .filter({ $0.category
                        .wrappedValue == .bottom})) { $clothingItem in
               SelectBottomCell(clothingItem: $clothingItem, dict: $dict, selectedDate: $selectedDate)
                }
            }
        }
        //.navigationTitle("Bottoms")
    }
}

struct SelectBottomCell: View {
    @Binding var clothingItem: ClothingItem
    @EnvironmentObject var wardrobeStore: WardrobeStore
    @Binding var dict: [Date: ClothingItem]
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack {
            Button  {
                dict[selectedDate] = clothingItem
            }label: {
                clothingItem.img
                    .resizable()
                    .scaledToFit()
            }
            
        }
    }
}
