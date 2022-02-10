import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var exhibitionColor: UIButton!
    @IBOutlet weak var festivalColor: UIButton!
    @IBOutlet weak var fairColor: UIButton!
    @IBOutlet weak var hashTagCollectionView: UICollectionView!
    private var posterList: [HomePosterDataModel] = []
    private var hashList: [HomeHashtagDataModel] = []
    var isFromLogoutOrWithdrawal: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        cornerView()
        setPosterList(postertitle: "e11")
        setPosterList(postertitle: "e12")
        setPosterList(postertitle: "e13")
        setPosterList(postertitle: "e14")
        setPosterList(postertitle: "e15")
        setPosterList(postertitle: "e16")
        setPosterList(postertitle: "e7")
        setHashList()

        hashTagCollectionView.delegate = self
        hashTagCollectionView.dataSource = self
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.collectionViewLayout.invalidateLayout()
        
    }
    
    func cornerView() {
        circleView.layer.cornerRadius = 4
        userImage.layer.cornerRadius = 20
        userImage.layer.masksToBounds = true
        userImage.layer.borderWidth = 1
        userImage.layer.borderColor = UIColor.clear.cgColor
        
    }
    
    func setHashList() {
        hashList.append(contentsOf: [
            HomeHashtagDataModel(coverName: "이색적", hashName: "이색적"),
            HomeHashtagDataModel(coverName: "삶", hashName: "삶"),
            HomeHashtagDataModel(coverName: "철학", hashName: "철학")
        ])
        
    }
    
    func setPosterList(postertitle: String) {
        posterList.append(contentsOf: [
            HomePosterDataModel(coverName: postertitle)
        ])
        
    }
    
    @IBAction func exhibitionButton(_ sender: Any) {
        posterList.removeAll()
        circleView.frame.origin.x = 20
        exhibitionColor.isHighlighted = false
        festivalColor.isHighlighted = true
        fairColor.isHighlighted = true
        setPosterList(postertitle: "e11")
        setPosterList(postertitle: "e12")
        setPosterList(postertitle: "e13")
        setPosterList(postertitle: "e14")
        setPosterList(postertitle: "e15")
        setPosterList(postertitle: "e16")
        setPosterList(postertitle: "e7")
        homeCollectionView.reloadData()
        homeCollectionView.scrollsToTop = true
        homeCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
        
    }
    
    @IBAction func festivalButton(_ sender: Any) {
        posterList.removeAll()
        circleView.frame.origin.x = 86
        exhibitionColor.isHighlighted = true
        festivalColor.isHighlighted = false
        fairColor.isHighlighted = true
        setPosterList(postertitle: "f3")
        setPosterList(postertitle: "f2")
        setPosterList(postertitle: "f1")
        setPosterList(postertitle: "f4")
        setPosterList(postertitle: "f5")
        setPosterList(postertitle: "f6")
        homeCollectionView.reloadData()
        homeCollectionView.scrollsToTop = true
        homeCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func fairButton(_ sender: Any) {
        posterList.removeAll()
        circleView.frame.origin.x = 165
        exhibitionColor.isHighlighted = true
        festivalColor.isHighlighted = true
        fairColor.isHighlighted = false
        setPosterList(postertitle: "fa1")
        setPosterList(postertitle: "fa2")
        setPosterList(postertitle: "fa3")
        setPosterList(postertitle: "fa4")
        homeCollectionView.reloadData()
        homeCollectionView.scrollsToTop = true
        homeCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHashDetail" {
            if  let destination = segue.destination as? HashtagDetailViewController {
                if let index = sender as? Int {
                    destination.hashName = hashList[index].hashName
                    destination.hashNumber = index
                }
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeCollectionView {
            return posterList.count } else {
                return hashList.count }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == homeCollectionView {
        guard let posterCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeImageCollectionViewCell.identifier, for: indexPath) as? HomeImageCollectionViewCell else {
            return UICollectionViewCell() }
        posterCell.setData(imageName: posterList[indexPath.row].coverName)
        return posterCell
        } else {
            guard let hashCell = collectionView.dequeueReusableCell(withReuseIdentifier: HashtagCollectionViewCell.identifier, for: indexPath) as? HashtagCollectionViewCell else {
                return UICollectionViewCell() }
            
            hashCell.setData(imageName: hashList[indexPath.row].coverName, hashtag: hashList[indexPath.row].hashName)
            
            hashCell.hashtagImageView.layer.cornerRadius = 15
            hashCell.hashView.layer.cornerRadius = 15
            hashCell.layer.shadowColor = UIColor.black.cgColor
            hashCell.layer.shadowOffset = CGSize(width: 0, height: 10)
            hashCell.layer.shadowOpacity = 0.05
            hashCell.layer.shadowRadius = 3
            
            return hashCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 서버 연결 후 작성
        
        if collectionView == homeCollectionView {
      //  let detailPageStoryboard = UIStoryboard(name: "DetailViewPage", bundle: nil)
            /*    guard let detailPageVC = detailPageStoryboard.instantiateViewController(withIdentifier: "DetailPageViewController") as? DetailPageViewController else {
                    return
                }
        detailPageVC.navigationItem.largeTitleDisplayMode = .never
                detailPageVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailPageVC, animated: true)*/
        } else {
            guard let hashDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "HashtagDetailViewController") as? HashtagDetailViewController else {
                return }
            hashDetailVC.hashName = hashList[indexPath.row].hashName
            hashDetailVC.hashNumber = indexPath.row
            self.navigationController?.pushViewController(hashDetailVC, animated: true)
       // self.performSegue(withIdentifier: "showHashDetail", sender: indexPath.row)
        }
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == homeCollectionView { return 10 } else { return 0 }
    }

 }
