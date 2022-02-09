//
//  DetailCategoryViewController.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/01/17.
//

import UIKit

class DetailCategoryViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cardList: [ServiceDataModel] = []
    
    let categoryTabStoryboard: UIStoryboard = UIStoryboard(name: "CategoryTab", bundle: nil)
    let detailPageStoryboard : UIStoryboard = UIStoryboard(name: "DetailViewPage", bundle: nil)
    
    @IBOutlet weak var categoryTitle: UILabel!
    var categoryTabTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCategoryTitle()
        setCardList()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        registerXib()
    }
    
    func setCategoryTitle(){
        if let title = self.categoryTabTitle{
            categoryTitle.text = title
        }
    }
    // data 나눠서 테이블 뷰에 보여주기
    // 전시회 일 때
    // 박람회 일 때
    // 페스티벌 일 때
    
    func registerXib(){
        let nibName = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
    
    //아까 선언해둔 cardList형 Array에 정보를 넣는 함수
    func setCardList(){
        cardList.append(contentsOf: [
            ServiceDataModel(iconImageName: "poster", title: "라이프 사진전: 더 라스트 프린트", placeTitle: "세종문화회관 미술관", dateTitle: "2021.05.11~08.21"),
            ServiceDataModel(iconImageName: "poster", title: "라이프 사진전: 더 라스트 프린트", placeTitle: "세종문화회관 미술관", dateTitle: "2021.05.11~08.21"),
            ServiceDataModel(iconImageName: "poster", title: "라이프 사진전: 더 라스트 프린트", placeTitle: "세종문화회관 미술관", dateTitle: "2021.05.11~08.21"),
            ServiceDataModel(iconImageName: "poster", title: "라이프 사진전: 더 라스트 프린트", placeTitle: "세종문화회관 미술관", dateTitle: "2021.05.11~08.21"),
            ServiceDataModel(iconImageName: "poster", title: "라이프 사진전: 더 라스트 프린트", placeTitle: "세종문화회관 미술관", dateTitle: "2021.05.11~08.21")
        ])
    }
    
    // 뒤로 가기 버튼
    @IBAction func detailCategoryBackButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension DetailCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    // cell을 몇개를 만들건지 -> cardList의 원소 개수만큼 만듬!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        /*
         재사용큐를 활용해서 Cell을 가져오거나/생성
         -> identifier를 통해 Cell을 구분하고 indexPath를 통해 순서를 관리
         -> guard - let 구문을 통해 안전하게 값을 가져와서 cell에 넣어준다
         */
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // 위에서 생성한 cell에 대해서 값을 cardList의 값으로 채움
        //cell.setData(iconName: cardList[indexPath.row].iconImageName, title: cardList[indexPath.row].title, placeTitle: cardList[indexPath.row].placeTitle, dateTitle: cardList[indexPath.row].dateTitle)
        
        // 위 코드를 작성하면 cell에는 데이터가 담겨있는데 해당 cell을 return!
        return cell
    }
    
    // didSelectedItemAt() 함수 구현 -> 사용자가 cell을 터치할 때마다, 이 함수가 호출된다
}

extension CategoryCollectionViewCell: CollectionViewCellDelegate {
    func collectionView(collectionviewcell: CategoryCollectionViewCell?, index: Int) {
        
        print("어쩌구저쩌구")
    }
}

// 보통 UICollectionViewDelegateFlowLayout에서는 4가지 메서드로 Cell들의 Layout을 구성
extension DetailCategoryViewController: UICollectionViewDelegateFlowLayout
{
    
    /*
     sizeForItemAt : 각 Cell들의 크기를 CGSize 형태로 return
     indexPath를 가져와서 row나 section별로 다르게 크기 지정도 가능
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 현재 실행하고 있는 기기의 width
        let width = UIScreen.main.bounds.width
        
        // 304, 184
        let cellWidth = width * (304/375)
        let cellHeight = cellWidth * (184/304)
            
        return CGSize(width: cellWidth, height: cellHeight)
      
    }
    
    /*
     ContentInset : Cell에서 Content 외부에 존재하는 Inset의 크기를 결정
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    // minimumLineSpacing : Cell들의 위, 아래 간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // minimumInteritemSpacing : Cell들의 좌, 우 간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
