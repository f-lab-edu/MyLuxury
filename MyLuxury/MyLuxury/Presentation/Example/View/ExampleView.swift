//
//  ExampleView.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/3/24.
//

import UIKit

final class ExampleView: UIView {
    
    let myView = UIView()
    let exampleUILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(exampleUILabel)
        
        exampleUILabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            exampleUILabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            exampleUILabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        exampleUILabel.text = "안녕하세요"
        exampleUILabel.textColor = .white
    }
}
