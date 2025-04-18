////
////  NetworkError.swift
////  SwiftMVVMApp
////
////  Created by DarkMoon on 16/04/25.
////
//
//import Foundation
//


enum NetworkError:Error{
    case badURL
    case invalidError(Error)
    case invalidResonse
    case invalidData
    case decodingError(Error)
    
}

