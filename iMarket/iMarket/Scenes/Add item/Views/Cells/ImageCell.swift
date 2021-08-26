//
//  ImageCell.swift
//  iMarket
//
//  Created by Amin on 26/08/2021.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet var uiImage: UIImageView!
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        uiImage.layer.masksToBounds = true
        
        uiImage.layer.borderWidth = 0.5
        uiImage.layer.borderColor = UIColor.darkGray.cgColor
        uiImage.layer.cornerRadius = uiImage.layer.frame.height / 2
    }
}
