//
//  WriteReviewViewController.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/02/06.
//

import UIKit
import SnapKit
import Then

class WriteReviewViewController: UIViewController {
    
    let placeholder = "전시/박람회/페스티벌에 대한 리뷰를 남겨주세요."
    
    let activityTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 17)
        $0.layer.cornerRadius = 18
        $0.backgroundColor = .white
        $0.tintColor = .black
        $0.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    let letterNumLabel = UILabel().then {
        $0.text = "0/300"
        $0.font = .systemFont(ofSize: 17)
        $0.textColor = .black
        $0.textAlignment = .right
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupAutoLayout()
        setupTextView()
    }
    
    // MARK: - Custom Method
    func configUI() {
        view.backgroundColor = .white
    }
    
    func setupAutoLayout() {
        view.addSubview(activityTextView)
        view.addSubview(letterNumLabel)
        
        activityTextView.snp.makeConstraints { make in
            make.top.equalTo(110)
            make.centerX.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(340)
        }
        
        letterNumLabel.snp.makeConstraints { make in
            make.top.equalTo(activityTextView.snp.bottom).offset(6)
            make.trailing.equalToSuperview().inset(28)
        }
    }
    
    func setupTextView() {
        activityTextView.delegate = self
        activityTextView.text = placeholder /// 초반 placeholder 생성
        activityTextView.textColor = .gray /// 초반 placeholder 색상 설정
    }
    
    /// 화면을 누르면 키보드 내려가게 하는 것
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 취소 버튼
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 확인 버튼
    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension WriteReviewViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        /// 플레이스홀더
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            activityTextView.textColor = .gray
            activityTextView.text = placeholder
        } else if textView.text == placeholder {
            activityTextView.textColor = .black
            activityTextView.text = nil
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let color = UIColor(rgb: 0x005550)
        
        /// 글자 수 제한
        if activityTextView.text.count > 300 {
            activityTextView.deleteBackward()
        }
        
        /// 아래 글자 수 표시되게 하기
        letterNumLabel.text = "\(activityTextView.text.count)/300"
        
        /// 글자 수 부분 색상 변경
        let attributedString = NSMutableAttributedString(string: "\(activityTextView.text.count)/300")
        attributedString.addAttribute(.foregroundColor, value: color, range: ("\(activityTextView.text.count)/300" as NSString).range(of:"\(activityTextView.text.count)"))
        letterNumLabel.attributedText = attributedString
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        /// 텍스트뷰 입력 완료시 테두리 없애기
        activityTextView.layer.borderWidth = 0
        
        /// 플레이스홀더
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textView.text == placeholder {
            activityTextView.textColor = .gray
            activityTextView.text = placeholder
            letterNumLabel.textColor = .gray /// 텍스트 개수가 0일 경우에는 글자 수 표시 색상이 모두 gray 색이게 설정
            letterNumLabel.text = "0/300"
        }
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
