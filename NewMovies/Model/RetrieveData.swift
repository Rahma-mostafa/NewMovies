//
//  DecodeApiResponse.swift
//  NewMovies
//
//  Created by Rahma on 10/19/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class RetrieveData{
    func getDataFromApi( array: [Movie]) {
        Alamofire.request(URL(string: APIKey.BASE_API_URL.rawValue)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON {[weak self] (response) in
            print("Connect")
            if response.data != nil {
                let jsonDecoder = JSONDecoder()
                let model = try? jsonDecoder.decode(MoviesPlayList.self, from: response.data!)
                var array = array
                array = model!.results
                print(array)


            }else{
                print("nil")
                return
            }
        }
    }
 
}
