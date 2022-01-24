import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var exhibitionColor: UIButton!
    @IBOutlet weak var festivalColor: UIButton!
    @IBOutlet weak var fairColor: UIButton!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var optionButton: UIButton!
    var actionClosure: (() -> Void)? = nil
    var review: String?
    var count: Int?
    var reviewList: [ReviewDataModel] = []
    
    let green = UIColor(red: 0.00, green: 0.33, blue: 0.31, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        exhibitionColor.layer.borderColor = green.cgColor
        exhibitionColor.layer.cornerRadius = 15
        festivalColor.layer.cornerRadius = 15
        fairColor.layer.cornerRadius = 15
        enableButtonColor(oneButton: fairColor, twoButton: festivalColor)
        
//        posterCollectionView.layer.shadowColor = UIColor.black.cgColor
//        posterCollectionView.layer.shadowOffset = CGSize(width: 10, height: 10)
//        posterCollectionView.layer.shadowOpacity = 0.3
//        posterCollectionView.layer.shadowRadius = 9
        OperationQueue.main.addOperation {
            self.reviewTableView.reloadData()
        }
//        reviewList.append(contentsOf: [
//            ReviewDataModel(title: "라이프 사진전 : 더 라스트 프린트", review: "와 진짜 ! 너무 좋았어요 ㅎㅎ ", data: "4 MAR 2019", scope: Double(5.0)),
//            ReviewDataModel(title: "칸딘스키와 함께하는 색채여행", review: "색감이 넘 이뻐요 ", data: "9 MAY 2020", scope: Double(4.5)),
//            ReviewDataModel(title: "모네, 르누아르... 샤갈", review: "흠 가지마세요 별루,,", data: "2 JAN 2021", scope: Double(1.0)),
//            ReviewDataModel(title: "수퍼네이처 - 부산", review: "쩝스바리~", data: "4 MAR 2019", scope: Double(0.5)),
//            ReviewDataModel(title: "카유보트: 향기를 만나다", review: "향기가 납니다", data: "4 MAR 2019", scope: Double(4.0)),
//            ReviewDataModel(title: "아라리오뮤지엄", review: "흠 그닥임 ", data: "4 MAR 2019", scope: Double(1.5)),
//            ReviewDataModel(title: "어둠속의 대화", review: "가까워지고싶은 사람과 함께가면 좋을 것 같아요", data: "4 MAR 2019", scope: Double(5.0)),
//            ReviewDataModel(title: "애니메이션 박물관", review: "뭐냐 미쳤음", data: "4 MAR 2019", scope: Double(5.0)),
//            ReviewDataModel(title: "플라워 바이 네이키", review: "쩝..", data: "4 MAR 2019", scope: Double(0.5)),
//            ReviewDataModel(title: "필립 할스만 사진전", review: "와!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ", data: "4 MAR 2019", scope: Double(4.5)),
//            ReviewDataModel(title: "유미의 세포들 부산", review: "유미야 사랑해", data: "4 MAR 2019", scope: Double(3.0)),
//            ReviewDataModel(title: "아르떼 뮤지엄", review: "와 진짜 ! 너무 좋았어요 ㅎㅎ ", data: "4 MAR 2019", scope: Double(4.5))
//
//        ])
        setReviewList(title: "라이프 사진전 : 더 라스트 프린트", review: "와 진짜 ! 너무 좋았어요 ㅎㅎ ", data: "4 MAR 2019", scope: Double(5.0))
        setReviewList(title: "칸딘스키와 함께하는 색채여행", review: "색감이 넘 이뻐요 ", data: "9 MAY 2020", scope: Double(4.5))
        setReviewList(title: "모네, 르누아르... 샤갈", review: "흠 가지마세요 별루,,", data: "2 JAN 2021", scope: Double(1.0))
        setReviewList(title: "수퍼네이처 - 부산", review: "쩝스바리~", data: "4 MAR 2019", scope: Double(0.5))
        setReviewList(title: "카유보트: 향기를 만나다", review: "향기가 납니다", data: "4 MAR 2019", scope: Double(4.0))
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.separatorStyle = .none
    //    reviewList[0].review = review!
   //     reviewTableView.reloadData()
    }
    func setReviewList(title: String, review: String, data: String, scope: Double) {
        reviewList.append(contentsOf: [
            ReviewDataModel(title: title, review: review, data: data, scope: scope)
           
        ])
    }
    
    @IBAction func optionMenu(_ sender: Any) {
        self.actionClosure?()
    }

    func clickButtonColor (button: UIButton ) {
        button.backgroundColor = green
        button.setTitleColor(UIColor.white, for: .normal)
    }
    
    func enableButtonColor (oneButton: UIButton, twoButton: UIButton ) {
        oneButton.backgroundColor = UIColor.white
        oneButton.setTitleColor(green, for: .normal)
        oneButton.layer.borderWidth = 1.5
        oneButton.layer.borderColor = green.cgColor
        twoButton.backgroundColor = UIColor.white
        twoButton.setTitleColor(green, for: .normal)
        twoButton.layer.borderWidth = 1.5
        twoButton.layer.borderColor = green.cgColor
    }
    
    @IBAction func exhibitionButton(_ sender: Any) {
        clickButtonColor(button: exhibitionColor)
        enableButtonColor(oneButton: fairColor, twoButton: festivalColor)
        reviewTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        reviewList.removeAll()
        setReviewList(title: "라이프 사진전 : 더 라스트 프린트", review: "와 진짜 ! 너무 좋았어요 ㅎㅎ ", data: "4 MAR 2019", scope: Double(5.0))
        setReviewList(title: "칸딘스키와 함께하는 색채여행", review: "색감이 넘 이뻐요 ", data: "9 MAY 2020", scope: Double(4.5))
        setReviewList(title: "모네, 르누아르... 샤갈", review: "흠 가지마세요 별루,,", data: "2 JAN 2021", scope: Double(1.0))
        setReviewList(title: "수퍼네이처 - 부산", review: "쩝스바리~", data: "4 MAR 2019", scope: Double(0.5))
        setReviewList(title: "카유보트: 향기를 만나다", review: "향기가 납니다", data: "4 MAR 2019", scope: Double(4.0))
        
        reviewTableView.reloadData()
        
    }
    
    @IBAction func fairButton(_ sender: Any) {
     clickButtonColor(button: fairColor)
        enableButtonColor(oneButton: exhibitionColor, twoButton: festivalColor)
        reviewTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        reviewList.removeAll()
        setReviewList(title: "아라리오뮤지엄", review: "흠 그닥임 ", data: "4 MAR 2019", scope: Double(1.5))
        setReviewList(title: "어둠속의 대화", review: "가까워지고싶은 사람과 함께가면 좋을 것 같아요", data: "4 MAR 2019", scope: Double(5.0))
        setReviewList(title: "애니메이션 박물관", review: "뭐냐 미쳤음", data: "4 MAR 2019", scope: Double(5.0))
        setReviewList(title: "플라워 바이 네이키", review: "쩝..", data: "4 MAR 2019", scope: Double(0.5))
        setReviewList(title: "필립 할스만 사진전", review: "와!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ", data: "4 MAR 2019", scope: Double(4.5))
        reviewTableView.reloadData()

    }
    
    @IBAction func festivalButton(_ sender: Any) {
        clickButtonColor(button: festivalColor)
        enableButtonColor(oneButton: exhibitionColor, twoButton: fairColor)
        reviewTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        reviewList.removeAll()
        setReviewList(title: "유미의 세포들 부산", review: "유미야 사랑해", data: "4 MAR 2019", scope: Double(3.0))
        setReviewList(title: "아르떼 뮤지엄", review: "와 진짜 ! 너무 좋았어요 ㅎㅎ ", data: "4 MAR 2019", scope: Double(4.5))
        reviewTableView.reloadData()
        
    }
    
    func remove(index: IndexPath) {
        reviewList.remove(at: index.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func hello() {
          print("제발떠라")
    }
    override func viewWillAppear(_ animated: Bool) {
        // if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentCon
        
       // reviewList.set
        DispatchQueue.main.async {
            self.reviewTableView.reloadData()
        }
        print("123")
            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if  let destination = segue.destination as? ReviewEditViewController {
                if let index = sender as? Int {
                    print("왕")
                    print(index)
                    destination.numberIndex = index
                    destination.review = reviewList[index].review
                    destination.lalabel = reviewList[index].title
                }
        
            }
        }
    }

}
extension ReviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .normal, title: nil) {
//            (action, view, completion) in
//
//            self.reviewList.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            completion(true)
//        }
//        deleteAction.backgroundColor = .white
//        deleteAction.image = #imageLiteral(resourceName: "delete-bin-6-line.png")
//
//        let conf = UISwipeActionsConfiguration(actions: [deleteAction])
//        conf.performsFirstActionWithFullSwipe = false
//        return conf
//    }
//
}

