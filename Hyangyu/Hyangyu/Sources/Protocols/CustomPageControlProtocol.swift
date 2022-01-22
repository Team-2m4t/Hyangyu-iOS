//
//  CustomPageControlProtocol.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/20.
//

import Foundation
import UIKit

protocol CustomPageControllerDataSource: class {
    
    func pageController(_ pageController: CustomPageViewController, viewControllerAt index: Int) -> CustomController
    func numberOfViewControllers(in pageController: CustomPageViewController) -> Int
    func headerViewFor(_ pageController: CustomPageViewController) -> UIView
    func headerViewHeightFor(_ pageController: CustomPageViewController) -> CGFloat
    func menuViewFor(_ pageController: CustomPageViewController) -> UIView
    func menuViewHeightFor(_ pageController: CustomPageViewController) -> CGFloat
    
}

protocol CustomPageControllerDelegate: class {
    
    /// Any offset changes in pageController's contentScrollView
    ///
    /// - Parameters:
    ///   - pageController: AquamanPageViewController
    ///   - scrollView: contentScrollView
    func pageController(_ pageController: CustomPageViewController, contentScrollViewDidScroll scrollView: UIScrollView)
    
    /// Method call when viewController will cache
    ///
    /// - Parameters:
    ///   - pageController: AquamanPageViewController
    ///   - viewController: target viewController
    ///   - index: target viewController's index
    func pageController(_ pageController: CustomPageViewController, willCache viewController: CustomController, forItemAt index: Int)
    
    /// Method call when viewController did display
    ///
    /// - Parameters:
    ///   - pageController: AquamanPageViewController
    ///   - viewController: target viewController
    ///   - index: target viewController's index
    func pageController(_ pageController: CustomPageViewController, didDisplay viewController: CustomController, forItemAt index: Int)
    
    
    /// Method call when menuView is adsorption
    ///
    /// - Parameters:
    ///   - pageController: AquamanPageViewController
    ///   - isAdsorption: is adsorption
    func pageController(attach pageController: CustomPageViewController, menuView isAdsorption: Bool)
    
}
