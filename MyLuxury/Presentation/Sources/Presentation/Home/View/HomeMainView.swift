//
//  HomeMainView.swift
//  Presentation
//
//  Created by KoSungmin on 10/27/24.
//

import UIKit
import Combine

final class HomeMainView: UIView {
    let headerView = HomeHeaderView()
    var contentView: HomeContentsView
    var homeVM: HomeViewModel
    
    /// 원래는 뷰를 생성할 때 우선적으로 init(frame:)이 호출됩니다.
    /// 따라서 커스텀 생성자를 사용하겠다고 호출하는 쪽에서 지정해줘야 합니다.
    init(homeVM: HomeViewModel) {
        /// 모든 저장 프로퍼티가 초기회된 이후에 super.init()을 호출할 수 있습니다.
        self.homeVM = homeVM
        self.contentView = HomeContentsView(homeVM: homeVM)
        super.init(frame: .zero)
        self.backgroundColor = .black
        setUpHierarchy()
        setUpLayout()
    }
    
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpHierarchy() {
        self.addSubview(headerView)
        self.addSubview(contentView)
    }
    
    private func setUpLayout() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            headerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
