//
//  UIImageView+.swift
//  Presentation
//
//  Created by KoSungmin on 10/30/24.
//

import UIKit

extension UIImageView {
    public func addTopBottomShadow(shadowColor: UIColor = UIColor.black.withAlphaComponent(0.5), shadowHeight: CGFloat) {
        /// 기존의 CAGradientLayer 제거. 제거 안해주면 그림자가 갈수록 중첩되어 적용됨.
        self.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        
        let topShadowLayer = CAGradientLayer()
        topShadowLayer.cornerRadius = self.layer.cornerRadius
        topShadowLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: shadowHeight)
        topShadowLayer.colors = [
            shadowColor.cgColor,
            UIColor.clear.cgColor
        ]
        topShadowLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        topShadowLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        let bottomShadowLayer = CAGradientLayer()
        bottomShadowLayer.cornerRadius = self.layer.cornerRadius
        bottomShadowLayer.frame = CGRect(x: 0, y: self.bounds.height - shadowHeight, width: self.bounds.width, height: shadowHeight)
        bottomShadowLayer.colors = [
            shadowColor.cgColor,
            UIColor.clear.cgColor
        ]
        bottomShadowLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        bottomShadowLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        
//        self.layer.addSublayer(topShadowLayer)
        self.layer.addSublayer(bottomShadowLayer)
    }
}
