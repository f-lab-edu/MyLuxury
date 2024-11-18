//
//  SplashView.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit

final class SplashView: UIView {
    private let sceneDelegateWindow: UIWindow
    private let onCompletedSplashView: () -> Void
    
    private let inputLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "appLogoBlack")
        return imageView
    }()
    
    private let appSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.black, size: 24)
        label.textColor = .white
        label.text = "상식과 지식 사이"
        return label
    }()
    
    init(window: UIWindow, completion: @escaping () -> Void) {
        print("SplashView init")
        self.sceneDelegateWindow = window
        self.onCompletedSplashView = completion
        super.init(frame: .zero)
        self.frame = window.bounds
        self.backgroundColor = .white
        self.appSubtitleLabel.isHidden = true
        setUpHierarchy()
        setUpLayout()
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("SplashView deinit")
    }
    
    private func setUpHierarchy() {
        self.addSubview(inputLogoImageView)
        self.addSubview(appSubtitleLabel)
    }
    
    private func setUpLayout() {
        inputLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        appSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputLogoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            inputLogoImageView.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            inputLogoImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 140),
            inputLogoImageView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 140)/4),
            appSubtitleLabel.leadingAnchor.constraint(equalTo: inputLogoImageView.leadingAnchor),
            appSubtitleLabel.topAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func setUpUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.75) {
                self.backgroundColor = .black
                self.inputLogoImageView.image = UIImage(named: "appLogo")
                self.appSubtitleLabel.isHidden = false
            }
        }
        /// 시간이 지나고 window에서 splashview를 제거
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.removeFromSuperview()
            self.onCompletedSplashView()
        }
    }
}
