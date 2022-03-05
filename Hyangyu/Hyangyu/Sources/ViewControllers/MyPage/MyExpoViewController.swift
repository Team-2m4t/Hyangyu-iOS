//
//  MyExpoViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/20.
//

import UIKit

final class MyExpoViewController: UIViewController, CustomChildViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var emptyExpoView: UIView!
    private var myExpoList:[MyListModel] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        let myPageCollectionViewCellNib = UINib(nibName: String(describing: MyPageCollectionViewCell.self), bundle: nil)
        collectionView.register(myPageCollectionViewCellNib, forCellWithReuseIdentifier: String(describing: MyPageCollectionViewCell.self))
        
        if !myExpoList.isEmpty {
            emptyExpoView.isHidden = true
        }
    }
    
    func customChildScrollView() -> UIScrollView {
        return collectionView
    }
    
}

extension MyExpoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
        
        print("createCompositionalLayout() called")
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            let groupHeight = NSCollectionLayoutDimension.fractionalWidth(0.9)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
            
            return section
        }
        return layout
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myExpoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: MyPageCollectionViewCell.self),
            for: indexPath
        ) as? MyPageCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
