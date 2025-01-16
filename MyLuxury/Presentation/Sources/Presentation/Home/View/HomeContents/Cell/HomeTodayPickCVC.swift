//
//  HomeTodayPickCVC.swift
//  Presentation
//
//  Created by KoSungmin on 12/11/24.
//

import UIKit

final class HomeTodayPickCVC: UICollectionViewCell {
    struct ViewModel: Hashable {
        let uuid: String
        let homePostTemplate: HomePostTemplate
        
        // DiffableDataSource는 내부적으로 Hashable과 Equtable을 사용하여
        // 이전 스냅샷과 새로운 스냅샷을 비교함.
        
        // hash와 == 메소드는 항상 일관성을 유지해야함.
        func hash(into hasher: inout Hasher) {
            hasher.combine(uuid)
        }
        
        // title이 업데이트 될 수 있는 상황이라면
        // equtable에서 title도 비교를 해줘야 함.
        static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
            lhs.uuid == rhs.uuid
        }
    }
    
    static let identifier = "HomeTodayPickCVC"
    
    private let postThumbnailImageView: UIImageView = {
        let content = UIImageView()
        content.layer.cornerRadius = 10
        content.isUserInteractionEnabled = true
        return content
    }()
    
    private let postTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.extrabold, size: 22)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHierarchy()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpHierarchy() {
        self.addSubview(postThumbnailImageView)
        postThumbnailImageView.addSubview(postTitleLabel)
    }
    
    private func setUpLayout() {
        postThumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        postTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postThumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor),
            postThumbnailImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            postThumbnailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            postThumbnailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            postTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            postTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            postTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    func configure(viewModel: ViewModel) {
        self.postTitleLabel.text = viewModel.homePostTemplate.postTitle
        self.postThumbnailImageView.image = UIImage(named: viewModel.homePostTemplate.postThumbnailImage)
    }
}
