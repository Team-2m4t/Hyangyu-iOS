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
    let profileImage: UIImage?
    let userName: String?
}



class ProfileEditViewController: UIViewController {
    
    // MARK: - properties
    
    private let badgeView: UIImageView = UIImageView()
    
    private let imageShadowView = UIView().then {
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowRadius = 5.0
        $0.layer.shadowColor = UIColor.gray.cgColor
    }
    
    
    private let profileImageView = UIImageView().then {
        $0.image = Image.userDefaultImage
        $0.contentMode = .scaleAspectFill
    }
    
    private let userNameTextField = UITextField().then {
        $0.font = UIFont(name: FontType.appleSDGothicNeoMedium.rawValue, size: 15)
        $0.clearButtonMode = .whileEditing
    }
    
    private let informationLabel = UILabel().then {
        $0.font = UIFont(name: FontType.appleSDGothicNeoMedium.rawValue, size: 13)
        $0.text = "닉네임은 최소 3자, 최대 10자까지 입력가능합니다."
        $0.textColor = .textBlack
        $0.numberOfLines = 1
    }

    
    private var isAbleToSubmit: Bool = true
    
    // MARK: - Property
    var userName: String? = ""
    var userProfileImage: UIImage? = UIImage()
    
    
    private var maxLength = 10
    
    
    weak var delegate: ProfileEditViewControllerDelegate?
    
    
    
    // MARK: - UIImagePicker
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigationBar()
        
        
        self.view.addSubview(imageShadowView)
        imageShadowView.addSubview(profileImageView)
        self.view.addSubview(userNameTextField)
        self.view.addSubview(informationLabel)
        
        configureUI()
        
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToPickImage))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
        
        userNameTextField.delegate = self
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange(_:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: userNameTextField)
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userNameTextField.setUnderLine(color: .black)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
    
    
    func configureUI() {
        
        imageShadowView.snp.makeConstraints {
            $0.centerX.equalTo(self.view)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(70)
            $0.width.equalTo(profileImageView.snp.height).multipliedBy(1.0 / 1.0)
            $0.height.equalTo(100)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(imageShadowView.snp.top)
            $0.leading.equalTo(imageShadowView.snp.leading)
            $0.bottom.equalTo(imageShadowView.snp.bottom)
            $0.trailing.equalTo(imageShadowView.snp.trailing)
        }
        
        userNameTextField.snp.makeConstraints {
            $0.centerX.equalTo(self.view)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            $0.top.equalTo(profileImageView.snp.bottom).offset(25)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            $0.height.equalTo(40)
        }
        
        informationLabel.snp.makeConstraints {
            $0.top.equalTo(userNameTextField.snp.bottom).offset(5)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
        }
        
    }
    
    private func configureNavigationBar() {
        title = "프로필 변경"
        self.navigationController?.initTransparentNavBar()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector((didTapDone)))
        navigationItem.leftBarButtonItem?.tintColor = .textBlack
        navigationItem.rightBarButtonItem?.tintColor = .textBlack
    }
    
    
    
    @objc func touchToPickImage() {
        actionSheetAlert()
    }
    
    @objc func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapDone() {
        guard isAbleToSubmit && (userNameTextField.text != nil) else{
            informationLabel.textColor = .red
            userNameTextField.setUnderLine(color: .red)
            return
        }
        delegate?.setUpdate(profileImage: profileImageView.image, userName: userNameTextField.text)
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        if let userNameTextField = notification.object as? UITextField {
            if let text = userNameTextField.text {
                if text.count > maxLength {
                    // 8글자 넘어가면 자동으로 키보드 내려감
                    userNameTextField.resignFirstResponder()
                }
                
                // 초과되는 텍스트 제거
                if text.count >= maxLength {
                    let index = text.index(text.startIndex, offsetBy: maxLength)
                    let newString = text[text.startIndex..<index]
                    userNameTextField.text = String(newString)
                    isAbleToSubmit = true
                }
                
                else if text.count < 3 {
                    informationLabel.textColor = .red
                    userNameTextField.setUnderLine(color: .red)
                    isAbleToSubmit = false
                    
                } else {
                    informationLabel.textColor = .black
                    userNameTextField.setUnderLine(color: .black)
                    isAbleToSubmit = true
                }
            }
        }
    }
    
    
    func actionSheetAlert() {
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
        if profileImageView.image != UIImage(named: "userDefaultImage") {
            actionSheet.addAction(UIAlertAction(title: "사진 지우기", style: .destructive, handler: {(_ action: UIAlertAction) -> Void in
                self.profileImageView.image = UIImage(named: "userDefaultImage")
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
        profileImageView.image = viewModel.profileImage
        userNameTextField.text = viewModel.userName
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
        profileImageView.image = newImage
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
        informationLabel.textColor = .black
        userNameTextField.setUnderLine(color: .black)
        
    }
}
