//
//  TableViewCell.swift
//  BlackStarWear
//
//  Created by MackBook on 14.07.2020.
//  Copyright © 2020 Oleg. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCell: UITableViewCell {
    

    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var textLabelCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCell.layer.cornerRadius = 10
    }
    
    func initCell(item: Category){
        let url = URL(string: GetUrl.shared.getImage() + item.image)
        self.imageCell.kf.setImage(with: url)
        textLabelCell.text = item.name
    }
    
    func initCell2(item: Subcategory){
        let url = URL(string: GetUrl.shared.getImage() + item.iconImage)
        self.imageCell.kf.setImage(with: url)
        textLabelCell.text = item.name
        
    }
}
