//
//  API.swift
//  LeFood
//
//  Created by Kristo Kiis on 26.08.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import Foundation
import Networking
import Combine

struct Api: NetworkingService {

    var network = NetworkingClient(baseURL: "https://bdcapps.eu/parse/functions")
    let cloudHeaders = ["X-Parse-Application-Id": "compucash", "X-Parse-Client-Key": "parseClientKey"]
    mutating func callCloudMethod(path: String, params: Codable) -> AnyPublisher<Any, Error> {
        network.headers = cloudHeaders
        //network.post(<#T##route: String##String#>, params: <#T##Params#>)
        //post(path, params: params)
        //network.headers = cloudHeaders

        return post(path, params: params as! Params)
    }

}

/*
 curl -X POST \
   -H "X-Parse-Application-Id: compucash" \
   -H "Content-Type: application/json" \
   -d '{api_version:1}' \
   http://bdcapps.eu:1337/parse/functions/create_customer_key
 */
