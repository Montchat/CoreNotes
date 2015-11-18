//
//  Constants.swift
//  CoreNotes
//
//  Created by Joe E. on 11/18/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit

private let darkGrey = UIColor(hue: 0, saturation: 0, brightness: 0.19, alpha: 1)
private let softRed = UIColor(hue: 0.99, saturation: 0.63, brightness: 0.93, alpha: 1)
private let softGreen = UIColor(hue: 0.27, saturation: 0.62, brightness: 0.83, alpha: 1)

extension UIColor {
    
    class func darkGrey() -> UIColor {
        return darkGrey()
        
    }
    
    class func softRed() -> UIColor {
        return softRed()
        
    }
    
    class func softGreen() -> UIColor {
        return softGreen()
    }
    
}

extension UIViewController : UITextFieldDelegate {
    
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    
    
}