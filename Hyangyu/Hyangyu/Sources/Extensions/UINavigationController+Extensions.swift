//
//  UINavigationController+Extensions.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/21.
//

import UIKit


extension UINavigationController {
    
    // MARK: - navigation bar 투명하게
    
    func initTransparentNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.setTitleTextAttributes(appearance)
    }
    
    // MARK: - 뒤로가기 버튼 만들기
    
    func initWithBackButton(backgroundColor: UIColor? = nil) {
        let appearance = UINavigationBarAppearance()
        appearance.initBackButtonAppearance()
        
        if backgroundColor != nil {
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = backgroundColor
            appearance.shadowColor = .clear
            self.navigationBar.barTintColor = backgroundColor // for iOS14
        } else {
            appearance.configureWithTransparentBackground()
        }
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.tintColor = .textBlack
        self.setTitleTextAttributes(appearance)
    }
    
    // 제목
    func setTitleTextAttributes(_ appearance: UINavigationBarAppearance) {
        appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 15),NSAttributedString.Key.foregroundColor: UIColor.black]
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance

    }
    
}

extension UINavigationBarAppearance {
    
    func initBackButtonAppearance() {
        // back button image
        var backButtonImage: UIImage? {
            return UIImage(named: "backBtn")
        }
        // back button appearance
        var backButtonAppearance: UIBarButtonItemAppearance {
            let backButtonAppearance = UIBarButtonItemAppearance()
            // backButton하단에 표출되는 text를 안보이게 설정
            backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear, .font: UIFont.systemFont(ofSize: 0.0)]

            return backButtonAppearance
        }
        self.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        self.backButtonAppearance = backButtonAppearance
    }
}
