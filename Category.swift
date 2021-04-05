import Foundation

class Category{
    let name: String
    let sortOrder: Int
    let image, iconImage, iconImageActive: String
    var subcategories: [Subcategory]
    init?(data: NSDictionary){
        guard let name = data["name"] as? String,
            let sortOrder = data["sortOrder"] as? String,
            let image = data["image"] as? String,
            let iconImage = data["iconImage"] as? String,
            let iconImageActive = data["iconImageActive"] as? String,
            let subcategories = data["subcategories"] as? [NSDictionary] else { return nil }
        var subcat = [Subcategory]()
        for data in subcategories {
            if let sub = Subcategory(data: data){
                subcat.append(sub)
            }
        }
        self.name = name
        self.sortOrder = Int(sortOrder) ?? 0
        self.image = image
        self.iconImage = iconImage
        self.iconImageActive = iconImageActive
        self.subcategories = subcat
    }
}

class Subcategory {
    let id: Int
    let iconImage: String
    let sortOrder: Int
    let name: String

    init?(data: NSDictionary) {
        guard let id = data["id"] as? String,
              let iconImage = data["iconImage"] as? String,
              let sortOrder = data["sortOrder"] as? String,
              let name = data["name"] as? String else { return nil }
    self.id = Int(id) ?? 0
    self.iconImage = iconImage
    self.sortOrder = Int(sortOrder) ?? 0
    self.name = name
    
}
}
