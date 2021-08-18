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
        if #available(iOS 13.0, *){
            uiImage.image = UIImage(systemName: category.imageName ?? "") ?? nil
        }else{
            uiImage.image = UIImage(named: "star")
        }
        uiLabel.text = category.name
    }
}
