//
//  HomeViewController.swift
//  Binance
//
//  Created by Rock on 2018/8/16.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    let customNavBarContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = RGB.sharedInstance.requiredColor(r: 33, g: 40, b: 50, alpha: 1.0)
        return v
    }()
    
    lazy var topNavContainerView: TopNavContainerView = {
        let v = TopNavContainerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        v.motherVC = self
        return v
    }()
    
    lazy var navTitle: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Markets", comment: "")
        label.textColor = RGB.sharedInstance.requiredColor(r: 176, g: 179, b: 184, alpha: 1.0)
        label.font = UIFont(name: FontNames.OpenSansBold, size: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        return cv
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "iconSearch"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleAnimateSearchBar), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelSearchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont(name: FontNames.OpenSansSemiBold, size: 14)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleCancelSearch), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var searchTextField: UITextField = {
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "Search by currency"
        txtField.autocorrectionType = .no
        txtField.textColor = .white
        txtField.font = UIFont(name: FontNames.OpenSansRegular, size: 14)
        txtField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        txtField.delegate = self
        return txtField
    }()
    
    let searchContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        v.layer.cornerRadius = 16
        v.clipsToBounds = true
        return v
    }()
    
    
    let refresh = PullToRefresh.sharedInstance.refreshControl

    
    private let bnbIdentifier = "bnbIdentifier"
    private let btcIdentifier = "btcIdentifier"
    private let ethIdentifier = "ethIdentifier"
    private let usdtIdentifier = "usdtIdentifier"
    
    
    var bnbObjects = [Any]()
    var btcObjects = [Any]()
    var ethObjects = [Any]()
    var usdObjects = [Any]()



    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        UIApplication.shared.statusBarStyle = .lightContent
        
        setUpViews()
        
        collectionView.register(BNBCollectionContainerView.self, forCellWithReuseIdentifier: bnbIdentifier)
        collectionView.register(BTCCollectionContainerView.self, forCellWithReuseIdentifier: btcIdentifier)
        collectionView.register(ETHCollectionContainerView.self, forCellWithReuseIdentifier: ethIdentifier)
        collectionView.register(USDTCollectionContainerView.self, forCellWithReuseIdentifier: usdtIdentifier)




    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchData()

    }
    
    
    var keepTrackOfSelectedCells = 0

    var filteredArray = [Any]()
    var btcFilteredArray = [Any]()
    var isSearching = false
    
    @objc func textFieldDidChange(){
        
        let searchText = self.searchTextField.text!
        print(keepTrackOfSelectedCells)
        
        switch self.keepTrackOfSelectedCells {
            
        case 0:
            
            self.filterBNB(searchText: searchText)
            
        case 1:
            
            self.filterBTC(searchText: searchText)
            
        case 2:
            
            self.filterETH(searchText: searchText)
            
        case 3:
            
            self.filterUSDT(searchText: searchText)

        default:
            print("")
        }
        
       
        
        
        
    }
    
    
    func filterBNB(searchText: String){
        
        self.filteredArray = self.bnbObjects.filter({ (object) -> Bool in
            
            let objc = object as AnyObject
            
            if let foundString = objc.object(forKey: "baseAssetName") as? String {
                
                if foundString.lowercased().contains(searchText.lowercased()){
                    
                    print(filteredArray)
                    self.bnbVC?.collectionView.reloadData()
                    
                    return true
                    
                    
                }else{
                    
                    return false
                }
                
            }else{
                
                return false
            }
            
            
            
        })
        
    }
    
    
    
    func filterBTC(searchText: String){
        
        self.btcFilteredArray = self.btcObjects.filter({ (object) -> Bool in
            
            let objc = object as AnyObject
            
            if let foundString = objc.object(forKey: "baseAssetName") as? String {
                
                if foundString.lowercased().contains(searchText.lowercased()){
                    
                    self.btcVC?.collectionView.reloadData()
                    
                    return true
                    
                    
                }else{
                    
                    return false
                }
                
            }else{
                
                return false
            }
            
            
            
        })
        
    }
    
    
    func filterETH(searchText: String){
        
        self.filteredArray = self.ethObjects.filter({ (object) -> Bool in
            
            let objc = object as AnyObject
            
            if let foundString = objc.object(forKey: "baseAssetName") as? String {
                
                if foundString.lowercased().contains(searchText.lowercased()){
                    
                    self.ethVC?.collectionView.reloadData()
                    
                    return true
                    
                    
                }else{
                    
                    return false
                }
                
            }else{
                
                return false
            }
            
            
            
        })
        
    }
    
    
    func filterUSDT(searchText: String){
        
        self.filteredArray = self.usdObjects.filter({ (object) -> Bool in
            
            let objc = object as AnyObject
            
            if let foundString = objc.object(forKey: "baseAssetName") as? String {
                
                if foundString.lowercased().contains(searchText.lowercased()){
                    
                    self.usdtVC?.collectionView.reloadData()
                    
                    return true
                    
                    
                }else{
                    
                    return false
                }
                
            }else{
                
                return false
            }
            
            
            
        })
        
    }
    
    
    func fetchData(){
        
        SVProgressHUD.show(withStatus: "Fetching...")
        
        Network.sharedInstance.fetchData { (response) in
            
            DispatchQueue.main.async {
                
                SVProgressHUD.dismiss()
                self.refresh.endRefreshing()
                PullToRefresh.sharedInstance.ethRefreshControl.endRefreshing()
                PullToRefresh.sharedInstance.btcRefreshControl.endRefreshing()
                PullToRefresh.sharedInstance.usdtRefreshControl.endRefreshing()
            }
            
            if let error = response.result.error {
            
                DispatchQueue.main.async {
                    
                    CustomAlerts.sharedInstance.showAlert(message: error.localizedDescription, image: #imageLiteral(resourceName: "iconWarning"))

                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2), execute: {
                        
                        CustomAlerts.sharedInstance.dismiss()
                        
                        
                    })
                    
                }
                
                return
            }
            
            
        
            if let resp = response.result.value {
                
                self.processResults(resp: resp)
            }
            
        }
    }
    
    
    
    
    
    
    func processResults(resp: Any){
        
        let json = JSON(resp)
        
        if let dataArray = json["data"].arrayObject {
            
            if dataArray.count > 0 {
                
                
                //Clears the array to make way for new content
                self.bnbObjects.removeAll(keepingCapacity: true)
                self.ethObjects.removeAll(keepingCapacity: true)
                self.btcObjects.removeAll(keepingCapacity: true)
                self.usdObjects.removeAll(keepingCapacity: true)
                
                for data in dataArray {
                    
                    if let quoteAsset = (data as AnyObject).object(forKey: "quoteAsset") as? String {
                        
                        let quoteAssetCapitalized = quoteAsset.uppercased()
                        //Filters the data by currency
                        
                        switch quoteAssetCapitalized {
                            
                        case "BNB":
                            
                            self.bnbObjects.append(data)
                            
                        case "ETH":
                            
                            self.ethObjects.append(data)
                            
                        case "BTC":
                            
                            self.btcObjects.append(data)
                            
                        case "USDT":
                            
                            self.usdObjects.append(data)
                            
                        default:
                            
                            print("nothing")
                        }
                        
                    }
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    if self.bnbObjects.count > 0 {
                        
                        if let cellContainerVC = self.bnbVC {
                            print(self.bnbObjects)
                            cellContainerVC.objects = self.bnbObjects
                            cellContainerVC.collectionView.reloadData()
                            
                            
                        }
                       
                    }
                    

                    
                    if self.btcObjects.count > 0 {
                        
                        if let cellContainerVC = self.btcVC {
                            
                            cellContainerVC.btcOjbects = self.btcObjects
                            cellContainerVC.collectionView.reloadData()
                            

                            
                            
                        }
                        
                    }
                    
                    
                    
                    
                    if self.ethObjects.count > 0 {
                        
                        if let cellContainerVC = self.ethVC {
                            
                            cellContainerVC.objects = self.ethObjects
                            cellContainerVC.collectionView.reloadData()
                            
                            
                        }
                        
                    }
                    
                    
                    
                    
                    if self.usdObjects.count > 0 {
                        
                        if let cellContainerVC = self.usdtVC {
                            
                            cellContainerVC.objects = self.usdObjects
                            cellContainerVC.collectionView.reloadData()
                            
                            
                        }
                        
                    }
                    
                    
                    
                  
                    
                }
                
                
                
            }
            
        }
        
    }
    
    
    
    
    @objc func handleCancelSearch(){
        
        self.isSearching = false

        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.searchTextFieldWidthConstraint?.constant = 0
            self.view.layoutIfNeeded()
            self.cancelSearchButton.isHidden = true

            
        }) { (completed) in
            
            self.searchButton.isHidden = false
            self.navTitle.isHidden = false
            self.searchTextField.resignFirstResponder()
            
            self.searchTextField.text = ""
            self.btcVC?.collectionView.reloadData()
            self.ethVC?.collectionView.reloadData()
            self.usdtVC?.collectionView.reloadData()
            self.bnbVC?.collectionView.reloadData()


            
        }
        
    }
    
    
    @objc func handleAnimateSearchBar(){
        
        self.isSearching = true
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.searchTextFieldWidthConstraint?.constant = self.view.frame.width - 90
            self.view.layoutIfNeeded()
            self.searchButton.isHidden = true
            self.cancelSearchButton.isHidden = false
            self.navTitle.isHidden = true
            
        }) { (completed) in
            
            self.searchTextField.becomeFirstResponder()
            
            
        }
        
    }
    
    
    var searchTextFieldWidthConstraint: NSLayoutConstraint?
    
    func setUpViews(){
        
        view.addSubview(customNavBarContainerView)
        customNavBarContainerView.addSubview(navTitle)
        customNavBarContainerView.addSubview(topNavContainerView)
        customNavBarContainerView.addSubview(searchButton)
        customNavBarContainerView.addSubview(cancelSearchButton)
        customNavBarContainerView.addSubview(searchContainerView)
        searchContainerView.addSubview(searchTextField)
        
        
        
        
        cancelSearchButton.centerYAnchor.constraint(equalTo: navTitle.centerYAnchor).isActive = true
        cancelSearchButton.rightAnchor.constraint(equalTo: customNavBarContainerView.rightAnchor, constant: -15).isActive = true
        cancelSearchButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cancelSearchButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        view.addSubview(collectionView)
        
        
        
        searchTextField.rightAnchor.constraint(equalTo: searchContainerView.rightAnchor).isActive = true
        searchTextField.leftAnchor.constraint(equalTo: searchContainerView.leftAnchor, constant: 8).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        searchTextField.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor).isActive = true


        //expand to when animated view.frame.width - 70
        
        searchContainerView.rightAnchor.constraint(equalTo: cancelSearchButton.leftAnchor, constant: -8).isActive = true
        searchTextFieldWidthConstraint = searchContainerView.widthAnchor.constraint(equalToConstant: 0)
        searchTextFieldWidthConstraint?.isActive = true
        searchContainerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        searchContainerView.centerYAnchor.constraint(equalTo: navTitle.centerYAnchor).isActive = true
        
        
        searchButton.centerYAnchor.constraint(equalTo: navTitle.centerYAnchor).isActive = true
        searchButton.rightAnchor.constraint(equalTo: customNavBarContainerView.rightAnchor, constant: -15).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: customNavBarContainerView.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        if UIDevice.current.isIphoneX {
            
            navTitle.centerYAnchor.constraint(equalTo: customNavBarContainerView.centerYAnchor, constant: -5).isActive = true

        }else{
            
            navTitle.centerYAnchor.constraint(equalTo: customNavBarContainerView.centerYAnchor, constant: -10).isActive = true

        }
        navTitle.rightAnchor.constraint(equalTo: customNavBarContainerView.rightAnchor).isActive = true
        navTitle.leftAnchor.constraint(equalTo: customNavBarContainerView.leftAnchor).isActive = true
        navTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        
        
        topNavContainerView.rightAnchor.constraint(equalTo: customNavBarContainerView.rightAnchor).isActive = true
        topNavContainerView.leftAnchor.constraint(equalTo: customNavBarContainerView.leftAnchor).isActive = true
        topNavContainerView.bottomAnchor.constraint(equalTo: customNavBarContainerView.bottomAnchor).isActive = true
        if UIDevice.current.isIphoneX {
            
            topNavContainerView.topAnchor.constraint(equalTo: navTitle.bottomAnchor, constant: 15).isActive = true

        }else{
            
            topNavContainerView.topAnchor.constraint(equalTo: navTitle.bottomAnchor, constant: 20).isActive = true

        }
        
        
        
        customNavBarContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        customNavBarContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        customNavBarContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        customNavBarContainerView.heightAnchor.constraint(equalToConstant: 120).isActive = true

    }
    

    var bnbVC: BNBCollectionContainerView?
    var btcVC: BTCCollectionContainerView?
    var ethVC: ETHCollectionContainerView?
    var usdtVC: USDTCollectionContainerView?

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if indexPath.item == 0 {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bnbIdentifier, for: indexPath) as! BNBCollectionContainerView
            self.bnbVC = cell
            cell.motherVC = self
            return cell
            
        }else if indexPath.item == 1 {
            
            let cellTwo = collectionView.dequeueReusableCell(withReuseIdentifier: btcIdentifier, for: indexPath) as! BTCCollectionContainerView
            self.btcVC = cellTwo
            cellTwo.motherVC = self
            return cellTwo
            
            
        }else if indexPath.item == 2 {
            
            let cellThree = collectionView.dequeueReusableCell(withReuseIdentifier: ethIdentifier, for: indexPath) as! ETHCollectionContainerView
            cellThree.backgroundColor = .black
            self.ethVC = cellThree
            cellThree.motherVC = self
            return cellThree
            
            
        }else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: usdtIdentifier, for: indexPath) as! USDTCollectionContainerView
            cell.backgroundColor = .blue
            self.usdtVC = cell
            cell.motherVC = self
            return cell
        }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
  


}
