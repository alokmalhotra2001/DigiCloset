import SwiftUI

@main
struct Fashion_AppApp: App {
    @StateObject var wardrobeStore = WardrobeStore()
    
    var body: some Scene {
        WindowGroup {
            TabContainer().environmentObject(wardrobeStore)
        }
    }
}

//@main
//struct midtermApp: App {
//    @StateObject var synopsisLoader = SynopsisLoader( apiClient: OpenLibraryAPIClient() )
//    @StateObject var dataStore = DataStore()
//
//    var body: some Scene {
//        WindowGroup { TabContainer().environmentObject(synopsisLoader).environmentObject(dataStore) }
//    }
// }
