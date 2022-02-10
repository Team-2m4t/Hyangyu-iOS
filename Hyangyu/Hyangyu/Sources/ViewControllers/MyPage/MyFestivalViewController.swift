//
//  MyFestivalViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/18.
//

import UIKit

class MyFestivalViewController: UIViewController, CustomChildViewController {

    // MARK: - @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var emptyFestivalView: UIView!
    
    
    private var myFestivalList:[MyListModel] = []
    
    private let spinner = UIActivityIndicatorView().then{
        $0.tintColor = .label
        $0.hidesWhenStopped = true
    }
    
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setMyFestivalList()
        configureCollectionView()
        view.addSubview(spinner)
        
        if !myFestivalList.isEmpty {
            self.emptyFestivalView.isHidden = true
        }
    }
    
    
    // MARK: - Functions
    func customChildScrollView() -> UIScrollView {
        return collectionView
    }
    
    private func configureCollectionView() {
        let myPageCollectionViewCellNib = UINib(nibName: String(describing: MyPageCollectionViewCell.self), bundle: nil)
        collectionView.register(myPageCollectionViewCellNib, forCellWithReuseIdentifier: String(describing: MyPageCollectionViewCell.self))
        
        self.collectionView.collectionViewLayout = createCompositionalLayout()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white

        collectionView.alwaysBounceVertical = true
        
    }
    
    func setMyFestivalList() {
        myFestivalList.append(contentsOf: [
            MyListModel(posterImageURL: "exhibitionImg1",
                        title: "Dream of （… 을꿈꾸다）",
                        startDate: "2022.02.05",
                        endDate: "-",
                        location: "홍대 플렉스라운지"
            ),
        
        ])
    }
}

extension MyFestivalViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
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
        return myFestivalList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MyPageCollectionViewCell.self), for: indexPath) as? MyPageCollectionViewCell else {
            return UICollectionViewCell()
        }
//        cell.setData(event: myFestivalList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
    }
}


