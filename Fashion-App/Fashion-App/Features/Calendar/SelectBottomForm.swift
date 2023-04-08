import SwiftUI

struct SelectBottomForm: View {
    @EnvironmentObject var wardrobeStore: WardrobeStore
    
    var body: some View {
        List($wardrobeStore.clothes) { $clothingItem in SelectBottomRow(clothingItem: $clothingItem)
        }
        .navigationTitle("Bottoms")
    }
}

struct SelectBottomRow: View {
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

struct Bottom_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { SelectBottomForm().environmentObject( WardrobeStore() ) }
    }
}




