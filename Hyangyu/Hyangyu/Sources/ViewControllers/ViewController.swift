//
//  ViewController.swift
//  Hyangyu
//
//  Created by bsorinnn on 2022/01/06.
//

import UIKit

class ViewController: UIViewController {
    
    private let button = UIButton().then {
        $0.setTitle("시작 버튼", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .primary
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
        view.addSubview(button)
        configureUI()
        button.addTarget(self, action: #selector(pushToTabbar), for: .touchUpInside)
    }
    
    private func configureUI() {
        
        button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }

    @objc func pushToTabbar(_ sender: UIButton) {
        let tabBarStoryboard = UIStoryboard(name: "Tabbar", bundle: nil)
                guard let tabBarController = tabBarStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController else {
                    return
                }
                tabBarController.modalPresentationStyle = .fullScreen
                self.present(tabBarController, animated: true, completion: nil)
    }
}
