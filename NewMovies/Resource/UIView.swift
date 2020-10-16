//
//  UIView.swift
//  NewMovies
//
//  Created by Mohamed El-Taweel on 10/16/20.
//  Copyright © 2020 rahma. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get{
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
        }
    }
}
 

