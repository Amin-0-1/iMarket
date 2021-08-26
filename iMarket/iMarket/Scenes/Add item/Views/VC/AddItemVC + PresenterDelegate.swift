//
//  AddItemVC + PresenterDelegate.swift
//  iMarket
//
//  Created by Amin on 22/08/2021.
//

import UIKit

extension AddItemVC: AddItemViewInteface{
    
    
    func showError(error: String) {
        DispatchQueue.main.async {
            self.view.makeToast(error, point: CGPoint(x: self.view.center.x, y: self.view.center.y), title: nil, image: nil, completion: nil)
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.view.makeToastActivity(.center)
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.view.hideToastActivity()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    func didFinishedSaving(isSuccess: Bool) {
        let _ = isSuccess ? self.navigationController?.popViewController(animated: true) : nil
    }

    func didFinishedPreparingItemObject(item: Item) {
        presenter.saveItem(item: item)
    }
}

