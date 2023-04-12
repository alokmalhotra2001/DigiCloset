import SwiftUI
import CoreLocation


struct ClothingImageView: View {
    let currItem: ClothingItem
    let cat: Category
    
    var body: some View {
        cat == .top ?
            currItem.img
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 225, maxHeight: 275)
                .foregroundColor(.black)
                .clipped()
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(.black, lineWidth: 1))
        :
        currItem.img
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: 225, maxHeight: 275)
            .foregroundColor(.black)
            .clipped()
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(.black, lineWidth: 1))
    }
}
