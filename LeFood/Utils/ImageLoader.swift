//
//  ImageLoader.swift
//  LeFood
//
//  Created by Kristo Kiis on 05.07.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import Combine
import UIKit
import Foundation
import ParseSwift

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let pfobject: File
    private(set) var isLoading = false

    init(pfobject: File) {
        self.pfobject = pfobject
    }

    func load() {
        isLoading = true
        /*
        pfobject.getDataInBackground({ [weak self] (data, error) in
            self?.isLoading = false
            if let data = data {
                self?.image = UIImage(data: data)
            }
        }) { [weak self] progress in
            self?.isLoading = true
        }
        */
    }

    func cancel() {
        //pfobject.cancel()
    }

    deinit {
        //pfobject.cancel()
    }
}
