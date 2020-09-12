//
//  CardView.swift
//  LeFood
//
//  Created by Kristo Kiis on 22.07.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import SwiftUI

struct CardView: View {

    @EnvironmentObject var userData: UserData

    var productGroupName: String
    var product: Product
    var isSectionHeader: Bool
    var onBuyButton: ((Product) -> Void)
    var onFavourites: ((Product) -> Void)

    var body: some View{
        VStack(alignment: .leading) {
            if isSectionHeader {
                VStack(alignment: .leading) {
                    Text(productGroupName)
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                    Spacer()
                    Rectangle()
                        .fill(Color.yellow)
                        .frame(height: 3)
                        .edgesIgnoringSafeArea(.horizontal)
                }.frame(height: 40).padding(.bottom, 10)
            }
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {

                    Image("paella-alicante")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    //.shadow(color: .gray, radius: 10, x: 5, y: 5)
                    Text(String(format: "\(self.product.title!)" + " %.02f€", self.product.price!))
                        .fontWeight(.bold)
                        .padding(.top, 6)
                    Text(self.product.content!)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                }
                VStack(alignment: .center, spacing: 60) {
                    Button(action : {
                        self.onBuyButton(self.product)
                    }) {
                        Image(systemName: "cart.badge.plus")
                            .font(.title)
                            .foregroundColor(.primary)
                        Text("")
                    }
                        .padding(.top, 10)
                        .padding(.trailing, -10)
                        .padding(.leading, 10)

                    Button(action : {
                        self.onFavourites(self.product)
                    }) {
                        Image(systemName: userData.items.contains(product) ? "heart.fill" : "heart")
                            .font(.title)
                            .foregroundColor(.primary)
                        Text("")
                    }
                    .padding(.trailing, -10)
                    .padding(.leading, 10)

                }
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(productGroupName:"Mingi cool grupp", product: Product(title: "Soe suupistevalik", content: "Nachod, mozzarellapulgad, sibularõngad, cheddari jalapenod, tomatisalsa, küüslaugumajonees", price: 9.00, image: "paella-alicante"), isSectionHeader: true, onBuyButton: {_ in }, onFavourites: {_ in }).environmentObject(UserData())
    }
}
