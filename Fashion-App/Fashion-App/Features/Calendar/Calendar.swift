import SwiftUI

struct Calendar: View {
    
    @State private var date = Date()
    @State var isPresentingTopForm: Bool = false
    @State var isPresentingBottomsForm: Bool = false
    @State var newClothingFormData = ClothingItem.FormData()
    
    var dateClosedRange: ClosedRange<Date> {
        let min = Date()
        let max = Date.now.addingTimeInterval(60*60*24*7)
        return min...max
    }
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                //calendar view
                DatePicker("Selected Date", selection: $date,
                           in: dateClosedRange,
                           displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                //generate rest of week
                
                
                Text("Outfit for \(date.formatted(.dateTime.day().month(.wide).weekday(.wide)))")
                    .padding()
                
                //shirt picker
                HStack {
                    Image(systemName: "tshirt.fill")
                    Text("Top")
                        .padding()
                    Button {
                        isPresentingTopForm.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil.circle")
                            .resizable()
                            .frame(maxWidth: 30, maxHeight: 30)
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                //bottoms picker
                HStack {
                    
                    Image(systemName: "tshirt.fill")
                    Text("Bottoms")
                        .padding()
                    Button {
                        isPresentingBottomsForm.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil.circle")
                            .resizable()
                            .frame(maxWidth: 30, maxHeight: 30)
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
            }
            
            .sheet(isPresented: $isPresentingTopForm) {
              NavigationStack {
                SelectTopForm(data: $newClothingFormData)
                  .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                      Button("Cancel") { isPresentingTopForm = false }
                      
                    }
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                      Button("Save") {
//                        let newMovie = Movie.create(from: newMovieFormData)
//                        movieStore.createMovie(newMovie)
//                        isPresentingBottomsForm = false
//                      }
//                    }
                  }
              }
              .padding()
            }
            
            .sheet(isPresented: $isPresentingBottomsForm) {
              NavigationStack {
                SelectBottomForm(data: $newClothingFormData)
                  .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                      Button("Cancel") { isPresentingBottomsForm = false }
                      
                    }
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                      Button("Save") {
//                        let newMovie = Movie.create(from: newMovieFormData)
//                        movieStore.createMovie(newMovie)
//                        isPresentingBottomsForm = false
//                      }
//                    }
                  }
              }
              .padding()
            }
            //.navigationTitle(date)
        }
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar()
    }
}
