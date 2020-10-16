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
    var favArray = [Movie]()
    var index: Int?
    let jsonDecoder = JSONDecoder()
    let jsonEncoder = JSONEncoder()




    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        self.hiddenNav = true
        
    }

    func setData(){
        self.backgroundView.backgroundColor = backgroundColor
        self.movieNameLabel.text = selectedRow?.originalTitle ?? ""
        self.movieCategoryLabel.text = selectedRow?.releaseDate ?? ""
        self.descriptionLabel.text = selectedRow?.overview ?? ""
        self.rateLabel.text = "\(String(describing: selectedRow?.voteAverage ?? 0 ))"
        let posterPath = selectedRow?.posterPath ?? ""
        let url = URL(string: "\(APIKey.BASE_IMAGE_URL.rawValue)" + "\(String(describing: posterPath))")
        self.movieImageView.sd_setImage(with: url)
        let videoImageUrl = selectedRow?.backdropPath ?? ""
        let ImageUrl = URL(string: "\(APIKey.BASE_IMAGE_URL.rawValue)" + "\(String(describing: videoImageUrl))")
        self.videoImageView.sd_setImage(with: ImageUrl)
    }

    @IBAction func onBackButtonTapped(_ sender: Any) {
        back()
    }
    @IBAction func onPlayButtonTapped(_ sender: Any) {
        openURL(url: APIKey.VIDEO_URL.rawValue)
    }
    @IBAction func onFavouriteButtonTapped(_ sender: Any) {
        setFavButtonImage()
        decodeFavMoviesSaved()
        pushFavouriteController()
        removeRepeatedMovies()
        saveNewMovie()
    }
    private func setFavButtonImage(){
        let image = UIImage(named: "star (3)")
        favButton.setImage(image , for: .normal)
    }
    private func decodeFavMoviesSaved(){
        let favMovies = UserDefaults.standard.data(forKey: "favMovies")
        if favMovies != nil{
            favArray = try! jsonDecoder.decode([Movie].self, from: favMovies!)
        }
    }
    private func removeRepeatedMovies(){
        for index in 0 ..< favArray.count{
            if selectedRow?.id ==  favArray[index].id{
                self.index = index
                print(index)
                favArray.remove(at: index)
                break
            }else{
            }
        }
        favArray.append(selectedRow!)
    }
    private func saveNewMovie(){
        let newFavMovies = try! jsonEncoder.encode(favArray)
        UserDefaults.standard.set(newFavMovies, forKey: "favMovies")
    }
    private func pushFavouriteController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "FavouriteController") as! FavouriteController
        scene.backgroundColor = self.backgroundColor
        scene.index = self.index
        navigationController?.pushViewController(scene, animated: true)
        
    }



}







