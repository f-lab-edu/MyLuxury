//
//  HomeHorizontalCVC.swift
//  Presentation
//
//  Created by KoSungmin on 10/29/24.
//

import UIKit

final class HomeHorizontalCVC: UICollectionViewCell {
    struct ViewModel: Hashable {
        let uuid: String
        let homePostTemplate: HomePostTemplate
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(uuid)
        }
        static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
            lhs.uuid == rhs.uuid
        }
    }
    
    static let identifier = "HomeHorizontalCVC"
    private var viewModel: ViewModel?
    
    private var contentImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private var contentTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = 2
        title.textColor = UIColor.getCustomColor(.textGray)
        title.font = UIFont.pretendard(.light, size: 14)
        return title
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentImage)
        addSubview(contentTitle)
        contentImage.translatesAutoresizingMaskIntoConstraints = false
        contentTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentImage.topAnchor.constraint(equalTo: self.topAnchor),
            contentImage.widthAnchor.constraint(equalToConstant: homeHorizontalCVCLength),
            contentImage.heightAnchor.constraint(equalToConstant: homeHorizontalCVCLength),
            contentTitle.topAnchor.constraint(equalTo: contentImage.bottomAnchor, constant: 5),
            contentTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.contentTitle.text = viewModel.homePostTemplate.postTitle
        self.contentImage.image = UIImage(named: viewModel.homePostTemplate.postThumbnailImage)
    }
}
