import SwiftUI

struct Donate: View {
  
  @State var currTopIndex: Int = 0
  @State var currBottomIndex: Int = 0
  @State var isPresentingSelectionAlert: Bool = false
  @State var selectionConfirmed: Bool = false
  @EnvironmentObject var wardrobeStore: WardrobeStore
    
    var body: some View {
      VStack{
        ScrollView{
          Text("Clean My Closet").font(.title).frame(alignment: .top).padding(.top, 30)
          
          // TODO: all clothes in order of least worn, fix index (tops, all)
          // add note @ end: "All your clothes have been added for donation!"
          let clothes = wardrobeStore.clothes
          let clothes_donate = wardrobeStore.clothes_to_donate
          let clothes_keep = wardrobeStore.keep
          
          HStack { SingleClothingItemView(currIndex: $currTopIndex, disabled: $selectionConfirmed, currItem: clothes_donate[currTopIndex], currCat: .top, sz: clothes_donate.count) }
          
          HStack(alignment: .top){
            
           Button("Keep") {
              wardrobeStore.removeToDonate(clothes[currTopIndex])
              wardrobeStore.remKeep(clothes[currTopIndex])
            }.padding().buttonStyle(.borderedProminent).frame(maxHeight: 200)
              .frame(maxWidth: 200).tint(.black)
            
            Button("Donate") {
               wardrobeStore.removeToDonate(clothes[currTopIndex])
              // wardrobeStore.addFinDonate(clothes[currTopIndex])
               wardrobeStore.deleteClothingItem(clothes[currTopIndex])
             }.padding().buttonStyle(.borderedProminent).frame(maxHeight: 200)
              .frame(maxWidth: 200).tint(.black)
            
        }
      }
          
        Text("View Clothes to Donate")
        
        NavigationLink(destination: SelectDonate()) {
            Image(systemName: "shippingbox").resizable().scaledToFit()
              .frame(maxWidth: 120, maxHeight: 120)
          }
          
        }
      }
    }



struct Donate_Previews: PreviewProvider {
    static var previews: some View {
        Donate()
    }
}
