//
//  AddItemPresenter.swift
//  iMarket
//
//  Created by Amin on 22/08/2021.
//

import Foundation



protocol AddItemPresenterInteface{
    func getItemObject(categoryId: String, description: String, name: String,price: Double)-> Item
    func saveItem(item:Item)
}
protocol AddItemViewInteface: class {
    func showError(error:String)
    func showLoading()
    func hideLoading()
    func didFinishedSaving(isSuccess: Bool)

}

class AddItemPresenter: AddItemPresenterInteface {

    private weak var view: AddItemViewInteface!
    private var repo: Repository!
    init(view: AddItemViewInteface) {
        self.view = view
        self.repo = Repository()
        
    }
    
    func getItemObject(categoryId: String, description: String, name: String, price: Double) -> Item {
        return Item(id: UUID().uuidString, categoryId: categoryId, name: name, description: description, price: price, images: [])
    }
    func saveItem(item: Item) {
        if monitor.currentPath.status == .satisfied{
            repo.saveItem(item:item)
            completedSaving(isSuccess: true)
        }else{
            view.showError(error: "No Internet Connection, Please Try again Later!!")
            completedSaving(isSuccess: false)
        }
    }
    
    func completedSaving(isSuccess: Bool) {
        view.didFinishedSaving(isSuccess: isSuccess)
    }
    
    
    
}
