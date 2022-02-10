//
//  SignUpViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/24.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: Properties
    private var user = SignUpUser.shared
    private var isEmailRight: Bool = false
    private var isPasswordRight: Bool = false
    private var isConfirmPasswordRight: Bool = false
    private var isNicknameRight: Bool = false
    private var nameCount: Int = 0
    private var maxLength = 10
    
    // MARK: - @IBOutlets
    @IBOutlet weak var emailTextFieldView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailWarningLabel: UILabel!
    
    @IBOutlet weak var passwordTextFieldView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordWarningLabel: UILabel!
    
    @IBOutlet weak var confirmPasswordTextFieldView: UIView!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordWarningLabel: UILabel!
    
    @IBOutlet weak var nicknameTextFieldView: UIView!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var nicknameWarningLabel: UILabel!
    @IBOutlet weak var countingLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var passwordSecureButton: UIButton!
    @IBOutlet weak var confirmPasswordSecureButton: UIButton!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        checkTextField()
        navigationController?.initWithBackButton(backgroundColor: .white)
        
    }
    
    // MARK: - Functions
    @IBAction func updateCurrentStatus(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry {
                    passwordSecureButton.setImage(UIImage(systemName: "eye"), for: .normal)
                } else {
                    passwordSecureButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
                }
    }
    @IBAction func updateConfirmPasswordCurrentStatus(_ sender: UIButton) {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        if confirmPasswordTextField.isSecureTextEntry {
            confirmPasswordSecureButton.setImage(UIImage(systemName: "eye"), for: .normal)
                } else {
                    confirmPasswordSecureButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
                }
    }
    
    private func configureUI() {
        [emailTextFieldView, passwordTextFieldView, confirmPasswordTextFieldView, nicknameTextFieldView].forEach({$0?.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray2.cgColor) })
        signUpButton.makeRounded(radius: 20)
        
        [emailWarningLabel, passwordWarningLabel, confirmPasswordWarningLabel, nicknameWarningLabel, countingLabel].forEach({$0?.isHidden = true })
        
        signUpButton.isEnabled = false
        
    }
    
    private func checkTextField() {
        // 입력 중 일때
        emailTextField.addTarget(self, action: #selector(self.checkEmailTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.checkPasswordTextField), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(self.checkConfirmPasswordTextField), for: .editingChanged)
        nicknameTextField.addTarget(self, action: #selector(self.checkNicknameTextField), for: .editingChanged)
        
        // 입력 완료했을 때
        emailTextField.addTarget(self, action: #selector(self.inactivateEmailTextField), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(self.inactivatePasswordTextField), for: .editingDidEnd)
        confirmPasswordTextField.addTarget(self, action: #selector(self.inactivateConfirmPasswordTextField), for: .editingDidEnd)
        
        // 버튼 활성화 조건
        [emailTextField, passwordTextField, confirmPasswordTextField, nicknameTextField].forEach {$0.addTarget(self, action: #selector(self.activateSignUpButton), for: .editingChanged)}
        
        
    }
    
    // 이메일 정규식 체크
    private func checkEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    // 패스워드 정규식 체크
    private func checkPassword(password: String) -> Bool {
        let passwordRegEx = "[A-Z0-9a-z!@#$%^&*()_+=-]{6,12}"
        let passwordText = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordText.evaluate(with: password)
    }
    
    private func checkConfirmPassword (input: String) -> Bool {
        return passwordTextField.text == confirmPasswordTextField.text
    }
    
    @objc private func checkEmailTextField() {
        emailTextFieldView.layer.borderColor = UIColor.systemGray.cgColor
        emailWarningLabel.isHidden = true
    }
    
    @objc private func inactivateEmailTextField() {
        isEmailRight = checkEmail(email: emailTextField.text ?? "")
        emailWarningLabel.isHidden = isEmailRight || !emailTextField.hasText ? true : false
        emailTextFieldView.layer.borderColor = isEmailRight || !emailTextField.hasText ? UIColor.systemGray2.cgColor : UIColor.systemRed.cgColor
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
    
    @objc private func inactivatePasswordTextField() {
        passwordTextFieldView.layer.borderColor = isPasswordRight || !passwordTextField.hasText ? UIColor.systemGray2.cgColor : UIColor.systemRed.cgColor
    }
    
    // 비밀번호 확인 텍필 값 바뀔 떄
    @objc private func checkConfirmPasswordTextField() {
        isConfirmPasswordRight = checkConfirmPassword(input: passwordTextField.text ?? "")
        confirmPasswordWarningLabel.isHidden = isConfirmPasswordRight || !confirmPasswordTextField.hasText ? true : false
        confirmPasswordTextFieldView.layer.borderColor = isConfirmPasswordRight || !confirmPasswordTextField.hasText ? UIColor.systemGray2.cgColor : UIColor.systemRed.cgColor
    }
    @objc private func inactivateConfirmPasswordTextField() {
        confirmPasswordTextFieldView.layer.borderColor = isConfirmPasswordRight || !confirmPasswordTextField.hasText ? UIColor.systemGray2.cgColor : UIColor.systemRed.cgColor
    }
    
    @objc func checkNicknameTextField () {
        nameCount = nicknameTextField.text?.count ?? 0
        countingLabel.text = "\(nameCount) / 10"
        
        if nameCount > 10 {
            nicknameTextField.deleteBackward()
        }
        
        if !nicknameTextField.hasText {
            setWithNoneText()
        } else if !checkIsIncludeSpecial(input: nicknameTextField.text ?? "") {
            nicknameWarningLabel.text = "특수문자 입력은 불가능해요"
            setWarningLabelVisible()
        } else if nameCount < 3 {
            nicknameWarningLabel.text = "3자 이상 10자 이하 입력 가능합니다"
            setWarningLabelVisible()
        } else {
            isNicknameRight = true
            nicknameWarningLabel.isHidden = true
            nicknameTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray2.cgColor)
            countingLabel.textColor = UIColor(cgColor: UIColor.systemGray2.cgColor)
            
        }
    }
    
    private func setWithNoneText() {
        nicknameTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray2.cgColor)
        countingLabel.isHidden = true
        nicknameWarningLabel.isHidden = true
    }
    
    private func checkIsIncludeSpecial (input: String) -> Bool {
        let strRegEx = "[A-Za-z가-힣0-9ㄱ-ㅎㅏ-ㅣ]{1,10}"
        let pred = NSPredicate(format: "SELF MATCHES %@", strRegEx)
        return pred.evaluate(with: input)
    }
    private func setWarningLabelVisible() {
        nicknameTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemRed.cgColor)
        nicknameWarningLabel.isHidden = false
        countingLabel.isHidden = false
        countingLabel.textColor = .systemRed
    }
    
    // 버튼 활성화
    @objc func activateSignUpButton() {
        signUpButton.alpha = 1.0
        signUpButton.isEnabled = isEmailRight && isPasswordRight && isConfirmPasswordRight && isNicknameRight
    }
    
    @IBAction func touchUpToPopToSignInView(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func touchUpToSignUp(_ sender: UIButton) {
        user.email = emailTextField.text ?? ""
        user.password = passwordTextField.text ?? ""
        user.nickname = nicknameTextField.text ?? ""
        signUp()
    }
    
    // 토스트 메세지
    private func showToast(message: String) {
        var toastLabel = UILabel()
        toastLabel = UILabel(frame: CGRect(x: 20,
                                           y: self.view.frame.size.height/2,
                                           width: self.view.frame.size.width - 40,
                                           height: 47))
        toastLabel.backgroundColor = .black
        toastLabel.textColor = .white
        toastLabel.text = message
        toastLabel.textAlignment = .center
        toastLabel.layer.cornerRadius = 12
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.5, delay: 0.1,
                       options: .curveEaseIn, animations: { toastLabel.alpha = 0.0 },
                       completion: {_ in toastLabel.removeFromSuperview() })
    }
    
}

extension SignUpViewController {
    func signUp() {
        
        guard let email = user.email else {return}
        guard let password = user.password else {return}
        guard let nickname = user.nickname else {return}
        
        SignUpAPI.shared.postSignUp(completion: { (response) in
            switch response {
            case .success(let jwtToken):
                self.navigationController?.initTransparentNavBar()
                self.navigationController?.popToRootViewController(animated: true)
                
            case .requestErr(let message):
                print("requestErr")
                guard let message = message as? String else { return }
                self.showToast(message: message)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }, email: email, password: password, nickname: nickname)
    }
}
