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
        setReviewList(title: "라이프 사진전 : 더 라스트 프린트", content: "동의한 적 없이 태어나서 바란 적 없는 죽음을 기다리는 평범한 소년의 이야기. 막 춤추기 시작한 걸음이 길을 찾았다는데 마음이 어둑하다. 작고 슬픈 아이는 땀과 눈물을 얼마나 더 마시고 신이 될까. 그 역시 원한 적 없을 텐데, 평범하게. ", data: "4 MAR 2019", scope: Double(5.0))
        setReviewList(title: "칸딘스키와 함께하는 색채여행", content: "어떤 천성들은 억누르기엔 너무 고결하고, 굽히기엔 너무 드높단다.", data: "9 MAY 2020", scope: Double(4.5))
        setReviewList(title: "모네, 르누아르... 샤갈", content: "흠 가지마세요 별루,,", data: "2 JAN 2021", scope: Double(1.0))
        setReviewList(title: "수퍼네이처 - 부산", content: "쩝스바리~", data: "4 MAR 2019", scope: Double(0.5))
        setReviewList(title: "카유보트: 향기를 만나다", content: "향기가 납니다", data: "4 MAR 2019", scope: Double(4.0))
       navigationController?.navigationBar.barStyle = .black
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.separatorStyle = .none
    }
    func passdata(data: String, num: Int) {
        reviewList[num].review = data
        reviewTableView.reloadData()
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
        setReviewList(title: "라이프 사진전 : 더 라스트 프린트", content: "동의한 적 없이 태어나서 바란 적 없는 죽음을 기다리는 평범한 소년의 이야기. 막 춤추기 시작한 걸음이 길을 찾았다는데 마음이 어둑하다. 작고 슬픈 아이는 땀과 눈물을 얼마나 더 마시고 신이 될까. 그 역시 원한 적 없을 텐데, 평범하게. ", data: "4 JAN 2022", scope: Double(5.0))
        setReviewList(title: "칸딘스키와 함께하는 색채여행", content: "어떤 천성들은 억누르기엔 너무 고결하고, 굽히기엔 너무 드높단다. ", data: "9 MAY 2020", scope: Double(4.5))
        setReviewList(title: "모네, 르누아르... 샤갈", content: "흠 가지마세요 별루,,", data: "2 JAN 2021", scope: Double(1.0))
        setReviewList(title: "수퍼네이처 - 부산", content: "쩝스바리~", data: "4 MAR 2019", scope: Double(0.5))
        setReviewList(title: "카유보트: 향기를 만나다", content: "향기가 납니다", data: "4 MAR 2019", scope: Double(5.0))
        reviewTableView.reloadData()
    }
    @IBAction func fairButton(_ sender: Any) {
     clickButtonColor(button: fairColor)
        enableButtonColor(oneButton: exhibitionColor, twoButton: festivalColor)
        reviewTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        reviewList.removeAll()
        setReviewList(title: "아라리오뮤지엄", content: "흠 그닥임 ", data: "4 MAR 2019", scope: Double(1.5))
        setReviewList(title: "어둠속의 대화", content: "가까워지고싶은 사람과 함께가면 좋을 것 같아요", data: "4 MAR 2019", scope: Double(5.0))
        setReviewList(title: "애니메이션 박물관", content: "뭐냐 미쳤음", data: "4 MAR 2019", scope: Double(5.0))
        setReviewList(title: "플라워 바이 네이키", content: "쩝..", data: "4 MAR 2019", scope: Double(0.5))
        setReviewList(title: "필립 할스만 사진전", content: "와!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ", data: "4 MAR 2019", scope: Double(4.5))
        reviewTableView.reloadData()
    }
    @IBAction func festivalButton(_ sender: Any) {
        clickButtonColor(button: festivalColor)
        enableButtonColor(oneButton: exhibitionColor, twoButton: fairColor)
        reviewTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        reviewList.removeAll()
        setReviewList(title: "유미의 세포들 부산", content: "유미야 사랑해", data: "4 MAR 2019", scope: Double(3.0))
        setReviewList(title: "아르떼 뮤지엄", content: "와 진짜 ! 너무 좋았어요 ㅎㅎ ", data: "4 MAR 2019", scope: Double(4.5))
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
