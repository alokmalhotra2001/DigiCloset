import SwiftUI
import CoreLocation


struct ForecastBox: View {
    let forecastSummary: [ForecastSummary]
    @Binding var selectedDate: Date
    var interval = 0
    
    var body: some View {
        //n is the difference in number of days between selected days and today
        var n = Int(round(selectedDate.timeIntervalSinceNow / (24*60*60)))
        
        var interval = interval + 7*n
        
        let value = NumberFormatting.temperature(forecastSummary[interval].data.temp) ?? "n/a"
        HStack {
            Text("\(value)°")
//            AsyncImage(url: URL(string: weatherIconURL())) { image in
//                image.resizable() } placeholder: { ProgressView() }
//                .frame(width: 35, height: 35)
        }
    }
    
//    func weatherIconURL() -> String {
//        let iconCode: String = forecastSummary[0].WeatherInfo.
//        return "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
//    }
}
