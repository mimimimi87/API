import SwiftUI

struct Favorites: View {
    @Binding var favoriteBreeds: Set<String>

    var body: some View {
        VStack {
            if favoriteBreeds.isEmpty {
                Text("No favorite breeds yet.")
                    .font(.title2)
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(favoriteBreeds.sorted(), id: \.self) { breed in
                        NavigationLink(destination: BreedDetailView(breed: breed, favoriteBreeds: $favoriteBreeds)) {
                            Text(breed.capitalized)
                        }
                    }
                    .onDelete(perform: removeFavorite)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Favorites")
    }

    func removeFavorite(at offsets: IndexSet) {
        let sortedBreeds = favoriteBreeds.sorted()
        for offset in offsets {
            let breedToRemove = sortedBreeds[offset]
            favoriteBreeds.remove(breedToRemove)
        }
    }
}
