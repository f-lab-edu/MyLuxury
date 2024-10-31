//
//  UIColor+.swift
//  Presentation
//
//  Created by KoSungmin on 10/27/24.
//

import UIKit

extension UIColor {
    enum Custom {
        case customBlue
        case lightGray
        case darkGray
        case textGray
        
        var name: String {
            switch self {
            case .customBlue:
                return "customBlue"
            case .lightGray:
                return "lightGray"
            case .darkGray:
                return "darkGray"
            case .textGray:
                return "textGray"
            }
        }
    }
    
    static func getCustomColor(_ name: Custom) -> UIColor {
        guard let color = UIColor(named: name.name) else { return .black }
        return color
    }
}
