//
//  MoreReviewViewController.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/02/06.
//

import UIKit

class MoreReviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func moreReviewButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
