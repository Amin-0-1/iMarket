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
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.view.hideToastActivity()
        }
    }
    
    func didFinishedSaving(isSuccess: Bool) {
        let _ = isSuccess ? self.navigationController?.popViewController(animated: true) : nil
    }
    
    
}

