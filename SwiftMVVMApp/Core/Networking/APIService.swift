// Networking/APIService.swift
import Foundation

class APIService: PhotoFetching {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        print("--- APIService instance created (using session: \(session)) ---")
        self.session = session
    }
    
    // 2. Implement the fetchPhotos function
    func fetchPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        
        // --- Create URL ---
        guard let url = URL(string: API.BASEURL) else {
            // If URL is invalid, call completion immediately with failure
            completion(.failure(NetworkError.badURL))
            return
        }
        
        // --- Create URLSession Data Task ---
        // URLSession.shared is a singleton for basic requests
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // This closure executes when the network request completes
            
            // --- Handle Network Error ---
            if let error = error {
                completion(.failure(NetworkError.invalidError(error)))
                return
            }
            
            // --- Check HTTP Response ---
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResonse))
                return
            }
            
            // --- Check Data ---
            // Ensure we actually received data
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            // --- Decode JSON Data ---
            do {
                let decoder = JSONDecoder()
                
                let photos = try decoder.decode([Photo].self, from: data)
                
                // --- Success ---
                // Call completion handler with the decoded photos array
                completion(.success(photos))
                
            } catch let decodingError {
                // If JSON structure doesn't match Photo or is invalid
                completion(.failure(NetworkError.decodingError(decodingError)))
            }
        }
        
        task.resume()
    }
}

