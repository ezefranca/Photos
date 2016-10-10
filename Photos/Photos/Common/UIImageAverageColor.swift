//
//  UIImageAverageColor.swift
//  Photos
//
//  Created by Ezequiel on 07/10/16.
//  Copyright © 2016 Ezequiel França. All rights reserved.
//

import UIKit
import CoreImage
import CoreGraphics
import UIImageColors

extension UIImage {
    
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public func imageColor(completion: (UIColor) -> Void){
        self.getColors { (colors) in
            completion(colors.backgroundColor)
        }
    }
}

