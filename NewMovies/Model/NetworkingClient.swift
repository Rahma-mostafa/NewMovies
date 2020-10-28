//
//  NetworkingClient.swift
//  NewMovies
//
//  Created by Rahma on 10/27/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import Foundation
import Alamofire
class NetWorkingClient{
//    typealias ServiceResponse = ([[String: Any]]?, Error?) -> Void
    typealias ServiceResponse = (_ movie:[Movie]?) -> Void
    var callBack:ServiceResponse?

     
//    func execute(completion: @escaping ServiceResponse ){
//        Alamofire.request(URL(string: APIKey.BASE_API_URL.rawValue)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).validate().responseJSON { response in
//            if let error = response.error{
//                completion(nil, error)
//            }else if let jsonArrray = response.result.value as? [[String: Any]]{
//                let jsonDecoder = JSONDecoder()
//                let model = try? jsonDecoder.decode(MoviesPlayList.self, from: response.data!)
//
//                completion(jsonArrray, nil)
//            }
//        }
//    }
    func getAllMovies(){
        Alamofire.request(URL(string: APIKey.BASE_API_URL.rawValue)!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).response { (response) in
            guard let data = response.data else {
                self.callBack?(nil)
                return
            }
            do{
                let jsonDecoder = JSONDecoder()
                let model = try?jsonDecoder.decode(MoviesPlayList.self, from: response.data!)
                let jsonArray = model?.results
                self.callBack?(jsonArray)
            }catch{
                self.callBack?(nil)
            }
        }
    }
        
    
    func completionHandler(callBack: @escaping ServiceResponse) {
          self.callBack = callBack
    }
}
