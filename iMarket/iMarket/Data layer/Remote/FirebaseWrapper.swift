//
//  FirebaseWrapper.swift
//  iMarket
//
//  Created by Amin on 13/08/2021.
//

import Foundation
import FirebaseFirestore

enum FBCollectionReference: String{
    case User
    case Category
    case Items
    case Basket
}

class FirebaseWrapper {
    func save(_ item:NSDictionary) {
        getFirebaseReference(.Category).document(item[kOBJECTID] as! String).setData(item as! [String : Any])
    }
    
    private func getFirebaseReference(_ collectionReference: FBCollectionReference) -> CollectionReference {
        return Firestore.firestore().collection(collectionReference.rawValue)
        
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
