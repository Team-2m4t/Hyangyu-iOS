//
//  DetailPageViewController.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/01/26.
//

import UIKit

class DetailPageViewController: UIViewController {
    
    let moreReviewStoryboard : UIStoryboard = UIStoryboard(name: "MoreReviewPage", bundle: nil)
    
    let writeReviewStoryboard : UIStoryboard = UIStoryboard(name: "WriteReviewPage", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func writeReviewButtonClicked(_ sender: Any) {
        guard let writeReviewVC = writeReviewStoryboard.instantiateViewController(identifier: "WriteReviewViewController") as? WriteReviewViewController else {return}
        
        writeReviewVC.modalPresentationStyle = .fullScreen
        writeReviewVC.modalTransitionStyle = .crossDissolve
        self.present(writeReviewVC, animated: true, completion: nil)
    }
    
    @IBAction func moreReviewButtonClicked(_ sender: Any) {
        guard let moreReviewVC = moreReviewStoryboard.instantiateViewController(identifier: "MoreReviewViewController") as? MoreReviewViewController else {return}
        
        moreReviewVC.modalPresentationStyle = .fullScreen
        moreReviewVC.modalTransitionStyle = .crossDissolve
        self.present(moreReviewVC, animated: true, completion: nil)
    }
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
