//
//  ViewController.swift
//  NewMovies
//
//  Created by MacBook Pro on 9/20/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit

class AllMoviesController: UIViewController {

    @IBOutlet var moviesTableView: UITableView!
    //variables
    var moviesArray:[Movie] = [Movie(image: "yasmine", name: "Fast & Furious Presents",category: "movie", rate: "6.6"),Movie(image: "yasmine", name: "Fast & Furious Presents",category: "movie", rate: "6.6"),Movie(image: "yasmine", name: "Fast & Furious Presents",category: "movie", rate: "6.6"),Movie(image: "yasmine", name: "Fast & Furious Presents",category: "movie", rate: "6.6"),Movie(image: "yasmine", name: "Fast & Furious Presents",category: "movie", rate: "6.6"),Movie(image: "yasmine", name: "Fast & Furious Presents",category: "movie", rate: "6.6"),Movie(image: "yasmine", name: "Fast & Furious Presents",category: "movie", rate: "6.6"),Movie(image: "yasmine", name: "Fast & Furious Presents",category: "movie", rate: "6.6"),Movie(image: "yasmine", name: "Fast & Furious Presents",category: "movie", rate: "6.6"),Movie(image: "yasmine", name: "Fast & Furious Presents",category: "movie", rate: "6.6"),Movie(image: "yasmine", name: "Fast & Furious Presents",category: "movie", rate: "6.6")]
    let colorArray:[UIColor] = [UIColor(red: 0.50, green: 0, blue: 0.6, alpha: 0.9),UIColor(red: 0, green: 0, blue: 0.6, alpha: 0.7),UIColor(red: 0.50, green: 0, blue: 0, alpha: 0.7),UIColor(red: 0.50, green: 0, blue: 0.6, alpha: 0.7),UIColor(red: 0.3, green: 0, blue: 0.3, alpha: 0.8),UIColor(red: 0.50, green: 0, blue: 0.6, alpha: 0.9),UIColor(red: 0.50, green: 0, blue: 1.6, alpha: 0.7),UIColor(red: 0.4, green: 0.2, blue: 0.6, alpha: 0.16)]
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup(){
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }


}
extension AllMoviesController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MoviesCell", owner: self, options: nil)?.first as! MoviesCell
        cell.movieImageView.image = UIImage(named: "yasmine")
        cell.movieNameLabel.text = moviesArray[indexPath.item].name
        cell.categoryLabel.text = moviesArray[indexPath.item].category
        cell.rateLabel.text = moviesArray[indexPath.item].rate

        
//        var index = indexPath.item
        if indexPath.item < colorArray.count{
            cell.roundedView.backgroundColor = colorArray[indexPath.item]
        }
        

        
        return cell
    }
    
    
    
}

