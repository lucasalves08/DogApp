//
//  SubBreedDetailsViewController.swift
//  DogApp
//
//  Created by Lucas A. dos Santos on 14/03/2019.
//  Copyright © 2019 Lucas A. dos Santos. All rights reserved.
//

import UIKit

class SubBreedDetailsViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var subBreeds: [String] = []
    var breed = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        breedLabel.text = breed
        
        DogAPI.requestSubBreedsList(breed: breed, completionHandler: handleSubBreedListResponse(subBreeds:error:))
        
        
        
    }
    func handleSubBreedListResponse(subBreeds:[String], error:Error?){
        self.subBreeds = subBreeds
        DispatchQueue.main.sync {
            self.pickerView.reloadAllComponents()
        }
    }
    func handleRandonImageResponse(imageData: BreedImage?, error: Error?){
        guard let imageURL = URL(string: imageData?.message ?? "") else {
            return
        }
        DogAPI.requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:error:))
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?){
        DispatchQueue.main.sync {
            imageView.image = image
        }
        
    }
    

}

extension SubBreedDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subBreeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subBreeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogAPI.requestRandomImageSubBreed(breed: breed, subBreed: subBreeds[row], completionHandler: handleRandonImageResponse(imageData:error:))
    }
}


