//
//  DogListTableViewController.swift
//  DogApp
//
//  Created by Lucas A. dos Santos on 14/03/2019.
//  Copyright © 2019 Lucas A. dos Santos. All rights reserved.
//

import UIKit

class DogListTableViewController: UITableViewController {
    
    var breeds: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        DogAPI.requestBreedsList(completionHandler: handleBreedsListResponse(breeds:error:))
        
    }
    
    func handleBreedsListResponse(breeds: [String], error: Error?){
        self.breeds = breeds
        DispatchQueue.main.sync {
            self.tableView.reloadData()
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return breeds.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        breeds.sort()
        let selectBreed = breeds[indexPath.row]
        cell.textLabel?.text = selectBreed
        return cell
    }


    


}
