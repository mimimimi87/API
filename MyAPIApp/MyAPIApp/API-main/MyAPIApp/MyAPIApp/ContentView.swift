import SwiftUI

struct ContentView: View {
    @State private var favoriteBreeds: Set<String> = []

    var body: some View {
        TabView {
            NavigationView {
                BrowseView(favoriteBreeds: $favoriteBreeds)
            }
            .tabItem {
                Label("Browse", systemImage: "magnifyingglass")
            }

            NavigationView {
                Favorites(favoriteBreeds: $favoriteBreeds)
            }
            .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
