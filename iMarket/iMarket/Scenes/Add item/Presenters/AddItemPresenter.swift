//
//  AddItemPresenter.swift
//  iMarket
//
//  Created by Amin on 22/08/2021.
//

import Foundation


protocol AddItemPresenterInteface{
    func prepareItemObject(withImagesData:[Data],categoryId: String, description: String, name: String,price: Double)
    func saveItem(item:Item)
}
protocol AddItemViewInteface: class {
    func showError(error:String)
    func showLoading()
    func hideLoading()
    func didFinishedPreparingItemObject(item:Item)
    func didFinishedSaving(isSuccess: Bool)

}

class AddItemPresenter: AddItemPresenterInteface {

    private weak var view: AddItemViewInteface!
    private var repo: Repository!
    init(view: AddItemViewInteface) {
        self.view = view
        self.repo = Repository()
        
    }
    

    func prepareItemObject(withImagesData data: [Data] ,categoryId: String, description: String, name: String, price: Double) {
        let item =  Item(id: UUID().uuidString, categoryId: categoryId, name: name, description: description, price: price, images: [])
        view.showLoading()
        uploadImages(images: data, itemId: item.id) { [weak self] (links) in
            
            guard let self = self else {return}
            
            item.imageLinks.append(contentsOf: links)
            self.view.didFinishedPreparingItemObject(item: item)
        }
    }
    func saveItem(item: Item) {
        view.hideLoading()
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
    
    
    private func uploadImages(images: [Data],itemId:String,completion:@escaping ([String])->Void){
        
        if images.isEmpty{
            completion([])
            return
        }

        var imageLinksArray = [String]()
        var nameSuffix = 0
        var uploadedImageCount = 0
        
        for image in images{
            let fileName = "itemImages/\(itemId)/\(nameSuffix).jpg"
            print(fileName)
            repo.saveToFirebase(image: image, fileName: fileName) { (link) in
                
                if let link = link {
                    imageLinksArray.append(link)
                    uploadedImageCount += 1
                    
                    if uploadedImageCount == images.count{
                        completion(imageLinksArray)
                    }
                }else{
                    print("erro ")
                }
                
            }
            nameSuffix += 1
        }
        
    }
    
}
