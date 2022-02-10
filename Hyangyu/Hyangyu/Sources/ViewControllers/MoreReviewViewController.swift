//
//  MoreReviewViewController.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/02/06.
//

import UIKit

class MoreReviewViewController: UIViewController {
    
    //MARK: - HardCoding
    private var reviewList : [ReviewModel] = []
    
    // MARK: - Properties
    private var allData = [ReviewDisplayResponse]()
    private var currentData = [ReviewDisplayResponse]()
    var displayiD : Int!
    
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setReviewList()
        
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self
        
        registerXib()
        //getDisplayReview(displayId: displayiD)
    }
    
    func registerXib() {
        let nibName = UINib(nibName: "ReviewCollectionViewCell", bundle: nil)
        reviewCollectionView.register(nibName, forCellWithReuseIdentifier: "ReviewCollectionViewCell")
    }
    
    func setReviewList() {
        reviewList.append(contentsOf: [
            ReviewModel(nickName: "이물사딱", createTime: "2022/02/09 00:46", reviewContent: "장난감 자동차를 캔버스 가득 옮기는 영국 작가 제레미 디킨슨의 그림은 삭막한 화이트큐브 전시장보다 사람들이 한데 어울리는 공간에 더 잘 어울린다. ‘Jeremy at Home’은 어쩌면 그런 이유에서 기획된 전시인지도 모르겠다. 12월 10일까지 청담동 갤러리 서미를 방문하면 헬라 용게리우스, 베르너 팬톤, 소리 야나기 등의 가구가 디킨슨의 그림과 어우러진 풍경을 감상할 수 있다."),
            
            ReviewModel(nickName: "수야", createTime: "2022/02/09 01:28", reviewContent: "일단 전작을 이은 점들이 눈에 띈다. 폐쇄된 공간에서 추리가 벌어진다는 점, 그리고 영상미가 준수하다는 점을 들 수 있는데 반면 전작이 추리 자체에 집중한 영화라면 이번 작은 밀도 높은 서사 위주의 영화라는 점이 큰 차이점이라 생각된다. 때문에 전작에서 추리하는 흐름을 즐겼던 관객이라면 이번 작에서는 그런 부분이 다소 실망스러울 수 있겠지만, 개인적으로는 전작의 추리 방식이 그다지 매력적으로 느껴지지 않았기 때문이다."),
            
            ReviewModel(nickName: "수수수", createTime: "2022/02/09 00:46", reviewContent: "동의한 적 없이 태어나서 바란 적 없는 죽음을 기다리는 평범한 소년의 이야기. 막 춤추기 시작한 걸음이 길을 찾았다는데 마음이 어둑하다. 작고 슬픈 아이는 땀과 눈물을 얼마나 더 마시고 신이 될까. 그 역시 원한 적 없을 텐데, 평범하게."),
            
            ReviewModel(nickName: "배소린", createTime: "2022/02/09 00:46", reviewContent: "좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요 좋아요!"),
            
            ReviewModel(nickName: "길태연", createTime: "2022/02/09 00:46", reviewContent: "좋아요!"),
        ])
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
        return reviewList.count
        //return allData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let reviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.identifier, for: indexPath) as? ReviewCollectionViewCell else {return UICollectionViewCell()}
        reviewCell.setData(nickName: reviewList[indexPath.row].nickName, createtime: reviewList[indexPath.row].createTime, reviewcontent: reviewList[indexPath.row].reviewContent)
        
        
        //reviewCell.setData(displayReview: allData[indexPath.row])
        
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
                        //let statusCode = response.statusCode
                        //print(data, statusCode)
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
