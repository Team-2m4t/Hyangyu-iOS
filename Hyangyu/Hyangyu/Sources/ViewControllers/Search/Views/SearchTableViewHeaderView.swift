//
//  SearchTableViewHeaderView.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/30.
//

import UIKit

class SearchTableViewHeaderView: UIView {

    // MARK: - Properties

    private var searchType: SearchType {
        didSet { configure() }
    }

    private let headerLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 12)
    }

    // MARK: - LifeCycle

    init(searchType: SearchType) {
        self.searchType = searchType
        super.init(frame: .zero)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white
        configureLayout()
        configure()
    }

    func configureLayout() {
        self.addSubview(headerLabel)

        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-4)
        }
    }

    func configure() {
        headerLabel.text = searchType.description
    }
}
