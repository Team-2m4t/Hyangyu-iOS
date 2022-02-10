//
//  SignInViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/24.
//

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: - Properties
    var signUpUser = SignUpUser.shared
    private let userDefaults = UserDefaults.standard
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextFieldView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextFieldView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addTarget()

    }
    
    private func configureUI() {
        inactivateTextField()
        loginButton.isEnabled = false
        loginButton.makeRounded(radius: 12)
    }
    
    // MARK: - Functions
    private func addTarget() {
        emailTextField.addTarget(self, action: #selector(self.activateEmailTextField), for: .editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(self.activatePasswordTextField), for: .editingDidBegin)
        [emailTextField, passwordTextField].forEach({$0.addTarget(self, action: #selector(self.inactivateTextField), for: .editingDidEnd)})
        [emailTextField, passwordTextField].forEach({$0.addTarget(self, action: #selector(self.activateLogInButton), for: .editingChanged)})
    }
    
    // 텍스트 필드 확성화
    @objc private func activateEmailTextField() {
        emailTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray2.cgColor)
    }
    @objc private func activatePasswordTextField() {
        passwordTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray2.cgColor)
    }

    // 텍스트 필드 비활성화
    @objc private func inactivateTextField() {
        emailTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray6.cgColor)
        passwordTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray6.cgColor)
    }
    
    // 버튼 활성화
    @objc private func activateLogInButton() {
        loginButton.isEnabled = emailTextField.hasText && passwordTextField.hasText
    }

    @IBAction func didTapLoginButton(_ sender: UIButton) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        postLogin()
    }
    @IBAction func didTapSignUpButton(_ sender: UIButton) {
        self.navigationController?.pushViewController(SignUpViewController.loadFromNib(), animated: true)
    }
    @IBAction func didTapResetPasswordButton(_ sender: UIButton) {
        self.navigationController?.pushViewController(FindPasswordViewController.loadFromNib(), animated: true)
    }
    
    func pushHomeViewController() {
        let tabbarStoryboard = UIStoryboard(name: "Tabbar", bundle: nil)
        guard let tabbarViewController = tabbarStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController else {
            return
        }
        tabbarViewController.modalPresentationStyle = .fullScreen
        tabbarViewController.modalTransitionStyle = .crossDissolve
        self.present(tabbarViewController, animated: true, completion: nil)
    }
    
}

extension SignInViewController {
    func postLogin() {
        
        guard let password = passwordTextField.text else {
            return
        }
        guard let email = emailTextField.text else {
            return
        }
        
        print(email,password)

        LoginAPI.shared.postSignIn(completion: { (response) in
            switch response {
            case .success(let data):
                print(data)
                if let data = data as? SignIn {
                    print("성공함")
                    UserDefaults.standard.setValue(data.token, forKey: "jwtToken")
                    UIApplication.shared.registerForRemoteNotifications()
                    self.pushHomeViewController()
                }
                print("실패함....")
            case .requestErr(let message):
                print("requestErr", message)
                self.showToast(message: "등록되지 않은 유저나 비밀번호입니다")
            case .pathErr:
                print("pathErr")
                self.showToast(message: "등록되지 않은 유저나 비밀번호입니다")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }, email: email, password: password)
    }

}
