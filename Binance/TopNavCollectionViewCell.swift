//
//  TopNavCollectionViewCell.swift
//  Binance
//
//  Created by Rock on 2018/8/16.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit

let darkYellowColor = RGB.sharedInstance.requiredColor(r: 239, g: 191, b: 93, alpha: 1.0)


class TopNavCollectionViewCell: UICollectionViewCell {
    
    
    lazy var tokenTitleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("BNB", comment: "")
        label.textColor = darkYellowColor
        label.font = UIFont(name: FontNames.OpenSansSemiBold, size: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    let indicatorView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = darkYellowColor
        return v
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        
        self.addSubview(tokenTitleLabel)
        self.addSubview(indicatorView)
        
        indicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        indicatorView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        tokenTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        tokenTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tokenTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tokenTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
}
