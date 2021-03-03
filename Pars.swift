import Foundation
import Alamofire

class CategoriesLoader {
    func loadCategories(completion: @escaping ([Category]) -> Void){
        AF.request("https://blackstarshop.ru/index.php?route=api/v1/categories").responseJSON
            { response in
            if let objects = response.value,
                let jsonDict = objects as? NSDictionary{
                DispatchQueue.main.async {
                var categories: [Category] = []
                for (_, data) in jsonDict where data is NSDictionary{
                        if let category = Category(data: data as! NSDictionary){
                            if !category.image.isEmpty {
                                categories.append(category)
                            }

                        }
                         completion(categories)
                    }
                }
                 
            }
        }
    }
}

class ProductsLoader {
    func loadProducts(id: Int, completion: @escaping ([Product]) -> Void){
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
                        completion(products)
                    }
                }
                
            }
        }
    }
}
