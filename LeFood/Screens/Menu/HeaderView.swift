//
//  MenuHeaderView.swift
//  LeFood
//
//  Created by Kristo Kiis on 06.08.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct HeaderView: View {
    var placeName: String
    @Binding var show: Bool

    var body: some View {
        GeometryReader { g in
            Image("cover")
                .resizable()
                .scaledToFill()
                .offset(y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0)
                .frame(width: g.size.width, height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / headerMultiplier + g.frame(in: .global).minY  : UIScreen.main.bounds.height / headerMultiplier)
            .onDisappear {
                self.show = true
            }.onAppear {
                self.show = false
            }
            Text(self.placeName)
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(.leading, 15)
                .padding(.bottom, 15)
                .frame(width: g.size.width, height: 100, alignment: .bottomLeading)
                .background(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .bottom, endPoint: .top))
                .offset(y: UIScreen.main.bounds.height / headerMultiplier - 100)
        }
        .frame(height: UIScreen.main.bounds.height / headerMultiplier)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        return HeaderView(placeName: "Sadama Suveterrass",
                          show: .constant(true))
    }
}
