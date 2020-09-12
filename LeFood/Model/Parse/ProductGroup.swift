//
//  ProductGroup.swift
//  LeFood
//
//  Created by Kristo Kiis on 05.07.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import ParseSwift
import Foundation

final class ProductGroup: ParseObject, Identifiable {
    var id = UUID()

    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ACL?

    var name : String?
    var place : Place?
    var products : [Product]?

    init(name : String, place: Place, products: [Product]) {
        self.name = name
        self.place = place
        self.products = products
    }
}

extension ProductGroup: Equatable {
    static func ==(lhs: ProductGroup, rhs: ProductGroup) -> Bool {
        return lhs.objectId == rhs.objectId
    }
}

//SwiftUI purposes
extension ProductGroup {
    public var wrappedName: String {
        get{name ?? "NoName"}
        set{name = newValue}
    }
    public var wrappedPlace: Place? {
        get{place ?? nil}
        set{place = newValue}
    }
    public var wrappedProducts: [Product] {
        get{products ?? [Product]()}
        set{products = newValue}
    }
}
