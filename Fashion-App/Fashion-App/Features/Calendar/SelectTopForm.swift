import SwiftUI

struct SelectTopForm: View {
    @EnvironmentObject var wardrobeStore: WardrobeStore
    
    var body: some View {
        List($wardrobeStore.clothes) { $clothingItem in SelectTopRow(clothingItem: $clothingItem)
        }
        .navigationTitle("Tops")
    }
}

struct SelectTopRow: View {
    @Binding var clothingItem: ClothingItem
    @EnvironmentObject var wardrobeStore: WardrobeStore
    
    var body: some View {
        HStack(alignment: .center) {
            
            VStack(alignment: .leading) {
                Text(clothingItem.name).fontWeight(.semibold)
            }
            Spacer()
        }
    }
}

struct Top_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { SelectTopForm().environmentObject( WardrobeStore() ) }
    }
}




