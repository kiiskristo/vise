//
//  Cart.swift
//  LeFood
//
//  Created by Kristo Kiis on 05.07.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import Foundation

struct Item: Identifiable {
    var id: String
    var item: Product
    var units: Int
}

class Cart: ObservableObject {
    @Published
    var items = [Item]()
    @Published
    var numberOfItems = 0
    var total: Double {
        if items.count > 0 {
            return items.reduce(0) { $0 + ($1.item.price ?? 0)*Double($1.units) }
        } else {
            return 0
        }
    }

    func addToCart(product: Product) {
        numberOfItems += 1
        if let index = (items.firstIndex{ $0.item == product }) {
            items[index].units += 1
        } else {
            items.append(Item(id: UUID().uuidString, item: product, units: 1))
        }
    }

    func remove(product: Product) {
        if let index = (items.firstIndex { $0.item == product }) {
            if items[index].units > 1 {
                items[index].units -= 1
            } else {
                items.remove(at: index)
            }
            numberOfItems -= 1
        }
    }

    func checkout() {
        // Checkout = empty cart item
        debugPrint("Done, send to compucash, pay money later")
    }

}
