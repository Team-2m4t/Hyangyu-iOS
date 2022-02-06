//
//  CustomPageViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/20.
//

import Foundation
import UIKit

extension CustomPageViewController {
    
    public func setSelect(index: Int, animation: Bool) {
        let offset = CGPoint(x: contentScrollView.bounds.width * CGFloat(index),
                             y: contentScrollView.contentOffset.y)
        contentScrollView.setContentOffset(offset, animated: animation)
        if animation == false {
            contentScrollViewDidEndScroll(contentScrollView)
        }
    }

}


extension CustomPageViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == mainScrollView {
            let offsetY = scrollView.contentOffset.y
            if offsetY >= sillValue {
                scrollView.contentOffset = CGPoint(x: 0, y: sillValue)
                currentChildScrollView?.am_isCanScroll = true
                scrollView.am_isCanScroll = false
                pageController(attach: self, menuView: true)
            } else {
                let negScroll = (scrollView.am_isCanScroll == false)
                pageController(attach: self, menuView: negScroll)
                if negScroll{
                    scrollView.contentOffset = CGPoint(x: 0, y: sillValue)
                }
            }
        } else {
            pageController(self, contentScrollViewDidScroll: scrollView)
            // front content page
            layoutChildViewControlls()
        }
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == contentScrollView {
            mainScrollView.isScrollEnabled = false
        }
    }

    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == contentScrollView {
            mainScrollView.isScrollEnabled = true
            if decelerate == false {
                contentScrollViewDidEndScroll(contentScrollView)
            }
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == contentScrollView {
            contentScrollViewDidEndScroll(contentScrollView)
        }
    }
    
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == contentScrollView {
            contentScrollViewDidEndScroll(contentScrollView)
        }
    }
    
    public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        guard scrollView == mainScrollView else {
            return false
        }
        // code scroll
        currentChildScrollView?.setContentOffset(currentChildScrollView.offset, animated: true)
        // return scroll
        return true
    }
    
}



extension CustomPageViewController {
    internal func childScrollView(didScroll scrollView: UIScrollView){
        let scrollOffset = scrollView.am_originOffset.val
        
        let offsetY = scrollView.contentOffset.y
        
        if scrollView.am_isCanScroll == false {
            scrollView.contentOffset = scrollOffset
        }
        else if offsetY <= scrollOffset.y {
            scrollView.contentOffset = scrollOffset
            scrollView.am_isCanScroll = false
            mainScrollView.am_isCanScroll = true
        }
    }
}
