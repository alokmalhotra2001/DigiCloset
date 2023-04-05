import SwiftUI

struct Calendar: View {
    
    @State private var date = Date()
    
    var dateClosedRange: ClosedRange<Date> {
        let min = Date()
        let max = Date.now.addingTimeInterval(60*60*24*7)
        return min...max
    }
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                DatePicker("Selected Date", selection: $date,
                           in: dateClosedRange,
                           displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
            }
            //.navigationTitle(date)
        }
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar()
    }
}
