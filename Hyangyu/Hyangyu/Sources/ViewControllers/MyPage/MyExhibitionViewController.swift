//
//  MyExhibitionViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/18.
//

import UIKit


class MyExhibitionViewController: UIViewController, CustomChildViewController  {
    
    
    // MARK: - Properties
    private var allData: SavedResponse = SavedResponse(displays: [Event]())
    private var currentData: SavedResponse = SavedResponse(displays: [Event]())
    private var currentPage = 0
    private var isPaging: Bool = false // 현재 페이징 중인지 체크
    private var isLast = false // 마지막 페이지인지 체크
    private var cachedPages: [Int] = []
    
    // MARK: - @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var emptyExhibitionView: UIView!
    
    
    private var myExhibitionList:[MyListModel] = []
    
    private var refreshControl = UIRefreshControl().then {
        $0.tintColor = .primary
    }
    
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setDelegation()
        registerXib()
        addObserver()
//        getMyDisplay(page: currentPage)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMyDisplay(page: currentPage)
    }
    
    // MARK: - Functions
    
    private func configUI() {
        configureCollectionView()
        self.collectionView.collectionViewLayout = createCompositionalLayout()
        
        if allData.displays.isEmpty {
            self.emptyExhibitionView.isHidden = true
        }
        
    }
    
    private func configureCollectionView() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.alwaysBounceVertical = true
        
    }
    
    private func setDelegation() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        collectionView.refreshControl?.addTarget(self, action: #selector(getMyDisplay), for: .valueChanged)
    }
    
    private func registerXib() {
        let myPageCollectionViewCellNib = UINib(nibName: String(describing: MyPageCollectionViewCell.self), bundle: nil)
        
        // 가져온 닙파일로 콜렉션뷰에 셀로 등록한다.
        collectionView.register(myPageCollectionViewCellNib, forCellWithReuseIdentifier: String(describing: MyPageCollectionViewCell.self))
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(getMyDisplay), name: NSNotification.Name("RefreshMyCollectionView"), object: nil)
    }
    
    private func updateData(display: SavedResponse) {
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
        
        collectionView.reloadData()
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

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension MyExhibitionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
        
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
        return allData.displays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MyPageCollectionViewCell.self), for: indexPath) as? MyPageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setData(event: allData.displays[indexPath.row])
        
        if indexPath.row == allData.displays.count - 1 && !isLast {
            currentPage += 1
            self.getMyDisplay(page: currentPage)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let result = allData.displays[indexPath.row]
        let detailPageStoryboard = UIStoryboard(name: "DetailViewPage", bundle: nil)
        guard let detailPageVC = detailPageStoryboard.instantiateViewController(withIdentifier: "DetailPageViewController") as? DetailPageViewController else {
            return
        }
        detailPageVC.configure(with: result)
        detailPageVC.title = result.title
        detailPageVC.navigationItem.largeTitleDisplayMode = .never
        detailPageVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailPageVC, animated: true)
    }
}

extension MyExhibitionViewController  {
    @objc func getMyDisplay(page: Int) {
        SavedAPI.shared.getMyDisplay(page: currentPage) { response in
                switch response {
                case .success(let data):
                    if let data = data as? SavedResponse {
                        self.updateData(display: data)
                        self.collectionView.reloadData()
                        self.refreshControl.endRefreshing()
                        self.cachedPages.append(page)
                    }
                case .requestErr(let message):
                    print("얘도 문제야?")
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
