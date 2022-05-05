//
//  ResetCodeViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/05.
//

import UIKit

class ResetCodeViewController: UIViewController {

    // MARK: - Properties
    var email: String? // 이메일
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var codeTextFieldView: UIView!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    // MARK: - View Life Cycle 
    override func viewDidLoad() {
        print("이거 실행되긴 하니?")
        super.viewDidLoad()
        
        initNavigationBar()
        setDelegation()
        configureUI()

    }
    
    // MARK: - Functions
    private func addTarget() {
        codeTextField.addTarget(self, action: #selector(self.activateCodeTextField), for: .editingDidBegin)
        codeTextField.addTarget(self, action: #selector(self.inactivateCodeTextField), for: .editingDidEnd)
        codeTextField.addTarget(self, action: #selector(self.activateCompleteButton), for: .editingChanged)
    }
    
    // 텍스트 필드 확성화
    @objc private func activateCodeTextField() {
        codeTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray2.cgColor)
    }

    // 텍스트 필드 비활성화
    @objc private func inactivateCodeTextField() {
        codeTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray6.cgColor)
    }
    
    // 버튼 활성화
    @objc private func activateCompleteButton() {
        completeButton.isEnabled = codeTextField.hasText
        completeButton.alpha = 1.0
    }
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
    }
    
    private func setDelegation() {
        self.codeTextField.delegate = self
    }
    
    private func configureUI() {
        codeTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray6.cgColor)
        completeButton.makeRounded(radius: 12)
        warningLabel.isHidden = true
        makeCompleteButtonDisable()
    }
    
    private func pushToNewPasswordViewController() {
        self.navigationController?.pushViewController(NewPasswordViewController.loadFromNib(), animated: true)
    }
    
    private func makeCompleteButtonEnable() {
        completeButton.isEnabled = true
        completeButton.alpha = 1.0
    }

    private func makeCompleteButtonDisable() {
        completeButton.isEnabled = false
        completeButton.alpha = 0.3
    }

    func validateCode(code: String) -> Bool {
        // Email 정규식
        let codeRegEx = "^[a-z0-9+]{6}$"
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
        
    @IBAction func touchCompleteButton(_ sender: Any) {
        print("touched Complete Button")
        sendCode()
    }
    
    private func pushToNewPasswordViewController(email: String) {
        let newPasswordViewController = NewPasswordViewController.loadFromNib()
        self.navigationController?.pushViewController(newPasswordViewController, animated: true)
    
    }
    
}

// MARK: - UITextFieldDelegate
extension ResetCodeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidendEditing")
        guard let text = textField.text else {
            return
        }
        checkCodeFormat(userInput: text)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("저 실행되었습니다.")
        warningLabel.isHidden = true
        codeTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray2.cgColor)
        completeButton.isEnabled = true
    }
    
    // Return 눌렀을 시 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ResetCodeViewController {
    func sendCode() {
        print("저 실행됩니다요")
        guard let code = codeTextField.text else {
            return
        }
        
        PasswordAPI.shared.checkCode(completion: { response in
            switch response {
            case .success(let data):
                if let data = data as? String {
                    self.showToast(message: data)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.dismiss(animated: true)
                }
                self.pushToNewPasswordViewController()
            case .requestErr(let message):
                if let message = message as? String {
                    print(message)
                    self.showToast(message: message)
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
        }, email: email ?? "", authNum: code)
    }
}
