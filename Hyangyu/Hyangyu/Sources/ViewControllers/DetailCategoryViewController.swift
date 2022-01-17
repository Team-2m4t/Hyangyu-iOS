//
//  DetailCategoryViewController.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/01/17.
//

import UIKit

class DetailCategoryViewController: UIViewController {
    
    let categoryTabStoryboard: UIStoryboard = UIStoryboard(name: "CategoryTab", bundle: nil)
    
    @IBOutlet weak var categoryTitle: UILabel!
    var categoryTabTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCategoryTitle()
    }
    
    func setCategoryTitle(){
        if let title = self.categoryTabTitle{
            categoryTitle.text = title
        }
    }

    @IBAction func detailCategoryBackButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
