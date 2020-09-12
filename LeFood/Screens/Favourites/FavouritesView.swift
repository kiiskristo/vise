//
//  FavouritesView.swift
//  LeFood
//
//  Created by Kristo Kiis on 15.07.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import SwiftUI

struct FavouritesState {
    var favourites: [Product]
    var place: Place
}

struct FavouritesView : View {

    @EnvironmentObject var userData: UserData
    @EnvironmentObject var cart: Cart

    var body: some View {
        NavigationView {
            if userData.items.isEmpty {
                Text("Lisa lemmikuid menüüst")
            }
            ScrollView(.vertical, showsIndicators: false, content: {
                ForEach(userData.items) { product in
                    CardView(productGroupName: "",
                             product: product,
                             isSectionHeader: false,
                             onBuyButton: {_ in
                                self.cart.addToCart(product: product)
                            }) {_ in
                                self.userData.toggle(product: product)
                    }.padding([.top, .leading, .trailing], 20)
                }
                Spacer()
            }).navigationBarTitle("Lemmikud", displayMode: .large)
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        return FavouritesView()
    }
}
