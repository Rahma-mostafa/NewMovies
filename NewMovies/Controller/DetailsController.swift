//
//  DetailsController.swift
//  NewMovies
//
//  Created by MacBook Pro on 9/21/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import KRProgressHUD
import SafariServices




class DetailsController: BaseController  {
    @IBOutlet var movieNameLabel: UILabel!
    @IBOutlet var movieCategoryLabel: UILabel!
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var videoImageView: UIImageView!
    @IBOutlet var shadowView: UIView!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var subview: UIView!
    @IBOutlet weak var favButton: UIButton!
    //variables
    var selectedRow:Movie? //passed array that has the selected Item
    var backgroundColor: UIColor?
//    var colorArray: [Colors] = []
//    var selectedRowColor: Colors?
    let baseImageUrl = "https://image.tmdb.org/t/p/original"
    // I assume any static videoUrl for all items as the api used does't have videos url
    let videoUrl = "https://www.youtube.com/watch?v=cjzu8pzx1Wc&t=1s&has_verified=1"
    var favArray = [Movie]()



    override func viewDidLoad() {
        super.viewDidLoad()
        setCornerRadius()
        setData()
        self.hiddenNav = true
    }
    func setCornerRadius(){
        movieImageView.layer.cornerRadius = 29
        videoImageView.layer.cornerRadius = 16
        shadowView.layer.cornerRadius = 16
    }
    func setData(){
        self.backgroundView.backgroundColor = backgroundColor
        self.movieNameLabel.text = selectedRow?.originalTitle ?? ""
        self.movieCategoryLabel.text = selectedRow?.releaseDate ?? ""
        self.descriptionLabel.text = selectedRow?.overview ?? ""
        self.rateLabel.text = "\(String(describing: selectedRow?.voteAverage ?? 0 ))"
        let posterPath = selectedRow?.posterPath ?? ""
        let url = URL(string: "\(baseImageUrl)" + "\(String(describing: posterPath))")
          print(posterPath)
        self.movieImageView.sd_setImage(with: url)
        let videoImageUrl = selectedRow?.backdropPath ?? ""
        let ImageUrl = URL(string: "\(baseImageUrl)" + "\(String(describing: videoImageUrl))")
        self.videoImageView.sd_setImage(with: ImageUrl)
    }
    func didTapWatchNow(url: String){
         let videoURL = URL(string: url)!
         let safariVC = SFSafariViewController(url: videoURL)
         self.present(safariVC, animated: true, completion: nil)
     }
    
    @IBAction func onBackButtonTapped(_ sender: Any) {
        back()
    }
    @IBAction func onPlayButtonTapped(_ sender: Any) {
        didTapWatchNow(url: videoUrl)
    }
    @IBAction func onFavouriteButtonTapped(_ sender: Any) {
        let image = UIImage(named: "star (3)")
        favButton.setImage(image , for: .normal)
        let favMovies = UserDefaults.standard.data(forKey: "favMovies")
        let jsonDecoder = JSONDecoder()
        let jsonEncoder = JSONEncoder()
        if favMovies != nil{
            favArray = try! jsonDecoder.decode([Movie].self, from: favMovies!)
        }
        for index in 0 ..< favArray.count{
            if selectedRow?.id ==  favArray[index].id{
                print(index)
                favArray.remove(at: index)
                break
            }else{
            }
        }
        favArray.append(selectedRow!)
        // set newFavMovies to UserDefault
        let newFavMovies = try! jsonEncoder.encode(favArray)
        UserDefaults.standard.set(newFavMovies, forKey: "favMovies")
        // navigate to FavouriteController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "FavouriteController") as! FavouriteController
        navigationController?.pushViewController(scene, animated: true)
        
    }




}
 







