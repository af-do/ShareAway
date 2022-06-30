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
        text.font = UIFont(name: "Arima-Bold", size: 20)
    }
    
    static func styleTitle(_ text: UILabel) {
        text.font = UIFont(name: "Splash-Regular", size: 36)
    }
    
    static func styleButton(_ btn: UIButton) {
        btn.titleLabel?.font = UIFont(name: "Arima-Bold", size: 24)
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
