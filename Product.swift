import Foundation

class Product {
    let name: String
    let mainImage: String
    let price: String
    var description: String
    let colorName: String
    var productImages: [String]
    var offers: [Offers]

    init?(data: NSDictionary){
        guard let name = data["name"] as? String,
              let colorName = data["colorName"] as? String,
              let description = data["description"] as? String,
              let offersData = data["offers"] as? [NSDictionary],
              let mainImage = data["mainImage"] as? String,
              let price = data["price"] as? String else {return nil}
        self.name = name
        self.colorName = colorName
        self.mainImage = mainImage
        self.price = price
        self.description = description
        self.productImages = []
        for image in data["productImages"] as! NSArray {
            if let img = image as? NSDictionary {
                self.productImages.append(img["imageURL"] as! String )
            }
        }
        self.offers = []
        for data in offersData {
            if let offer = Offers(data: data){
                self.offers.append(offer)
            }
        }

    }
    init() {
        self.name = ""
        self.description = ""
        self.mainImage = ""
        self.price = ""
        self.description = ""
        self.offers = []
        self.productImages = []
        self.colorName = ""
        }

}

class Offers {
    let size: String
    let productOfferID: String
    let quantity: String
    init?(data: NSDictionary){
        guard let size = data["size"] as? String,
              let productOfferID = data["productOfferID"] as? String,
              let quantity = data["quantity"] as? String else {return nil}
        self.size = size
        self.productOfferID = productOfferID
        self.quantity = quantity
    }
}
