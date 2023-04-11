import Foundation
import CoreLocation

struct WeatherEndpoint {
  static let baseUrl = "https://api.openweatherMap.org/data/2.5"
  static let apiKey = "83c6d37f88283da0a326c1ba7dcaa934"

  enum QueryType: String {
    case forecast
    case current = "weather"
  }

  static func path(queryType: QueryType, coordinate: CLLocationCoordinate2D) -> String {
    let url = "\(baseUrl)/\(queryType.rawValue)"
    let key = "appid=\(apiKey)"
    let units = "units=imperial"
    let queryParameters = "lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
    return "\(url)?\(units)&\(queryParameters)&\(key)"
  }
}
