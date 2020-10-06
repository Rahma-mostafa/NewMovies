//
//  ViewController.swift
//  NewMovies
//
//  Created by MacBook Pro on 9/20/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import KRProgressHUD
import SVPullToRefresh


class AllMoviesController: UIViewController {
//    struct Colors: UIColor, Codable {
//        var red: Double
//        var green: Double
//        var blue: Double
//        var alpha: Double
//    }

    @IBOutlet var moviesTableView: UITableView!
    //variables
    var resultsArray: [Result] = []
    var newResults: [Result] = []
    var selectedRow: Result?
//    var selectedRowColor: Colors?
    let baseImageUrl = "https://image.tmdb.org/t/p/original"
    var currentPage: Int = 1
    let colorArray:[UIColor] = [UIColor(red: 0.50, green: 0, blue: 0.6, alpha: 0.9),UIColor(red: 0, green: 0, blue: 0.6, alpha: 0.7),UIColor(red: 0.50, green: 0, blue: 0, alpha: 0.7),UIColor(red: 0.50, green: 0, blue: 0.6, alpha: 0.7),UIColor(red: 0.3, green: 0, blue: 0.3, alpha: 0.8),UIColor(red: 0.50, green: 0, blue: 0.6, alpha: 0.9),UIColor(red: 0.50, green: 0, blue: 1.6, alpha: 0.7),UIColor(red: 0.4, green: 0.2, blue: 0.6, alpha: 0.16),UIColor(red: 0.50, green: 0, blue: 0.2, alpha: 0.9),UIColor(red: 0.8, green: 0, blue: 0.6, alpha: 0.7)]
    var index: Int = 0
    

  
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getData()
        moviesTableView.addPullToRefresh {
            self.currentPage = self.currentPage + 1
            self.getMoreData()
          }
    
    }
    func setup(){
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
    func getData(){
        Alamofire.request(URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=1344b54a76b1c0901f3215aef89a1139&language=en-US&page=1")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON {[weak self] (response) in
            if let self = self {
                 let jsonDecoder = JSONDecoder()
                 let model = try? jsonDecoder.decode(Welcome.self, from: response.data!)
                self.resultsArray = model!.results
                self.moviesTableView.reloadData()
            }else{
                return
            }
        }
    }
    func getMoreData(){
        Alamofire.request(URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=1344b54a76b1c0901f3215aef89a1139&language=en-US&page=\(currentPage)")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON {[weak self] (response) in
             if let self = self {
                    let jsonDecoder = JSONDecoder()
                    let model = try? jsonDecoder.decode(Welcome.self, from: response.data!)
                    var newResults = model!.results
                    newResults += self.resultsArray
                    self.resultsArray = newResults
                    self.moviesTableView.reloadData()
                    self.moviesTableView.pullToRefreshView.stopAnimating()
            }else{
                return
            }
        }
    }
    


}
extension AllMoviesController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MoviesCell", owner: self, options: nil)?.first as! MoviesCell
        cell.movieNameLabel.text = resultsArray[indexPath.item].originalTitle
        cell.categoryLabel.text = resultsArray[indexPath.item].releaseDate
        cell.rateLabel.text = "\( resultsArray[indexPath.item].voteAverage)"
        let posterPath = resultsArray[indexPath.row].posterPath
        let url = URL(string: "\(baseImageUrl)" + "\(posterPath)")
        cell.movieImageView.sd_setImage(with: url )
        self.index = indexPath.row % colorArray.count
        if indexPath.item < colorArray.count{
            cell.roundedView.backgroundColor = colorArray[indexPath.item]
        }else{
            cell.roundedView.backgroundColor = colorArray[index]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "DetailsController") as! DetailsController
        scene.selectedRow = self.resultsArray[indexPath.row]
        
        self.index = indexPath.row % colorArray.count
        if indexPath.item < colorArray.count{
            scene.backgroundColor = colorArray[indexPath.row]
//            scene.selectedRowColor = colorArray[indexPath.row]
        }else{
            scene.backgroundColor = colorArray[index]
//            scene.selectedRowColor = colorArray[index]
        }
        navigationController?.pushViewController(scene, animated: true)
    }
  
 

 
    
    
    
}

