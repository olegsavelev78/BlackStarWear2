//
//  CartViewController.swift
//  BlackStarWear
//
//  Created by Олег Савельев on 14.02.2021.
//  Copyright © 2021 Oleg. All rights reserved.


import UIKit
import Kingfisher
import RealmSwift

class CartViewController: UIViewController {
//    let realm = try! Realm()
    let productUrl = "https://blackstarshop.ru/"
    var product = Product()
    var tableViewOffers = UITableView(frame: CGRect(x: 0, y: 50, width: 200, height: 170))
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
        performSegue(withIdentifier: "Size", sender: self)
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Size", let destination = segue.destination as? ModalViewController {
            let productSelect = product
            destination.product = productSelect
        }
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

}

