//
//  SearchResultView.swift
//  Presentation
//
//  Created by KoSungmin on 11/14/24.
//

import UIKit
import Combine
import Domain

final class SearchResultView: UIView {
    private var cancellables = Set<AnyCancellable>()
    private let searchVM: SearchViewModel
    /// 최근 검색인지 검색 결과인지 여부
    @Published private var isRecentSearch: Bool = true
    
    /// 최근 검색
    var recentSearchPosts: [Post] = [] {
        didSet {
            resultCollectionView.reloadData()
        }
    }
    /// 검색 결과
    var searchResultPosts: [Post] = [] {
        didSet {
            resultCollectionView.reloadData()
        }
    }
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "제목 혹은 카테고리 검색",
            attributes: [
                .foregroundColor: UIColor.getCustomColor(.lightGray),
                .font: UIFont.pretendard(.light, size: 18)
            ]
        )
        textField.backgroundColor = UIColor.getCustomColor(.darkGray)
        textField.layer.cornerRadius = 10
        /// 텍스트 왼쪽 여백을 주기 위해 왼쪽에 빈 UIView 추가
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 45))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 45))
        textField.rightView = rightPaddingView
        textField.rightViewMode = .always
        textField.textColor = .white
        textField.font = UIFont.pretendard(.light, size: 18)
        textField.becomeFirstResponder()
        return textField
    }()
    
    private let cancelTextLabel: UILabel = {
        let label = UILabel()
        label.text = "취소"
        label.font = UIFont.pretendard(.light, size: 18)
        label.textColor = .white
        label.isUserInteractionEnabled = true
        return label
    }()
    
    /// 텍스트 필드가 비어있을 경우 최근 검색, 비어있지 않을 경우 검색 결과
    private let resultTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.bold, size: 18)
        label.textColor = .white
        label.text = "최근 검색"
        return label
    }()
    
    /// 텍스트 필드에 입력값이 없을 때는 최근 검색
    /// 입력값이 있을 때는 검색 결과
    private let resultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth, height: searchPostResultCVCHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    init(searchVM: SearchViewModel) {
        self.searchVM = searchVM
        super.init(frame: .zero)
        self.backgroundColor = .black
        self.searchTextField.delegate = self
        bindEvent()
        setUpCollectionView()
        setUpHierarchy()
        setUpLayout()
        setUpCancelTextTapGesture()
        setUpDismissKeyboardGesture()
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindEvent() {
        $isRecentSearch
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isRecent in
                guard let self = self else { return }
                self.resultTitleLabel.text = isRecent ? "최근 검색" : "검색 결과"
                self.resultCollectionView.reloadData()
            }.store(in: &cancellables)
    }
    
    private func setUpCollectionView() {
        self.resultCollectionView.dataSource = self
        self.resultCollectionView.delegate = self
        self.resultCollectionView.register(SearchResultCVC.self, forCellWithReuseIdentifier: "SearchResultCVC")
    }
    
    private func setUpHierarchy() {
        self.addSubview(searchTextField)
        self.addSubview(cancelTextLabel)
        self.addSubview(resultTitleLabel)
        self.addSubview(resultCollectionView)
    }
    
    private func setUpLayout() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        cancelTextLabel.translatesAutoresizingMaskIntoConstraints = false
        resultTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        resultCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 25),
            searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            searchTextField.widthAnchor.constraint(equalToConstant: screenWidth - 70),
            searchTextField.heightAnchor.constraint(equalToConstant: 45),
            cancelTextLabel.centerYAnchor.constraint(equalTo: self.searchTextField.centerYAnchor),
            cancelTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            resultTitleLabel.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor, constant: 25),
            resultTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            resultCollectionView.topAnchor.constraint(equalTo: resultTitleLabel.bottomAnchor, constant: 15),
            resultCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            resultCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            resultCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpCancelTextTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cancelTextTapped))
        cancelTextLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setUpDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        /// 이 제스처가 다른 터치 이벤트를 막지 않도록 설정
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func cancelTextTapped() {
        searchVM.sendInputEvent(input: .searchBarCancelTapped)
    }
    
    @objc
    private func dismissKeyboard() {
        searchTextField.resignFirstResponder()
    }
}

// MARK: - UITextFieldDelegate
extension SearchResultView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updateText = (currentText as NSString).replacingCharacters(in: range, with: string)
        isRecentSearch = updateText.isEmpty
        return true
    }
}
// MARK: - UICollectionViewDelegate
extension SearchResultView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isRecentSearch ? recentSearchPosts.count : searchResultPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultCVC", for: indexPath) as! SearchResultCVC
        if isRecentSearch {
            let post = recentSearchPosts[indexPath.row]
            cell.isRecentPost = true
            cell.postCategory = post.postCategory.tagName
            cell.thumbnailImage = post.postThumbnailImage
            cell.postTitle = post.postTitle
            cell.onDeleteRecentSearchPost = { [weak self] in
                guard let self = self else { return }
                self.searchVM.sendInputEvent(input: .deleteRecentSearchPostBtnTapped(indexPath.row))
            }
        } else {
            cell.isRecentPost = false
            cell.postCategory = "#인문"
            cell.thumbnailImage = "testImage3"
            cell.postTitle = "그래서 이 아저씨가 누군데?"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isRecentSearch {
            let post = recentSearchPosts[indexPath.row]
            searchVM.sendInputEvent(input: .postTappedFromRecentSearch(post.post_id))
        } else {

        }
    }
    
    /// 컬렉션뷰의 스크롤이 시작될 때 호출되는 메소드
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dismissKeyboard()
    }
}
