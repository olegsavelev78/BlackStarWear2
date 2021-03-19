//
//  ImageCell.swift
//  BlackStarWear
//
//  Created by Олег Савельев on 09.03.2021.
//  Copyright © 2021 Oleg. All rights reserved.
//

import Foundation
import Kingfisher

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCartCell: UIImageView!
    
    func initImage(item: Product, index: Int){
        
        let url = URL(string: GetUrl.shared.getImage() + item.productImages[index])
        imageCartCell.kf.setImage(with: url)

    }
    
    
}
