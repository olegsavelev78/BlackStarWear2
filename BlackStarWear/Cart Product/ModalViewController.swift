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
    var product = Product()
    var array2 = [ProductData]()
    var arrayInBasket = Persistance.shared.getItems()
    @IBOutlet weak var sizeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    func nonduplicated(array: [ProductData], item1: ProductData){
        var item2 = ProductData()
        var answer: Set<Int> = []
        for i in array{
            if !array.contains(where: { $0.productOfferID == item1.productOfferID }){
                    answer.insert(item1.productOfferID)
                    print("Нет дупликатов")
                    print(i.productOfferID)
                    Persistance.shared.save(item: item1)
                } else {
                    
                    Persistance.shared.changeCount(item: item1)
                    
//                    item2.count += 1
                    print("Есть дупликат")
                }
            }
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
        for i in arrayInBasket{
            array2.append(i)
        }
        if !array2.isEmpty {
            nonduplicated(array: array2, item1: item) // Пытаемся найти одинаковые товары
        } else {
            Persistance.shared.save(item: item) // Сохраняем первые данные в реалм
            print("Создаем первый реалм")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
