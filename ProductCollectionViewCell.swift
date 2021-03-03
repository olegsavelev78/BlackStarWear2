//
//  ProductCollectionViewCell.swift
//  BlackStarWear
//
//  Created by MackBook on 16.01.2021.
//  Copyright © 2021 Oleg. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    let productUrl = "https://blackstarshop.ru/"
    
    @IBOutlet weak var mainImageProduct: UIImageView!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var buyLabel: UILabel!
    
    
    
    func initCollectionCell(item: Product){
        let stringImfUrl = productUrl + "\(item.mainImage)"
        let imgUrl: URL = URL(string: stringImfUrl)!
        if let data = NSData(contentsOf: imgUrl){
            self.mainImageProduct.image = UIImage(data: data as Data)
        }
        priceProduct.text = String(item.price.split(separator: ".")[0] + " ₽")
        nameProduct.text = item.name
        buyLabel.text = "КУПИТЬ"
        buyLabel.layer.masksToBounds = true
        buyLabel.layer.cornerRadius = 6
        mainImageProduct.layer.cornerRadius = 5
    }
}
