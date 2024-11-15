//
//  Font+.swift
//  Presentation
//
//  Created by KoSungmin on 10/26/24.
//

import UIKit

public extension UIFont {
    enum Pretendard {
        case thin
        case extraLight
        case light
        case regular
        case medium
        case semibold
        case bold
        case extrabold
        case black
        
        var name: String {
            switch self {
            case .thin:
                return "Pretendard-Thin"
            case .extraLight:
                return "Pretendard-ExtraLight"
            case .light:
                return "Pretendard-Light"
            case .regular:
                return "Pretendard-Regular"
            case .medium:
                return "Pretendard-Medium"
            case .semibold:
                return "Pretendard-SemiBold"
            case .bold:
                return "Pretendard-Bold"
            case .extrabold:
                return "Pretendard-ExtraBold"
            case .black:
                return "Pretendard-Black"
            }
        }
    }
    
    public static func pretendard(_ weight: Pretendard, size: CGFloat) -> UIFont {
        return UIFont(name: weight.name, size: size)!
    }
}
