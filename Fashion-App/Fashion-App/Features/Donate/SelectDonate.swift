import SwiftUI

struct SelectDonate: View {
    @EnvironmentObject var wardrobeStore: WardrobeStore
    
    var fourColumnGrid = [GridItem(), GridItem(), GridItem(), GridItem(), GridItem(), GridItem()]
    
  var body: some View {
    NavigationView {
      
      VStack{
        ScrollView{
          Text("Selected Clothes to Donate").font(.title).frame(alignment: .top)
          
          
          LazyVGrid(columns: fourColumnGrid) {
            ForEach($wardrobeStore.keep) { $clothingItem in
                  SelectTopCell(clothingItem: $clothingItem)
                }
          }
          
//          Button("Donate") {
//            print("filler") // add To Donate bag, go to next image //TODO: TEMP -- CHANGE
//          }.padding().buttonStyle(.borderedProminent).frame(maxHeight: 200)
//            .frame(maxWidth: 200).tint(.black)
          
          NavigationLink(destination: ContentView()) {
            Text("Find Donation Centers Near Me").padding(.top, 40)
          }
          
        }
      }
      
    }
  }
}

struct DonatePreviews: PreviewProvider {
    static var previews: some View {
        NavigationView { SelectDonate().environmentObject( WardrobeStore() ) }
    }
}




