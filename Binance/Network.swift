//
//  Network.swift
//  Binance
//
//  Created by Rock on 2018/8/16.
//  Copyright © 2018 RockzAppStudio. All rights reserved.
//

import Foundation
import Alamofire


class Network: NSObject {
    
    static let sharedInstance = Network()
    
    
    override init() {
        super.init()
    }
    
    
    func fetchData(completion: @escaping (DataResponse<Any>)->()){
        
        let url = "https://www.binance.com/exchange/public/product"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            completion(response)
        }
        
    }
    
}
