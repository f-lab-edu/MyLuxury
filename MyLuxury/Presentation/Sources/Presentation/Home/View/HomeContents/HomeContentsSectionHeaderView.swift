//
//  HomeSectionHeaderView.swift
//  Presentation
//
//  Created by KoSungmin on 12/11/24.
//

import UIKit

final class HomeSectionHeaderView: UICollectionReusableView {
    struct ViewModel {
        let sectionTitle: String
    }
    
    static let identifier = "HomeSectionHeaderView"
    
    let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.extrabold, size: 24)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(sectionTitleLabel)
        sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sectionTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            sectionTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: ViewModel) {
        self.sectionTitleLabel.text = viewModel.sectionTitle
    }
}
