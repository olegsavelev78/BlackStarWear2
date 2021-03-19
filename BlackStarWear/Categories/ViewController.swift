//
//  ViewController.swift
//  BlackStarWear
//
//  Created by MackBook on 12.07.2020.
//  Copyright © 2020 Oleg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var categories: [Category] = []
    var subcategories: [Subcategory] = []
    var tableIndex = 0
    var categoryId = 0
    var titleName = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func basketButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "BasketController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func backButton(_ sender: UIButton) {
        self.backButton.isHidden = true
        self.backButton.isEnabled = false
        subcategories.removeAll()
        tableIndex = 0
        tableView.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
        CategoriesLoader().loadCategories { categories in
            self.categories = categories
            self.tableView.reloadData()
        }
        if tableIndex == 0 {
            backButton.isHidden = true
            backButton.isEnabled = false
        }
        backButton.setTitle("Назад", for: .normal)
    }

}


extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !subcategories.isEmpty {
            return subcategories.count
        }
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOne", for: indexPath) as! CategoryCell
        if tableIndex == 0 {
            navigationItem.title = "Каталог"
            cell.initCell(item: categories[indexPath.row]) // инициализация ячейки Категорий
            return cell
        } else {
            if subcategories.isEmpty{
                
            } else{
                cell.initCell2(item: subcategories[indexPath.row]) // инициализация ячейки Подкатегорий
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if tableIndex == 0 {
            tableIndex = 1
            navigationItem.title = categories[indexPath.row].name
            subcategories = categories[indexPath.row].subcategories
            backButton.isHidden = false
            backButton.isEnabled = true
        } else {
            let product = subcategories[indexPath.row]
            titleName = subcategories[indexPath.row].name
            self.categoryId = product.id
            performSegue(withIdentifier: "ShowProducts", sender: categoryId)
        }
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProducts",
           let destination = segue.destination as? ProductViewController,
           let id = sender as? Int {
            destination.titleName = titleName
            destination.itemID = id
            tableIndex = 1
        }
    }
}
