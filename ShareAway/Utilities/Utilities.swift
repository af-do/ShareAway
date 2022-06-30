//
//  Utilities.swift
//  ShareAway
//
//  Created by Dmitry Ovchinikov on 29/06/2022.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleText(_ text: UILabel) {
        
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: text.frame.height - 2, width: text.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        //text.borderStyle = .none
        text.layer.addSublayer(bottomLine)
    }
    
    static func styleTitle(_ text: UILabel) {
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func createAlert(_ title: String, _ message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert;
    }
    
}
