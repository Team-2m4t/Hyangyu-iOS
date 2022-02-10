//
// Code created with the help of Stack Overflow question
// https://stackoverflow.com/questions/3808808/how-to-get-element-by-class-in-javascript
// Question by Taylor:
// https://stackoverflow.com/users/460058/taylor
// Answer by Andrew Dunn:
// https://stackoverflow.com/users/451672/andrew-dunn
//  MyPageViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/17.
//


import UIKit

import SnapKit
import Then

final class MyPageViewController: CustomPageViewController  {
    
    
    // MARK: - Property
    
    private let tabTitles:[String] = ["전시회", "박람회", "페스티벌"]
    private var userName: String = ""
    private var userImage: UIImage =  Image.userDefaultImage
    
    private let profileEditVC = ProfileEditViewController(nibName: "ProfileEditViewController", bundle: nil)
    
    private let headerView = HeaderView()
    
    lazy var menuView: CustomMenuView = {
        let view = CustomMenuView(parts:
                                    .normalTextColor(UIColor.gray),
                                  .selectedTextColor(UIColor.primary),
                                  .normalTextFont(UIFont.systemFont(ofSize: 15.0)),
                                  .selectedTextFont(UIFont.systemFont(ofSize: 15.0, weight: .medium)),
                                  .sliderStyle(
                                    SliderViewStyle(parts:
                                                        .backgroundColor(UIColor.primary),
                                                    .height(3.0),
                                                    .cornerRadius(1.5),
                                                    .position(.bottom),
                                                    .extraWidth( 10.0 ),
                                                    .shape( .line )
                                    )
                                  ),
                                  .bottomLineStyle(
                                    BottomLineViewStyle(parts:
                                                            .hidden( false )
                                    )
                                  )
        )
        view.delegate = self
        view.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: -24)
        view.titles = tabTitles
        return view
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        configUI()
        
        profileEditVC.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserData()
    }
    
    func configUI() {
        view.backgroundColor = .systemGray6
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initTransparentNavBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "settingIcon"),
            landscapeImagePhone: UIImage(systemName: "settingIcon"),
            style: .done,
            target: self,
            action: #selector(didTapSettings)
        )
        navigationItem.rightBarButtonItem?.tintColor = .textBlack
    }
    
    
    @objc func didTapSettings() {
        let vc = SettingsViewController()
        vc.title = "설정"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.navigationController?.initTransparentNavBar()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - setHeaderView
    
    
    override func headerViewFor(_ pageController: CustomPageViewController) -> UIView {
        headerView.delegate = self
        return headerView
        
    }
    
    override func headerViewHeightFor(_ pageController: CustomPageViewController) -> CGFloat {
        return 275.0
    }
    
    override func numberOfViewControllers(in pageController: CustomPageViewController) -> Int {
        return tabTitles.count
    }
    
    override func pageController(_ pageController: CustomPageViewController, viewControllerAt index: Int) -> CustomController{
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        if index == 0 {
            return storyboard.instantiateViewController(withIdentifier: "MyExhibitionViewController") as! MyExhibitionViewController
        } else if index == 1 {
            return storyboard.instantiateViewController(withIdentifier: "MyExpoViewController") as! MyExpoViewController
        } else {
            return storyboard.instantiateViewController(withIdentifier: "MyFestivalViewController") as! MyFestivalViewController
        }
    }
    
    override func menuViewFor(_ pageController: CustomPageViewController) -> UIView {
        return menuView
    }
    
    override func menuViewHeightFor(_ pageController: CustomPageViewController) -> CGFloat {
        return 54.0
    }
    
    
    override func pageController(_ pageController: CustomPageViewController, contentScrollViewDidScroll scrollView: UIScrollView) {
        menuView.updateLayout(scrollView)
    }
    
    
    override func pageController(_ pageController: CustomPageViewController, didDisplay viewController: CustomController, forItemAt index: Int) {
        menuView.checkState(animation: true)
    }
}

// MARK: -CustomMenuViewDelegate
extension MyPageViewController: CustomMenuViewDelegate {
    func menuView(_ menuView: CustomMenuView, didSelectedItemAt index: Int) {
        guard index < tabTitles.count else {
            return
        }
        setSelect(index: index, animation: true)
    }
}

// MARK: - HeaderViewDelegate
extension MyPageViewController: HeaderViewDelegate {
    func headerViewDidTapProfileEditButton(_ headerView: HeaderView) {
//        configure()
        profileEditVC.modalPresentationStyle = .fullScreen
        self.present(profileEditVC, animated: true, completion: nil)
    }
    
    func headerViewDidTapReviewButton(_ headerView: HeaderView) {
        let storyboard = UIStoryboard(name: "Review", bundle: nil)
        guard let reviewVC = storyboard.instantiateViewController(withIdentifier: "ReviewViewController") as? ReviewViewController else {
            return
        }
        reviewVC.navigationController?.initTransparentNavBar()
        self.navigationController?.pushViewController(reviewVC, animated: true)
        
    }
}

// MARK: - ProfileEditViewControllerDelegate
extension MyPageViewController: ProfileEditViewControllerDelegate {
    func setUpdate(data: MyPageResponse) {
        headerView.configure(with: HeaderViewViewModel(profileImage: userImage, userName: data.username))
        self.userName = data.username
        profileEditVC.configure(with: ProfileEditViewControllerViewModel(profileImage: userImage, userName: self.userName))
    }
}

// MARK: - Server
extension MyPageViewController {
    private func getUserData() {
        
        MyPageAPI.shared.getUserData { (response) in
            switch response {
            case .success(let data):
                if let data = data as? MyPageResponse {
                    print(data)
                    self.setUpdate(data: data)
                }
            case .requestErr(let message):
                print("requestErr", message)
                print("어디가 문제야?")
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}
