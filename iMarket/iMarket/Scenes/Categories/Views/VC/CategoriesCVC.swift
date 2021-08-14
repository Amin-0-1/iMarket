//
//  CaegoriesCVC.swift
//  iMarket
//
//  Created by Amin on 13/08/2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoriesCVC: UICollectionViewController {
    
    @IBOutlet var uiEmptyImage: UIImageView!
    
    var presenter: CategoryPresenterInteface!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = CategoryPresenter(view: self)
        presenter.loadCategories()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return presenter.categoriesCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCell
        
        let category = presenter.getCategory(of: indexPath.item)
        if #available(iOS 13.0, *){
            cell.uiImage.image = UIImage(systemName: category.imageName ?? "") ?? nil
        }else{
            cell.uiImage.image = UIImage(named: "star")
        }
        cell.uiLabel.text = category.name
        return cell
    
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
