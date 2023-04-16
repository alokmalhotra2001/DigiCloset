import SwiftUI
import CoreLocation
import EventKit
import EventKitUI

struct Calendar: View {
    
    let location: CLLocationCoordinate2D
    @EnvironmentObject var forecastLoader: ForecastLoader
    @EnvironmentObject var currentConditionsLoader: CurrentConditionsLoader
    @EnvironmentObject var wardrobeStore: WardrobeStore
    @State private var date = Date()
    @State var isPresentingTopForm: Bool = false
    @State var isPresentingBottomsForm: Bool = false
    @State var newClothingFormData = ClothingItem.FormData()
    @State var dictionaryTop: [Date: ClothingItem] = [:]
    @State var dictionaryBottoms: [Date: ClothingItem] = [:]
    @State var currTopIndex: Int = 0
    @State var currBottomIndex: Int = 0
    
    var dateClosedRange: ClosedRange<Date> {
        let min = Date()
        let max = Date.now.addingTimeInterval(60*60*24*5)
        return min...max
    }
    
    var body: some View {
        
        let tops = wardrobeStore.getCleanTops()
        let bottoms = wardrobeStore.getCleanBottoms()
        
        NavigationStack {
            
            ScrollView {
                //calendar view
                DatePicker("Selected Date", selection: $date,
                           in: dateClosedRange,
                           displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                //generate random outfit for selected date
                HStack {
                    Button {
                        currTopIndex = Int.random(in: 0..<tops.count)
                        dictionaryTop[date] = tops[currTopIndex]
                        
                        currBottomIndex = Int.random(in: 0..<bottoms.count)
                        dictionaryBottoms[date] = bottoms[currBottomIndex]
                    } label: { Text("Generate Random Outfit") }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(8)
                        .buttonStyle(PlainButtonStyle())
                        .disabled(wardrobeStore.selectionConfirmed || tops.count == 0 || bottoms.count == 0)
                }
                
                //pick outfit
                Text("My outfit for \(date.formatted(.dateTime.day().month(.wide).weekday(.wide)))")
                    .padding()
                
                //shirt picker
                HStack {
                    var value = dictionaryTop[date]
                    
                    value?.img
                        .resizable()
                        .frame(maxWidth: 45, maxHeight: 45)
                    
                    Text(value?.name ?? "No Top Selected")
                    
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
                    
                    var value = dictionaryBottoms[date]
                    
                    value?.img
                        .resizable()
                        .frame(maxWidth: 45, maxHeight: 45)
                    
                    Text(value?.name ?? "No Bottoms Selected")
                    
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
                  VStack {
                      switch currentConditionsLoader.state {
                      case .idle: Color.clear
                      case .loading: ProgressView()
                      case .failed(let error): Text("Error \(error.localizedDescription)")
                      case .success(let currentConditions):
                          SelectTopForm(currWeather: currentConditions, dict: $dictionaryTop, selectedDate: $date)
                      }
                  }
                  .task { await currentConditionsLoader.loadWeatherData(coordinate: location) }
                  
                  .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                      Button("Cancel") { isPresentingTopForm = false }
                      
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                      Button("Save") {
                        isPresentingTopForm = false
                      }
                    }
                  }
              }
              .padding()
            }
            
            .sheet(isPresented: $isPresentingBottomsForm) {
                
              NavigationStack {
                  
                  VStack {
                      switch currentConditionsLoader.state {
                      case .idle: Color.clear
                      case .loading: ProgressView()
                      case .failed(let error): Text("Error \(error.localizedDescription)")
                      case .success(let currentConditions):
                          SelectBottomForm(currWeather: currentConditions, dict: $dictionaryBottoms, selectedDate: $date)
                      }
                  }
                  .task { await currentConditionsLoader.loadWeatherData(coordinate: location) }

                  .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                      Button("Cancel") { isPresentingBottomsForm = false }

                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                      Button("Save") {
                        isPresentingBottomsForm = false
                      }
                    }
                  }
              }
              .padding()
            }
        }
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar(location: CLLocationCoordinate2D(latitude: 40.3451, longitude: 74.1840))
            .environmentObject(CurrentConditionsLoader(apiClient: MockWeatherAPIClient()))
            .environmentObject(WardrobeStore() )
            .environmentObject(ForecastLoader(apiClient: MockWeatherAPIClient()))
    }
}
