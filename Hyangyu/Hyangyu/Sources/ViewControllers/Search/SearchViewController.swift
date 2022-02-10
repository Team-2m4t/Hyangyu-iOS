//
//  SearchViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/24.
//

import UIKit

protocol RecentSearchCoreDataUsable {
    func saveRecentResearch(term: String, date: Date, index: Int32)
}

class SearchViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, SearchResultsViewConrollerDelegate {
    func didTapResult(_ result: SearchResult) {
        let detailPageStoryboard = UIStoryboard.init(name: "DetailViewPage", bundle: nil)
        guard let detailPageVC = detailPageStoryboard.instantiateViewController(withIdentifier: "DetailPageViewController") as? DetailPageViewController else {
            return
        }
        switch  result {
        case .display(let model), .fair(let model), .festival(let model):
            detailPageVC.configure(with: model)
            detailPageVC.title = model.title
            detailPageVC.navigationItem.largeTitleDisplayMode = .never
            self.navigationController?.isNavigationBarHidden = false
            detailPageVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailPageVC, animated: true)
        }
    }
    
    
    
    
    
    // MARK: - Property
    private let terms = ["재즈", "연인과 함께", "친구와 함께",
                         "도자기", "정물화", "사진전", "증명사진"]
    
    private var results: [SearchResult] = []
    private let searchResultsViewController = SearchResultsViewController()
    
    // MARK: - View
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.sectionInset = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        
        $0.isScrollEnabled = false
        $0.collectionViewLayout = layout
        $0.backgroundColor = .systemBackground
        $0.register(SearchTagCollectionViewCell.self, forCellWithReuseIdentifier: "SearchTagCollectionViewCell")
    }
    
    
    let searchController: UISearchController = {
        let vc = UISearchController(searchResultsController: SearchResultsViewController())
        vc.searchBar.placeholder = "전시회 / 페스티벌 / 박람회 검색"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
    }()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setSearchController()
        setConstraint()
        initSearchBar()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(
            SearchHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SearchHeaderCollectionReusableView.identifier
        )
        
//        searchResultUpdate()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    
    func setConstraint() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.center.width.equalToSuperview()
            $0.leading.equalTo(view.snp.leading)
            $0.bottom.equalTo(view.snp.bottom)
            $0.trailing.equalTo(view.snp.trailing)
            
        }
    }
    func initSearchBar() {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([.foregroundColor : UIColor.primary], for: .normal)
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14)
        searchController.searchBar.searchBarStyle = .minimal
    }
    
//    func searchResultUpdate() {
//        results.append(contentsOf: [
//            .festival(model: MyListModel(posterImageURL: "exhibitionImg1", title: "서울국제재즈페스티벌", startDate: "2020.5.25", endDate: "2020.5.26", location: "올림픽 공원")),
//            .festival(model: MyListModel(posterImageURL: "exhibitionImg1", title: "자라섬재즈페스티벌", startDate: "2021.11.7", endDate: "2021.11.7", location: "자라섬")),
//            .festival(model: MyListModel(posterImageURL: "exhibitionImg1", title: "제 8회 해운대재즈페스티벌", startDate: "2021.10.26", endDate: "2021.10.30", location: "부산 해운대 문화회관 해운홀")),
//            .festival(model: MyListModel(posterImageURL: "exhibitionImg1", title: "대구국제재즈축제", startDate: "2021.10.6", endDate: "2021.10.11", location: "수성 아트피아&아트 센터")),
//            .exhibition(model: MyListModel(
//                            posterImageURL: "exhibitionImg1",
//                            title: "재즈의 역사",
//                            startDate: "2021.3.18",
//                            endDate: "2021.10.18",
//                            location: "서울국제뮤지선"))
//        ])
//    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
              guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        search(query: query)
    
        
        print(query)
        // perform search
    }
    
    // perform search
    
    private func search(term: String) {
        searchController.searchBar.text = term
        searchController.isActive = true
        searchController.searchBar.resignFirstResponder()
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        results = []
        guard let text = searchController.searchBar.text,
              !text.isEmpty else {
            return
        }
    }
}




extension SearchViewController: UICollectionViewDataSource {
    // cell갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return terms.count
    }
    
    // cell 선언
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchTagCollectionViewCell", for: indexPath) as? SearchTagCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setData(title: terms[indexPath.item])
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    // 셀 크기설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel().then {
            $0.font = .systemFont(ofSize: 14)
            $0.text = terms[indexPath.row]
            $0.sizeToFit()
        }
        let size = label.frame.size
        
        return CGSize(width: size.width + 36, height: size.height + 30)
    }
    
    // 아이템 선택
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        search(term: terms[indexPath.item])
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController else {
            return
        }
        resultsController.update(with: results)
        // perform search
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SearchHeaderCollectionReusableView.identifier,
            for: indexPath
        ) as? SearchHeaderCollectionReusableView,
        kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
}

extension SearchViewController {
    func search(query: String) {
        SearchAPI.shared.search(keyword: query) { response in
            switch response {
            case .success(let data):
                if let data = data as? SearchResultResponse {
                    self.results.append(contentsOf: data.display.compactMap({ .display(model: $0)}))
                    self.results.append(contentsOf: data.festival.compactMap({ .festival(model: $0)}))
                    self.results.append(contentsOf: data.fair.compactMap({ .fair(model: $0)}))
                    guard let resultsController = self.searchController.searchResultsController as? SearchResultsViewController else {
                        return
                    }
                    resultsController.update(with: self.results)
                    resultsController.delegate = self
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
