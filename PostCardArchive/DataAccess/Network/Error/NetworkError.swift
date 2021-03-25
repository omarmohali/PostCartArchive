//
//  NetworkError.swift
//  PostCardArchive
//
//  Created by Omar Ali on 24/03/2021.
//

import Foundation

enum NetworkError: Error, Equatable {
    case noInternetConnection
    case apiError(statusCode: Int)
    case decodingError
    case encodingError
}
