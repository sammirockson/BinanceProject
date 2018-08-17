//
//  TopNavContainerView.swift
//  Binance
//
//  Created by Rock on 2018/8/16.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit

class TopNavContainerView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    
    var motherVC: HomeViewController!
    
    let titlesArray = ["BNB","BTC","ETH","USDT"]
    
    
    let identifier = "identifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(TopNavCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        
        self.addSubview(collectionView)
        
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TopNavCollectionViewCell
        cell.backgroundColor = .clear
        
        let title = self.titlesArray[indexPath.item]
        cell.tokenTitleLabel.text = title
        
        if indexPath.item == 0 {
            
            cell.indicatorView.isHidden = false
            cell.tokenTitleLabel.textColor = darkYellowColor
            
        }else{
            
            cell.indicatorView.isHidden = true
            cell.tokenTitleLabel.textColor = .white


        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 4, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.motherVC.collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        self.hideOrShowIndicator(indexPath: indexPath)
        
    }
    
    
    func hideOrShowIndicator(indexPath: IndexPath){
        
        let arrayIndex = [0,1,2,3]
        
        for index in arrayIndex {
            
            if index == indexPath.item {
                
                //Show indicator
                
                let cell = self.collectionView.cellForItem(at: indexPath) as! TopNavCollectionViewCell
                cell.indicatorView.backgroundColor = darkYellowColor
                cell.tokenTitleLabel.textColor = darkYellowColor
                cell.indicatorView.isHidden = false
                
                
            }else{
                
                //Hide indicator
                let otherIndexPath = IndexPath(item: index, section: 0)
                
                let otherCell = self.collectionView.cellForItem(at: otherIndexPath) as! TopNavCollectionViewCell
                otherCell.indicatorView.backgroundColor = .clear
                otherCell.tokenTitleLabel.textColor = .white
                otherCell.indicatorView.isHidden = true

            }
        }
        
    }
   
}
