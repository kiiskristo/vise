//
//  FoodService.swift
//  LeFood
//
//  Created by Kristo Kiis on 05.07.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

protocol MenuProvider {
    // Book list
    var place: Place { get set }
    func menuList(completion: @escaping ([ProductGroup]?, Error?) -> Void)
    func menuList() -> [ProductGroup]
}
