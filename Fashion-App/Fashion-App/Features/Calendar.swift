import SwiftUI

struct Calendar: View {
    
    @State private var date = Date()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                CalendarView(interval: DateInterval(start: .distantPast, end: .distantFuture))
                    
            }
            //.navigationTitle("Calendar View")
        }
        
//        DatePicker("start date", selection: $date, displayedComponents: [.date])
//            .datePickerStyle(.graphical)
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
        //.backgroundColor = .black
        calView.backgroundColor = .white
        calView.availableDateRange = interval
        //view.dateSelection(UICalendarSelectionSingleDate, canSelectDate: DateComponents?)
        calView.calendar = .current
        calView.locale = .current
        calView.fontDesign = .rounded
        return calView
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }
}
