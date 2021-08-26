//
//  FirebaseWrapper.swift
//  iMarket
//
//  Created by Amin on 13/08/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage


enum FBCollectionReference: String{
    case User
    case Category
    case Items
    case Basket
}

class FirebaseWrapper {
    func save(_ item:NSDictionary,in collection: FBCollectionReference) {
        getFirebaseReference(collection).document(item[kOBJECTID] as! String).setData(item as! [String : Any])
    }
    
    func load(collectionName:FBCollectionReference,completion: @escaping (Result<[Category],NSError>)->Void ) {
        getFirebaseReference(.Category).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error as NSError))
            }else{
                guard let snapshot = snapshot else { completion(.success([])) ; return }
                
                var categories = [Category]()
                if !snapshot.isEmpty{
                    for document in snapshot.documents{
                        let dict = document.data()
                        categories.append(Category(dict as NSDictionary))
                    }
                    completion(.success(categories))
                }
            }
        }
    }
    
    private func getFirebaseReference(_ collectionReference: FBCollectionReference) -> CollectionReference {
        return Firestore.firestore().collection(collectionReference.rawValue)
        
    }
    
    func saveImageToFirestorage(image:Data,fileName:String,completion: @escaping (_ imageLink:String?)->Void){
        let storage = Storage.storage()

        var task: StorageUploadTask!
        let storageRef = storage.reference(forURL: kFIREBASE_STORAGE).child(fileName)
        task = storageRef.putData(image, metadata: nil, completion: { (metadata, error) in
                 
            task.removeAllObservers()
             
            if error != nil{
                completion(nil)
                return
            }else{
                storageRef.downloadURL { (url, error) in
                    guard let url = url else { completion(nil) ;return }
                    completion(url.absoluteString)
                    task.removeAllObservers()
                }
            }

            
        })
    }

}


//func createCategorySet() {
//    let womenClothing = Category ("Women's Clothing & Accessories", "womenCloth")
//    let footWaer = Category ( "Footwaer","footWaer")
//    let electronics = Category ( "Electronics",  "electronics")
//    let menClothing = Category ( "Men's Clothing & Accessories","menCloth")
//    let health = Category ( "Health & Beauty",  "health")
//    let baby = Category ("Baby Stuff",  "baby")
//    let home = Category ( "Home & Kitchen",  "home")
//    let car = Category ( "Automobiles & Motorcyles",  "car")
//    let luggage = Category ( "Luggage & bags",  "luggage")
//    let jewelery = Category ("Jewelery",  "jewelery")
//    let hobby = Category ( "Hobby, Sport, Traveling",  "hobby")
//    let pet = Category( "Pet products",  "pet")
//    let industry = Category ( "Industry & Business",  "industry")
//    let garden = Category ( "Garden supplies",  "garden")
//    let camera = Category ( "Cameras & Optics",  "camera")
//
//    let categories = [womenClothing,footWaer,electronics,menClothing,health,baby,home,car,luggage,jewelery,car,hobby,pet,industry,garden,camera]
//
//    for item in categories{
//        FirebaseWrapper().save(item.convertToDictionary())
//    }
//
//}
