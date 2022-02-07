//
//  SearchHeaderCollectionReusableView.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/06.
//

import UIKit

class SearchHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "SearchHeaderCollectionReusableView"
    
    private let headerLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "추천 검색어"
        $0.font = .boldSystemFont(ofSize: 15)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(headerLabel)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers
    override func layoutSubviews() {
        super.layoutSubviews()
        headerLabel.frame = CGRect(x: 15, y: 0, width: frame.size.width-30, height: frame.size.height)
    }
        
}
