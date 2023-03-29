import SwiftUI

struct TabContainer: View {
    
    var body: some View {
        TabView{
            NavigationView { MyCloset() }
                .tabItem { Label("My Closet", systemImage: "house") }
            NavigationView { Today() }
                .tabItem { Label("Today", systemImage: "thermometer.medium") }
            NavigationView { Calendar() }
                .tabItem { Label("Calendar", systemImage: "calendar") }
            NavigationView { Donate() }
                .tabItem { Label("Donate", systemImage: "box.truck") }
        }
    }
}

struct TabContainer_Previews: PreviewProvider {
    static var previews: some View {
        TabContainer()
    }
}
