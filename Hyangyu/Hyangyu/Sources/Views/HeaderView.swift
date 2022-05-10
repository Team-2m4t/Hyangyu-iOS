//
//  HeaderView.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/20.
//

import UIKit

import Kingfisher
import Then
import SnapKit

protocol HeaderViewDelegate: class {
    func headerViewDidTapProfileEditButton(_ headerView: HeaderView)
    func headerViewDidTapReviewButton(_ headerView: HeaderView)
}

struct HeaderViewViewModel {
    let profileImage: UIImage?
    let userName: String?
}

class HeaderView: UIView {
    
    
    private var profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = Image.userDefaultImage
    }
    
    private var userNameLabel = UILabel().then {
        $0.font = UIFont(name: FontType.appleSDGothicNeoBold.rawValue, size: 17)
        $0.text = "이물사딱아요"
        $0.textColor = .textBlack
        $0.numberOfLines = 2
    }
    
    private var buttonStackView = UIStackView().then{
        $0.spacing = 15
        $0.axis = .horizontal
        $0.alignment = .center
    }
    
    
    private var profileEditButton = UIButton().then {
        $0.setTitle("프로필 설정 >", for: .normal)
        $0.setTitleColor(.primary, for: .normal)
        $0.titleLabel?.font = UIFont(name: FontType.appleSDGothicNeoMedium.rawValue, size: 13)
    }
    
    private var myReviewButton = UIButton().then {
        $0.setTitle("마이 리뷰 >", for: .normal)
        $0.setTitleColor(.primary, for: .normal)
        $0.titleLabel?.font = UIFont(name: FontType.appleSDGothicNeoMedium.rawValue, size: 13)
    }
    
    // MARK: - Protocol
    
    weak var delegate: HeaderViewDelegate?
    
    func configureUI() {
        addSubview(profileImageView)
        addSubview(userNameLabel)
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(profileEditButton)
        buttonStackView.addArrangedSubview(myReviewButton)
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaInsets.top).offset(110)
            $0.leading.equalTo(safeAreaInsets.left).offset(20)
            $0.height.equalTo(74)
            $0.width.equalTo(profileImageView.snp.height).multipliedBy(1.0 / 1.0)
            
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(15)
            $0.leading.equalTo(safeAreaInsets.left).offset(20)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(safeAreaInsets.left).offset(20)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        configureUI()
        
        profileEditButton.addTarget(self, action: #selector(didTapEdit), for: .touchUpInside)
        myReviewButton.addTarget(self, action: #selector(didTapReview), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapEdit))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
        
        profileImageView.layer.cornerRadius = 36
        profileImageView.clipsToBounds = true
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    // MARK: - Functions
    @objc func didTapEdit() {
        self.delegate?.headerViewDidTapProfileEditButton(self)
    }
    
    @objc func didTapReview() {
        self.delegate?.headerViewDidTapReviewButton(self)
    }
    
    
    
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(ovalIn: CGRect(x:-130,y:-180, width: 601.0, height: 383.3))
        UIColor.systemGray6.set() // 색상 변경
        path.fill()
        
    }
    
    // MARK: - Configure
    func configure(with viewModel: HeaderViewViewModel) {
        profileImageView.image = viewModel.profileImage
        userNameLabel.text = viewModel.userName
    }
    
}
