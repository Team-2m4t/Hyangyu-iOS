//
//  DetailPageViewController.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/01/26.
//

import UIKit

class DetailPageViewController: UIViewController {
    
    let writeReviewStoryBoard : UIStoryboard = UIStoryboard(name: "DetailViewPage", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func writeReviewButtonClicked(_ sender: Any) {
        guard let writeReviewVC = writeReviewStoryBoard.instantiateViewController(identifier: "WriteReviewViewController") as? WriteReviewViewController else {return}
        
        self.navigationController?.pushViewController(writeReviewVC, animated: true)
    }
    
    @IBAction func moreReviewButtonClicked(_ sender: Any) {
        guard let moreReviewVC = writeReviewStoryBoard.instantiateViewController(identifier: "MoreReviewViewController") as? MoreReviewViewController else {return}
        
        self.navigationController?.pushViewController(moreReviewVC, animated: true)
    }
    
}
