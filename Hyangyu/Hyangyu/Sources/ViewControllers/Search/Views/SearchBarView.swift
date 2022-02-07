//
//  SearchBarView.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/30.
//

import UIKit

class SearchBarView: UIView {

    // MARK: - Properties

    lazy var searchTextField = UITextField().then {
        $0.placeholder = "전시회 / 페스티벌 / 박람회를 검색하세요"
        $0.font = .systemFont(ofSize: 15)

        let searchIcon = UIImageView()
        searchIcon.contentMode = .scaleAspectFit
        searchIcon.tintColor = UIColor.gray
        searchIcon.image = UIImage(systemName: "magnifyingglass")
        searchIcon.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.width.equalTo(44)
        }

        $0.leftView = searchIcon
        $0.leftViewMode = .always
        $0.clearButtonMode = .whileEditing
        $0.returnKeyType = .search
    }

    private lazy var searchTextCustomView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8

        $0.addSubview(searchTextField)
        searchTextField.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    let cancelButton = UIButton(type: .system).then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.primary, for: .normal)
        $0.setTitleColor(.lightGray, for: .disabled)
        $0.titleLabel?.font = .systemFont(ofSize: 18)
        $0.isEnabled = false
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white
        configureLayout()
        searchTextCustomView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray5.cgColor)
    }

    func configureLayout() {
        [searchTextCustomView, cancelButton].forEach {
            self.addSubview($0)
        }

        searchTextCustomView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-12)
            $0.trailing.equalTo(cancelButton.snp.leading).offset(-12)
        }

        cancelButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
    }
    
    var grow: Bool = false
    
    func animateGrowShrinkTextFields(grow: Bool, duration: TimeInterval) {
        if grow {
            UIView.animate(withDuration: duration, animations: {
                self.searchTextCustomView.snp.updateConstraints {
                    $0.trailing.equalToSuperview().offset(-16)
                }
            }, completion: { (finished: Bool) in
                print("Grow animation complete!")
            })
        } else {
            UIView.animate(withDuration: duration, animations: {
                self.searchTextCustomView.snp.updateConstraints {
                    $0.trailing.equalTo(self.cancelButton.snp.leading).offset(-12)
                }
            }, completion: { (finished: Bool) in
                print("Shrink animation complete!")
            })
        }
    }
}

