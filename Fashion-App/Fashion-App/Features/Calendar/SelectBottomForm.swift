import SwiftUI

struct SelectBottomForm: View {
    let currWeather: CurrentWeather
    var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @EnvironmentObject var wardrobeStore: WardrobeStore
    @Binding var dict: [Date: ClothingItem]
    @Binding var selectedDate: Date
    
    var body: some View {
        
        Text("\(selectedDate.formatted(.dateTime.day().month(.wide).weekday(.wide)))")
            .padding()
            .font(.system(size: 23))
        
        TempBox(currWeather: currWeather)
        
        ScrollView{
            LazyVGrid(columns: threeColumnGrid) {
                ForEach($wardrobeStore.clothes
                    .filter({ $0.category
                        .wrappedValue == .bottom})) { $clothingItem in
               SelectBottomCell(clothingItem: $clothingItem, dict: $dict, selectedDate: $selectedDate)
                }
            }
        }
        .navigationTitle("Bottoms")
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
                //clothingItem.planToWear?.toggle()
                dict[selectedDate] = clothingItem
            }label: {
                clothingItem.img
                    .resizable()
                    .scaledToFit()
                    //.frame(maxWidth: 100, maxHeight: 100)
            }
            
        }
        
//        if clothingItem.planToWear ?? false {
//              Image(systemName: "checkmark.circle.fill")
//                .foregroundColor(Color.black)
//                .font(.largeTitle)
//                .padding(5)
//                .background(Circle().foregroundColor(.white))
//        }
//        Spacer()
    }
}

//struct Bottom_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView { SelectBottomForm()
//            .environmentObject( WardrobeStore() )
//            .environmentObject(CurrentConditionsLoader(apiClient: WeatherAPI))
//        }
//    }
//}
