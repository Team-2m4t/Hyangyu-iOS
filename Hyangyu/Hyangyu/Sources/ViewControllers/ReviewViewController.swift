import UIKit
class ReviewViewController: UIViewController, PassData {
    @IBOutlet weak var exhibitionColor: UIButton!
    @IBOutlet weak var festivalColor: UIButton!
    @IBOutlet weak var fairColor: UIButton!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var optionButton: UIButton!
    var actionClosure: (() -> Void)? = nil
    private var reviewList: [ReviewDataModel] = []
    let green = UIColor(red: 0.00, green: 0.33, blue: 0.31, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        setColor()
        enableButtonColor(oneButton: fairColor, twoButton: festivalColor)
//        setReviewList(title: "라이프 사진전 : 더 라스트 프린트", content: "와 진짜! 너무 좋았어요 ㅎㅎ ", data: "4 MAR 2019", scope: Double(5.0))
//        setReviewList(title: "칸딘스키와 함께하는 색채여행", content: "색감이 넘 이뻐요 ", data: "9 MAY 2020", scope: Double(4.5))
//        setReviewList(title: "모네, 르누아르... 샤갈", content: "흠 가지마세요 별루,,", data: "2 JAN 2021", scope: Double(1.0))
//        setReviewList(title: "수퍼네이처 - 부산", content: "쩝스바리~", data: "4 MAR 2019", scope: Double(0.5))
//        setReviewList(title: "카유보트: 향기를 만나다", content: "향기가 납니다", data: "4 MAR 2019", scope: Double(4.0))
        exhibitionApi(button: exhibitionColor)
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.separatorStyle = .none
    }
    func passdata(data: String, num: Int) {
        reviewList[num].review = data
        reviewTableView.reloadData()
    }
    func setColor() {
        exhibitionColor.layer.borderColor = green.cgColor
        exhibitionColor.layer.cornerRadius = 15
        festivalColor.layer.cornerRadius = 15
        fairColor.layer.cornerRadius = 15
    }
    func setReviewList(title: String, content: String, data: String, scope: Double) {
        reviewList.append(contentsOf: [
            ReviewDataModel(title: title, review: content, data: data, scope: scope)
        ])
    }
    func exhibitionApi(button: UIButton) {
        GetReviewDataService.shared.getExhibitionInfo { [self] (response) in
            switch response {
            
            case .success(let resultss):
                if let results = resultss as? [Review] {
                    
                        for num in 0 ... results.count-1 {
                            setReviewList(title: results[num].username, content: results[num].content, data: results[num].createTime, scope: Double(5.0))
                    }
                    DispatchQueue.main.async {
                        self.reviewTableView.reloadData()
                    }
                }
            case .requestErr(let message) :
                print("requestERR", message)
            case .pathErr :
                print("pathERR")
            case .serverErr :
                print("serverERR")
            case .networkFail:
                print("networkFail")
                
            }
        }
    }
    func fairApi(button: UIButton) {
        GetReviewDataService.shared.getFairInfo { [self] (response) in
            
            switch response {
            case .success(let resultss):
                if let results = resultss as? [Review] {
                
                        for num in 0 ... results.count-1 {
                            setReviewList(title: results[num].username, content: results[num].content, data: results[num].createTime, scope: Double(5.0))
                    }
                    
                    DispatchQueue.main.async {
                        self.reviewTableView.reloadData()
                        
                    }

                }
                
            case .requestErr(let message) :
                print("requestERR", message)
            case .pathErr :
                print("pathERR")
            case .serverErr :
                print("serverERR")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    func festivalApi(button: UIButton) {
        GetReviewDataService.shared.getFestivalInfo { [self] (response) in
            switch response {
            case .success(let resultss):
                if let results = resultss as? [Review] {
                        for num in 0 ... results.count-1 {
                            setReviewList(title: results[num].username, content: results[num].content, data: results[num].createTime, scope: Double(5.0))
                    }
                    DispatchQueue.main.async {
                        self.reviewTableView.reloadData()
                    }
                }
            case .requestErr(let message) :
                print("requestERR", message)
            case .pathErr :
                print("pathERR")
            case .serverErr :
                print("serverERR")
            case .networkFail:
                print("networkFail")
            }
        }
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
        exhibitionApi(button: exhibitionColor)
//        setReviewList(title: "라이프 사진전 : 더 라스트 프린트", content: "와 진짜 ! 너무 좋았어요 ㅎㅎ ", data: "4 MAR 2019", scope: Double(5.0))
//        setReviewList(title: "칸딘스키와 함께하는 색채여행", content: "색감이 넘 이뻐요 ", data: "9 MAY 2020", scope: Double(4.5))
//        setReviewList(title: "모네, 르누아르... 샤갈", content: "흠 가지마세요 별루,,", data: "2 JAN 2021", scope: Double(1.0))
//        setReviewList(title: "수퍼네이처 - 부산", content: "쩝스바리~", data: "4 MAR 2019", scope: Double(0.5))
//        setReviewList(title: "카유보트: 향기를 만나다", content: "향기가 납니다", data: "4 MAR 2019", scope: Double(5.0))
        reviewTableView.reloadData()
    }
    @IBAction func fairButton(_ sender: Any) {
     clickButtonColor(button: fairColor)
        enableButtonColor(oneButton: exhibitionColor, twoButton: festivalColor)
        reviewTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        reviewList.removeAll()
        fairApi(button: fairColor)
//        setReviewList(title: "아라리오뮤지엄", content: "흠 그닥임 ", data: "4 MAR 2019", scope: Double(1.5))
//        setReviewList(title: "어둠속의 대화", content: "가까워지고싶은 사람과 함께가면 좋을 것 같아요", data: "4 MAR 2019", scope: Double(5.0))
//        setReviewList(title: "애니메이션 박물관", content: "뭐냐 미쳤음", data: "4 MAR 2019", scope: Double(5.0))
//        setReviewList(title: "플라워 바이 네이키", content: "쩝..", data: "4 MAR 2019", scope: Double(0.5))
//        setReviewList(title: "필립 할스만 사진전", content: "와!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ", data: "4 MAR 2019", scope: Double(4.5))
        reviewTableView.reloadData()
    }
    @IBAction func festivalButton(_ sender: Any) {
        clickButtonColor(button: festivalColor)
        enableButtonColor(oneButton: exhibitionColor, twoButton: fairColor)
        reviewTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        reviewList.removeAll()
       festivalApi(button: festivalColor)
//        setReviewList(title: "유미의 세포들 부산", content: "유미야 사랑해", data: "4 MAR 2019", scope: Double(3.0))
//        setReviewList(title: "아르떼 뮤지엄", content: "와 진짜 ! 너무 좋았어요 ㅎㅎ ", data: "4 MAR 2019", scope: Double(4.5))
        reviewTableView.reloadData()
    }
    func remove(index: IndexPath) {
        reviewList.remove(at: index.row)
    }
    override func viewWillAppear(_ animated: Bool) {
        reviewTableView.reloadData()
    }
}

extension ReviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
extension ReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell else {return UITableViewCell() }
        reviewCell.setData(title: reviewList[indexPath.row].title, review: reviewList[indexPath.row].review, data: reviewList[indexPath.row].data, scope: Double(reviewList[indexPath.row].scope))
        reviewCell.actionClosure = { [weak self] in
            let option = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "리뷰 삭제", style: .default) { _ in
                        let alert = UIAlertController(title: "리뷰 삭제", message: "리뷰를 삭제하시겠어요?", preferredStyle: UIAlertController.Style.alert)
                        let okAction = UIAlertAction(title: "취소", style: .default)
                        let removeAction = UIAlertAction(title: "삭제하기", style: .default) { _ in
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
            let editAction = UIAlertAction(title: "리뷰 수정", style: .default) { _ in
                guard let reviewEdit = self?.storyboard?.instantiateViewController(identifier: "ReviewEditViewController") as? ReviewEditViewController else { return }
                reviewEdit.review = self?.reviewList[indexPath.row].review
                reviewEdit.numberIndex = indexPath.row
                self?.navigationController?.pushViewController(reviewEdit, animated: true)
                reviewEdit.editMode = self
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
        return reviewCell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
