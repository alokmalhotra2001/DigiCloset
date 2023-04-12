import SwiftUI

struct SelectTopForm: View {
    @EnvironmentObject var wardrobeStore: WardrobeStore
    
    var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: threeColumnGrid) {
            ForEach($wardrobeStore.clothes
                .filter({ $0.category
                    .wrappedValue == .top})) { $clothingItem in
           SelectTopCell(clothingItem: $clothingItem)
            }
        }
        .navigationTitle("Tops")
    }
}

struct SelectTopCell: View {
    @Binding var clothingItem: ClothingItem
    @EnvironmentObject var wardrobeStore: WardrobeStore
    
    var body: some View {
            VStack {
                Button {
                } label: {
                    clothingItem.img
                        .resizable()
                        .scaledToFit()
                        //.frame(maxWidth: 100, maxHeight: 100)
                }
            }
            Spacer()
    }
}

struct Top_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { SelectTopForm().environmentObject( WardrobeStore() ) }
    }
}




