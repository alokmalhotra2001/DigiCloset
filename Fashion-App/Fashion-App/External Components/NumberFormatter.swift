import Foundation

struct NumberFormatting {
    static func temperature(_ temperature: Double) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        let temp = NSNumber(value: temperature)
        return formatter.string(from: temp)
    }
    
    static func date() -> String {
        let date = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd"
        
        return dateFormatter.string(from: date)
    }
}
