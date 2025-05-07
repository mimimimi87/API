import SwiftUI


struct BrowseView: View {
    @Binding var favoriteBreeds: Set<String>
    @State public var searchText: String = ""
    @State public var allBreeds: [String] = []
    @State public var filteredBreeds: [String] = []
    @State  public var isLoading: Bool = false
    @State public var errorMessage: String?
    
    
    
    
    var body: some View {
        VStack {
            TextField("Enter breed", text: $searchText)
                .padding()
            // .autocapitalization(.none)
                .onChange(of: searchText) { newValue in
                    filterBreeds(searchText: newValue)
                }
            
            
            
            if isLoading {
                ProgressView("Fetching Breeds...")
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                List {
                    ForEach(searchText.isEmpty ? allBreeds : filteredBreeds, id: \.self) { breed in
                        NavigationLink(destination: BreedDetailView(breed: breed, favoriteBreeds: $favoriteBreeds)) {
                            Text(breed.capitalized)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        
        .navigationTitle("Dog Breeds")
        .onAppear {
            if allBreeds.isEmpty {
                fetchBreeds()
            }
            
        }
    }
    func fetchBreeds() {
        isLoading = true
        DogAPI.shared.getAllBreeds { result in
            DispatchQueue.main
            isLoading = false
            switch result {
            case .success( let breedsResponse):
                self.allBreeds = Array(breedsResponse.message.keys).sorted()
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                
            }
        }
        
    }
    
    
    func filterBreeds(searchText: String) {
        if searchText.isEmpty {
            filteredBreeds = []
        } else {
            filteredBreeds = allBreeds.filter { $0.localizedCaseInsensitiveContains(searchText) }.sorted()
        }
    }
    
}

