import SwiftUI

struct Donate: View {
    
    var body: some View {
      VStack{
        ScrollView{
          Text("Clean My Closet").font(.title).frame(alignment: .top).padding(.top, 30)
          // images of clothes
          Image("tshirt").renderingMode(.original).resizable().scaledToFit().frame(maxHeight: 200)
            .frame(maxWidth: 200).padding(.vertical)
          HStack(alignment: .top){
            Button("Keep") { // remove from to_donate, next image
              print("filler")
            }.padding().buttonStyle(.borderedProminent).frame(maxHeight: 200)
              .frame(maxWidth: 200).tint(.black)
            Button("Donate") {
              print("filler") // remove from to_donate, add to finalized_donate, next image
            }.padding().buttonStyle(.borderedProminent).frame(maxHeight: 200)
              .frame(maxWidth: 200).tint(.black)
          }
          
          NavigationLink(destination: SelectDonate()) {
            Image(systemName: "shippingbox").resizable().scaledToFit()
              .frame(maxWidth: 120, maxHeight: 120).padding(.top, 75)
          }
          
        }
      }
    }
}


struct Donate_Previews: PreviewProvider {
    static var previews: some View {
        Donate()
    }
}
