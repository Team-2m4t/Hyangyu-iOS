//
//  SearchResultCell.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/30.
//

import UIKit

class SearchResultCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "SearchResultCell"

    var isEmptyRecentArray: Bool = false
    var isEmptySearchArray: Bool = false
    var searchType: SearchType = .popular {
        didSet { configure() }
    }

    let resultLabel = UILabel().then {
        $0.text = "테스트"
        $0.textColor = .primary
        $0.font = .systemFont(ofSize: 18)
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white

        self.addSubview(resultLabel)
        resultLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        let underLine = UIView()
        underLine.backgroundColor = UIColor.gray

        self.addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }

    func configure() {
        switch searchType {
        case .popular:
            resultLabel.textColor = UIColor.primary
        case .recent:
            resultLabel.textColor = isEmptyRecentArray ? .lightGray : .black
        case .fileShort:
            resultLabel.textColor = isEmptySearchArray ? .lightGray : .black
        }
    }
}
