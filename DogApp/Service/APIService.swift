//
//  APIService.swift
//  DogApp
//
//  Created by Lucas A. dos Santos on 14/03/2019.
//  Copyright © 2019 Lucas A. dos Santos. All rights reserved.
//

import Foundation
import UIKit

class DogAPI {
    
    enum APIError: String, Error {
        case noNetwork = "No Network"
        case serverOverload = "Server is overloaded"
        case permissionDenied = "You don't have permission"
    }
    
    enum Endpoint {
        case listAllBreeds
        
        var url:URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    
    class func requestBreedsList(completionHandler: @escaping([String],Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoint.listAllBreeds.url) {
            (data, reponse, error) in
            guard let data = data else {
                completionHandler([],error)
                return
            }
            let decoder = JSONDecoder()
            let breedsReponse = try! decoder.decode(BreedsListResponse.self, from: data)
            let breeds = breedsReponse.message.keys.map({$0})
            print(breeds)
            completionHandler(breeds, nil)
        }
        task.resume()
        
    }
}






