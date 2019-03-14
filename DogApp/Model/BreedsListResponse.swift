//
//  BreedsListResponse.swift
//  DogApp
//
//  Created by Lucas A. dos Santos on 14/03/2019.
//  Copyright © 2019 Lucas A. dos Santos. All rights reserved.
//

import Foundation

class BreedsListResponse: Codable {
    let status: String
    let message: [String: [String]]
}