extension ReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell else {return UITableViewCell() }

        reviewCell.actionClosure = { [weak self] in
            let option = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

                    let deleteAction = UIAlertAction(title: "리뷰 삭제", style: .default) {(action) in
                        let alert = UIAlertController(title: "리뷰 삭제", message: "리뷰를 삭제하시겠어요?", preferredStyle: UIAlertController.Style.alert)
                        let okAction = UIAlertAction(title: "취소", style: .default) {(action) in }
                        let removeAction = UIAlertAction(title: "삭제하기", style: .default) {(action) in
                            self!.remove(index: indexPath)
                            tableView.deleteRows(at: [indexPath], with: .fade)
                            tableView.reloadData()
                        }
                        okAction.setValue(self?.green, forKey: "titleTextColor")
                        removeAction.setValue(self?.green, forKey: "titleTextColor")
                        alert.addAction(okAction)
                        alert.addAction(removeAction)
                        self?.present(alert, animated: false, completion: nil)
                        }
            let editAction = UIAlertAction(title: "리뷰 수정", style: .default) { (action) in
//                guard let reviewEdit = self?.storyboard?.instantiateViewController(identifier: "ReviewEditViewController") as? ReviewEditViewController else {return }
//                self?.present(reviewEdit,animated: true,completion: nil)
                    //  reviewEdit.modalPresentationStyle = .fullScreen
                print(Int(indexPath.row))
                print(self!.reviewList[indexPath.row])
             //   tableView(UITableView, didSelectRowAt: IndexPath)
                self?.performSegue(withIdentifier: "showDetail", sender: Int(indexPath.row))
                  }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in })
                  cancelAction.setValue(self?.green, forKey: "titleTextColor")
                  deleteAction.setValue(UIColor.black, forKey: "titleTextColor")
                  editAction.setValue(UIColor.black, forKey: "titleTextColor")
                  option.addAction(deleteAction)
                  option.addAction(editAction)
                  option.addAction(cancelAction)

            self?.present(option, animated: true, completion: nil)

        }
        reviewCell.setData(title: reviewList[indexPath.row].title, review: reviewList[indexPath.row].review, data: reviewList[indexPath.row].data, scope: Double(reviewList[indexPath.row].scope))
        reviewCell.selectionStyle = .none
        
        return reviewCell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
}
