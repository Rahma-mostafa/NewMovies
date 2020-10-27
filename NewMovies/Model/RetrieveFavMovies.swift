//
//  RetrieveFavMovies.swift
//  NewMovies
//
//  Created by Rahma on 10/27/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import Foundation
import UIKit
class RetrieveFavMovies{
    var favArray = [Movie]()
    func FavMoviesSaved(){
        let favMovies = UserDefaults.standard.data(forKey: "favMovies")
        let jsonDecoder = JSONDecoder()
        favArray = try! jsonDecoder.decode([Movie].self, from: favMovies!)
    }
}
