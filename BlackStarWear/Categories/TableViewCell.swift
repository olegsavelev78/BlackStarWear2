//
//  TableViewCell.swift
//  BlackStarWear
//
//  Created by MackBook on 14.07.2020.
//  Copyright © 2020 Oleg. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    let categoriesUrl = "https://blackstarshop.ru/"
    
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var textLabelCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCell.layer.cornerRadius = 10
    }
    
    func initCell(item: Category){
        let stringImgUrl = categoriesUrl + "\(item.image)"
        let imgUrl: URL = URL(string: stringImgUrl)!
        if let data = NSData(contentsOf: imgUrl) {
            self.imageCell.image = UIImage(data: data as Data)
        }
        textLabelCell.text = item.name
    }
    
    func initCell2(item: Subcategory){
        let stringImgUrl = "https://blackstarwear.ru/" + "\(item.iconImage)"
        let imgUrl: URL = URL(string: stringImgUrl)!
        if let data = NSData(contentsOf: imgUrl) {
            self.imageCell.image = UIImage(data: data as Data)
        }
        textLabelCell.text = item.name
        
    }
}
