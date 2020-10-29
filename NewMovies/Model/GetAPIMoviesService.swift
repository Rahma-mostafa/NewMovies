//
//  NetworkingClient.swift
//  NewMovies
//
//  Created by Rahma on 10/27/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import Foundation
import Alamofire
class GetAPIMoviesService{
//    typealias ServiceResponse = (_ movie:[Movie]?) -> Void
//    var callBack:ServiceResponse?
//
//    func getAllMovies(){
//        Alamofire.request(URL(string: APIKey.BASE_API_URL.rawValue)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).response {[weak self] (response) in
//            guard response.data != nil else {
//                self?.callBack?(nil)
//                return
//            }
//            do{
//                let jsonDecoder = JSONDecoder()
//                let model = try?jsonDecoder.decode(MoviesPlayList.self, from: response.data!)
//                let jsonArray = model?.results
//                self?.callBack?(jsonArray)
//            }catch{
//                self?.callBack?(nil)
//            }
//        }
//    }
//
//
//    func completionHandler(callBack: @escaping ServiceResponse) {
//          self.callBack = callBack
//    }
    typealias ServiceResponse = (_ movie:[Movie]?) -> Void

    func getAllMovies(completion: @escaping ServiceResponse){
        Alamofire.request(URL(string: APIKey.BASE_API_URL.rawValue)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).response { response in
            guard response.data != nil else {
                completion(nil)
                return
            }
                let jsonDecoder = JSONDecoder()
                let model = try?jsonDecoder.decode(MoviesPlayList.self, from: response.data!)
                let jsonArray = model?.results
                completion(jsonArray)

        }
    }
        

}
