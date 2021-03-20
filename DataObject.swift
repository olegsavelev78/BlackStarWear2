import Foundation
import RealmSwift

class ProductData: Object {
    @objc dynamic var name = ""
    @objc dynamic var colorName = ""
    @objc dynamic var size = ""
    @objc dynamic var quantity = ""
    @objc dynamic var mainImage = ""
    @objc dynamic var price = ""
    @objc dynamic var count = 1
    @objc dynamic var productOfferID = 0
}

class Persistance {
    static let shared = Persistance()
    let realm = try! Realm()
    
    func save(item: ProductData){
        try! realm.write {
            realm.add(item)
        }
    }
    
    func getItems() -> Results<ProductData>{
        realm.objects(ProductData.self)
    }
    
    func remove(index: Int) {
        let item = realm.objects(ProductData.self)[index]
        try! realm.write {
            realm.delete(item)
        }
    }
    func countProduct(){
        let item = realm.objects(ProductData.self).first
        try! realm.write {
            item?.count += 1
        }
            
        
    }
    
    
}
