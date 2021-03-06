//
//  getProductsResponse.swift
//  shopifyApp
//
//  Created by Ahmed Al-Zahrani on 2018-01-03.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import SwiftyJSON

struct getProductResponse {
    
    let products: [Product]
    
    // populates the products array with Product objects based on the response from the Alamofire request
    init(json: JSON) throws {
        let products = json["products"].arrayValue.map{ Product(json: $0) }.flatMap{$0}
        self.products = products
    }
}
