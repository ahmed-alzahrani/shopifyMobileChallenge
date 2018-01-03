//
//  DetailsViewController.swift
//  shopifyApp
//
//  Created by Ahmed Al-Zahrani on 2018-01-03.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var vendorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBAction func buyButton(_ sender: Any) {
    }
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = product.title
        idLabel.text = "Product ID: " + product.id
        vendorLabel.text = "Vendor: " + product.vendor
        productTypeLabel.text = "Product Category: " + product.productType
        tagsLabel.text = "Tags: " + product.tags
        priceLabel.text = product.price
        
        let imageUrl = product.imageUrl
        
        Alamofire.request(imageUrl).responseImage(completionHandler: { (response) in
            self.productImage.image = response.result.value
        })
    }
    
}
