//
//  DetailsViewController.swift
//  DogApp
//
//  Created by Lucas A. dos Santos on 14/03/2019.
//  Copyright © 2019 Lucas A. dos Santos. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var breed = ""
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var breedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        breedLabel.text = breed
        DogAPI.requestRandomImage(breed: breed, completionHandler: handleRandonImageResponse(imageData:error:))
        
    }
    func handleRandonImageResponse(imageData: BreedImage?, error: Error?){
        guard let imageURL = URL(string: imageData?.message ?? "") else {
            return
        }
        DogAPI.requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:error:))
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?){
        DispatchQueue.main.sync {
            breedImage.image = image
        }
        
    }
    
    @IBAction func moveToSubbreed(_ sender: Any) {
        
    }
}
