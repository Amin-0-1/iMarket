//
//  CategoryPresenter.swift
//  iMarket
//
//  Created by Amin on 13/08/2021.
//

import Foundation
import Network

// functions that the view call to make  this presenter perform
protocol CategoryPresenterInteface {
    var categoriesCount: Int {get}
    
    func loadCategories()
    func getCategory(of index:Int)-> Category
}

// functions that category view can invoke
protocol CategoryViewInterface : class {
    func showError(error:String)
    func showLoading()
    func hideLoading()
    func hideEmptyImage()
    func showEmptyImage()
    func reloadCollection()
    
}

private let monitor = NWPathMonitor()


class CategoryPresenter: CategoryPresenterInteface {
    
    weak private var view: CategoryViewInterface!
    private var repo : Repository!
    private var categories: [Category] {
        didSet{
            if !self.categories.isEmpty{
                view.hideEmptyImage()
            }else{
                view.showEmptyImage()
            }
        }
    }
    
    var categoriesCount: Int{ return self.categories.count}

    
    init(view: CategoryViewInterface) {
        self.view = view
        repo = Repository()
        categories =  [Category]()
    }
    
    func loadCategories(){
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }

            if path.status == .satisfied {
                self.view.showLoading()
                self.repo.loadCategories { [weak self] (result) in
                    guard let self = self else { return }

                    self.view.hideLoading()
                    switch result {
                    case .failure(let error) :
                        self.categories = []
                        self.view.showError(error: error.localizedDescription)
                    case .success(let categories) :
                        self.categories = categories
                        self.view.reloadCollection()
                    }
                }
            }else{
                self.categories = []
                self.view.showError(error: NSError(domain: "no internet connection", code: 404, userInfo: nil).localizedDescription)
            }
        }
        
        monitor.start(queue: DispatchQueue(label: "monitor"))

    }
    
    func getCategory(of index: Int)-> Category {
        return categories[index]
    }
    
    
}
