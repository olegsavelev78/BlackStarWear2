//
//  ModalViewController.swift
//  BlackStarWear
//
//  Created by Олег Савельев on 15.03.2021.
//  Copyright © 2021 Oleg. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    var product = Product()
    var array2 = [ProductData]()
    var arrayInBasket = Persistance.shared.getItems()
    @IBOutlet weak var sizeStackView: UIStackView!
    @IBOutlet weak var sizeTableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBAction func cancelActionButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.setTitle("ОТМЕНА", for: .normal)
        cancelButton.layer.cornerRadius = 20
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        sizeTableView.delegate = self
        sizeTableView.dataSource = self
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
        
        let item = ProductData()
        item.productOfferID = Int(product.offers[indexPath.row].productOfferID)!
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
