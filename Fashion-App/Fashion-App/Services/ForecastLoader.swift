import Foundation
import CoreLocation

class ForecastLoader: ObservableObject {
    let apiClient: WeatherAPI

    @Published private(set) var state: LoadingState = .idle

    enum LoadingState {
        case idle
        case loading
        case success(data: [ForecastSummary])
        case failed(error: Error)
    }

    init(apiClient: WeatherAPI) { self.apiClient = apiClient }

    @MainActor
    func loadForecastData(coordinate: CLLocationCoordinate2D) async {
        self.state = .loading
        do {
          let weather = try await apiClient.fetchForecast(coordinate: coordinate)
          self.state = .success(data: weather)
        }
        catch { self.state = .failed(error: error) }
    }
}
