import Foundation
import RealmSwift

class ProductData: Object {
    @objc dynamic var name = ""
    @objc dynamic var colorName = ""
    @objc dynamic var size = ""
    @objc dynamic var quantity = ""
    @objc dynamic var mainImage = ""
    func getData(name: String, colorName: String, size: String, quantity: String, mainImage: String) {
        self.name = name
        self.colorName = colorName
        self.size = size
        self.quantity = quantity
        self.mainImage = mainImage
    }
}

class Persistance {
    static let shared = Persistance()
    let realm = try! Realm()
    
    func save(item: ProductData){
        try! realm.write {
            realm.add(item)
        }
    }
    
    func dataTake() -> Results<ProductData>{
        realm.objects(ProductData.self)
    }
    
}
