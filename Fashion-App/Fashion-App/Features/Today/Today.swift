import SwiftUI
import CoreLocation

struct Today: View {
    @EnvironmentObject var currentConditionsLoader: CurrentConditionsLoader
    let location: CLLocationCoordinate2D
    
    var body: some View {
        VStack {
            switch currentConditionsLoader.state {
            case .idle: Color.clear
            case .loading: ProgressView()
            case .failed(let error): Text("Error \(error.localizedDescription)")
            case .success(let currentConditions):
                TodayDetail(currWeather: currentConditions)
            }
        }
        .task { await currentConditionsLoader.loadWeatherData(coordinate: location) }
    }
}

struct Today_Previews: PreviewProvider {
  static var previews: some View {
      Today(location: CLLocationCoordinate2D(latitude: 40.3451, longitude: 74.1840))
          .environmentObject(ForecastLoader(apiClient: MockWeatherAPIClient()))
          .environmentObject(CurrentConditionsLoader(apiClient: MockWeatherAPIClient()))
          .environmentObject(WardrobeStore())
  }
}
