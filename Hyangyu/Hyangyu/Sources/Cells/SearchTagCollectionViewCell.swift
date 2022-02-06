//
//  SearchTagCollectionViewCell.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/24.
//

import UIKit

import SnapKit
import Then

class SearchTagCollectionViewCell: UICollectionViewCell {
    // MARK: - View
    
    let tagLabel = UILabel().then {
        $0.font = UIFont(name: FontType.appleSDGothicNeoLight.rawValue, size: 14)
        $0.textColor = UIColor.primary
    }
    
    private let tagView = UIView().then {
        $0.layer.borderColor = UIColor.primary.cgColor
        $0.layer.borderWidth = 1
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 18
    }
    
    // MARK: - layout
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(tagView)
        tagView.addSubview(tagLabel)
        
        setConstraint()
    }
    
    func setConstraint() {
        
        tagView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        tagLabel.snp.makeConstraints {
            $0.top.equalTo(tagView.snp.top).offset(10)
            $0.leading.equalTo(tagView.snp.leading).offset(16)
            $0.bottom.equalTo(tagView.snp.bottom).offset(-10)
            $0.trailing.equalTo(tagView.snp.trailing).offset(-16)
        }
    }
    
    func setData(title: String){
        tagLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
