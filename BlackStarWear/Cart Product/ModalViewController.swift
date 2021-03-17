//
//  ModalViewController.swift
//  BlackStarWear
//
//  Created by Олег Савельев on 15.03.2021.
//  Copyright © 2021 Oleg. All rights reserved.
//

import UIKit
import RealmSwift

class ModalViewController: UIViewController {
    var arrayProductInBasket: Results<ProductData>!
    var product = Product()
    let realm = try! Realm()
    
    @IBOutlet weak var sizeTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
                view.isOpaque = false
        sizeTableView.delegate = self
        sizeTableView.dataSource = self
        
        self.arrayProductInBasket = realm.objects(ProductData.self)
    }


}

extension ModalViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.offers.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Выберите размер"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOffers", for: indexPath) as! Size2TableViewCell
        
        cell.sizeLabel.text = "\(product.offers[indexPath.row].size) RUS"
        cell.quantityLabel.text = "\(product.offers[indexPath.row].quantity) шт"
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOffers", for: indexPath) as! Size2TableViewCell
        cell.accessoryType = .checkmark
        let item = ProductData()
        item.name = product.name
        item.size = product.offers[indexPath.row].size
        item.colorName = product.colorName
        item.quantity = product.offers[indexPath.row].quantity
        item.mainImage = product.mainImage
        item.price = product.price
    
        Persistance.shared.save(item: item)
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
