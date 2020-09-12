//
//  MenuProviderMoc.swift
//  LeFood
//
//  Created by Kristo Kiis on 05.07.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import Foundation

//should we init with place???
final class MenuProviderMoc: MenuProvider {
    func menuList(completion: @escaping ([ProductGroup]?, Error?) -> Void) {
        let snacks = ProductGroup(name: "Suupisted", place: place, products: productsMoc)
        let salads = ProductGroup(name: "Salatid", place: place, products: productsMoc)
        let mains = ProductGroup(name: "Pearoad", place: place, products: productsMoc)
        let deserts = ProductGroup(name: "Magus", place: place, products: productsMoc)
        let drinks = ProductGroup(name: "Joogid", place: place, products: drinkProductsMoc)
        let menu = [snacks, salads, mains, deserts, drinks]
        completion(menu, nil)
    }

    
    var place: Place = Place(name: "Sadama Suveterrass", info: "Info", image: nil)

    let productsMoc = [
        Product(title: "Soe suupistevalik", content: "Nachod, mozzarellapulgad, sibularõngad, cheddari jalapenod, tomatisalsa, küüslaugumajonees", price: 8.50, image: "paella-alicante"),
        Product(title: "Juurviljavalik", content: "Nachod, mozzarellapulgad, sibularõngad, cheddari jalapenod, tomatisalsa", price: 8.00, image: "paella-alicante"),
        Product(title: "Test3", content: "test", price: 9.00, image: "paella-alicante"),
        Product(title: "Test4", content: "test", price: 8.00, image: "paella-alicante")
    ]

    let drinkProductsMoc = [
        Product(title: "Soe suupistevalik", content: "Nachod, mozzarellapulgad, sibularõngad, cheddari jalapenod, tomatisalsa, küüslaugumajonees", price: 8.50),
        Product(title: "Juurviljavalik", content: "Nachod, mozzarellapulgad, sibularõngad, cheddari jalapenod, tomatisalsa", price: 8.00),
        Product(title: "Test3", content: "test", price: 9.00),
        Product(title: "Test4", content: "test", price: 8.00)
    ]

    func menuList() -> [ProductGroup] {
        let snacks = ProductGroup(name: "Suupisted", place: place, products: productsMoc)
        let salads = ProductGroup(name: "Salatid", place: place, products: productsMoc)
        let mains = ProductGroup(name: "Pearoad", place: place, products: productsMoc)
        let deserts = ProductGroup(name: "Magus", place: place, products: productsMoc)
        let drinks = ProductGroup(name: "Joogid", place: place, products: drinkProductsMoc)
        return [snacks, salads, mains, deserts, drinks]
    }

}
