//
//  MyExhibitionViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/18.
//

import UIKit

class MyExhibitionViewController: UIViewController, CustomChildViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var emptyExhibitionView: UIView!
    private var myExhibitionList:[MyListModel] = []
    
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.alwaysBounceVertical = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setMyExhibitionList()
        
        let myPageCollectionViewCellNib = UINib(nibName: String(describing: MyPageCollectionViewCell.self), bundle: nil)
        
        // 가져온 닙파일로 콜렉션뷰에 셀로 등록한다.
        collectionView.register(myPageCollectionViewCellNib, forCellWithReuseIdentifier: String(describing: MyPageCollectionViewCell.self))
        
        self.collectionView.collectionViewLayout = createCompositionalLayout()
        
        if !myExhibitionList.isEmpty {
            self.emptyExhibitionView.isHidden = true
        }
        
        
    }
    
    func setMyExhibitionList() {
        myExhibitionList.append(contentsOf: [
            MyListModel(posterImageURL: "exhibitionImg1",
                        title: "샤갈 특별전",
                        startDate: "2021.11.25",
                        endDate: "2022.04.10",
                        location: "마이아트뮤지엄"
            ),
            MyListModel(posterImageURL: "exhibitionImg1",
                        title: "내맘쏙 모두의 그림책 展",
                        startDate: "2021.12.24",
                        endDate: "2022.03.27",
                        location: "예술의전당 한가람디자인미술관"
            ),
            MyListModel(posterImageURL: "exhibitionImg1",
                        title: "［북촌］2022년 1,2,3월-어둠속의대화(DIALOGUE IN THE DARK)",
                        startDate: "2010.01.20",
                        endDate: "2022.03.31",
                        location: "북촌 어둠속의대화"
            ),
            MyListModel(posterImageURL: "exhibitionImg1",
                        title: "빛：영국 테이트미술관 특별전",
                        startDate: "2021.12.21",
                        endDate: "2022.05.08",
                        location: "서울시립 북서울미술관"
            ),
        
        ])
    }
    
    
    func customChildScrollView() -> UIScrollView {
        return collectionView
    }
}

extension MyExhibitionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
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
        return myExhibitionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MyPageCollectionViewCell.self), for: indexPath) as? MyPageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setData(myList: myExhibitionList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
