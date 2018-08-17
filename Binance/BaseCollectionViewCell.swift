//
//  BaseCollectionViewCell.swift
//  Binance
//
//  Created by Rock on 2018/8/17.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    let thinLineView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        v.alpha = 0.3
        return v
    }()
    
    let tokenLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "EOS / BTC"
        label.textColor = .white
        label.font = UIFont(name: FontNames.OpenSansSemiBold, size: 16)
        return label
    }()
    
    let tokenValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0.0012345933"
        label.font = UIFont(name: FontNames.OpenSansSemiBold, size: 16)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    
    let volumeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vol 6,045"
        label.font = UIFont(name: FontNames.OpenSansSemiBold, size: 14)
        label.textColor = UIColor(white: 0.5, alpha: 0.5)
        return label
    }()
    
    let fiatValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$ 7.89"
        label.font = UIFont(name: FontNames.OpenSansSemiBold, size: 14)
        label.textColor = UIColor(white: 0.5, alpha: 0.5)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        
        self.addSubview(thinLineView)
        self.addSubview(tokenLabel)
        self.addSubview(tokenValue)
        self.addSubview(volumeLabel)
        self.addSubview(fiatValueLabel)
        
        
        
        fiatValueLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        fiatValueLabel.widthAnchor.constraint(equalToConstant: (self.frame.width / 2) - 60).isActive = true
        fiatValueLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        fiatValueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 14).isActive = true
        
        tokenValue.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        tokenValue.widthAnchor.constraint(equalToConstant: (self.frame.width / 2) - 60).isActive = true
        tokenValue.heightAnchor.constraint(equalToConstant: 20).isActive = true
        tokenValue.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -14).isActive = true
        
        
        volumeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 14).isActive = true
        volumeLabel.widthAnchor.constraint(equalToConstant: (self.frame.width / 2) - 22).isActive = true
        volumeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        volumeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        tokenLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        tokenLabel.widthAnchor.constraint(equalToConstant: (self.frame.width / 2) - 22).isActive = true
        tokenLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        tokenLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -14).isActive = true
        
        thinLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        thinLineView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        thinLineView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        thinLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
