//
//  CostVC.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/02/08.
//

import UIKit

class CostVC: UIViewController {
    
    // MARK: - Properties
    private var allData: CagetoryDisplayResponse = CagetoryDisplayResponse(displays: [Event]())
    private var currentData: CagetoryDisplayResponse = CagetoryDisplayResponse(displays: [Event]())
    private var currentPage = 0
    private var isPaging: Bool = false // 현재 페이징 중인지 체크
    private var isLast = false // 마지막 페이지인지 체크
    private var cachedPages: [Int] = []
    
    @IBOutlet weak var costCollectionView: UICollectionView!
    
    // 화면 전환 스토리보드
    let categoryTabStoryboard: UIStoryboard = UIStoryboard(name: "CategoryTab", bundle: nil)
    let detailViewStoryboard : UIStoryboard = UIStoryboard(name: "DetailViewPage", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        costCollectionView.delegate = self
        costCollectionView.dataSource = self
        
        registerXib()
        getCategory(order: "charge", page: currentPage)
    }
    
    func registerXib() {
        let nibName = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        costCollectionView.register(nibName, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
    
    private func updateData(display: CagetoryDisplayResponse) {
        if display.displays.isEmpty {
            isLast = true
            return
        }
        
        currentData = display
        if currentPage == 0 {
            allData = display
        } else {
            if cachedPages.filter({ $0 == currentPage }).count == 0 {
                allData.displays.append(contentsOf: display.displays)
            }
        }
        
        costCollectionView.reloadData()
    }
}

extension CostVC : UICollectionViewDataSource
{
    // cell을 몇개를 만들건지 -> cardList의 원소 개수만큼 만듬!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allData.displays.count
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
        
        cell.setData(event: allData.displays[indexPath.row])
        
        if indexPath.row == allData.displays.count - 1 && !isLast {
            currentPage += 1
            self.getCategory(order: "charge", page: currentPage)
        }

        // 위 코드를 작성하면 cell에는 데이터가 담겨있는데 해당 cell을 return!
        return cell
    }
}

extension CostVC : UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let result = allData.displays[indexPath.row]
        
        guard let nextVC = detailViewStoryboard.instantiateViewController(identifier: "DetailPageViewController") as? DetailPageViewController else {return}
        
        nextVC.configure(with: result)
        nextVC.title = result.title
        nextVC.navigationItem.largeTitleDisplayMode = .never
        nextVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension CostVC : UICollectionViewDelegateFlowLayout
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

extension CostVC
{
    @objc func getCategory(order: String, page: Int) {
        CategoryAPI.shared.getCategory(order: "charge", page: currentPage) { response in
            switch(response)
            {
            case .success(let data):
                if let data = data as? CagetoryDisplayResponse {
                    self.updateData(display: data)
                    self.costCollectionView.reloadData()
                    self.cachedPages.append(page)
                }
            case .requestErr(let message) :
                print("requestERR",message)
            case .pathErr :
                print("pathERR")
            case .serverErr:
                print("serverERR")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}
