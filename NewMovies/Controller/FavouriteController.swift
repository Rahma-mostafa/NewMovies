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
    var favArray = [Result]()
//    var selectedRow:Result?
    var backgroundColor: UIColor?



    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setData()
        self.hiddenNav = true
 

    }
    func setup(){
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
    func setData(){
        let favMovies = UserDefaults.standard.data(forKey: "favMovies")
        let jsonDecoder = JSONDecoder()
        favArray = try! jsonDecoder.decode([Result].self, from: favMovies!)
        self.moviesTableView.reloadData()

    }
    @IBAction func onBackButtobTapped(_ sender: Any) {
        back()
    }
}
extension FavouriteController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MoviesCell", owner: self, options: nil)?.first as! MoviesCell
//        cell.roundedView.backgroundColor = colorArray[indexPath.row]
//                cell.movieImageView.image = UIImage(named: "yasmine")
        cell.movieNameLabel.text = favArray[indexPath.item].originalTitle
//                cell.categoryLabel.text = moviesArray[indexPath.item].category
//                cell.rateLabel.text = moviesArray[indexPath.item].rate
        
                return cell
    }
    
    
}
