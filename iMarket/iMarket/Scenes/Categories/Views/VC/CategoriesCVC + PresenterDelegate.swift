//
//  CategoriesCVC + Pinterface.swift
//  iMarket
//
//  Created by Amin on 13/08/2021.
//

import Foundation
import JGProgressHUD

extension CategoriesCVC: CategoryViewInterface{

    private static var progressHUD = JGProgressHUD(style: .dark)
    
    func showError(error: String) {
        DispatchQueue.main.async {
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = error
            hud.indicatorView = JGProgressHUDErrorIndicatorView()
            hud.show(in: self.view, animated: true, afterDelay: 0.3)
            hud.dismiss(afterDelay: 3.0, animated: true)
            
        }

    }
    
    func showLoading() {
        DispatchQueue.main.async {
            UIApplication.shared.beginIgnoringInteractionEvents()
            CategoriesCVC.progressHUD.textLabel.text = "Loading"
            CategoriesCVC.progressHUD.show(in: self.view,animated: true)
        }

    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            UIApplication.shared.endIgnoringInteractionEvents()
            CategoriesCVC.progressHUD.dismiss(animated: true)
        }

    }
    
    func hideEmptyImage() {
        DispatchQueue.main.async { [unowned self] in
            uiEmptyImage.isHidden = true
            collectionView.isScrollEnabled = true
            collectionView.visibleCells.forEach{$0.isHidden = false}
            
        }
    }
    
    func showEmptyImage() {
        DispatchQueue.main.async { [unowned self] in
            uiEmptyImage.isHidden = false
            collectionView.isScrollEnabled = false
            collectionView.visibleCells.forEach{$0.isHidden = true}
        }
    }
    
    func reloadCollection() {
        collectionView.reloadData()
    }
    
    
}
