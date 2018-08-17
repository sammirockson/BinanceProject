//
//  CustomAlertsView.swift
//  cryptowallet
//
//  Created by Rock on 2018/7/13.
//  Copyright © 2018 Cybermiles. All rights reserved.
//

import UIKit

class CustomAlerts: NSObject {
    
    static let sharedInstance = CustomAlerts()
    
    let alertView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 20
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    let iconCheckMarkImageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
//        v.image = #imageLiteral(resourceName: "iconCheckmarkCircle")
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    let coverView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.alpha = 0
        return v
    }()
    
    let coloredBackground: UIView = {
        let v = UIView()
        v.backgroundColor = RGB.sharedInstance.requiredColor(r: 4, g: 33, b: 75, alpha: 1.0)
//        v.isHidden = true
        return v
    }()
    
    let messageLabel: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: FontNames.OpenSansSemiBold, size: 16)
        label.textAlignment = .center
        label.isEditable = false
        label.isSelectable = false
        label.textColor = RGB.sharedInstance.requiredColor(r: 8, g: 26, b: 54, alpha: 1.0)
        return label
    }()
    
    
    override init() {
        super.init()
    }
    
    func showAlert(message: String, image: UIImage?){
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            keyWindow.addSubview(coloredBackground)
            coloredBackground.frame = keyWindow.bounds
            self.coloredBackground.alpha = 0.70
            
            keyWindow.addSubview(coverView)
            self.coverView.frame = keyWindow.bounds
            
            self.coverView.addSubview(alertView)
            self.alertView.addSubview(iconCheckMarkImageView)
            self.alertView.addSubview(messageLabel)
            
            
            messageLabel.text = message
            
            if image != nil {
                
                self.iconCheckMarkImageView.image = image!

                
            }else{
                
                self.iconCheckMarkImageView.image = #imageLiteral(resourceName: "iconWarning")


            }
            
            
            messageLabel.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: -8).isActive = true
            messageLabel.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 8).isActive = true
            messageLabel.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -5).isActive = true
            messageLabel.topAnchor.constraint(equalTo: iconCheckMarkImageView.bottomAnchor, constant: 0).isActive = true
            
            iconCheckMarkImageView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
            iconCheckMarkImageView.centerYAnchor.constraint(equalTo: alertView.centerYAnchor, constant: -17).isActive = true
            iconCheckMarkImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
            iconCheckMarkImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
            
            alertView.rightAnchor.constraint(equalTo: coverView.rightAnchor, constant: -20).isActive = true
            alertView.leftAnchor.constraint(equalTo: coverView.leftAnchor, constant: 20).isActive = true
            alertView.heightAnchor.constraint(equalToConstant: 180).isActive = true
            alertView.centerYAnchor.constraint(equalTo: coverView.centerYAnchor).isActive = true
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.coverView.alpha = 1.0
                
            }) { (completed) in
                
                
                
            }
            
           
            
        }
        
    }
    
    
    func dismiss(){
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.coverView.alpha = 0
            self.coloredBackground.alpha = 0
            
        }) { (completed) in
            
            self.coloredBackground.removeFromSuperview()
            self.coverView.removeFromSuperview()
            
        }
        
    }
}
