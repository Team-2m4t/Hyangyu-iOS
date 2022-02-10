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
    
    private var reviewRequest = ReviewRequest(content: "", score: 0)
    
    private var score: Int = 0
    
    private var displayId: Int = 0
    
    private var isKeyboardOn: Bool = false
    private var keyboardHeight: CGFloat = 0
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        isKeyboardOn = true
    }
    @objc private func keyboardWillHide(_ notification: Notification) {
        keyboardHeight = 0
        isKeyboardOn = false
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
    
    func configure(displayId: Int) {
        self.displayId = displayId
        print("전시 아이디: \(displayId)")
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
        postDisplayReivew{[weak self] response in
            NotificationCenter.default.post(
                name: NSNotification.Name("RefreshMyReviewCollectionView"),
                object: nil,
                userInfo: nil
            )
        }
    }
    
    // 토스트 메세지
    private func showToastKeyboard(message: String) {
        let isKeyboardOn: Bool = self.isKeyboardOn
        let keyboardHeight: CGFloat = self.keyboardHeight
        var toastLabel = UILabel()
        // 토스트 위치
        if isKeyboardOn {
            toastLabel = UILabel(frame: CGRect(x: 30,
                                               y: self.view.frame.size.height - keyboardHeight - 59,
                                               width: self.view.frame.size.width - 60,
                                               height: 40))
        } else {
            toastLabel = UILabel(frame: CGRect(x: 30,
                                               y: self.view.frame.size.height - 95,
                                               width: self.view.frame.size.width - 60,
                                               height: 40))
        }
        // 토스트 색
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        // 토스트 값
        toastLabel.text = message
        // 토스트 모양
        toastLabel.textAlignment = .center
        toastLabel.layer.cornerRadius = 12
        toastLabel.clipsToBounds = true
        // 토스트 애니메이션
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.0, delay: 0.1,
                       options: .curveEaseIn, animations: { toastLabel.alpha = 0.0 },
                       completion: {_ in toastLabel.removeFromSuperview() })
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

extension WriteReviewViewController {
    func postDisplayReivew(completion: @escaping(String) -> Void) {
        reviewRequest.content = activityTextView.text
        score = Int.random(in: 2...5)
        ReviewAPI.shared.postDisplayReview(displayId: displayId, content: reviewRequest.content, score: score) { (response) in
            switch response {
            case .success(let data):
                if let data = data as? String {
                    self.showToastKeyboard(message: data)
                    completion(data)
                    
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.dismiss(animated: true)
                }
            case .requestErr(let message):
                if let message = message as? String {
                    print(message)
                    self.showToastKeyboard(message: "이미 전시에 대한 리뷰를 달았습니다.")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.dismiss(animated: true)
                }
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
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
