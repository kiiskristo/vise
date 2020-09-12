//
//  UserData.swift
//  LeFood
//
//  Created by Kristo Kiis on 25.07.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import Foundation

class UserData: ObservableObject {
    @Published
    var items = [Product]()
    @Published
    var favourites = [String]()
    @Published
    var isFacebookSuggestionShown = true

    func add(product: Product) {
        favourites.append(product.objectId!)
        items.append(product)
        debugPrint("Favourites added \(product.objectId!)")
    }

    func remove(product: Product) {
        if let index = favourites.firstIndex(of: product.objectId!) {
            favourites.remove(at: index)
        }
        if let index = items.firstIndex(of: product) {
            items.remove(at: index)
        }
        debugPrint("Favourites removed \(product.objectId!)")
    }

    func toggle(product: Product) {
        if favourites.contains(product.objectId!) && items.contains(product) {
            remove(product: product)
        } else {
            add(product: product)
        }
    }

    func isFavourite(objectId: String) -> Bool {
        return favourites.contains(objectId)
    }
}

