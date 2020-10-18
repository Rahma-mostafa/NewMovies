//
//  MoviesCell.swift
//  NewMovies
//
//  Created by MacBook Pro on 9/20/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit

class MoviesCell: UITableViewCell {

    @IBOutlet var roundedView: UIView!
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieNameLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedView.layer.cornerRadius = 16
        movieImageView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(movie: Movie){
        movieNameLabel.text = movie.originalTitle
        categoryLabel.text = movie.releaseDate
        rateLabel.text = "\(movie.voteAverage)"
        let postPath = URL(string: "\(APIKey.BASE_IMAGE_URL.rawValue)\(movie.posterPath)")
        movieImageView.sd_setImage(with: postPath!)
    }
    
    
}
