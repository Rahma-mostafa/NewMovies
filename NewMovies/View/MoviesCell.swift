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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
