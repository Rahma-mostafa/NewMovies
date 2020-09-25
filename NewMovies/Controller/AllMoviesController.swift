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

    @IBOutlet var moviesTableView: UITableView!
    //variables
    var resultsArray:[Result] = []
    var selectedRow:[Result] = []
    let baseImageUrl = "https://image.tmdb.org/t/p/original"
    var currentPage: Int = 1

    

    let colorArray:[UIColor] = [UIColor(red: 0.50, green: 0, blue: 0.6, alpha: 0.9),UIColor(red: 0, green: 0, blue: 0.6, alpha: 0.7),UIColor(red: 0.50, green: 0, blue: 0, alpha: 0.7),UIColor(red: 0.50, green: 0, blue: 0.6, alpha: 0.7),UIColor(red: 0.3, green: 0, blue: 0.3, alpha: 0.8),UIColor(red: 0.50, green: 0, blue: 0.6, alpha: 0.9),UIColor(red: 0.50, green: 0, blue: 1.6, alpha: 0.7),UIColor(red: 0.4, green: 0.2, blue: 0.6, alpha: 0.16)]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getData()
        moviesTableView.addPullToRefresh {
              print("Test")
            self.currentPage = self.currentPage + 1
            self.getCoreData()
          }
    
    }
    func setup(){
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
    func getData(){
        Alamofire.request(URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=1344b54a76b1c0901f3215aef89a1139&language=en-US&page=1&fbclid=IwAR1PuKNdOP36m7wipxt3lk3HHJJhYDixpvZLxRa66rqtH2y1T08oeUkH9Kk")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON {[weak self] (response) in
            if let self = self {
//                print(response.response?.statusCode)
//                 print("\(response.data)")
                 let jsonDecoder = JSONDecoder()
                 let model = try? jsonDecoder.decode(Welcome.self, from: response.data!)
                self.resultsArray = model!.results
                self.moviesTableView.reloadData()
            }else{
                return
            }
        }
    }
        func getCoreData(){
            Alamofire.request(URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=1344b54a76b1c0901f3215aef89a1139&language=en-US&page=\(currentPage)&fbclid=IwAR1PuKNdOP36m7wipxt3lk3HHJJhYDixpvZLxRa66rqtH2y1T08oeUkH9Kk")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON {[weak self] (response) in
                if let self = self {
    //                print(response.response?.statusCode)
    //                 print("\(response.data)")
                     let jsonDecoder = JSONDecoder()
                     let model = try? jsonDecoder.decode(Welcome.self, from: response.data!)
                    self.resultsArray = model!.results
                    self.moviesTableView.reloadData()
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
        cell.movieImageView.image = UIImage(named: "yasmine")
        cell.movieNameLabel.text = resultsArray[indexPath.item].originalTitle
        cell.categoryLabel.text = resultsArray[indexPath.item].releaseDate
        cell.rateLabel.text = "\( resultsArray[indexPath.item].voteAverage)"
        let posterPath = resultsArray[indexPath.row].posterPath
        let url = URL(string: "\(baseImageUrl)" + "\(posterPath)")
        cell.movieImageView.sd_setImage(with: url )
    

        
//        var index = indexPath.item
        if indexPath.item < colorArray.count{
            cell.roundedView.backgroundColor = colorArray[indexPath.item]
        }
        

        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        self.selectedRow = [resultsArray[indexPath.row]]
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "DetailsController") as! DetailsController
        scene.selectedRow = self.selectedRow
        navigationController?.pushViewController(scene, animated: true)
             
             
            
    }
  
 

 
    
    
    
}

