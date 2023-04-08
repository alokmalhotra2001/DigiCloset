import SwiftUI

struct SelectBottomForm: View {
    @EnvironmentObject var wardrobeStore: WardrobeStore
    
    var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: threeColumnGrid) {
            ForEach($wardrobeStore.clothes) { $clothingItem in
           SelectBottomCell(clothingItem: $clothingItem)
            }
        }
        .navigationTitle("Bottoms")
    }
}

struct SelectBottomCell: View {
    @Binding var clothingItem: ClothingItem
    @EnvironmentObject var wardrobeStore: WardrobeStore
    
    var body: some View {
        VStack {
            clothingItem.img
                .resizable()
                .scaledToFit()
                //.frame(maxWidth: 100, maxHeight: 100)
        }
    }
}

struct Bottom_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { SelectBottomForm().environmentObject( WardrobeStore() ) }
    }
}




