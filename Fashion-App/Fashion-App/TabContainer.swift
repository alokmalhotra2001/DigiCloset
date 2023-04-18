import SwiftUI
import CoreLocation

struct TabContainer: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var coordinate: CLLocationCoordinate2D? { locationViewModel.lastSeenLocation?.coordinate }
    
    var body: some View {
        TabView{
            NavigationView { MyCloset() }
                .tabItem { Label("My Closet", systemImage: "cabinet.fill") }
            NavigationView { Today(location: CLLocationCoordinate2D(latitude: coordinate?.latitude ?? 0, longitude: coordinate?.longitude ?? 0)) }
                .tabItem { Label("Today", systemImage: "thermometer.medium") }
            NavigationView { Calendar(location: CLLocationCoordinate2D(latitude: coordinate?.latitude ?? 0, longitude: coordinate?.longitude ?? 0)) }
                .tabItem { Label("Calendar", systemImage: "calendar") }
            NavigationView { Donate() }
                .tabItem { Label("Donate", systemImage: "box.truck") }
        }
            .environmentObject(locationViewModel)
    }
}

struct LocationRequestView: View {
    @StateObject var locationViewModel = LocationViewModel()
    
    var body: some View {
        switch locationViewModel.authorizationStatus {
        case .notDetermined:
            AnyView(LocationAccessView())
                .environmentObject(locationViewModel)
        case .restricted:
            ErrorView(errorText: "Location use is restricted.")
        case .denied:
            ErrorView(errorText: "FashionApp requires location permissions to provide optimal outfit recommendations. Please enable them in settings.")
        case .authorizedAlways, .authorizedWhenInUse:
            TabContainer().environmentObject(locationViewModel)
        default:
            Text("Unexpected status")
        }
    
    }
}

struct ErrorView: View {
    var errorText: String
    
    var body: some View {
        ZStack {
            Color(.systemRed).ignoresSafeArea()
            
            VStack {
                Image(systemName: "xmark.octagon")
                        .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                Text(errorText)
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.red)
        }
    }
}
