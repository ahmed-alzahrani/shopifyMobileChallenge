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

// VC for the details page presented when a user taps on a specific product
class DetailsViewController: UIViewController {
    
    // labels that are populated based on the specific product
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var vendorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBAction func buyButton(_ sender: Any) {
    }
    
    // product that was tapped in the UITableView
    var product: Product!
    
    // ovveride the viewDidLoad() so that the page is programatically put together as the page loads
    // simply assign the picture and labels based on the product info
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
