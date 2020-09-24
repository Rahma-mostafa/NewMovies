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


class DetailsController: UIViewController {
    @IBOutlet var movieNameLabel: UILabel!
    @IBOutlet var movieCategoryLabel: UILabel!
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var videoImageView: UIImageView!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    //variables
    
    var selectedRow:[Result] = []
    let baseImageUrl = "https://image.tmdb.org/t/p/original"
    override func viewDidLoad() {
        super.viewDidLoad()
        setCornerRadius()
        setData()
    }
    func setData(){
        self.movieNameLabel.text = selectedRow[0].originalTitle
        self.movieCategoryLabel.text = selectedRow[0].releaseDate
        self.descriptionLabel.text = selectedRow[0].overview
        self.rateLabel.text = "\(selectedRow[0].voteAverage)"
        let posterPath = selectedRow[0].posterPath
        let url = URL(string: "\(baseImageUrl)" + "\(posterPath)")
        self.movieImageView.sd_setImage(with: url)
        let videoImageUrl = selectedRow[0].backdropPath
        let ImageUrl = URL(string: "\(baseImageUrl)" + "\(videoImageUrl)")
        self.videoImageView.sd_setImage(with: ImageUrl)

        

    }
    func setCornerRadius(){
        movieImageView.layer.cornerRadius = 32
        videoImageView.layer.cornerRadius = 8
    }
    
    @IBAction func onBackButtonTapped(_ sender: Any) {
    }
    @IBAction func onFavouriteButtonTapped(_ sender: Any) {
    }
    @IBAction func onPlayButtonTapped(_ sender: Any) {

    }

}

//protocol videoCellDelegate {
//    func didTapWatchNow(url: String)
//}
//var delegate: videoCellDelegate?




