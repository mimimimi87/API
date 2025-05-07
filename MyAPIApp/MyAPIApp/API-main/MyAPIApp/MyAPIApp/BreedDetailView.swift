import SwiftUI

struct BreedDetailView: View {
    let breed: String
    @Binding var favoriteBreeds: Set<String>
    @State private var imageUrl: URL?
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    
    var isFavorited: Bool {
        favoriteBreeds.contains(breed)
    }
    
    var body: some View {
        VStack {
            Text(breed.capitalized)
                .font(.largeTitle)
                .padding()
            
            if isLoading {
                ProgressView("Fetching Image...")
            } else if let imageUrl = imageUrl {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 100, maxHeight: 100)
                        .foregroundColor(.gray)
                }
                .padding()
            } else if let errorMessage = errorMessage {
                Text("Error loading image: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                Text("No image available.")
                    .foregroundColor(.gray)
                    .padding()
            }
            
            Button {
                if isFavorited {
                    favoriteBreeds.remove(breed)
                } else {
                    favoriteBreeds.insert(breed)
                }
            } label: {
                Image(systemName: isFavorited ? "heart.fill" : "heart")
                    .font(.title)
                    .foregroundColor(.red)
                    .padding()
            }
            .buttonStyle(.plain)
            
            Spacer()
        }
        .navigationTitle(breed.capitalized)
        //.navigationBarTitleDisplayMode(.inline)
//        .onAppear {
//            fetchRandomImage(for: breed)
//            
//            
//            
//        }
        
        
        
    }
//    func fetchRandomImage(for breed: String)
//    {
//        isLoading = true
//        DogAPI.shared.getRandomImage(for: breed) { result in
//            DispatchQueue.main
//            isLoading = false
//            switch result {
//            case .success(let imageResponse):
//                if let urlString = imageResponse.message.first, let url = URL(string: urlString) {
//                    self.imageUrl = url
//                } else {
//                    self.errorMessage = "Invalid image URL received."
//                }
//            case .failure(let error):
//                self.errorMessage = error.localizedDescription
//            }
//            
//        }
//        
//    }
}
