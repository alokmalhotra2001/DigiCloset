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
                //calendar view
                DatePicker("Selected Date", selection: $date,
                           in: dateClosedRange,
                           displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                //generate rest of week
                
                //shirt picker
                Text("\(date.formatted(.dateTime.day().month().weekday()))")
                    .padding()
                
                HStack {
                    Image(systemName: "tshirt.fill")
                    Text("shirt")
                }
                
                //bottoms picker
                HStack {
                    Image(systemName: "tshirt.fill")
                    Text("bottoms")
                }
                
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
