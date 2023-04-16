import SwiftUI
import CoreLocation

struct NoItemsAvailableView: View {
    let currCat: Category
    @EnvironmentObject var wardrobeStore: WardrobeStore
    
    var body: some View {
        HStack {
            Spacer()
            Spacer()
            
            Button {
                // currIndex = currIndex - 1
            } label: {
                Image(systemName: "chevron.left.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 40, maxHeight: 40)
                    .foregroundColor(.black)
            }
                .buttonStyle(PlainButtonStyle())
                .disabled(true)
                .zIndex(1)
                
            
            Spacer()
            
            currCat == .top ?
            Image("notops")
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 225, maxHeight: 275)
                .foregroundColor(.black)
                .clipped()
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(.black, lineWidth: 1))
            :
            Image("nobottoms")
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 225, maxHeight: 275)
                .foregroundColor(.black)
                .clipped()
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(.black, lineWidth: 1))
            
            Spacer()
            
            Button {
                // currIndex = currIndex + 1
            } label: {
                Image(systemName: "chevron.right.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 40, maxHeight: 40)
                    .foregroundColor(.black)
            }
                .buttonStyle(PlainButtonStyle())
                .disabled(true)
        
            .zIndex(1)
            
            Spacer()
            Spacer()
        }
    }
}
