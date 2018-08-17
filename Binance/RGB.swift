//
//  RGB.swift
//  cryptowallet
//
//  Created by Rock on 2018/5/28.
//  Copyright © 2018 Cybermiles. All rights reserved.
//

import UIKit



struct RGB {
    
    static let sharedInstance = RGB()
    
    func requiredColor(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) -> UIColor {
        let color =  UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
        return color
    }
}
