//
//  NetworkingService.swift
//  shopifyApp
//
//  Created by Ahmed Al-Zahrani on 2018-01-03.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// NetworkingService is simply set up for us to make Alamofire requests to the url provided in the challenge
class NetworkingService {
    
    // so we can use it elsewhere
    static let shared = NetworkingService()
    private init() {}
    
    // getProducts makes the request and then calls the successHandler if it gets it properly (getProductsResponse)
    func getProducts(success successHandler: @escaping (getProductResponse) -> Void) {
        let url = "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        Alamofire.request(url, method: .get).responseJSON { response in
            
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                do {
                    // print(json)
                    let getProducts = try getProductResponse(json: json)
                    successHandler(getProducts)
                } catch {}
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
