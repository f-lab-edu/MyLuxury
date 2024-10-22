//
//  SplashView.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import UIKit

class SplashView: UIView {
    
    var sceneDelegateWindow: UIWindow?
    
    init(window: UIWindow?) {
        print("SplashView init")
        self.sceneDelegateWindow = window
        super.init(frame: window!.bounds)
        window?.addSubview(self)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("SplashView deinit")
    }
    
    private func setUpUI() {
        
        self.backgroundColor = .white
        
        let label = UILabel()
        label.text = "SplashView"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 0.5, animations: {
                self.backgroundColor = .black
                label.textColor = .white
            })
        }
        
        // 일정 시간 후 스플래시 화면 제거
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 0.0
            }) { _ in
                self.removeFromSuperview() // 스플래시 뷰 제거
            }
        }
    }
}


//guard let window = self.window else { return }
//
//// 스플래시 화면을 담을 뷰
//let splashView = SplashView(frame: window.bounds)
//splashView.backgroundColor = .white
//
//let label = UILabel()
//label.text = "Splash Screen"
//label.textAlignment = .center
//label.font = UIFont.boldSystemFont(ofSize: 24)
//label.translatesAutoresizingMaskIntoConstraints = false
//
//splashView.addSubview(label)
//
//// 오토레이아웃으로 화면 중앙에 배치
//NSLayoutConstraint.activate([
//    label.centerXAnchor.constraint(equalTo: splashView.centerXAnchor),
//    label.centerYAnchor.constraint(equalTo: splashView.centerYAnchor)
//])
//
//// window의 가장 위에 스플래시 뷰 추가
//window.addSubview(splashView)
//
//// 2초 후 배경색과 레이블 색상 변경 애니메이션
//DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//    UIView.animate(withDuration: 0.5, animations: {
//        splashView.backgroundColor = .black
//        label.textColor = .white
//    })
//}
//
//// 일정 시간 후 스플래시 화면 제거
//DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
//    UIView.animate(withDuration: 0.5, animations: {
//        splashView.alpha = 0.0
//    }) { _ in
//        splashView.removeFromSuperview() // 스플래시 뷰 제거
//    }
//}
