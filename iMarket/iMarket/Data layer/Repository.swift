//
//  Repository.swift
//  iMarket
//
//  Created by Amin on 13/08/2021.
//

import Foundation

class Repository {
    var remote: FirebaseWrapper
    
    init() {
        remote = FirebaseWrapper()
        
    }
    
    func loadCategories(completion: @escaping (Result<[Category],NSError>)->Void) {
        
               
        self.remote.load(collectionName: .Category) { (result) in
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let categories):
                completion(.success(categories))
            }
        }
                
    }
    
    func saveItem(item:Item) {
        self.remote.save(item.convertToDictionary(), in: .Items)
    }
    
    func saveToFirebase(image:Data,fileName:String,completion:@escaping (_ links:String?)->Void){
        remote.saveImageToFirestorage(image: image, fileName: fileName) { (link) in
            completion(link)
        }
    }
    
}

