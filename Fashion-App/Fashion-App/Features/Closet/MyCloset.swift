// MyCloset.swift
// Written by Alexandra Rivera

import SwiftUI

struct MyCloset: View {
    @EnvironmentObject var wardrobeStore: WardrobeStore
    @State var isPresentingClothingForm: Bool = false
    @State var newClothingFormData = ClothingItem.FormData()
    @State var isPresentingLaundryAlert: Bool = false
    
    var body: some View {
        List($wardrobeStore.clothes) { $clothingItem in ClothingItemRow(clothingItem: $clothingItem)
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        wardrobeStore.deleteClothingItem(clothingItem)
                    } label: { Label("Delete", systemImage: "trash") }
                }
        }
        .navigationTitle("My Closet")
        .toolbar {
            let dirtyClothesExist = wardrobeStore.getDirtyClothes().isEmpty
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    isPresentingLaundryAlert = true
                } label: { dirtyClothesExist ? Image(systemName: "washer") : Image(systemName: "washer.fill") }
                    .alert(isPresented: $isPresentingLaundryAlert) {
                        Alert(
                            title: Text("Confirm a load of laundry?"),
                            message: Text("All clothes that are currently marked dirty will be cleaned."),
                            primaryButton: .destructive(Text("Confirm")) {
                                wardrobeStore.cleanAllClothes()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    .disabled(dirtyClothesExist)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add") { isPresentingClothingForm.toggle() }
            }
        }
        .sheet(isPresented: $isPresentingClothingForm) {
            NavigationStack {
                ClothingForm(data: $newClothingFormData)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            isPresentingClothingForm = false
                            newClothingFormData = ClothingItem.FormData()
                        }
                        
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            let newClothingItem = ClothingItem.create(from: newClothingFormData)
                            wardrobeStore.addClothingItem(newClothingItem)
                            isPresentingClothingForm = false
                            newClothingFormData = ClothingItem.FormData()
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct ClothingItemRow: View {
    @Binding var clothingItem: ClothingItem
    @EnvironmentObject var wardrobeStore: WardrobeStore
    @State var isPresentingClothingForm: Bool = false
    @State var editClothingFormData: ClothingItem.FormData = ClothingItem.FormData()
    
    var body: some View {
        HStack(alignment: .center) {
            VStack {
                clothingItem.img
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 55, maxHeight: 55)
            }
            
            VStack(alignment: .leading) {
                Text(clothingItem.name).fontWeight(.semibold)

                HStack(alignment: .bottom) {
                    Text(clothingItem.clean ? "CLEAN" : "DIRTY")
                        .font(.subheadline)
                        .foregroundColor(clothingItem.clean ? Color.green : Color.red)
                    
                    Text("|")
                    
                    if let lastWorn = clothingItem.lastWornOn {
                        Text("last worn \(dateToString(date:lastWorn))")
                            .font(.subheadline)
                    } else {
                        Text("never worn")
                            .font(.subheadline)
                    }
                }
            }
            Spacer()
            Button {
                editClothingFormData = clothingItem.dataForForm
                isPresentingClothingForm = true
                } label: {
                    Image(systemName: "square.and.pencil.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 30, maxHeight: 30)
                        .foregroundColor(.blue)
                }
                .buttonStyle(PlainButtonStyle())
        }
        .sheet(isPresented: $isPresentingClothingForm) {
            NavigationStack {
                ClothingForm(data: $editClothingFormData)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            isPresentingClothingForm = false
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            let updatedClothingItem = ClothingItem.update(clothingItem, from: editClothingFormData)
                            wardrobeStore.updateClothingItem(updatedClothingItem)
                            isPresentingClothingForm = false
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct ClothingList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { MyCloset().environmentObject( WardrobeStore() ) }
    }
}
