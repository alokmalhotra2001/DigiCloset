// NotificationsView.swift
// Written by Alexandra Rivera

import SwiftUI

struct NotificationsView: View {
    @Binding var currTopIndex: Int
    @Binding var currBottomIndex: Int
    @EnvironmentObject var wardrobeStore: WardrobeStore
    var body: some View {
        VStack{
            List($wardrobeStore.notifications) { $notif in NotificationItemRow(notif: $notif, currTopIndex: $currTopIndex, currBottomIndex: $currBottomIndex) }
            .navigationTitle("Notifications")
            .toolbar {
            }
        }
    }
}

struct NotificationItemRow: View {
    @Binding var notif: Notification
    @Binding var currTopIndex: Int
    @Binding var currBottomIndex: Int
    @EnvironmentObject var wardrobeStore: WardrobeStore
    @State var notifFormData = Notification.FormData()
    @State var isPresentingNotifForm: Bool = false
    @State var isPresentingAlert: Bool = false
    
    var body: some View {
        
        let topClothingItem: ClothingItem = notif.top
        let bottomClothingItem:  ClothingItem = notif.bottom
        
        HStack(alignment: .center) {
            VStack(alignment: .leading){
                Text("Your outfit on \(dateToString(date:notif.timestamp))")
                    .fontWeight(.semibold)
                
                HStack {
                    topClothingItem.img
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 55, maxHeight: 55)
                    bottomClothingItem.img
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 55, maxHeight: 55)
                    Spacer()
                }
            }
            
            Button {
                isPresentingNotifForm.toggle()
            } label: {
                VStack(alignment: .trailing){
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 30, maxHeight: 30)
                        .foregroundColor( notif.completed ? Color.gray : Color.red )
                    Text( notif.completed ? "action complete" : "action required")
                        .foregroundColor( notif.completed ? Color.gray : Color.red )
                }
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(notif.completed)

        }
        .sheet(isPresented: $isPresentingNotifForm) {
            NavigationStack {
                NotificationsForm(data: $notifFormData, notif: notif)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") {
                                isPresentingNotifForm = false
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Save") {
                                isPresentingAlert = true
                            }
                            .alert(isPresented: $isPresentingAlert) {
                                Alert(
                                    title: Text("Confirm selection?"),
                                    message: Text("This action cannot be undone!"),
                                    primaryButton: .destructive(Text("Confirm")) {
                                        var updatedTop = Notification.updateTop(topClothingItem, from: notifFormData)
                                        var updatedBottom = Notification.updateBottom(bottomClothingItem, from: notifFormData)
                                        updatedTop.lastWornOn = Date.now
                                        updatedBottom.lastWornOn = Date.now
                                        wardrobeStore.updateClothingItem(updatedTop)
                                        wardrobeStore.updateClothingItem(updatedBottom)
                                        
                                        if let index = wardrobeStore.notifications.firstIndex(where: { $0.id == notif.id }) {
                                            if (index == 0) { wardrobeStore.resetOutfitSelection() }
                                        }
                                        currTopIndex = 0
                                        currBottomIndex = 0
                                        
                                        notif.completed = true
                                        isPresentingAlert = false
                                        isPresentingNotifForm = false
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                        }
                    }
            }
        }
    }
}


//struct NotificationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView { NotificationsView(currTopIndex: $0, currBottomIndex: $0).environmentObject( WardrobeStore() ) }
//    }
//}
