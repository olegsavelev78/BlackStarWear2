//
//  basketViewController.swift
//  BlackStarWear
//
//  Created by Олег Савельев on 10.03.2021.
//  Copyright © 2021 Oleg. All rights reserved.


import UIKit
import Kingfisher

class BasketViewController: UIViewController {
    var product = Product()
    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var basketButton: UIButton!
    @IBAction func basketButtonAction(_ sender: Any) {
        if arrayProductInBasket.isEmpty {
            let vc = storyboard?.instantiateViewController(identifier: "Category") as! ViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    var array2: [ProductData] = []
    var arrayProductInBasket = Persistance.shared.getItems(){
        didSet{
            basketTableView.reloadData()
        }
    }
    var count: [ProductData] = []
    
    
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
            
            sum += Int(Double(item.price) ?? 0) * item.count
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
        let item = self.arrayProductInBasket[indexPath.row]
        cell.initCell(item: item)
        
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = self.arrayProductInBasket[indexPath.row]
        if editingStyle == .delete {
            if item.count > 1{
                Persistance.shared.remove(item: item)

            } else {
                Persistance.shared.removeAl(item: item)
                basketTableView.deleteRows(at: [indexPath], with: .left)
                
            }
            basketTableView.reloadData()
            sumProducts()
            if self.count.isEmpty {
                self.basketButton.setTitle("На главную", for: .normal)
            }
        }
    }
}
