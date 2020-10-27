//
//  FavouriteController.swift
//  NewMovies
//
//  Created by MacBook Pro on 9/21/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit
import SDWebImage

class FavouriteController: BaseController {
    @IBOutlet var moviesTableView: UITableView!
    var favArray = [Movie]()
//    var selectedRow:Result?
    var backgroundColor: UIColor?
    let baseImageUrl = "https://image.tmdb.org/t/p/original"
    var colorArray = [UIColor]()
    var index: Int?




    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.hiddenNav = true
//        self.colorArray.append(backgroundColor!)
//        print(colorArray)
        readFavMoviesSaved()
 

    }
   private func setup(){
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
    private func readFavMoviesSaved(){
        let favMovies = UserDefaults.standard.data(forKey: "favMovies")
        let jsonDecoder = JSONDecoder()
        favArray = try! jsonDecoder.decode([Movie].self, from: favMovies!)
//        let retriveFavMovies = RetrieveFavMovies()
//        retriveFavMovies.FavMoviesSaved()
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
        cell.config(movie: favArray[indexPath.row])
        return cell
    }
    
    
}
