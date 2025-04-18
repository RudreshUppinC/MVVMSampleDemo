//
//  PhotoFetchingProtocal.swift
//  SwiftMVVMApp
//
//  Created by DarkMoon on 16/04/25.
//

import Foundation
import Foundation


import Foundation

protocol PhotoFetching {
    func fetchPhotos(completion: @escaping (Result<[Photo], Error>) -> Void)
}
