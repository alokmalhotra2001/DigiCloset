import SwiftUI

@main
struct Fashion_AppApp: App {
    
    @StateObject var wardrobeStore = WardrobeStore()
    @StateObject var forecastLoader = ForecastLoader(apiClient: WeatherAPIClient())
    @StateObject var currentConditionsLoader = CurrentConditionsLoader(apiClient: WeatherAPIClient())
    
    var body: some Scene {
        WindowGroup {
            LocationRequestView()
                .environmentObject(wardrobeStore)
                .environmentObject(forecastLoader)
                .environmentObject(currentConditionsLoader)
        }
    }
}
