//
//  Images.swift
//  BlackStarWear
//
//  Created by Олег Савельев on 22.02.2021.
//  Copyright © 2021 Oleg. All rights reserved.
//

import Foundation
let productUrl = "https://blackstarshop.ru/"
var imageArray: [Data] = []
class Images{
    func loadImages(data: Product){
        let stringImgUrl = productUrl + "\(data.productImages)"
        let imgURL: URL = URL(string: stringImgUrl)!
        if let item = NSData(contentsOf: imgURL) {
            imageArray.append(item as Data)
        }
    }
}
