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
        case randomImageForBreed(String)
        
        var url:URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
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
            completionHandler(breeds, nil)
        }
        task.resume()
    }
    
    class func requestRandomImage(breed: String, completionHandler: @escaping (BreedImage?,Error?) -> Void){
        let randomImageEndPoint = DogAPI.Endpoint.randomImageForBreed(breed).url
        let task = URLSession.shared.dataTask(with: randomImageEndPoint) {
            (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(BreedImage.self, from: data)
            completionHandler(imageData, nil)
        }
        task.resume()
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)
        })
        task.resume()
    }
    
}






