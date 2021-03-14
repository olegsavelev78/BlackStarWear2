//
//  CartViewController.swift
//  BlackStarWear
//
//  Created by Олег Савельев on 14.02.2021.
//  Copyright © 2021 Oleg. All rights reserved.
//
//
// 3. сделать алерт для выбора размеров. Установить таблицу в алерт, сделать ячейки (либо xib, либо код)
// 4. Cделать сохранение в реалм
//

import UIKit
import Kingfisher
import RealmSwift

class CartViewController: UIViewController {
//    let realm = try! Realm()
    let productUrl = "https://blackstarshop.ru/"
    var product = Product()
    var tableViewOffers = UITableView(frame: CGRect(x: 0, y: 0, width: 365, height: 170))
    var selectRow = -1

    
    @IBAction func basketButton(_ sender: Any) {
        performSegue(withIdentifier: "showBasket", sender: self)
        
    }
    
    @IBOutlet weak var imageCollectoinView: UICollectionView!
    @IBOutlet weak var imgPageControl: UIPageControl!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var costLabel1: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var addToButton: UIButton!
    @IBAction func addToButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Выберите размер", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        let done = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        
        alert.view.addSubview(tableViewOffers)
            alert.addAction(done)
            present(alert, animated: true, completion: nil)
//        }

        
    }
    @IBOutlet weak var descriptionTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarSetting()
        self.addToButton.setTitle("ДОБАВИТЬ В КОРЗИНУ", for: .normal)
        self.addToButton.layer.cornerRadius = 8
        self.costLabel1.text = "Стоимость:"
        self.nameLabel.text = product.name
        self.descriptionTextView.text = product.description
        self.costLabel.text = String(product.price.split(separator: ".")[0] + " ₽")
        
        tableViewOffers.dataSource = self
        tableViewOffers.delegate = self
        tableViewOffers.register(UINib(nibName: "Test", bundle: nil), forCellReuseIdentifier: "cellOffers")
    }

    func navigationBarSetting() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
}

extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = UIScreen.main.bounds.width
        let h = view.frame.height
        return CGSize(width: w, height: h)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imgPageControl.numberOfPages = product.productImages.count
        return product.productImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCartCell", for: indexPath) as! ImageCell
        cell.initImage(item: product, index: indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = imageCollectoinView.contentOffset.x
        let width = imageCollectoinView.frame.width
        let horizontalCenter = width / 2

        imgPageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationItem.backBarButtonItem?.title = "Назад"
    }
}
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOffers", for: indexPath) as! SizeTableViewCell
//        cell.accessoryType = .checkmark
        cell.colorLabel.text = product.colorName
        cell.sizeLabel.text = product.offers[indexPath.row].size
        cell.quantityLabel.text = product.offers[indexPath.row].quantity
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOffers", for: indexPath) as! SizeTableViewCell
        let item = ProductData()
//        item.size = product.offers[indexPath.row].size
//        item.colorName = product.colorName
//        item.quantity = product.offers[indexPath.row].quantity
//        item.mainImage = product.mainImage
        
        Persistance.shared.save(item: item)
    }
    
    
}
