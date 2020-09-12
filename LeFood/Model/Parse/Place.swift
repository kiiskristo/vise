//
//  Place.swift
//  LeFood
//
//  Created by Kristo Kiis on 05.07.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import ParseSwift
import Foundation

final class Place: ParseObject, Identifiable {
    var id = UUID()

    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ACL?

    var name : String?
    var info : String?
    var image : File?

    init(name : String, info : String, image: File?) {
        self.name = name
        self.info = info
        self.image = image
    }
}
