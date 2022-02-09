//
//  HomeVC.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/02/08.
//

import UIKit
import Tabman
import Pageboy
//CategoryDetailPage

class HomeVC: TabmanViewController {
    
    @IBOutlet weak var categoryTitle: UILabel!
    var categoryTabTitle: String?
    @IBOutlet weak var tempView: UIView!
    
    private var viewControllers: Array<UIViewController> = []
    
    let tabColor = UIColor(rgb: 0x005550)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 상단 탭바
        // swiftlint:disable force_cast
        let newVC = UIStoryboard.init(name: "CategoryDetailPage", bundle: nil).instantiateViewController(withIdentifier: "NewVC") as! NewVC
        // swiftlint:enable force_cast
        
        // swiftlint:disable force_cast
        let bestVC = UIStoryboard.init(name: "CategoryDetailPage", bundle: nil).instantiateViewController(withIdentifier: "BestVC") as! BestVC
        // swiftlint:enable force_cast
        
        // swiftlint:disable force_cast
        let freeVC = UIStoryboard.init(name: "CategoryDetailPage", bundle: nil).instantiateViewController(withIdentifier: "FreeVC") as! FreeVC
        // swiftlint:enable force_cast
        
        // swiftlint:disable force_cast
        let costVC = UIStoryboard.init(name: "CategoryDetailPage", bundle: nil).instantiateViewController(withIdentifier: "CostVC") as! CostVC
        // swiftlint:enable force_cast
        
        viewControllers.append(newVC)
        viewControllers.append(bestVC)
        viewControllers.append(freeVC)
        viewControllers.append(costVC)
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        
        bar.backgroundView.style = .blur(style: .regular)
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        bar.buttons.customize { (button) in
            button.tintColor = .black // 선택 안되어 있을 때
            button.selectedTintColor = self.tabColor // 선택 되어 있을 때
        }
        // 인디케이터 조정
        bar.indicator.weight = .light
        bar.indicator.tintColor = self.tabColor
        bar.indicator.overscrollBehavior = .compress
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.layout.interButtonSpacing = 35 // 버튼 사이 간격
        
        bar.layout.transitionStyle = .snap // Customize
        addBar(bar, dataSource: self, at: .custom(view: tempView, layout: nil))
        
        setCategoryTitle()
    }
    
    // categoryTitle 바꾸기
    func setCategoryTitle() {
        if let title = self.categoryTabTitle {
            categoryTitle.text = title
        }
    }
    
    
    //뒤로가기 버튼 클릭
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension HomeVC: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        // MARK: - Tab 안 글씨들
        switch index {
        case 0:
            return TMBarItem(title: "최신순")
        case 1:
            return TMBarItem(title: "인기순")
        case 2:
            return TMBarItem(title: "무료")
        case 3:
            return TMBarItem(title: "유료")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }
        
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

