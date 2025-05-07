import Foundation

struct DogBreedsResponse: Decodable {
    let message: [String: [String]]
    let status: String
}

struct DogImageResponse: Decodable {
    let message: [String]
    let status: String
}


