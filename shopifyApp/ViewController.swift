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
    
    //outlets for our tableView and searchBar
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //products list to be generated through Alamofire
    var products = [Product]()
    var filteredProducts = [Product]() // updates the table based on user's input to search bar

    // override veiwDidLoad() to make sure the tableView is generated when the VC loads
    override func viewDidLoad() {
        NetworkingService.shared.getProducts { response in
            self.products = response.products
            self.filteredProducts = response.products
            self.tableView.rowHeight = 80
            self.tableView.reloadData()
        }
    }
    
    // prepares the segue so that the details page is properly generated based on the specific product the user taps on
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
    
    // numberOfRows dependent on user's current search
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    // programatically generates the custom cell for each product in the tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom_cell", for: indexPath) as! CustomCellViewController
        let imageUrl = filteredProducts[indexPath.row].imageUrl
        Alamofire.request(imageUrl).responseImage(completionHandler: { ( response ) in
            cell.myImage.image = response.result.value
        })
        cell.productTitleLabel.text = filteredProducts[indexPath.row].title
        cell.productPriceLabel.text = filteredProducts[indexPath.row].price
        cell.descriptionLabel.text = filteredProducts[indexPath.row].body
        return cell
    }

}

// UITableViewDelegate to allow us to perform the segue with the product clicked as the sender
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "productsToDetails", sender: products[indexPath.row])
    }
}

extension ViewController: UISearchBarDelegate {
    
    // generates the filtered list of products based on the user's search
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredProducts = products.filter({ product -> Bool in
            guard let text = searchBar.text else { return false }
            if (text == "") {
                return true
            } else {
                return product.title.contains(String(text)) || product.vendor.contains(String(text)) || product.tags.contains(String(text))
            }
        })
        self.tableView.reloadData()
    }
}



