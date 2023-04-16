import SwiftUI

struct SelectDonate: View {
    @EnvironmentObject var wardrobeStore: WardrobeStore
    
    var fourColumnGrid = [GridItem(), GridItem(), GridItem(), GridItem(), GridItem(), GridItem()]
    
  var body: some View {
      VStack{
        ScrollView{
          Text("Selected Clothes to Donate").font(.title).frame(alignment: .top).padding(.vertical, 30).fontWeight(.bold)
          
          
          LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 30)), count: 5), spacing: 10) {
            ForEach($wardrobeStore.clothes_donate) { $clothingItem in
                  SelectTopCellDonate(clothingItem: $clothingItem)
                }
          }
          
          VStack{
          
          Text("Find Donation Centers Near Me").padding(.top, 65)
          
            NavigationLink(destination: ContentView()) {
              Image(systemName: "map").resizable().scaledToFit()
                .frame(maxWidth: 120, maxHeight: 120).foregroundColor(Color(.black))
            }
            
            
          }
          
        }
      }
  }
}


struct SelectTopCellDonate: View {
    @Binding var clothingItem: ClothingItem
    @EnvironmentObject var wardrobeStore: WardrobeStore
    
    var body: some View {
            VStack {
                Button {
                } label: {
                    clothingItem.img
                        .resizable()
                        .scaledToFit()
                }
            }
        Spacer()
    }
}

struct DonatePreviews: PreviewProvider {
    
    static var previews: some View {
        NavigationView { SelectDonate().environmentObject( WardrobeStore() ) }
    }
}




