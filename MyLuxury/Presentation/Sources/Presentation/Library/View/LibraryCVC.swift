//
//  LibraryCVC.swift
//  Presentation
//
//  Created by KoSungmin on 11/28/24.
//

import UIKit

final class LibraryCVC: UICollectionViewCell {
    static let idenrifier = "LibraryCVC"
    
    private let itemTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.bold, size: 20)
        label.textColor = .white
        return label
    }()
    
    private let goToNextImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chevronRight")
        imageView.frame = CGRect(x: 0, y: 0, width: 10, height: 18)
        return imageView
    }()
    
    var itemTitle: String? {
        didSet {
            self.itemTitleLabel.text = itemTitle
            if itemTitle == "로그아웃" || itemTitle == "회원탈퇴" {
                goToNextImageView.isHidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHierarchy()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpHierarchy() {
        self.addSubview(itemTitleLabel)
        self.addSubview(goToNextImageView)
    }
    
    private func setUpLayout() {
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        goToNextImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            itemTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            goToNextImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            goToNextImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
}
