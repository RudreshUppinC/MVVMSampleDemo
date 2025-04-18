//
//  Photo.swift
//  SwiftMVVMApp
//
//  Created by DarkMoon on 16/04/25.
//

import Foundation

import Foundation

struct Photo: Codable, Identifiable, Hashable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let downloadUrl: String // Matches API key "download_url"

    // Use CodingKeys to map snake_case API keys to camelCase Swift properties
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadUrl = "download_url"
    }
}
