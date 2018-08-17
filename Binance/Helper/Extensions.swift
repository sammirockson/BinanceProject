//
//  Extensions.swift
//  Binance
//
//  Created by Rock on 2018/8/16.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit


extension UIDevice {
    
    var isIphoneX: Bool {
        if #available(iOS 11.0, *), isIphone {
            if isLandscape {
                if let leftPadding = UIApplication.shared.keyWindow?.safeAreaInsets.left, leftPadding > 0 {
                    return true
                }
                if let rightPadding = UIApplication.shared.keyWindow?.safeAreaInsets.right, rightPadding > 0 {
                    return true
                }
            } else {
                if let topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.top, topPadding > 0 {
                    return true
                }
                if let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom, bottomPadding > 0 {
                    return true
                }
            }
        }
        return false
    }
    
    var isLandscape: Bool {
        return UIDeviceOrientationIsLandscape(orientation) || UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation)
    }
    
    var isPortrait: Bool {
        return UIDeviceOrientationIsPortrait(orientation) || UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation)
    }
    
    var isIphone: Bool {
        return self.userInterfaceIdiom == .phone
    }
    
    var isIpad: Bool {
        return self.userInterfaceIdiom == .pad
    }
}
