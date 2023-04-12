import SwiftUI
import CoreLocation

struct SingleClothingItemView: View {
    @Binding var currIndex: Int
    @Binding var disabled: Bool
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
                .disabled(currIndex == 0 || disabled)
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
                .disabled(currIndex == sz - 1  || disabled)
        
            .zIndex(1)
            
            Spacer()
            Spacer()
        }
    }
}
