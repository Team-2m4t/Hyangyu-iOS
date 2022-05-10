//
//  NewPasswordViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/03.
//

import UIKit

class NewPasswordViewController: UIViewController {
    
    var user = User.shared
    private var isPasswordRight: Bool = false
    private var isConfirmPasswordRight: Bool = false
    
    @IBOutlet weak var passwordTextFieldView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordWarningLabel: UILabel!
    
    @IBOutlet weak var confirmPasswordTextFieldView: UIView!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordWarningLabel: UILabel!
    
    @IBOutlet weak var passwordSecureButton: UIButton!
    @IBOutlet weak var confirmPasswordSecureButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        configureUI()
        setDelegation()
        
    }
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
    }
    
    private func configureUI() {
        [passwordTextFieldView, confirmPasswordTextFieldView].forEach({$0?.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray6.cgColor) })
        [passwordWarningLabel, confirmPasswordWarningLabel].forEach({$0?.isHidden = true })
        
        confirmButtonDisable()
        confirmButton.makeRounded(radius: 12)
        
    }
    
    // MARK: - Functions
    private func checkTextField() {
        // 입력 중 일때
        passwordTextField.addTarget(self, action: #selector(self.checkPasswordTextField), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(self.checkConfirmPasswordTextField), for: .editingChanged)
        
    }
    
    // 비밀번호 텍필 값 바뀔 때
    @objc private func checkPasswordTextField() {
        // 비밀번호
        let passwordCount = passwordTextField.text?.count ?? 0
        if passwordCount > 11 {
            passwordTextField.deleteBackward()
        }
        isPasswordRight = checkPassword(password: passwordTextField.text ?? "")
        passwordWarningLabel.isHidden = isPasswordRight || !passwordTextField.hasText ? true : false
        passwordTextFieldView.layer.borderColor = isPasswordRight || !passwordTextField.hasText ? UIColor.systemGray2.cgColor : UIColor.systemRed.cgColor
        
        // 비밀번호 확인 텍필
        isConfirmPasswordRight = checkConfirmPassword(input: passwordTextField.text ?? "")
        confirmPasswordWarningLabel.isHidden = isConfirmPasswordRight || !confirmPasswordTextField.hasText ? true : false
        confirmPasswordTextFieldView.layer.borderColor = isConfirmPasswordRight || !confirmPasswordTextField.hasText ? UIColor.systemGray2.cgColor : UIColor.systemRed.cgColor
    }
    
    // 비밀번호 확인 텍필 값 바뀔 떄
    @objc private func checkConfirmPasswordTextField() {
        isConfirmPasswordRight = checkConfirmPassword(input: passwordTextField.text ?? "")
        confirmPasswordWarningLabel.isHidden = isConfirmPasswordRight || !confirmPasswordTextField.hasText ? true : false
        confirmPasswordTextFieldView.layer.borderColor = isConfirmPasswordRight || !confirmPasswordTextField.hasText ? UIColor.systemGray2.cgColor : UIColor.systemRed.cgColor
    }
    
    @IBAction func updateCurrentStatus(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry {
            passwordSecureButton.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            passwordSecureButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
    @IBAction func updateConfirmStatus(_ sender: UIButton) {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        if confirmPasswordTextField.isSecureTextEntry {
            confirmPasswordSecureButton.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            confirmPasswordSecureButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
    // 화면 터치시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func checkConfirmPassword (input: String) -> Bool {
        return passwordTextField.text == confirmPasswordTextField.text
    }
    
    private func setDelegation() {
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    private func confirmButtonEnable() {
        confirmButton.isEnabled = true
        confirmButton.alpha = 1.0
    }
    
    private func confirmButtonDisable() {
        confirmButton.isEnabled = false
        confirmButton.alpha = 0.3
    }
    
    private func showFormatError() {
        passwordWarningLabel.isHidden = false
        passwordWarningLabel.text = "6~12자리의 영문, 숫자, 특수문자만 사용 가능합니다"
        passwordWarningLabel.textColor = UIColor.systemRed
        confirmButtonDisable()
    }
    
    private func hideFormatError() {
        passwordWarningLabel.isHidden = false
        passwordWarningLabel.text = "사용 가능한 비밀번호입니다"
        passwordWarningLabel.textColor = UIColor.systemGreen
        confirmButtonDisable()
    }
    
    private func checkPasswordSameness() {
        if passwordTextField.text == confirmPasswordTextField.text {
            confirmPasswordWarningLabel.isHidden = false
            confirmPasswordWarningLabel.text = "비밀번호가 일치합니다"
            confirmPasswordWarningLabel.textColor = .systemGreen
            confirmButtonEnable()
        } else {
            confirmPasswordWarningLabel.isHidden = false
            confirmPasswordWarningLabel.text = "비밀번호가 일치하지 않습니다."
            confirmPasswordWarningLabel.textColor = .systemRed
            confirmButtonDisable()
        }
    }
    
    // 패스워드 정규식 체크
    private func checkPassword(password: String) -> Bool {
        let passwordRegEx = "[A-Z0-9a-z!@#$%^&*()_+=-]{6,12}"
        let passwordText = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordText.evaluate(with: password)
    }
    
    @IBAction func touchCompleteButton(_ sender: UIButton) {
        postNewPassword()
    }
    
    func popToRootViewController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension NewPasswordViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == passwordTextField {
            passwordTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray2.cgColor)
        } else if textField == confirmPasswordTextField {
            confirmPasswordTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray2.cgColor)
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == passwordTextField {
            passwordTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray2.cgColor)
        } else if textField == confirmPasswordTextField {
            confirmPasswordTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray2.cgColor)
        }
        
        guard let password = passwordTextField.text else {
            return
        }
        
        if password != "" {
            if checkPassword(password: password) {
                if confirmPasswordTextField.text != "" {
                    checkPasswordSameness()
                } else {
                    hideFormatError()
                }
            } else {
                showFormatError()
            }
        } else {
            passwordWarningLabel.isHidden = true
        }
    }
}

extension NewPasswordViewController {
    func postNewPassword() {
        guard let password = passwordTextField.text else {
            return
        }
        user.password = password
        
        guard let email = user.email else {
            return
        }
        
        PasswordAPI.shared.postNewPassword(completion: { (response) in
            switch response {
            case .success(let data):
                if let data = data as? String {
                    self.showToast(message: data)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.dismiss(animated: true)
                    }
                }
                self.popToRootViewController()
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }, email: email, password: password)
    }
}
