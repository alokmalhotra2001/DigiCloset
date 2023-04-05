import SwiftUI

struct Calendar: View {
    
    @State private var date = Date()
    //let dateRange:
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                DatePicker("Selected Date", selection: $date, in: Date()..., displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
            }
//            //.navigationTitle("Calendar View")
        }
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar()
    }
}

struct CalendarView: UIViewRepresentable {
    let interval: DateInterval
    
    func makeUIView(context: Context) -> UICalendarView {
        let calView = UICalendarView()
        calView.backgroundColor = .white
        calView.availableDateRange = interval
        calView.calendar = .current
        calView.locale = .current
        calView.fontDesign = .rounded
        return calView
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }
}
