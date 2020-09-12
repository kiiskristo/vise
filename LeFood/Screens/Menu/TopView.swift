//
//  TopView.swift
//  LeFood
//
//  Created by Kristo Kiis on 22.07.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import SwiftUI
import Introspect

struct TopView : View {

    @Binding var activeSection: Int
    @Binding var isSticked: Bool

    var productGroups : [ProductGroup]
    var onSelection: ((Int) -> Void)

    @State var scrollView: UIScrollView?
    @State var time = Timer.publish(every: 5, on: .current, in: .tracking).autoconnect()

    var body: some View {

        HStack{
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .bottom, spacing: 20) {
                    ForEach(productGroups.indices) { i in
                        Button(action : {
                            self.onSelection(i)
                            self.scrollToRightPosition(section: i)
                        }) {
                            if i == self.activeSection {
                                Text(self.productGroups[i].wrappedName)
                                .padding(10)
                                .foregroundColor(Color(UIColor.systemBackground))
                                .background(Color.yellow)
                                .cornerRadius(20)
                            } else {
                                Text(self.productGroups[i].wrappedName)
                                .padding(10)
                                .foregroundColor(.primary)
                                .overlay(RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.primary, lineWidth: 2))
                            }
                        }
                    }
                }
                .padding()
                .padding(.top, self.isSticked ? 35 : 10)
                .onReceive(self.time) { (_) in
                    //self.scrollToRightPosition()
                    //debugPrint("TEST")
                }
                .introspectScrollView { scrollView in
                    self.scrollView = scrollView
                }
            }
            .frame(height:self.isSticked ? 105 : 80)

        }.background(Color(UIColor.systemBackground))
    }
}

extension TopView {
    func scrollToRightPosition(section: Int? = nil) {
        guard let scrollView = self.scrollView else { return }
        let maxScroll = UIScreen.main.bounds.width-scrollView.contentSize.width
        let scrollStep = maxScroll / CGFloat(self.productGroups.count-1)
        let currentScroll = scrollStep*CGFloat(section ?? self.activeSection)
        if scrollView.contentOffset.x != -currentScroll {
            scrollView.setContentOffset(CGPoint(x: -currentScroll, y: 0), animated: true)
        }
    }
}


struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AnyViewModel(MenuListViewModel(service: MenuProviderMoc()))
        return TopView(
            activeSection: .constant(0),
            isSticked: .constant(false),
            productGroups: viewModel.menu,
            onSelection: {_ in
                debugPrint("yooo")
            }
        )
    }
}
