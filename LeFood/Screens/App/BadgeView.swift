//
//  BadgeView.swift
//  LeFood
//
//  Created by Kristo Kiis on 27.08.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import SwiftUI

struct BadgeView: View {
    var badgePosition: CGFloat
    var tabsCount: CGFloat
    var badgeCount: Int

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .foregroundColor(.red)
                Text("\(badgeCount)")
                    .foregroundColor(.white)
                    .font(Font.system(size: 12))
            }.frame(width: 15, height: 15)
            .offset(x: ( ( 2 * self.badgePosition) - 0.95 ) * ( geometry.size.width / ( 2 * self.tabsCount ) ) + 2, y: geometry.size.height-45)
            .opacity(badgeCount == 0 ? 0 : 1.0)
        }
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView(badgePosition: 2, tabsCount: 3, badgeCount: 1)
    }
}
