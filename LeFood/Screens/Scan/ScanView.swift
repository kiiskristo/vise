//
//  ScanView.swift
//  LeFood
//
//  Created by Kristo Kiis on 08.08.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import SwiftUI

struct ScanView: View {

    //@EnvironmentObject var userData: UserData
    private let scanner = NFCScanner()
    private let menuProvider = MenuProviderMoc()
    @State private var isPlaceLoaded: Bool = false

    private var userData = UserData()
    private var cart = Cart()

    var body: some View {
        if isPlaceLoaded {
            AppView(service: menuProvider)
                .environmentObject(cart)
                .environmentObject(userData)
        } else {
            VStack {
                Button(action: {
                    self.isPlaceLoaded = true
                    scanner.scanTheTag()
                }) {
                    Text("Scan")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                }
                .frame(width: 200)
                .padding()
                .foregroundColor(Color(UIColor.systemBackground))
                .background(Color.yellow)
                .cornerRadius(40)

            }
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
