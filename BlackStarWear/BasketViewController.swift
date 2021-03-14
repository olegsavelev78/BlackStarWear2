//
//  basketViewController.swift
//  BlackStarWear
//
//  Created by Олег Савельев on 10.03.2021.
//  Copyright © 2021 Oleg. All rights reserved.
//
// 2. добавить корзину и сделать экшн переход на корзину - сделано
// 4. Настроить экран корзины

import UIKit
import RealmSwift

class BasketViewController: UIViewController {
    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var basketButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Корзина"
        
        
        
    }
    
}
//extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//    
//}
