import SwiftUI
import CoreLocation

struct TodayDetail: View {
    let currWeather: CurrentWeather
    @State var currTopIndex: Int = 0
    @State var currBottomIndex: Int = 0
    @State var isPresentingSelectionAlert: Bool = false
    @State var selectionConfirmed: Bool = false
    @EnvironmentObject var wardrobeStore: WardrobeStore
    
    var body: some View {
        let tops = wardrobeStore.getCleanTops().sorted(by: { sortByTempDiff(i1: $0, i2: $1, currWeather: currWeather) } )
        let bottoms = wardrobeStore.getCleanBottoms().sorted(by: { sortByTempDiff(i1: $0, i2: $1, currWeather: currWeather) } )
        
        VStack {
            Spacer()
            
            HStack { SingleClothingItemView(currIndex: $currTopIndex, disabled: $selectionConfirmed, currItem: tops[currTopIndex], currCat: .top, sz: tops.count) }
            
            HStack { SingleClothingItemView(currIndex: $currBottomIndex, disabled: $selectionConfirmed, currItem: bottoms[currBottomIndex], currCat: .bottom, sz: bottoms.count) }
            
            Spacer()
            
            HStack {
                Button {
                    currTopIndex = Int.random(in: 0..<tops.count)
                    currBottomIndex = Int.random(in: 0..<bottoms.count)
                } label: { Text("Generate Random Outfit") }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(8)
                    .buttonStyle(PlainButtonStyle())
                    .disabled(selectionConfirmed)
                
                
                Button {
                    isPresentingSelectionAlert = true
                } label: { selectionConfirmed ? Text("Reset") : Text("Confirm") }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(8)
                    .alert(isPresented: $isPresentingSelectionAlert) {
                        selectionConfirmed ?
                        
                        Alert(title: Text("Undo selection?"),
                              message: Text("Choose a different combination!"),
                              primaryButton: .destructive(Text("Confirm")) {
                                // Insert notification logic here
                                selectionConfirmed = false
                              },
                              secondaryButton: .cancel())
                        :
                        
                        Alert(title: Text("Confirm selection?"),
                              message: Text("Boutta be lookin' sexy!"),
                              primaryButton: .destructive(Text("Confirm")) {
                                let notif: Notification = Notification(top: tops[currTopIndex], bottom: bottoms[currBottomIndex])
                                wardrobeStore.addNotification(notif: notif)
                                selectionConfirmed = true
                              },
                              secondaryButton: .cancel())
                    }
            }
            
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
        .offset(y: 15)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    
                } label: { Image(systemName: "envelope.fill") }
            }
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(NumberFormatting.date()).font(.title2)
                    TempBox(currWeather: currWeather)
//                        .padding(10)
//                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.black, lineWidth: 2))
                }
                .offset(y: 30)
                
            }
        }
    }
}
