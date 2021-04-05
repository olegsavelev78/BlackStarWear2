import Foundation
import Alamofire
import ProgressHUD

class CategoriesLoader {
    func loadCategories(completion: @escaping ([Category], [String]) -> Void){
        ProgressHUD.animationType = .systemActivityIndicator
        ProgressHUD.colorAnimation = .systemOrange
        ProgressHUD.show()
        AF.request("https://blackstarshop.ru/index.php?route=api/v1/categories").responseJSON
            { response in
            if let objects = response.value,
                let jsonDict = objects as? NSDictionary{
                DispatchQueue.main.async {
                var categories: [Category] = []
                var categoryId: [String] = []
                    for (_, data) in jsonDict where data is NSDictionary{
                        if let category = Category(data: data as! NSDictionary){
                            if !category.name.isEmpty {
                                categories.append(category)
                            }
                        }  
                }
                    categoryId = jsonDict.allKeys as! [String]
                    ProgressHUD.dismiss()
                    completion(categories,categoryId)
                }
                 
            }
        }
    }
}

class ProductsLoader {
    func loadProducts(id: Int, completion: @escaping ([Product]) -> Void){
        ProgressHUD.show()
        AF.request("https://blackstarshop.ru/index.php?route=api/v1/products&cat_id=\(id)").responseJSON { response in
            if let objects = response.value,
               let jsonDict = objects as? NSDictionary{
                DispatchQueue.main.async {
                    
                    var products: [Product] = []
                    for (_, data) in jsonDict where data is NSDictionary{
                        if let product = Product(data: data as! NSDictionary){
                            if !product.name.isEmpty {
                                products.append(product)
                            }
                        }
                        ProgressHUD.dismiss()
                        completion(products)
                    }
                }
                
            }
        }
    }
}
