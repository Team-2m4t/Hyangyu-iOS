//
//  ViewController.swift
//  Hyangyu
//
//  Created by bsorinnn on 2022/01/06.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pushToTabbar(_ sender: Any) {
        let tabBarStoryboard = UIStoryboard(name: "Tabbar", bundle: nil)
                guard let tabBarController = tabBarStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController else {
                    return
                }
                tabBarController.modalPresentationStyle = .fullScreen
                self.present(tabBarController, animated: true, completion: nil)
    }
}
