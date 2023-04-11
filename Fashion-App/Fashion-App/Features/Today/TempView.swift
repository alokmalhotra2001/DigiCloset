import SwiftUI
import CoreLocation

struct TempBox: View {
    let currWeather: CurrentWeather
    
    var body: some View {
        HStack {
            Text(currentTemperature(currWeather)).font(.title3)
            AsyncImage(url: URL(string: weatherIconURL())) { image in
                image.resizable() } placeholder: { ProgressView() }
                .frame(width: 35, height: 35)
        }
    }
    
    func currentTemperature(_ conditions: CurrentWeather) -> String {
        let formattedTemp = NumberFormatting.temperature(conditions.data.temp) ?? "n/a"
        return "\(formattedTemp)°"
    }
    
    func weatherIconURL() -> String {
        let iconCode: String = currWeather.weather.icon
        return "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
    }
}
