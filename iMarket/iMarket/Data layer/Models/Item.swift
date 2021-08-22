//
//  Item.swift
//  iMarket
//
//  Created by Amin on 19/08/2021.
//

import Foundation

class Item {
    var id: String!
    var categoryId: String!
    var name: String!
    var description: String!
    var price: Double!
    var imageLinks: [String]!

    init() {}
    
    init(id:String,categoryId:String,name:String,description:String,price:Double,images: [String]) {
        self.id = id
        self.categoryId = categoryId
        self.description = description
        self.imageLinks = images
        self.price = price
        
    }
    
    init(_ _dict: NSDictionary) {
        id = _dict[kOBJECTID] as? String
        name = _dict[kNAME] as? String
        categoryId = _dict[kCATEGORYID] as? String
        description = _dict[kDESCRIPTION] as? String
        price = _dict[kPRICE] as? Double
        imageLinks = _dict[kIMAGELINKS] as? [String]
    }
    
    func convertToDictionary() -> NSDictionary{
        return NSDictionary(objects: [id ?? "",name ?? "",categoryId ?? "",description ?? "",price ?? "",imageLinks ?? []], forKeys: [kOBJECTID as NSCopying ,kNAME as NSCopying,kCATEGORYID as NSCopying,kDESCRIPTION as NSCopying, kPRICE as NSCopying,kIMAGELINKS as NSCopying])
    }
}
