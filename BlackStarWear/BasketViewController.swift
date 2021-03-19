//
//  basketViewController.swift
//  BlackStarWear
//
//  Created by Олег Савельев on 10.03.2021.
//  Copyright © 2021 Oleg. All rights reserved.


import UIKit
import Kingfisher

class BasketViewController: UIViewController {
    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var basketButton: UIButton!
    @IBAction func basketButtonAction(_ sender: Any) {
        if arrayProductInBasket.isEmpty {
            performSegue(withIdentifier: "showMain", sender: self)
        }
    }
    
    var arrayProductInBasket = Persistance.shared.getItems(){
        didSet{
            basketTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Корзина"
       
        self.basketButton.setTitle("На главную", for: .normal)
        if !arrayProductInBasket.isEmpty {
            self.basketButton.setTitle("Оформить заказ", for: .normal)
        }
        self.basketButton.layer.cornerRadius = 20
        sumLabel.text = "Итого:"
        sumProducts()
        
        
        
    }
    func sumProducts(){
        var sum = 0
        for item in arrayProductInBasket{
            sum += Int(Double(item.price) ?? 0)
        }
        self.costLabel.text = "\(sum) ₽"
    }
    
}
extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayProductInBasket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = basketTableView.dequeueReusableCell(withIdentifier: "product") as! BasketTableViewCell
        
        let product = arrayProductInBasket[indexPath.row]
        print(product.count)
        
        
        cell.initCell(item: product)
        print(product)

        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Persistance.shared.remove(index: indexPath.row)
            basketTableView.deleteRows(at: [indexPath], with: .left)
            basketTableView.reloadData()
            sumProducts()
            if arrayProductInBasket.isEmpty {
                self.basketButton.setTitle("На главную", for: .normal)
            }
        }
    }
    
    
}
