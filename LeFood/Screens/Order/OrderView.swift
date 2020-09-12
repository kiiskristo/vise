
//
//  OrderView.swift
//  LeFood
//
//  Created by Kristo Kiis on 15.07.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import SwiftUI
import Stripe

struct OrderState {
    var cart: [Product]
}

enum OrderInput {
    case checkout
}

struct OrderView: View {

    @EnvironmentObject var cart: Cart
    @ObservedObject var paymentContextDelegate = PaymentContextDelegate()
    @State private var paymentContext: STPPaymentContext!

    let config = STPPaymentConfiguration.shared()

    var body: some View {
        NavigationView {

            ScrollView(.vertical) {
                VStack {

                    VStack(alignment: .leading) {
                        ForEach(cart.items) { item in
                            withAnimation {
                                OrderRow(item: item) {
                                    self.cart.remove(product: item.item)
                                }
                                .frame(width: UIScreen.main.bounds.width-40)
                            }
                        }
                    }

                    Spacer().frame(height: 20)

                    // Summary
                    HStack {

                        VStack(alignment: .trailing) {
                            Text("Summa:")
                                .font(.system(size: 18))
                                .foregroundColor(.gray)
                            Text(String(format: "%.02f€", cart.total))
                                .font(.system(size: 34))
                                .fontWeight(.bold)
                        }.frame(width: UIScreen.main.bounds.width-30, height: 40, alignment: .trailing)

                        Spacer()//.frame(width: 80)
                    }

                    // Checkout button
                    Divider().padding()

                    //MARK: - present the payment options VC (to enter CC info) CC means credit card.
                    Button(action: {
                        self.paymentContext.presentPaymentOptionsViewController()
                    }) {
                        Text(self.paymentContextDelegate.paymentMethodButtonTitle)
                    }.padding()

                    //MARK: - If the user is new and has not selected a payment method yet, we dont show the Pay Now button until there is a CC on his account. CC means credit card.
                    if self.paymentContextDelegate.paymentMethodButtonTitle != "Vali maksemeetod" {
                        Button(action: {
                            self.paymentContext.requestPayment()
                        }) {
                            Text("Kinnita")
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
            .navigationBarTitle("Tellimus", displayMode: .large)
            .onAppear {
                //MARK: - Start configuring the payment context as soon as the view appears
                self.paymentContextConfiguration()
            }.alert(isPresented: self.$paymentContextDelegate.showAlert) {
                Alert(title: Text("Tellimus kinnitatud"),
                      message: Text("Aitäh ostu eest, toit saabub kohe."),
                      dismissButton: .default(Text("Ok")) {
                        self.cart.checkout()
                })
            }
        }
    }

    func paymentContextConfiguration() {
        STPTheme.default().accentColor = UIColor.darkText
        let customerContext = STPCustomerContext(keyProvider: MyAPIClient())
        self.config.requiredBillingAddressFields = .none
        self.config.companyName = "LeFood"
        self.paymentContext = STPPaymentContext(customerContext: customerContext, configuration: self.config, theme: .default())
        self.paymentContext.delegate = self.paymentContextDelegate
        let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
            .filter({$0.isKeyWindow}).first

        self.paymentContext.hostViewController = keyWindow?.rootViewController
        self.paymentContext.paymentAmount = Int(cart.total)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        let cart = Cart()
        let paymentContextDelegate = PaymentContextDelegate()
        let product1 = Product(title: "Mango Karri kana ja hobuse mingi asi", content: "V2ga maitsev sook, Kristo lemmik", price: 9.00, image: "paella-alicante-thumb")
        let product2 = Product(title: "Mango Karri", content: "V2ga maitsev sook, Kristo lemmik", price: 9.00, image: "paella-alicante-thumb")
        cart.addToCart(product: product1)
        cart.addToCart(product: product1)
        cart.addToCart(product: product1)
        cart.addToCart(product: product2)
        return OrderView(paymentContextDelegate: paymentContextDelegate).environmentObject(cart)
    }
}

