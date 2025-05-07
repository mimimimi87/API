//
//  DogAPI.swift
//  MyAPIApp
//
//  Created by Will on 5/6/25.
//

import SwiftUI

//
//  Data.swift
//  MyAPIApp
//
//  Created by Will on 5/6/25.
//

import Foundation

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid API response."
        case .decodingError:
            return "Error decoding the response."
        }
    }
}

struct DogAPI {
    static let shared = DogAPI()
    private init() {}
    
    private let baseURL = "https://dog.ceo/api"
    
    func getAllBreeds(completion: @escaping (Result<DogBreedsResponse, APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/breeds/list/all") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(DogBreedsResponse.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func getRandomImage(for breed: String, completion: @escaping (Result<DogImageResponse, APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/breed/\(breed)/images/random") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(DogImageResponse.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}





