//
//  AddItemVC.swift
//  iMarket
//
//  Created by Amin on 19/08/2021.
//

import UIKit

class AddItemVC: UIViewController {

    @IBOutlet private var uiTitle: UITextField!
    @IBOutlet private var uiPrice: UITextField!
    @IBOutlet private var uiDesc: UITextView!
    
    var categoryId : String!
    private var presenter: AddItemPresenterInteface!
    private var itemImages = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AddItemPresenter(view: self)
    }
    
    @IBAction func uiCameraBtn(_ sender: Any) {
        
    }
    
    @IBAction func uiDoneBtn(_ sender: Any) {
        if isFilled(){
            dismissKeyboard()
            
            let item = presenter.getItemObject(categoryId: categoryId, description: uiDesc.text!, name: uiTitle.text!, price: Double(uiPrice.text!) ?? 0)
            
            if !itemImages.isEmpty{
                item.imageLinks.append("")
            }
            presenter.saveItem(item: item)
            
            
        }else{
            let ac = UIAlertController(title: "missing fields", message: "Please fill in the blanks!!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    @IBAction func uiTapGestureRecognizer(_ sender: Any) {
        dismissKeyboard()
    }
    
    private func dismissKeyboard(){
        view.endEditing(true)
    }
    
    private func isFilled()->Bool{
        guard let title = uiTitle.text ,let price = uiPrice.text ,let description = uiDesc.text else { return false}

        return !title.isEmpty && !price.isEmpty && !description.isEmpty
    }
    
}
