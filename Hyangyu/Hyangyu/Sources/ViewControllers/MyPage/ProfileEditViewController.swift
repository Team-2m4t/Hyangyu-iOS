//
//  ProfileEditViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/21.
//

import UIKit

protocol ProfileEditViewControllerDelegate: class {
    func setUpdate(profileImage: UIImage?, userName: String?)
}

struct ProfileEditViewControllerViewModel {
    let profileImage: UIImage
    let userName: String
}



final class ProfileEditViewController: UIViewController {
    // MARK: - Properties
    var userName: String = ""
    var userProfileImage: UIImage = UIImage()
    private var nameCount: Int = 0
    private var isAbleToSubmit: Bool = true
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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        setUserNameTextField()
        
        userProfileImageView.layer.cornerRadius = 50
        userProfileImageView.clipsToBounds = true
                
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToPickImage))
        userProfileImageView.addGestureRecognizer(tapGesture)
        userProfileImageView.isUserInteractionEnabled = true
        
        userNameTextField.delegate = self
        
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapConfirm(_ sender: Any) {
        delegate?.setUpdate(profileImage: userProfileImageView?.image, userName: userNameTextField?.text)
        dismiss(animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    func configureUI() {
        userNameTextFieldView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray2.cgColor)
        warningLabel.isHidden = true
        countingLabel.isHidden = true
        
    }
    
    private func setUserNameTextField() {
        userNameTextField.addTarget(self, action: #selector(self.checkTextField), for: .editingChanged)
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
        userProfileImageView?.image = viewModel.profileImage
        userNameTextField?.text = viewModel.userName
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

// MARK: -
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
