//
//  File.swift
//  LeFood
//
//  Created by Kristo Kiis on 03.07.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//
import ParseSwift
import Foundation

final class Product: ParseObject, Identifiable {
    var id = UUID()

    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ACL?

    var title : String?
    var content : String?
    var image : String?
    var price: Double?
    var discountPrice: Double?

    init(title : String, content : String, price: Double, image: String? = nil) {
        //super.init()
        self.objectId = id.uuidString
        self.title = title
        self.content = content
        //TODO: use maping, make nicer
/*
        if let image = image {
            let image = UIImage(imageLiteralResourceName: image)
            if let imageData = image.pngData() {
                self.image = PFFileObject(name:"image.png", data:imageData)
            }
        }
 */
        self.price = price
        //self.objectId = UUID().uuidString
    }
}

extension Product: Equatable {
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.objectId == rhs.objectId
    }
}
