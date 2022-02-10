//
//  MoreReviewViewController.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/02/06.
//

import UIKit

class MoreReviewViewController: UIViewController {
    
    // MARK: - Properties
    private var allData = [ReviewDisplayResponse]()
    private var currentData = [ReviewDisplayResponse]()
    var displayiD : Int!
    
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
    private var reviewList : [ReviewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self
        
        registerXib()
        getDisplayReview(displayId: displayiD)
    }
    
    func registerXib() {
        let nibName = UINib(nibName: "ReviewCollectionViewCell", bundle: nil)
        reviewCollectionView.register(nibName, forCellWithReuseIdentifier: "ReviewCollectionViewCell")
    }
    
    private func updateData(display: ReviewDisplayResponse) {
        //allData = displayReview
        reviewCollectionView.reloadData()
    }
    
    
    
    //뒤로가기 버튼 클릭
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MoreReviewViewController : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let reviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.identifier, for: indexPath) as? ReviewCollectionViewCell else {return UICollectionViewCell()}
        
        return reviewCell
    }
}

extension MoreReviewViewController : UICollectionViewDelegate
{
}

extension MoreReviewViewController : UICollectionViewDelegateFlowLayout
{
    /*
     sizeForItemAt : 각 Cell들의 크기를 CGSize 형태로 return
     indexPath를 가져와서 row나 section별로 다르게 크기 지정도 가능
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 현재 실행하고 있는 기기의 width
        let width = UIScreen.main.bounds.width
        
        // 335, 186
        let cellWidth = width * (335/375)
        let cellHeight = cellWidth * (186/335)
        
        return CGSize(width: cellWidth, height: cellHeight)
        
    }
    
    /*
     ContentInset : Cell에서 Content 외부에 존재하는 Inset의 크기를 결정
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // minimumLineSpacing : Cell들의 위, 아래 간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // minimumInteritemSpacing : Cell들의 좌, 우 간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension MoreReviewViewController  {
    @objc func getDisplayReview(displayId: Int) {
        ShowReviewAPI.shared.getDisplayReview(displayId: displayiD) { response in
                switch response {
                case .success(let data):
                    if let data = data as? ReviewDisplayResponse {
                        self.updateData(display: data)
                        self.reviewCollectionView.reloadData()
                    }
                case .requestErr(let message):
                    print("requestErr", message)
                case .pathErr:
                    print("pathErr")
                case .serverErr:
                    print("serverErr")
                case .networkFail:
                    print("networkFail")
                }
        }
    }
}
