//
//  CollectionViewCell.swift
//  iMarket
//
//  Created by Amin on 13/08/2021.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet var uiImage: UIImageView!
    @IBOutlet var uiLabel: UILabel!
    
    func prepare(category: Category) {
        uiLabel.text = category.name
        
        guard let image = category.imageName else {
            uiImage.image = UIImage(named: "star")
            return
        }
        
        uiImage.image = UIImage(named: image)
    

    }
}
