//
//  BTCCollectionContainerView.swift
//  Binance
//
//  Created by Rock on 2018/8/16.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit

class BTCCollectionContainerView: UICollectionViewCell,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = RGB.sharedInstance.requiredColor(r: 19, g: 22, b: 27, alpha: 1.0)
        return cv
    }()
    
    
    
    var motherVC: HomeViewController?
    
    
    var btcOjbects = [Any]()
    
    
    let refresh = PullToRefresh.sharedInstance.btcRefreshControl
    
    
    let identifier = "identifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        
        collectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.contentInset = UIEdgeInsetsMake(60, 0, 50, 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(60, 0, 50, 0)
        
        
        refresh.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
        self.collectionView.addSubview(refresh)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        if newWindow == nil {
            // UIView disappear
            print("view disappear")
            
            
        } else {
            // UIView appear
            print("view has appeared")
            
            
            self.motherVC?.fetchData()
            
            
        }
    }
    
    func setUpViews(){
        
        self.addSubview(collectionView)
        
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
    }
    
    
    @objc func handlePullToRefresh(){
        
        refresh.beginRefreshing()
        self.motherVC?.fetchData()
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.btcOjbects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! BaseCollectionViewCell
        
        let object = self.btcOjbects[indexPath.item]
     
        
        self.processAndDisplay(object: object as AnyObject, cell: cell)
        
        
        return cell
    }
    
    func processAndDisplay(object: AnyObject, cell: BaseCollectionViewCell){
        
        print(object)
        
        
        if let volume = object.object(forKey: "volume") as? String {
            
            if let doubleVol = Double(volume){
                
                let intVolume = Int(doubleVol)
                let num = NSNumber(value: intVolume)
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                numberFormatter.groupingSize = 3
                let vol = numberFormatter.string(from: num)
                
                if let finalVol = vol {
                    
                    cell.volumeLabel.text = "Vol \(finalVol)"
                    
                }
                
                
                
            }
            
            
        }
        
        if let baseAsset = object.object(forKey: "baseAsset") as? String {
            
            
            let attributed = NSMutableAttributedString(string: baseAsset, attributes: [NSAttributedStringKey.font: UIFont(name: FontNames.OpenSansSemiBold, size: 16) as Any])
            
            let seconAttr = NSAttributedString(string: " / BTC", attributes: [NSAttributedStringKey.foregroundColor: RGB.sharedInstance.requiredColor(r: 157, g: 165, b: 178, alpha: 1.0) ,NSAttributedStringKey.font : UIFont(name: FontNames.OpenSansRegular, size: 14) as Any])
            attributed.append(seconAttr)
            
            cell.tokenLabel.attributedText = attributed
            
        }
        
        
        
        
        if let tradedMoney = object.object(forKey: "tradedMoney") as? Double {
            
            
            let tradedString = String(tradedMoney)
            
            if let formatted = tradedString.format2String() {
                
                cell.fiatValueLabel.text = "$ \(formatted)"
                
            }
        }
        
        
        
        if let open = object.object(forKey: "open") as? String {
            
            cell.tokenValue.text = "\(open)"
            
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 80)
    }
    
}
