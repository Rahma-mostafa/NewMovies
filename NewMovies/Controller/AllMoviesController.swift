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
    @IBOutlet weak var titlename: UILabel!
    
    var resultsArray: [Movie] = []
    var newResults: [Movie] = []
    var selectedRow: Movie?
    var currentPage: Int = 1
    let colorArray:[UIColor] = [UIColor(red: 0.50, green: 0, blue: 0.6, alpha: 0.9),UIColor(red: 0, green: 0, blue: 0.6, alpha: 0.7),UIColor(red: 0.50, green: 0, blue: 0, alpha: 0.7),UIColor(red: 0.50, green: 0, blue: 0.6, alpha: 0.7),UIColor(red: 0.3, green: 0, blue: 0.3, alpha: 0.8),UIColor(red: 0.50, green: 0, blue: 0.6, alpha: 0.9),UIColor(red: 0.50, green: 0, blue: 1.6, alpha: 0.7),UIColor(red: 0.4, green: 0.2, blue: 0.6, alpha: 0.16),UIColor(red: 0.50, green: 0, blue: 0.2, alpha: 0.9),UIColor(red: 0.8, green: 0, blue: 0.6, alpha: 0.7)]
    var index: Int = 0
    var backgroundColor: UIColor?
    var responseData: Data?
    let jsonDecoder = JSONDecoder()
//    let retrieveData = RetrieveData()
    private let netwokingClient = GetAPIMoviesService()

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getData()
        addPullToRefresh()
    }
    
    private func setup(){
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
    
//    private func getData(){
//        Alamofire.request(URL(string: APIKey.BASE_API_URL.rawValue)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON {[weak self] (response) in
//            if let self = self {
//                self.responseData = response.data
//                self.decodeResponseData()
//            }else{
//                return
//            }
//        }
//    }
    private func getData(){
//        retrieveData.getDataFromApi(array: resultsArray)
//        print(resultsArray)
//        netwokingClient.execute{ (json, error) in
//            if let error = error {
//                print(error)
//            }else if let json = json{
//                self.titlename.text = json.description
//                print(json.description)
//            }
//        }
        netwokingClient.completionHandler {[weak self] (movie) in
            guard let self = self else { return}
            if let _movie = movie {
            self.resultsArray = _movie
            self.moviesTableView.reloadData()
            print(self.resultsArray)
            }else{
                print("nil")
                return
            }

        }
        netwokingClient.getAllMovies()


        self.moviesTableView.reloadData()
        print("reloaded")
    }

    
    private func getMoreData(){
        Alamofire.request(URL(string: APIKey.BASE_API_URL.rawValue + "\(currentPage)")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON {[weak self] (response) in
            if let self = self {
                self.responseData = response.data
                self.decodeCurrentPageResponse()
            }else{
                return
            }
        }
    }
    
    private func addPullToRefresh(){
        //Closure
        moviesTableView.addPullToRefresh {[weak self] in
            guard let self = self else{ return }
            self.currentPage = self.currentPage + 1
            self.getMoreData()
        }
    }
//    private func decodeResponseData(){
//        let model = try? jsonDecoder.decode(MoviesPlayList.self, from: self.responseData!)
//        self.resultsArray = model!.results
//        self.moviesTableView.reloadData()
//    }
    private func decodeCurrentPageResponse(){
        let model = try? jsonDecoder.decode(MoviesPlayList.self, from: responseData!)
        var newResults = model!.results
        newResults += self.resultsArray
        self.resultsArray = newResults
        self.moviesTableView.reloadData()
        self.moviesTableView.pullToRefreshView.stopAnimating()
    }
}
extension AllMoviesController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MoviesCell", owner: self, options: nil)?.first as! MoviesCell
        cell.config(movie: resultsArray[indexPath.row])
        self.index = indexPath.row % colorArray.count
        if indexPath.item < colorArray.count{
            cell.roundedView.backgroundColor = colorArray[indexPath.item]
        }else{
            cell.roundedView.backgroundColor = colorArray[index]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = self.resultsArray[indexPath.row]
        self.index = indexPath.row % colorArray.count
        if indexPath.item < colorArray.count{
            self.backgroundColor = colorArray[indexPath.row]
        }else{
            self.backgroundColor = colorArray[index]
        }
        pushViewController()
    }
    private func pushViewController(){
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "DetailsController") as! DetailsController
        scene.selectedRow = self.selectedRow
        scene.backgroundColor = self.backgroundColor
        navigationController?.pushViewController(scene, animated: true)
    }
    
    
}

