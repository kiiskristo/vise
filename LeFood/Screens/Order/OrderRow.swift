//
//  OrderRowView.swift
//  LeFood
//
//  Created by Kristo Kiis on 24.07.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import SwiftUI

struct OrderRow: View {

    var item: Item
    var onRemoveButton: (() -> Void)

    var body: some View {
        HStack {
            
            Image("paella-alicante-thumb")
            .resizable()
            .frame(width: 80, height: 80)
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            //.shadow(color: .gray, radius: 10, x: 5, y: 5)
            .padding(.trailing)

            VStack(alignment: .leading) {
                Text(item.item.title ?? "").frame(maxWidth: .infinity, alignment: .leading)
                Spacer().frame(height: 5)
                if item.units > 1 {
                    Text("x\(item.units)").fontWeight(.semibold)
                }
                Spacer().frame(height: 10)
                Text(String(format: "%.02f€", item.item.price ?? 0))
                    .font(.system(size: 18))
                    .bold()
            }.padding([.top, .bottom])
            Button(action : {
                self.onRemoveButton()
            }) {
                Image(systemName: "minus.circle").font(.title).foregroundColor(.primary)
                Text("")
            }.padding(.leading, 10)
                .padding(.trailing, -10)
        }
    }
}

struct OrderRow_Previews: PreviewProvider {
    static var previews: some View {
        OrderRow(
            item: Item(id: UUID().uuidString,
                       item: Product(title: "Mango Karri kana ",
                                     content: "V2ga maitsev sook, Kristo lemmik",
                                     price: 8.00,
                                     image: "paella-alicante-thumb"
                ), units: 2
            ), onRemoveButton: {
                debugPrint("yeah")
            }
        )
    }
}
