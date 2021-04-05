import Foundation
import RealmSwift

class ProductData: Object {
    @objc dynamic var name = ""
    @objc dynamic var colorName = ""
    @objc dynamic var size = ""
    @objc dynamic var quantity = ""
    @objc dynamic var mainImage = ""
    @objc dynamic var price = ""
    @objc dynamic var productOfferID = 0
    @objc dynamic var count = 1
}

class Persistance {
    static let shared = Persistance()
    let realm = try! Realm()
    
    func save(item: ProductData){
        let items = realm.objects(ProductData.self)
        if !items.isEmpty{
            if let foundItem = items.first(where: { $0.productOfferID == item.productOfferID}){
                // Меняем количество
                try! realm.write {
                    foundItem.count += 1
                }
            } else {
                // Добавляем новый товар
                try! realm.write {
                    realm.add(item)
                }
            }
            } else {
                // Добавляем новый товар
                try! realm.write {
                    realm.add(item)
                }
            }
    }
    
    func getItems() -> Results<ProductData>{
        realm.objects(ProductData.self)
    }
    
    func remove(item: ProductData) { // Удаляем товар
        try! realm.write {
            item.count -= 1
           }
        }
    func removeAl(item: ProductData) {
        try! realm.write {
            realm.delete(item)
        }
    }
    
}
