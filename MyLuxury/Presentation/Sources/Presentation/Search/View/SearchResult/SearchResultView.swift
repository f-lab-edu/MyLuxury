//
//  SearchResultView.swift
//  Presentation
//
//  Created by KoSungmin on 11/14/24.
//

import UIKit
import Combine
import Domain

final class SearchResultView: UIView, UITextFieldDelegate {
    private let searchVM: SearchViewModel
    
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
    
    init(searchVM: SearchViewModel) {
        self.searchVM = searchVM
        super.init(frame: .zero)
        self.backgroundColor = .black
        self.searchTextField.delegate = self
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
    
    private func setUpHierarchy() {
        self.addSubview(searchTextField)
        self.addSubview(cancelTextLabel)
    }
    
    private func setUpLayout() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        cancelTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 25),
            searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            searchTextField.widthAnchor.constraint(equalToConstant: screenWidth - 70),
            searchTextField.heightAnchor.constraint(equalToConstant: 45),
            cancelTextLabel.centerYAnchor.constraint(equalTo: self.searchTextField.centerYAnchor),
            cancelTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    private func setUpCancelTextTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cancelTextTapped))
        cancelTextLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setUpDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
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
