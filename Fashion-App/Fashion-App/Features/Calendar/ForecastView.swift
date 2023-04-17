import SwiftUI
import CoreLocation

struct ForecastBox: View {
    let forecastSummary: [ForecastSummary]
    
    var body: some View {
        
        let value = forecastSummary[1].data.low
        Text("\(value)")
    }
}

//struct ForecastBox: View {
//    let forecastSummary: [ForecastSummary]
//
//    var body: some View {
//        HStack {
//            Text(currentTemperature(currWeather)).font(.title3)
//            AsyncImage(url: URL(string: weatherIconURL())) { image in
//                image.resizable() } placeholder: { ProgressView() }
//                .frame(width: 35, height: 35)
//        }
//    }
//
//    func currentTemperature(_ conditions: CurrentWeather) -> String {
//        let formattedTemp = NumberFormatting.temperature(conditions.data.temp) ?? "n/a"
//        return "\(formattedTemp)°"
//    }
//
//    func weatherIconURL() -> String {
//        let iconCode: String = currWeather.weather.icon
//        return "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
//    }
//}
