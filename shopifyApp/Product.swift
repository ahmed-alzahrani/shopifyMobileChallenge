//
//  Product.swift
//  shopifyMobileApp
//
//  Created by Ahmed Al-Zahrani on 2018-01-02.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation
import SwiftyJSON


// Product struct lets us take the response from the call to Shopify and isolate the information per product we want to work with
struct Product {
    let id          : String
    let title       : String
    let vendor      : String
    let productType : String
    let imageUrl    : String
    let tags        : String
    let price       : String
    let body        : String
    
    
    init?(json: JSON) {
        guard let id            = json["id"].rawString(),
            let title           = json["title"].rawString(),
            let vendor          = json["vendor"].rawString(),
            let productType     = json["product_type"].rawString(),
            let imageUrl        = json["image"]["src"].rawString(),
            let tags            = json["tags"].rawString(),     // we take the price of the first variant for simiplicity's sake
            let price           = json["variants"][0]["price"].rawString(),
            let body            = json["body_html"].rawString()
            else {return nil}
        
        self.id             = id
        self.title          = title
        self.vendor         = vendor
        self.productType    = productType
        self.imageUrl       = imageUrl
        self.tags           = tags
        self.price          = "$" + price // concatenate the price with the dollar sign as it should appear in the UI
        self.body           = body
        
    }
}
