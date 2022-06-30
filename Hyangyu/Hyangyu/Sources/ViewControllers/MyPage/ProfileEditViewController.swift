//
//  ProfileEditViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/21.
//

import UIKit

import Then

protocol ProfileEditViewControllerDelegate: AnyObject {
    func setUpdate(data: MyPageResponse)
}

struct ProfileEditViewControllerViewModel {
    let profileImage: UIImage
    let userName: String
}



final class ProfileEditViewController: UIViewController {
    
    // MARK: - Properties
    private var user = User.shared
    
    private var userName: String = ""
    private var userProfileImage: UIImage = UIImage()
    
    private var nameCount: Int = 0
    private var isAbleToSubmit: Bool = true
    private var isKeyboardOn: Bool = false
    private var keyboardHeight: CGFloat = 0
    private var maxLength = 10
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var userNameTextFieldView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet weak var countingLabel: UILabel!
    
    
    private let imageShadowView = UIView().then {
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowRadius = 5.0
        $0.layer.shadowColor = UIColor.gray.cgColor
    }
    
    
    weak var delegate: ProfileEditViewControllerDelegate?
    
    private var viewModel: ProfileEditViewControllerViewModel = ProfileEditViewControllerViewModel(profileImage: UIImage(), userName: "")
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        setUserNameTextField()
        setDelegation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureFirstData()
    }
    
    // MARK: - Functions
    
    func configureFirstData() {
        userProfileImageView?.image = viewModel.profileImage
        userNameTextField?.text = viewModel.userName
    }
    
    func configureUI() {
        userNameTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray2.cgColor)
        warningLabel.isHidden = true
        countingLabel.isHidden = true
        userProfileImageView.layer.cornerRadius = 50
        userProfileImageView.clipsToBounds = true
    }
    
    
    private func setDelegation() {
        userNameTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToPickImage))
        userProfileImageView.addGestureRecognizer(tapGesture)
        userProfileImageView.isUserInteractionEnabled = true
    }
    
    private func setUserNameTextField() {
        userNameTextField.addTarget(self, action: #selector(self.checkTextField), for: .editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
    
    // MARK: - @IBAction
    
    
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapConfirm(_ sender: Any) {
        //        delegate?.setUpdate(data: data)
        user.username = userNameTextField.text ?? ""
        user.profileImage = userProfileImageView.image ?? nil
        modifyUserName()
    }
    
    @objc func checkTextField () {
        nameCount = userNameTextField.text?.count ?? 0
        countingLabel.text = "\(nameCount) / 10"
        
        if nameCount > 10 {
            userNameTextField.deleteBackward()
        }
        
        if !userNameTextField.hasText {
            setWithNoneText()
        } else if !checkIsIncludeSpecial(input: userNameTextField.text ?? "") {
            warningLabel.text = "특수문자 입력은 불가능해요"
            setWarningLabelVisible()
        } else if nameCount < 3 {
            warningLabel.text = "3자 이상 입력 가능해요"
            setWarningLabelVisible()
        } else {
            setConfirmButtonEnable()
        }
    }
    
    // 키보드 Notification
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
    
    private func setWithNoneText() {
        userNameTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray2.cgColor)
        countingLabel.isHidden = true
        warningLabel.isHidden = true
        confirmButton.isEnabled = false
    }
    
    private func setConfirmButtonEnable() {
        userNameTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray2.cgColor)
        warningLabel.isHidden = true
        confirmButton.isEnabled = true
        countingLabel.textColor = UIColor(cgColor: UIColor.systemGray2.cgColor)
    }
    
    private func checkIsIncludeSpecial (input: String) -> Bool {
        let strRegEx = "[A-Za-z가-힣0-9ㄱ-ㅎㅏ-ㅣ]{1,10}"
        let pred = NSPredicate(format: "SELF MATCHES %@", strRegEx)
        return pred.evaluate(with: input)
    }
    private func setWarningLabelVisible() {
        userNameTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemRed.cgColor)
        warningLabel.isHidden = false
        countingLabel.isHidden = false
        countingLabel.textColor = .systemRed
        confirmButton.isEnabled = false
    }
    
    @objc func touchToPickImage() {
        actionSheetAlert()
    }
  
    private func actionSheetAlert() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true // 편집을 허용
        
        let actionSheet = UIAlertController(title: "프로필 사진 선택", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "앨범에서 가져오기", style: .default, handler: { (action:UIAlertAction) in
            if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                self.showAlert(withTitle: "접근 권한 거부", andMessage: "이미지를 저장하기 위해서는 '사진 앨범' 접근 권한이 필요합니다. 접근 권한을 허용해 주세요.")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        if userProfileImageView.image != Image.userDefaultImage {
            actionSheet.addAction(UIAlertAction(title: "사진 지우기", style: .destructive, handler: {(_ action: UIAlertAction) -> Void in
                self.userProfileImageView.image = Image.userDefaultImage
            }))
        }
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: {(_ action: UIAlertAction) -> Void in
        })
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: {() -> Void in
            alert.view.tintColor = UIColor.green
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func configure(with viewModel: ProfileEditViewControllerViewModel) {
        //        userProfileImageView?.image = viewModel.profileImage
        //        userNameTextField?.text = viewModel.userName
        self.viewModel = viewModel
    }
    
    
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegatenil
extension ProfileEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = image.resize(newWidth: 100)
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = image.resize(newWidth: 100)
        }
        self.userProfileImageView?.image = newImage
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UITextFieldDelegate
extension ProfileEditViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return false}
        
        // 최대 글자수 이상을 입력한 이후에는 중간에 다른 글자를 추가할 수 없게끔 작동
        if text.count >= maxLength && range.length == 0 && range.location < maxLength {
            return false
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nameCount = userNameTextField.text?.count ?? 0
        countingLabel.textColor = .systemGray2
        countingLabel.text = "\(nameCount) / 10"
        countingLabel.isHidden = false
        
    }
    
}

// MARK: - Server

extension ProfileEditViewController {
    func modifyUserName() {
        guard let userName = User.shared.username else { return }
        
        MyPageAPI.shared.modifyUserName(completion: { (response) in
            switch response {
            case .success:
                self.showToastKeyboard(message: "닉네임 변경에 성공하였습니다")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.dismiss(animated: true)
                }
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }, email: "", password: "", nickname: userName)
    }
}
