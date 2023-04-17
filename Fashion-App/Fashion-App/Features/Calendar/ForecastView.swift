import SwiftUI
import CoreLocation


struct ForecastBox: View {
    let forecastSummary: [ForecastSummary]
    @Binding var selectedDate: Date
    var interval = 0
    
    var body: some View {
        //Calendar.current.dateComponents([.day], from: selectedDate, to: Date()).day
        //let n = dateComponents([.day], from: Date(), to: selectedDate)
        
        //let n = difference in number of days between selected days and today
        let n = 5
        
        if (n != 0){
            var interval = 8*n - 1
        }
        
        let value = NumberFormatting.temperature(forecastSummary[interval].data.temp) ?? "n/a"
        HStack {
            Text("\(value)°")
//            AsyncImage(url: URL(string: weatherIconURL())) { image in
//                image.resizable() } placeholder: { ProgressView() }
//                .frame(width: 35, height: 35)
        }
    }
    
//    func weatherIconURL() -> String {
//        let iconCode: String = forecastSummary.
//        return "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
//    }
}
