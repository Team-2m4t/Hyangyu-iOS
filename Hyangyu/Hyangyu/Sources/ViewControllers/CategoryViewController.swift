//
//  CategoryViewController.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/01/17.
//

import UIKit

class CategoryViewController: UIViewController {

    var exhibition = "전시회"
    var fair = "박람회"
    var festival = "페스티벌"
    
    // 화면 전환 스토리보드
    let detailCategoryStoryboard : UIStoryboard = UIStoryboard(name: "CategoryTableView", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 화면 전환
    
    @IBAction func exhibitionButtonClicked(_ sender: Any) {
        guard let nextVC = detailCategoryStoryboard.instantiateViewController(identifier: "HomeVC") as? HomeVC else {return}
        
        nextVC.categoryTabTitle = exhibition // 카테고리 title 이름
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func fairButtonClicked(_ sender: Any) {
        guard let nextVC = detailCategoryStoryboard.instantiateViewController(identifier: "HomeVC") as? HomeVC else {return}
        
        nextVC.categoryTabTitle = fair // 카테고리 title 이름
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func festivalButtonClicked(_ sender: Any) {
        guard let nextVC = detailCategoryStoryboard.instantiateViewController(identifier: "HomeVC") as? HomeVC else {return}
        
        nextVC.categoryTabTitle = festival // 카테고리 title 이름
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
