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

class NetworkingService {
    
    static let shared = NetworkingService()
    private init() {}
    
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
