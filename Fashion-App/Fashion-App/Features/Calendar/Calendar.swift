import SwiftUI
import CoreLocation
import EventKit
import EventKitUI

struct Calendar: View {
    
    let location: CLLocationCoordinate2D
    @EnvironmentObject var forecastLoader: ForecastLoader
    @EnvironmentObject var currentConditionsLoader: CurrentConditionsLoader
    @EnvironmentObject var wardrobeStore: WardrobeStore
    @State private var date: Date = Date()
    @State var isPresentingTopForm: Bool = false
    @State var isPresentingBottomsForm: Bool = false
    @State var newClothingFormData = ClothingItem.FormData()
    @State var dictionaryTop: [Date: ClothingItem] = [:]
    @State var dictionaryBottoms: [Date: ClothingItem] = [:]
    @State var currTopIndex: Int = 0
    @State var currBottomIndex: Int = 0
    @State var topSelected: Bool = false
    @State var bottomSelected: Bool = false
    
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
                    .accentColor(.blue)
                
                
                
                //generate random outfit for selected date
                HStack {
                    Button {
                        currTopIndex = Int.random(in: 0..<tops.count)
                        dictionaryTop[date] = tops[currTopIndex]
                        topSelected = true
                        
                        currBottomIndex = Int.random(in: 0..<bottoms.count)
                        dictionaryBottoms[date] = bottoms[currBottomIndex]
                        bottomSelected = true
                    } label: { Text("Generate Random Outfit") }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(8)
                        .buttonStyle(PlainButtonStyle())
                        .disabled(wardrobeStore.selectionConfirmed || tops.count == 0 || bottoms.count == 0)
                }
                .padding()
                
                //pick outfit
                Text("My outfit for \(date.formatted(.dateTime.day().month(.wide).weekday(.wide)))")
                    .padding()
                    .bold()
                
                //shirt picker
                VStack {
                    HStack {
                        let value = dictionaryTop[date]
                        
                        value?.img
                            .resizable()
                            .frame(maxWidth: 55, maxHeight: 55)
                        
                        Text(value?.name ?? "No Top Selected")
                        
                        if (dictionaryTop[date] == nil){
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
                        
                        //reset top selection
                        else {
                            Button {
                                dictionaryTop[date] = nil
                            } label: {
                                Text("reset top")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .foregroundColor(.white)
                                    .background(.blue)
                                    .cornerRadius(8)
                                    .buttonStyle(PlainButtonStyle())
                            }
                        }
                        
                    }
                }
                
                //bottoms picker
                VStack {
                    HStack {
                        
                        let value = dictionaryBottoms[date]
                        
                        value?.img
                            .resizable()
                            .frame(maxWidth: 55, maxHeight: 55)
                        
                        Text(value?.name ?? "No Bottoms Selected")
                        
                        //display edit bottoms button
                        if (dictionaryBottoms[date] == nil){
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
                        
                        //reset bottoms selection
                        else {
                            Button {
                                dictionaryBottoms[date] = nil
                            } label: {
                                Text("reset bottoms")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .foregroundColor(.white)
                                    .background(.blue)
                                    .cornerRadius(8)
                                    .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
                
            }
            
            .sheet(isPresented: $isPresentingTopForm) {
              NavigationStack {
                  
                  VStack {
                      switch forecastLoader.state {
                      case .idle: Color.clear
                      case .loading: ProgressView()
                      case .failed(let error): Text("Error \(error.localizedDescription)")
                      case .success(let forecastSummary):
                          SelectTopForm(forecastSummary: forecastSummary, dict: $dictionaryTop, selectedDate: $date)
                      }
                  }
                  .task { await forecastLoader.loadForecastData(coordinate: location) }
                  
                  
                  //currentConditions version
//                  VStack {
//                      switch currentConditionsLoader.state {
//                      case .idle: Color.clear
//                      case .loading: ProgressView()
//                      case .failed(let error): Text("Error \(error.localizedDescription)")
//                      case .success(let currentConditions):
//                          SelectTopForm(currWeather: currentConditions, dict: $dictionaryTop, selectedDate: $date)
//                      }
//                  }
//                  .task { await currentConditionsLoader.loadWeatherData(coordinate: location) }
                  
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
            .environmentObject(ForecastLoader(apiClient: MockWeatherAPIClient()))
            .environmentObject(WardrobeStore())
    }
}
