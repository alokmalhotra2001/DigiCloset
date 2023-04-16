import SwiftUI

struct Donate: View {
  
  @State var currClothIndex: Int = 0
  @State var selectionConfirmed: Bool = false
  @EnvironmentObject var wardrobeStore: WardrobeStore
    
    var body: some View {
      VStack{
        ScrollView{
          Text("Clean My Closet").font(.title).frame(alignment: .top).padding(.vertical, 30).fontWeight(.bold)
          
          // TODO: all clothes in order of least worn, fix index (tops, all)
          // add note @ end: "All your clothes have been added for donation!"
          let clothes = wardrobeStore.clothes
          let clothes_dynamic = wardrobeStore.clothes_dynamic
          // let clothes_donate = wardrobeStore.clothes_donate
                    
          HStack { SingleClothingItemView(currIndex: $currClothIndex, disabled: $selectionConfirmed, currItem: clothes_dynamic[currClothIndex], currCat: .other, sz: clothes.count) }
          
          HStack(alignment: .top){
            
           Button("Keep") {
              wardrobeStore.removeDynamic(clothes_dynamic[currClothIndex]) 
            }.padding().buttonStyle(.borderedProminent).frame(maxHeight: 200)
              .frame(maxWidth: 200).tint(.black)
            
            Button("Donate") {
               wardrobeStore.addDonate(clothes_dynamic[currClothIndex])
               wardrobeStore.deleteClothingItem(clothes_dynamic[currClothIndex])
               wardrobeStore.removeDynamic(clothes_dynamic[currClothIndex])
             }.padding().buttonStyle(.borderedProminent).frame(maxHeight: 200)
              .frame(maxWidth: 200).tint(.black)
            
        }
          
          Text("View Clothes to Donate").padding(.top, 75)
          
          NavigationLink(destination: SelectDonate()) {
              Image(systemName: "shippingbox").resizable().scaledToFit()
                .frame(maxWidth: 120, maxHeight: 120).foregroundColor(Color(.black))
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
