//
//  PhotoListViewModel.swift
//  SwiftMVVMApp
//
//  Created by DarkMoon on 16/04/25.
//

import Foundation
// ViewModels/PhotoListViewModel.swift
import Foundation

class PhotoListViewModel {
    
    // MARK: - Properties
    
    private let photoService: PhotoFetching
    
    private(set) var photos: [Photo] = []
    
    var onUpdate: (() -> Void)?
    
    // MARK: - Initialization
    
    init(photoService: PhotoFetching) {
        self.photoService = photoService
    }
    
    // MARK: - Data Fetching
    
    func fetchPhotos() {
        photoService.fetchPhotos { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let fetchedPhotos):
                self.photos = fetchedPhotos
                // Notify the view controller via the callback
                self.onUpdate?()
                
            case .failure(let error):
                // Print the error as requested
                let errorMessage = "Error fetching photos: \(error.localizedDescription)"
                print("--- ViewModel Error: \(errorMessage) ---")
                // Optionally clear photos or handle state differently
                self.photos = []
                self.onUpdate?()
            }
        }
    }
    
    // MARK: - TableView Data Source Helpers
    func getnumberOfPhotos() -> Int {
        return photos.count
    }
    
    func photo(at index: Int) -> Photo? {
        guard index >= 0 && index < photos.count else {
            return nil
        }
        return photos[index]
    }
    
    
}
