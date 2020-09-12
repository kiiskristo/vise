//
//  PaymentContextDelegate.swift
//  Stripe-SwiftUI
//
//  Created by Nelson Gonzalez on 4/14/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import Foundation
import SwiftUI
import Stripe

class PaymentContextDelegate: NSObject, STPPaymentContextDelegate, ObservableObject {

    @Published var paymentMethodButtonTitle = "Vali maksemeetod"
    @Published var showAlert = false
    @Published var message = ""

    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        //   let title: String
        var message: String

        switch status {
        case .success:

            //    title = "Success!"
            message = "Thank you for your purchase."
            showAlert = true
            self.message = message
        case .error:

            //   title = "Error"
            message = error?.localizedDescription ?? ""
            showAlert = true
            self.message = message
        case .userCancellation:
            return
        @unknown default:
            fatalError("Something really bad happened....")

        }
    }



    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {

        paymentMethodButtonTitle = paymentContext.selectedPaymentOption?.label ?? "Vali maksemeetod"

        //updating the selected shipping method


        //            shippingMethodButtonTitle = paymentContext.selectedShippingMethod?.label ?? "Select Shipping Method"
        //
    }

    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {

    }

    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {

        let customerId = "cus_HlkcskIw3nILrI"

        let paymentAmount = paymentContext.paymentAmount

        print("TOTAL: \(paymentAmount)")

        MyAPIClient.createPaymentIntent(products: [], customerId: customerId) { (reponseString) in

            // Assemble the PaymentIntent parameters
            let paymentIntentParams = STPPaymentIntentParams(clientSecret: reponseString)
            paymentIntentParams.paymentMethodId = paymentResult.paymentMethod?.stripeId
            paymentIntentParams.paymentMethodParams = paymentResult.paymentMethodParams

            STPPaymentHandler.shared().confirmPayment(withParams: paymentIntentParams, authenticationContext: paymentContext) { status, paymentIntent, error in
                switch status {
                case .succeeded:
                    // Your backend asynchronously fulfills the customer's order, e.g. via webhook
                    print("SUCCESS!")

                    completion(.success, nil)
                case .failed:
                    completion(.error, error) // Report error
                case .canceled:
                    completion(.userCancellation, nil) // Customer cancelled
                @unknown default:
                    completion(.error, nil)
                }
            }
        }
    }
}
