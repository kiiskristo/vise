//
//  MenuListViewModel.swift
//  LeFood
//
//  Created by Kristo Kiis on 06.07.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import Foundation

class MenuListViewModel: ViewModel {

    @Published
    var state: MenuListState
    private var service: MenuProvider

    init(service: MenuProvider) {
        let menu = service.menuList()
        let place = service.place
        self.service = service
        self.state = MenuListState(menu: menu, place: place)
    }

    func trigger(_ input: Never) { }
}
