//
//  Category.swift
//  iMarket
//
//  Created by Amin on 13/08/2021.
//

import Foundation

class Category {
    var id: String
    var name: String
    var imageName: String?
    
    init(_ _name:String, _ _imageName:String) {
        id = UUID().uuidString
        name = _name
        imageName = _imageName
    }
    
    init(_ _dict: NSDictionary) {
        id = _dict[kOBJECTID] as! String
        name = _dict[kNAME] as! String
        imageName = _dict[KIMAGENAME] as? String ?? ""
    }
    
    func convertToDictionary() -> NSDictionary{
        return NSDictionary(objects: [self.id,self.name,self.imageName ?? ""], forKeys: [kOBJECTID as NSCopying ,kNAME as NSCopying,KIMAGENAME as NSCopying])
    }
}
