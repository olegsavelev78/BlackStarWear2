//
//  ProductCollectionViewCell.swift
//  BlackStarWear
//
//  Created by MackBook on 16.01.2021.
//  Copyright © 2021 Oleg. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImageProduct: UIImageView!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var buyLabel: UILabel!
    
    
    
    func initCollectionCell(item: Product){
        let url = URL(string: GetUrl.shared.getImage() + item.mainImage)
        mainImageProduct.kf.setImage(with: url)
        priceProduct.text = String(item.price.split(separator: ".")[0] + " ₽")
        nameProduct.text = item.name
        buyLabel.text = "КУПИТЬ"
        buyLabel.layer.masksToBounds = true
        buyLabel.layer.cornerRadius = 6
        mainImageProduct.layer.cornerRadius = 5
    }
}
