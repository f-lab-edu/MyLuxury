//
//  LoginView.swift
//  Presentation
//
//  Created by KoSungmin on 11/19/24.
//

import UIKit

final class LoginView: UIView {
    private let loginVM: LoginViewModel
    
    private let inputLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "appLogo")
        return imageView
    }()
    
    private let appSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.black, size: 24)
        label.textColor = .white
        label.text = "상식과 지식 사이"
        return label
    }()
    
    private var appleLoginBtnView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    private var appleLoginBtnLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.bold, size: 18)
        label.textColor = .black
        label.text = "Apple로 로그인하기"
        return label
    }()
    
    private var appleLoginBtnLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "appleLogo")
        imageView.frame = CGRect(x: 0, y: 0, width: 18, height: 22)
        return imageView
    }()
    
    init(loginVM: LoginViewModel) {
        self.loginVM = loginVM
        super.init(frame: .zero)
        setUpHierarchy()
        setUpLayout()
        setUpGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpHierarchy() {
        self.addSubview(inputLogoImageView)
        self.addSubview(appSubtitleLabel)
        self.addSubview(appleLoginBtnView)
        appleLoginBtnView.addSubview(appleLoginBtnLogo)
        appleLoginBtnView.addSubview(appleLoginBtnLabel)
    }
    
    private func setUpLayout() {
        inputLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        appSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        appleLoginBtnView.translatesAutoresizingMaskIntoConstraints = false
        appleLoginBtnLogo.translatesAutoresizingMaskIntoConstraints = false
        appleLoginBtnLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputLogoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            inputLogoImageView.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            inputLogoImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 140),
            inputLogoImageView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 140)/4),
            appSubtitleLabel.leadingAnchor.constraint(equalTo: inputLogoImageView.leadingAnchor),
            appSubtitleLabel.topAnchor.constraint(equalTo: self.centerYAnchor),
            appleLoginBtnView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            appleLoginBtnView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            appleLoginBtnView.widthAnchor.constraint(equalToConstant: screenWidth-60),
            appleLoginBtnView.heightAnchor.constraint(equalToConstant: 60),
            appleLoginBtnLogo.centerYAnchor.constraint(equalTo: appleLoginBtnView.centerYAnchor),
            appleLoginBtnLogo.leadingAnchor.constraint(equalTo: appleLoginBtnView.leadingAnchor, constant: 25),
            appleLoginBtnLabel.centerXAnchor.constraint(equalTo: appleLoginBtnView.centerXAnchor),
            appleLoginBtnLabel.centerYAnchor.constraint(equalTo: appleLoginBtnView.centerYAnchor)
        ])
    }
    
    private func setUpGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(appleLoginViewDidTap))
        self.appleLoginBtnView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func appleLoginViewDidTap() {
        loginVM.sendInputEvent(input: .loginBtnTap)
    }
}
