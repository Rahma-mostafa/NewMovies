//
//  FavouriteController.swift
//  NewMovies
//
//  Created by MacBook Pro on 9/21/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit

class FavouriteController: UIViewController {
    @IBOutlet var moviesTableView: UITableView!
    var moviesArray:[Movie] = [Movie()]

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    func setup(){
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }

    

    

}
extension FavouriteController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MoviesCell", owner: self, options: nil)?.first as! MoviesCell
                cell.movieImageView.image = UIImage(named: "yasmine")
                cell.movieNameLabel.text = moviesArray[indexPath.item].name
                cell.categoryLabel.text = moviesArray[indexPath.item].category
                cell.rateLabel.text = moviesArray[indexPath.item].rate
                return cell
    }
    
    
}
