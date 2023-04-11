import Foundation
import CoreLocation

class CurrentConditionsLoader: ObservableObject {
    let apiClient: WeatherAPI
    @Published private(set) var state: LoadingState = .idle

    enum LoadingState {
        case idle
        case loading
        case success(data: CurrentWeather)
        case failed(error: Error)
    }

    enum DataError: Error {
        case noWeather
    }


    init(apiClient: WeatherAPI) { self.apiClient = apiClient }

    @MainActor
    func loadWeatherData(coordinate: CLLocationCoordinate2D) async {
        self.state = .loading
        do {
            let response: CurrentWeatherResponse = try await apiClient.fetchCurrent(coordinate: coordinate)
            if let weather = response.weathers.first {
                let currentWeather = CurrentWeather(weather: weather, name: response.name,
                                                    data: response.data, wind: response.wind, clouds: response.clouds)
                self.state = .success(data: currentWeather)
            }
            else { self.state = .failed(error: DataError.noWeather) }
        }
        catch { self.state = .failed(error: error) }
    }
}

struct CurrentWeather {
    var weather: WeatherInfo
    var name: String
    var data: WeatherData
    var wind: Wind
    var clouds: Clouds
}
