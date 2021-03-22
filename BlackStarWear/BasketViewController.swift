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
            performSegue(withIdentifier: "showMain", sender: self)
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
        for i in arrayProductInBasket {
            array2.append(i)
        }
        count = nonduplicated1(array: array2)
        
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
        for item in count{
            
            sum += Int(Double(item.price) ?? 0) * item.count
        }
        self.costLabel.text = "\(sum) ₽"
    }
    
}
extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return count.count
    }
    func nonduplicated1(array: [ProductData]) -> [ProductData] {
        var answer: [Int] = []
        var answer2: [ProductData] = []
        for i in array{
            if answer.contains(i.productOfferID){
                print("Найден дупликат \(i.name)")
            } else {
                answer.append(i.productOfferID)
                answer2.append(i)
            }
            
        }
        print(answer2.count)
        return answer2
    }
    func nonduplicated(array: [ProductData], index: Int) -> [ProductData] {
        var answer: [Int] = []
        var answer2: [ProductData] = []
        for i in array{
            if answer.contains(i.productOfferID){
                i.count += 1
                Persistance.shared.save(item: i)
            } else {
                answer.append(i.productOfferID)
                answer2.append(i)
            }
            
        }
        print(answer2.count)
        return answer2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = basketTableView.dequeueReusableCell(withIdentifier: "product") as! BasketTableViewCell
        count = nonduplicated(array: array2, index: indexPath.row)
        
        cell.countLabel.text = "\(count[indexPath.row].count)"
        let item = self.count[indexPath.row]
        let url = URL(string: GetUrl.shared.getImage() + item.mainImage)
        cell.productImageView.kf.setImage(with: url)
        cell.nameLabel.text = item.name
        cell.sizeLabel.text = "Размер: \(item.size)"
        cell.colorLabel.text = "Цвет: \(item.colorName)"
        cell.costLabel.text = "\(Int(Double(item.price) ?? 0)) ₽"

        
//        cell.initCell(item: item)
        
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if count[indexPath.row].count > 1{
                
                Persistance.shared.countMinusProduct(indexItem: indexPath.row)
                count[indexPath.row].count -= 1
                basketTableView.reloadData()
                sumProducts()
            } else {
                
                Persistance.shared.remove(index: indexPath.row)
                count.remove(at: indexPath.row)
                basketTableView.deleteRows(at: [indexPath], with: .left)
                
                basketTableView.reloadData()
                
                sumProducts()
            }
            
            
            if self.count.isEmpty {
                self.basketButton.setTitle("На главную", for: .normal)
            }
        }
    }
}
