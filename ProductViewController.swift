import UIKit

class ProductViewController: UIViewController {
    var itemID = 0
    var titleName = ""
    var products: [Product] = []
    var productIndex = 0
    @IBOutlet weak var collectionViewProduct: UICollectionView!
    
    @IBAction func basketButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "BasketController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .black
        print(itemID)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.title = titleName
        ProductsLoader().loadProducts(id: itemID) { products in
            self.products = products
            self.collectionViewProduct.reloadData()
            
        }
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = UIScreen.main.bounds.size.width / 2
        let h = w * 1.5
        return CGSize(width: w, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
  
        cell.initCollectionCell(item: products[indexPath.row]) // Инициализация ячейки
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.productIndex = indexPath.row
        
        performSegue(withIdentifier: "ShowCart", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCart", let destination = segue.destination as? CartViewController {
            let productSelect = products[self.productIndex]
            destination.product = productSelect
        }
        navigationItem.backBarButtonItem?.title = ""
    }
}
