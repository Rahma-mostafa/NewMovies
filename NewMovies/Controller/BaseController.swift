//
//  BaseController.swift
//  Judo
//
//  Created by MacBook Pro on 4/17/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    var hiddenNav: Bool = false
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           if self.hiddenNav {
               // Show the Navigation Bar
               self.navigationController?.setNavigationBarHidden(true, animated: false )
               self.navigationController?.navigationBar.shadowImage = UIImage()

           } else {
               self.navigationController?.setNavigationBarHidden(false, animated: false)
           }
       }

       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           //baseViewModel = nil
           if self.hiddenNav {
               // Show the Navigation Bar
               self.navigationController?.setNavigationBarHidden(true, animated: false)
               self.navigationController?.navigationBar.shadowImage = UIImage()

           } else {
               self.navigationController?.setNavigationBarHidden(false, animated: false)
           }
       }
    func back(){
        self.navigationController?.popViewController(animated: true)
    }
    func didTapWatchNow(url: String){
         let videoURL = URL(string: url)!
         let safariVC = SFSafariViewController(url: videoURL)
         self.present(safariVC, animated: true, completion: nil)
     }
    

}
