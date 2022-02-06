//
//  SearchView.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/03.
//

import Foundation
import UIKit

protocol SearchViewDelegate {
    func click(searchTerm: String?)
}
class SearchView: UIView {
    
    // MARK: - Property
    private let terms = ["재즈", "연인과 함께", "친구와 함께",
                         "도자기", "정물화", "사진전", "증명사진"]
    // MARK: - View
    
    var delegate: SearchViewDelegate?
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.sectionInset = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        
        $0.isScrollEnabled = false
        $0.collectionViewLayout = layout
        $0.backgroundColor = .systemBackground
        $0.register(SearchTagCollectionViewCell.self, forCellWithReuseIdentifier: "SearchTagCollectionViewCell")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.backgroundColor = .white
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        configureCollectionView()
        
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
    }
}

extension SearchView: UICollectionViewDataSource {
    // cell갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return terms.count
    }
    
    // cell 선언
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchTagCollectionViewCell", for: indexPath) as? SearchTagCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setData(title: terms[indexPath.item])
        
        return cell
    }
}

extension SearchView: UICollectionViewDelegateFlowLayout {
    
    // 셀 크기설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel().then {
            $0.font = .systemFont(ofSize: 14)
            $0.text = terms[indexPath.row]
            $0.sizeToFit()
        }
        let size = label.frame.size
        
        return CGSize(width: size.width + 36, height: size.height + 30)
    }
    
    // 아이템 선택
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.click(searchTerm: terms[indexPath.item])
    }
}
