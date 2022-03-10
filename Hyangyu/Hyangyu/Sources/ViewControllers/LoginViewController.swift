//
//  LoginViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/10.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var signUpButtonBackgroundView: UIView!
    @IBOutlet weak var signInButtonBackgroundView: UIView!
    @IBOutlet weak var backgroundTopSpace: NSLayoutConstraint!
    @IBOutlet weak var loginStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        configureUI()
        setConstraintWitouthNotch()

        // Do any additional setup after loading the view.
    }
    
    private func setConstraintWitouthNotch() {
        backgroundTopSpace.constant = -70
        loginStackView.spacing =  8
    }
    
    private func initNavigationBar() {
        self.navigationController?.initTransparentNavBar()
    }
    
    private func configureUI() {
        signUpButtonBackgroundView.makeRoundedWithBorder(radius: 12, color: UIColor.primary.cgColor)
        signInButtonBackgroundView.makeRoundedWithBorder(radius: 12, color: UIColor.systemGray4.cgColor)
    }
    
    private func pushSignUpViewController() {
        let signUpViewController  = SignUpViewController.loadFromNib()
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    private func pushSignInViewController() {
        let signInViewController  = SignInViewController.loadFromNib()
        self.navigationController?.pushViewController(signInViewController, animated: true)
    }
    @IBAction func touchSignUpButton(_ sender: UIButton) {
        pushSignUpViewController()
    }
    @IBAction func touchSignInButton(_ sender: UIButton) {
        pushSignInViewController()
    }
    
    
}
