import SwiftUI
import MapKit

struct Donate: View {
    
    var body: some View {
      VStack{
        ScrollView{
          Text("Clean My Closet").font(.title).frame(alignment: .top).padding(.top, 30)
          // images of clothes
          Image("tshirt").renderingMode(.original).resizable().scaledToFit().frame(maxHeight: 300)
            .frame(maxWidth: 300).padding(.vertical)
          HStack(alignment: .top){
            Button("Keep") {
              print("filler") // go to next image
            }.padding().background(Color(.black)).foregroundColor(.white).clipShape(Capsule()).frame(maxHeight: 200)
              .frame(maxWidth: 200)
            Button("Donate") {
              print("filler") // add To Donate bag, go to next image
            }.padding().background(Color(.black)).foregroundColor(.white).clipShape(Capsule()).frame(maxHeight: 200)
              .frame(maxWidth: 200)
          }
          // bag icon at bottom "To Donate" --> selected clothes to donate screen --> find nearby donation centers screen
          Image("bag").renderingMode(.original).resizable().scaledToFit().frame(maxHeight: 150)
            .frame(maxWidth: 150).padding(.top, 50)
        }
      }
    }
}
