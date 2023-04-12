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
            Button("Keep") {
              print("filler") // go to next image
            }.padding().buttonStyle(.borderedProminent).frame(maxHeight: 200)
              .frame(maxWidth: 200).tint(.black)
            Button("Donate") {
              print("filler") // add To Donate bag, go to next image //TODO: TEMP -- CHANGE
            }.padding().buttonStyle(.borderedProminent).frame(maxHeight: 200)
              .frame(maxWidth: 200).tint(.black)
          }
          // bag icon at bottom "To Donate" --> selected clothes to donate screen --> find nearby donation centers screen
          
          NavigationLink(destination: ToDonate()) {
            Image("bag").renderingMode(.original).resizable().scaledToFit().frame(maxHeight: 150)
              .frame(maxWidth: 150).padding(.top, 50)
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
