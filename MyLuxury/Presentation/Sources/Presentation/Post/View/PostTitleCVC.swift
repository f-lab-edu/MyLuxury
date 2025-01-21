//
//  PostTitleCVC.swift
//  Presentation
//
//  Created by KoSungmin on 11/14/24.
//

import UIKit
import Domain
import Combine

final class PostTitleCVC: UICollectionViewCell {
    struct ViewModel: Hashable {
        let uuid: String
        let title: String?
        let editorProfileImage: String?
        let thumbnailImage: String?
        let editorName: String?
        let postCreatedAt: String?
        let postCategory: String?
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(uuid)
        }
        
        static func == (lhs: PostTitleCVC.ViewModel, rhs: PostTitleCVC.ViewModel) -> Bool {
            lhs.uuid == rhs.uuid
        }
    }
    
    static let identifier = "postTitleCVC"
    
    let backImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let backBlackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()
    
    let editorProfileImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.bold, size: 40)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    var editorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.bold, size: 16)
        label.textColor = .white
        return label
    }()
    
    var postCreatedAtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.light, size: 16)
        label.textColor = .white
        return label
    }()
    
    var postCategoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.light, size: 18)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setUpHierarchy()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpHierarchy() {
        self.addSubview(backImageView)
        backImageView.addSubview(backBlackView)
        self.addSubview(titleLabel)
        self.addSubview(editorNameLabel)
        self.addSubview(editorProfileImageView)
        self.addSubview(postCreatedAtLabel)
        self.addSubview(postCategoryLabel)
    }
    
    private func setUpLayout() {
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        backBlackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        editorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        editorProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        postCreatedAtLabel.translatesAutoresizingMaskIntoConstraints = false
        postCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backBlackView.topAnchor.constraint(equalTo: self.topAnchor),
            backBlackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backBlackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backBlackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 15),
            editorProfileImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            editorProfileImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -15),
            editorProfileImageView.widthAnchor.constraint(equalToConstant: 50),
            editorProfileImageView.heightAnchor.constraint(equalToConstant: 50),
            editorNameLabel.leadingAnchor.constraint(equalTo: editorProfileImageView.trailingAnchor, constant: 15),
            editorNameLabel.bottomAnchor.constraint(equalTo: editorProfileImageView.centerYAnchor),
            postCreatedAtLabel.leadingAnchor.constraint(equalTo: editorProfileImageView.trailingAnchor, constant: 15),
            postCreatedAtLabel.topAnchor.constraint(equalTo: editorProfileImageView.centerYAnchor),
            postCategoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            postCategoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15)
        ])
    }
    
    func configure(viewModel: ViewModel) {
        self.titleLabel.text = viewModel.title
        self.editorProfileImageView.image = UIImage(named: viewModel.editorProfileImage ?? "blackScreen")
        self.backImageView.image = UIImage(named: viewModel.thumbnailImage ?? "blackScreen")
        self.editorNameLabel.text = viewModel.editorName
        self.postCreatedAtLabel.text = viewModel.postCreatedAt
        self.postCategoryLabel.text = viewModel.postCategory
    }
}
