//
//  MenuListView.swift
//  LeFood
//
//  Created by Kristo Kiis on 06.07.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import SwiftUI
import Introspect
import UIKit

struct MenuListState {
    var menu: [ProductGroup]
    var place: Place
}

let headerMultiplier: CGFloat = 2.6

struct MenuListView: View {

    @EnvironmentObject var cart: Cart
    @EnvironmentObject var userData: UserData
    @ObservedObject private var viewModel: AnyViewModel<MenuListState, Never>

    @State fileprivate var tableView: UITableView?
    @State private var showTopView = false
    @State private var activeSection = 0

    init(viewModel: AnyViewModel<MenuListState, Never>) {
        self.viewModel = viewModel
        UITableView.appearance().separatorStyle = .none
    }

    var body: some View {
        ZStack {
            GeometryReader { fullView in
                List {
                    HeaderView(placeName: self.viewModel.place.name ?? "", show: self.$showTopView)
                    Section(header:
                        TopView(
                            activeSection: self.$activeSection,
                            isSticked: self.$showTopView,
                            productGroups: self.viewModel.state.menu,
                            onSelection: { section in
                                self.scrollToRow(section: section)
                        }).padding(.top, self.showTopView ? -25 : 0))
                    {
                        ForEach(self.viewModel.state.menu.indices) { index in
                            ForEach(self.viewModel.state.menu[index].wrappedProducts.indices) { productIndex in
                                CardView(
                                    productGroupName: self.viewModel.state.menu[index].wrappedName,
                                    product: self.viewModel.state.menu[index].wrappedProducts[productIndex],
                                    isSectionHeader: productIndex == 0,
                                    onBuyButton: { product in
                                        self.cart.addToCart(product: product)
                                },
                                    onFavourites: { product in
                                        self.userData.toggle(product: product)
                                }
                                )
                                    .buttonStyle(BorderlessButtonStyle())
                                    .padding([.leading, .trailing], 20)
                                    .onAppear {
                                        if productIndex == 2 || productIndex ==  (self.viewModel.state.menu[index].wrappedProducts.indices.last ?? 100)-2 {
                                            self.activeSection = index
                                        }
                                }
                            }
                        }
                        Spacer()
                    }
                }.padding(-20).introspectTableView() { tableView in
                    withAnimation {
                        self.tableView = tableView
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

extension MenuListView {
    func scrollToRow(section: Int) {
        var total = 0
        for index in 0..<section {
            total += viewModel.menu[index].products?.count ?? 0
        }
        tableView?.scrollToRow(at: IndexPath(row: total, section: 1), at: .top, animated: true)
    }
}

struct MenuListView_Previews: PreviewProvider {
    static var previews: some View {
        let cart = Cart()
        let userData = UserData()
        let viewModel = AnyViewModel(MenuListViewModel(service: MenuProviderMoc()))
        return MenuListView(viewModel: viewModel)
            .environmentObject(cart)
            .environmentObject(userData)
    }
}
