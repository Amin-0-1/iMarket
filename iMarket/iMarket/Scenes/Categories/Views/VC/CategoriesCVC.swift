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
    private let sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    private let itemsPerRow = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = CategoryPresenter(view: self)
        presenter.loadCategories()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return presenter.categoriesCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCell
        
        let category = presenter.getCategory(of: indexPath.item)
        cell.prepare(category: category)
        return cell
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CategoriesToItemsSeg", sender: presenter.getCategory(of: indexPath.row))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategoriesToItemsSeg" {
            guard let destination = segue.destination as? ItemsVC else {return}
            destination.category = sender as! Category
        }
    }

}

extension CategoriesCVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding = sectionInset.left * (CGFloat(itemsPerRow + 1))
                
        let availableWidth = view.safeAreaLayoutGuide.layoutFrame.width - padding  
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInset.left
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
         guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
             return
         }
         flowLayout.invalidateLayout()
    }
        
}
