//
//  AppView.swift
//  LeFood
//
//  Created by Kristo Kiis on 15.07.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import SwiftUI
import Combine

struct AppState {
    var service: MenuProvider
}

struct AppView: View {

    @EnvironmentObject var userData: UserData
    @EnvironmentObject var cart: Cart
    private var service: MenuProvider

    @State private var selectedTab: Tab = .menu

    init(service: MenuProvider) {
        self.service = service
        UITabBar.appearance().unselectedItemTintColor = .label
        UITabBar.appearance().backgroundColor = UIColor.secondarySystemBackground
    }

    var body: some View {
        // Create tab view - change in SceneDelegate
        ZStack(alignment: .bottomLeading) {

            TabView(selection: self.$selectedTab) {

                MenuListView(viewModel: AnyViewModel(MenuListViewModel(service: self.service)))
                    .tabItem {
                        Image(systemName: self.tabIcon(tab: .menu))
                            .font(.title)
                        Text("")
                    }.tag(Tab.menu)

                OrderView()
                    .tabItem {
                        Image(systemName: self.tabIcon(tab: .orders))
                            .font(.title)
                        Text("")
                    }.tag(Tab.orders)

                FavouritesView()
                    .tabItem {
                        Image(systemName: self.tabIcon(tab: .favourites))
                            .font(.title)
                        Text("")
                    }.tag(Tab.favourites)

            }.accentColor(.primary)
            BadgeView(badgePosition: 2, tabsCount: 3, badgeCount: cart.numberOfItems)
            ToastView(state: .minimized, onClosed: {
                self.userData.isFacebookSuggestionShown = false
            }).opacity(self.userData.isFacebookSuggestionShown && selectedTab == .menu ? 1 : 0)
        }
    }
}

extension AppView {
    enum Tab: Hashable {
        case menu
        case orders
        case favourites
    }

    func tabIcon(tab: Tab) -> String {
        switch tab {
        case .menu:
            return selectedTab == tab ? "house.fill" : "house"
        case .orders:
            return selectedTab == tab ? "cart.fill" : "cart"
        case .favourites:
            return selectedTab == tab ? "heart.fill" : "heart"
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        let cart = Cart()
        let userData = UserData()
        return AppView(service: MenuProviderMoc())
            .environmentObject(cart)
            .environmentObject(userData)
            .environment(\.colorScheme, .dark)
    }
}
