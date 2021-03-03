//
//  CartViewController.swift
//  BlackStarWear
//
//  Created by Олег Савельев on 14.02.2021.
//  Copyright © 2021 Oleg. All rights reserved.
//
// 1. Настроить загрузку картинок в скроллвью вместе с pagecontroll
// 2. добавить корзину
// 3. сделать алерт для выбора размеров

import UIKit

class CartViewController: UIViewController, UIScrollViewDelegate {
    
    let productUrl = "https://blackstarshop.ru/"
    var product = Product()
    var slides: [Slide] = []

    @IBOutlet weak var basketButton: UIBarButtonItem!
    @IBAction func basketButton(_ sender: Any) {
    }
    
    
    @IBOutlet weak var imgPageControl: UIPageControl!
    @IBOutlet weak var imagesScrollView: UIScrollView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var costLabel1: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var addToButton: UIButton!
    @IBAction func addToButton(_ sender: Any) {
    }
    func createSlides() -> [Slide] {
        
        var slideArray = [Slide]()
        
        for i in 0...product.productImages.count-1 {
            var productIndex = i
            let slide: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            let stringImgUrl = productUrl + product.productImages[productIndex]
            let imgUrl: URL = URL(string: stringImgUrl)!
            if let data = NSData(contentsOf: imgUrl){
                slide.image.image = UIImage(data: data as Data)
                productIndex += 1
                slide.image.contentMode = .scaleAspectFill
            }

            slideArray.append(slide)
        }
        return slideArray
        }

    func setupSlideScrollView(slides : [Slide]) {
        imagesScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        imagesScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        imagesScrollView.isPagingEnabled = true
            
            for i in 0 ..< slides.count {
                slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
                imagesScrollView.addSubview(slides[i])
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        imgPageControl.numberOfPages = slides.count
        imgPageControl.currentPage = 0
        view.bringSubviewToFront(imgPageControl)
        self.imagesScrollView.delegate = self
        
        
//        let image = UIImage(named: "basket3")
//        self.basketButton.image = image
        navigationBarSetting()
        self.addToButton.setTitle("ДОБАВИТЬ В КОРЗИНУ", for: .normal)
        self.costLabel1.text = "Стоимость:"
        self.nameLabel.text = product.name
        self.descriptionLabel.text = product.description
        self.costLabel.text = String(product.price.split(separator: ".")[0] + " ₽")
        self.addToButton.layer.cornerRadius = 8
        
    }
    
    func navigationBarSetting() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
//        let imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 40, height: 40))
//        imageView.image = image
//        self.navigationController?.navigationBar.addSubview(imageView)
    
        
//        let rightButton = UIBarButtonItem()
//        rightButton.width = CGFloat(40)
//        rightButton.image = image
//        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = rightButton
        
    }


    


}
