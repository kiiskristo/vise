//
//  MyApiClient.swift
//  Stripe-SwiftUI
//
//  Created by Nelson Gonzalez on 4/13/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import Foundation
import ParseSwift
import Stripe

struct Customer: Codable {
    var api_version: String
    var customer_id: String
}

class MyAPIClient: NSObject, STPCustomerEphemeralKeyProvider {
    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        //let api = API()
        //api.ca
        //ParseCloud.getFromCloud()
/*
        PFCloud.callFunction(inBackground: "create_customer_key", withParameters: ["api_version":apiVersion, "customer_id": "cus_HlkcskIw3nILrI"]) {
            (response, error) in
            completion(response as? [AnyHashable : Any], error)
            //
        }
 */
    }
    
    //MARK: - STEP 1. Create customer.

    class func createCustomer(email: String, phone: String, name: String, onSuccess: @escaping() -> Void, onError: @escaping(Error) -> Void){
        /*
        PFCloud.callFunction(inBackground: "createCustomer", withParameters: ["email": email, "phone": phone, "name": name]) {
            (response, error) in
            //Save customer id somewhere
        }
         */
    }
 
    class func createPaymentIntent(products: [Product], customerId: String, completion: @escaping (String) -> Void) {
        /*
        PFCloud.callFunction(inBackground: "createPaymentIntent", withParameters: ["products": products, "customerId": customerId]) {
            (response, error) in
            guard let clientSecret = response as? String else { return }
            completion(clientSecret)
        }
 */
    }
}
