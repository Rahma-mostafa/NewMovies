//
//  DetailsController.swift
//  NewMovies
//
//  Created by MacBook Pro on 9/21/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {
    @IBOutlet var movieNameLabel: UILabel!
    @IBOutlet var movieCategoryLabel: UILabel!
    @IBOutlet var movieImageView: UIImageView!
    
    @IBOutlet var videoImageView: UIImageView!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setCornerRadius()
        

    }
    func setCornerRadius(){
        movieImageView.layer.cornerRadius = 32
        videoImageView.layer.cornerRadius = 8
    }
    @IBAction func onBackButtonTapped(_ sender: Any) {
    }
    @IBAction func onFavouriteButtonTapped(_ sender: Any) {
    }
    


}
