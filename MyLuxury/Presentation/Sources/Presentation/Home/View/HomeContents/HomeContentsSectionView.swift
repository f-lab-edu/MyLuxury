//
//  HomeContentsSectionView.swift
//  Presentation
//
//  Created by KoSungmin on 11/10/24.
//

import UIKit

@MainActor
protocol HomeContentsSectionView: UIView {
    associatedtype PostData
    var sectionTitle: String { get set }
    var postData: PostData { get set }
}
