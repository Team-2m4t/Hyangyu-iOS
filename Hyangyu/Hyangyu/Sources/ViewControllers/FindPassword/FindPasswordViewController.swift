//
//  FindPasswordViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/03.
//

import UIKit

class FindPasswordViewController: UIViewController {
    
    // MARK: - Properties
    
    let user = SignUpUser.shared
    var isResetCodeEnabled: Bool = false
    private var userResetCode: Int = 0
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailTextFieldView: UIView!
    @IBOutlet weak var emailWarningLabel: UILabel!

    
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        setDelegation()
        configureUI()

    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
    }
    
    private func setDelegation() {
        emailTextField.delegate = self
    }
    
    
    private func configureUI() {
        emailTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray2.cgColor)
        nextButton.makeRounded(radius: 20)
        
        emailWarningLabel.isHidden = true
        
        
        nextButton.isEnabled = false
    }
    
    private func checkEmailFormat(email: String) {
        if validateEmail(email: email) {
            nextButton.isEnabled = true
            nextButton.alpha = 1.0
            
            emailWarningLabel.isHidden = true
        } else {
            nextButton.isEnabled = false
            nextButton.alpha = 0.3
            
            emailWarningLabel.isHidden = false
            emailWarningLabel.text = "이메일을 다시 입력해주세요"
        }
    }
    
    func validateEmail(email: String) -> Bool {
        // Email 정규식
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    private func makeCompleteButtonEnable() {
        nextButton.isEnabled = true
        nextButton.alpha = 1.0
    }
    
    private func makeCompleteButtonDisable() {
        nextButton.isEnabled = false
        nextButton.alpha = 0.3
    }
    
    func validateCode(code: String) -> Bool {
        // Email 정규식
        let codeRegEx = "^[0-9]{4}$"
        let codeTest = NSPredicate(format: "SELF MATCHES %@", codeRegEx)
        return codeTest.evaluate(with: code)
    }
    
    private func checkCodeFormat(userInput: String) {
        if validateCode(code: userInput) {
            makeCompleteButtonEnable()
        } else {
            makeCompleteButtonDisable()
        }
    }
    

    
    private func pushToNewPasswordViewController() {
        self.navigationController?.pushViewController(NewPasswordViewController.loadFromNib(), animated: true)
    }
    
    

}

extension FindPasswordViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray2.cgColor)
    }
    
    // 실시간
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return false
        }
        checkEmailFormat(email: text)
        return true
    }
    
    // 키보드 내렸을 때 (.co 등 때문에 추가)
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        checkEmailFormat(email: text)
        emailTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray6.cgColor)
    }

}

extension FindPasswordViewController {
    func getCode() {
        
        if let email = self.emailTextField.text {
            
            PasswordAPI.shared.getEmailCode(completion: { (result) in
                switch result {
                case .success(let code):
                    
                    if let data = code as? CodeData {
                        self.emailWarningLabel.isHidden = true
                        self.user.email = email
                    }
                case .requestErr(let message):
                    self.emailWarningLabel.isHidden = false
                    if let message = message as? String {
                        self.emailWarningLabel.text = "\(message)"
                    }
                case .pathErr:
                    print(".pathErr")
                case .serverErr:
                    print("serverErr")
                case .networkFail:
                    print("networkFail")
                }
            }, email: email)
            
        }
    }
}
