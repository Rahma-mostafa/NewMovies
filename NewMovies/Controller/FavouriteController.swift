//
//  FavouriteController.swift
//  NewMovies
//
//  Created by MacBook Pro on 9/21/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit

class FavouriteController: BaseController {
    @IBOutlet var moviesTableView: UITableView!
    var moviesArray:[Movie] = [Movie()]
    var selectedRow:Result?
    var favourite: Any?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.hiddenNav = true
        let movieName = UserDefaults.standard.string(forKey: "movieName")
       let object =  Movie(image: "movieName", name: movieName, category: "movieName", rate: "movieName")
        self.moviesArray.append(object)
        self.moviesTableView.reloadData()


    }
    func setup(){
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
    @IBAction func onBackButtobTapped(_ sender: Any) {
        back()
    }
    
    

    

}
extension FavouriteController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MoviesCell", owner: self, options: nil)?.first as! MoviesCell
//                cell.movieImageView.image = UIImage(named: "yasmine")

        cell.movieNameLabel.text = moviesArray[indexPath.item].name
//                cell.categoryLabel.text = moviesArray[indexPath.item].category
//                cell.rateLabel.text = moviesArray[indexPath.item].rate
                return cell
    }
    
    
}
