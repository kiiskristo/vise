//
//  Color+Extension.swift
//  LeFood
//
//  Created by Kristo Kiis on 27.08.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//
import UIKit

extension UIColor {
    func hexValue() -> String {
        let values = self.cgColor.components
        var outputR: Int = 0
        var outputG: Int = 0
        var outputB: Int = 0
        var outputA: Int = 1

        switch values!.count {
            case 1:
                outputR = Int(values![0] * 255)
                outputG = Int(values![0] * 255)
                outputB = Int(values![0] * 255)
                outputA = 1
            case 2:
                outputR = Int(values![0] * 255)
                outputG = Int(values![0] * 255)
                outputB = Int(values![0] * 255)
                outputA = Int(values![1] * 255)
            case 3:
                outputR = Int(values![0] * 255)
                outputG = Int(values![1] * 255)
                outputB = Int(values![2] * 255)
                outputA = 1
            case 4:
                outputR = Int(values![0] * 255)
                outputG = Int(values![1] * 255)
                outputB = Int(values![2] * 255)
                outputA = Int(values![3] * 255)
            default:
                break
        }
        return "#" + String(format:"%02X", outputR) + String(format:"%02X", outputG) + String(format:"%02X", outputB) + String(format:"%02X", outputA)
    }
}
