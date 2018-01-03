//
//  ViewController.swift
//  shopifyApp
//
//  Created by Ahmed Al-Zahrani on 2018-01-03.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var products = [Product]()

    override func viewDidLoad() {
        NetworkingService.shared.getProducts { response in
            self.products = response.products
            self.tableView.rowHeight = 80
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "productsToDetails",
        let DetailsViewController = segue.destination as? DetailsViewController,
        let product = sender as AnyObject as? Product
            else { return }
        DetailsViewController.product = product
        
    }


}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom_cell", for: indexPath) as! CustomCellViewController
        let imageUrl = products[indexPath.row].imageUrl
        Alamofire.request(imageUrl).responseImage(completionHandler: { ( response ) in
            cell.myImage.image = response.result.value
        })
        cell.productTitleLabel.text = products[indexPath.row].title
        cell.productPriceLabel.text = products[indexPath.row].price
        return cell
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "productsToDetails", sender: products[indexPath.row])
    }
}



