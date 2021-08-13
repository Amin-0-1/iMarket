//
//  FirebaseCollectionsReference.swift
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

func getFirebaseReference(_ collectionReference: FBCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
