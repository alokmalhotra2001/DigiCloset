// NotificationsView.swift
// Written by Alexandra Rivera

import SwiftUI

struct NotificationsView: View {
    @EnvironmentObject var wardrobeStore: WardrobeStore
    @State var isPresentingLaundryAlert: Bool = false
    
    var body: some View {
        List($wardrobeStore.notifications) { $notif in NotificationItemRow(notif: $notif)
        }
        .navigationTitle("Notifications")
        .toolbar {
        }
    }
    //        .sheet(isPresented: $isPresentingClothingForm) {
    //            NavigationStack {
    //                    }
    //                }
    //            }
    //            .padding()
}

struct NotificationItemRow: View {
    @Binding var notif: Notification
    @EnvironmentObject var wardrobeStore: WardrobeStore
    
    var body: some View {
        
        let topClothingItem: ClothingItem = notif.top
        let bottomClothingItem:  ClothingItem = notif.bottom
        
        HStack(alignment: .center) {
            VStack(alignment: .leading){
                if let lastWorn = topClothingItem.lastWornOn {
                    Text("Your outfit on \(dateToString(date:lastWorn)):")
                        .fontWeight(.semibold)
                }
                
                HStack {
                    topClothingItem.img
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 55, maxHeight: 55)
                    bottomClothingItem.img
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 55, maxHeight: 55)
                }
                
                Text("Have you put these items in your dirty clothes bin?")
                    .font(.caption)
            }
        }
    }
}


struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { NotificationsView().environmentObject( WardrobeStore() ) }
    }
}
