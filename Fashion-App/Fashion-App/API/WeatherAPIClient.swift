import CoreLocation
import Foundation

protocol WeatherAPI {
    func fetchCurrent(coordinate: CLLocationCoordinate2D) async throws -> CurrentWeatherResponse
    func fetchForecast(coordinate: CLLocationCoordinate2D) async throws -> [ForecastSummary]
}

struct WeatherAPIClient: WeatherAPI, APIClient {
    let session: URLSession = .shared
    
    func fetchCurrent(coordinate: CLLocationCoordinate2D) async throws -> CurrentWeatherResponse {
        let path = WeatherEndpoint.path(queryType: .current, coordinate: coordinate)
        dump(path)
        let response: CurrentWeatherResponse = try await performRequest(url: path)
        return response
    }

    func fetchForecast(coordinate: CLLocationCoordinate2D) async throws -> [ForecastSummary] {
        let path = WeatherEndpoint.path(queryType: .forecast, coordinate: coordinate)
        dump(path)
        let response: ForecastResponse = try await performRequest(url: path)
        return response.dailyForecasts
    }
}

struct MockWeatherAPIClient: WeatherAPI {
    func fetchCurrent(coordinate: CLLocationCoordinate2D) async throws -> CurrentWeatherResponse { CurrentWeatherResponse.mock() }
    func fetchForecast(coordinate: CLLocationCoordinate2D) async throws -> [ForecastSummary] { ForecastSummary.mockCollection() }
}
