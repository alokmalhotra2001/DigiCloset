import CoreLocation


class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastSeenLocation: CLLocation?
    @Published var currentPlacemark: CLPlacemark?
    
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastSeenLocation = locations.first
        fetchCountryAndCity(for: locations.first)
    }

    func fetchCountryAndCity(for location: CLLocation?) {
        guard let location = location else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            self.currentPlacemark = placemarks?.first
        }
    }
}

//class LocationManger: NSObject, ObservableObject {
//    private let manager = CLLocationManager()
//    @Published var userLocation: CLLocation?
//    @Published var authorizationStatus: CLAuthorizationStatus?
//    static let shared = LocationManger()
//
//    override init() {
//        super.init()
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.startUpdatingLocation()
//    }
//
//    func requestLocation() {
//        manager.requestWhenInUseAuthorization()
//    }
//}
//
//extension LocationManger: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .notDetermined:
//            print("Not determined")
//            authorizationStatus = .notDetermined
//        case .restricted:
//            print("Restricted")
//            authorizationStatus = .restricted
//        case .denied:
//            print("Denied")
//            authorizationStatus = .denied
//        case .authorizedAlways:
//            print("Always")
//            authorizationStatus = .authorizedAlways
//        case .authorizedWhenInUse:
//            print("In Use")
//            authorizationStatus = .authorizedWhenInUse
//        @unknown default:
//            break
//        }
//
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        self.userLocation = location
//    }
//}
