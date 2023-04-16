import SwiftUI
import CoreLocation

struct SingleClothingItemView: View {
    @Binding var currIndex: Int
    let currItem: ClothingItem
    let currCat: Category
    let sz: Int
    @EnvironmentObject var wardrobeStore: WardrobeStore
    
    var body: some View {
        HStack {
            Spacer()
            Spacer()
            
            Button {
                currIndex = currIndex - 1
            } label: {
                Image(systemName: "chevron.left.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 40, maxHeight: 40)
                    .foregroundColor(.black)
            }
                .buttonStyle(PlainButtonStyle())
                .disabled(currIndex == 0 || wardrobeStore.selectionConfirmed)
                .zIndex(1)
                
            
            Spacer()
            
            ClothingImageView(currItem: currItem, cat: currCat)
            
            Spacer()
            
            Button {
                currIndex = currIndex + 1
            } label: {
                Image(systemName: "chevron.right.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 40, maxHeight: 40)
                    .foregroundColor(.black)
            }
                .buttonStyle(PlainButtonStyle())
                .disabled(currIndex == sz - 1  || wardrobeStore.selectionConfirmed)
        
            .zIndex(1)
            
            Spacer()
            Spacer()
        }
    }
}
