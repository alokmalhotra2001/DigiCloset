import SwiftUI

struct TabContainer: View {
    
    var body: some View {
        TabView{
            NavigationView { MyCloset() }
                .tabItem { Label("My Closet", systemImage: "list.star") }
            NavigationView { Today() }
                .tabItem { Label("Today", systemImage: "book") }
            NavigationView { Calendar() }
                .tabItem { Label("Calendar", systemImage: "list.star") }
            NavigationView { Donate() }
                .tabItem { Label("Donate", systemImage: "list.star") }
        }
    }
}

struct TabContainer_Previews: PreviewProvider {
    static var previews: some View {
        TabContainer()
    }
}
