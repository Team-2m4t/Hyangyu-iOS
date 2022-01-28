import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var exhibitionColor: UIButton!
    @IBOutlet weak var festivalColor: UIButton!
    @IBOutlet weak var fairColor: UIButton!
    private var posterList: [HomePosterDataModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setPosterList(postertitle: "e1"); setPosterList(postertitle: "e10"); setPosterList(postertitle: "e3") ; setPosterList(postertitle: "e4"); setPosterList(postertitle: "e5"); setPosterList(postertitle: "e6"); setPosterList(postertitle: "e7");
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        circleView.layer.cornerRadius = 4
    }
    
    func setPosterList(postertitle: String) {
        posterList.append(contentsOf: [
            HomePosterDataModel(coverName: postertitle)
        ])
        
    }
    
    @IBAction func exhibitionButton(_ sender: Any) {
        circleView.frame.origin.x = 20
        exhibitionColor.isHighlighted = false
        festivalColor.isHighlighted = true
        fairColor.isHighlighted = true
        
    }
    
    @IBAction func festivalButton(_ sender: Any) {
        circleView.frame.origin.x = 102
        exhibitionColor.isHighlighted = true
        festivalColor.isHighlighted = false
        fairColor.isHighlighted = true
    }
    
    @IBAction func fairButton(_ sender: Any) {
        circleView.frame.origin.x = 203
        exhibitionColor.isHighlighted = true
        festivalColor.isHighlighted = true
        fairColor.isHighlighted = false
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let posterCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeImageCollectionViewCell.identifier, for: indexPath) as? HomeImageCollectionViewCell else {
            return UICollectionViewCell() }
        posterCell.setData(imageName: posterList[indexPath.row].coverName)
        
        return posterCell
    }
}
extension HomeViewController: UICollectionViewDelegate {
    
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widt = UIScreen.main.bounds.width
        let cellWidh = widt * (227/200)
        let cellHeight = cellWidh * (100/336)
        return CGSize(width: 227, height: 336)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 200
    }
    
}
