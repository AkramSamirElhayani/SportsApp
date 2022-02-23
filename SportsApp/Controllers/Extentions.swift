//
//  Extentions.swift
//  SportsApp
//
//  Created by Akram Elhayani on 23/02/2022.
//

import Foundation
import UIKit
extension UIView {

    @IBInspectable var dropShadow: Bool {
        set{
            if newValue {
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOpacity = 0.9
                layer.shadowRadius = 3.5
                layer.shadowOffset = CGSize(width: 0.7, height: 0.7)
            } else {
                layer.shadowColor = UIColor.clear.cgColor
                layer.shadowOpacity = 0
                layer.shadowRadius = 0
                layer.shadowOffset = CGSize.zero
            }
        }
        get {
            return layer.shadowOpacity > 0
        }
    }
    
 

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue

            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if dropShadow == false {
                self.layer.masksToBounds = true
            }
        }
    }

 
}
