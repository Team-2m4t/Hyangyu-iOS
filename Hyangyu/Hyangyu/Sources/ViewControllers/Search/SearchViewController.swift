//
//  SearchViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/24.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    
    
    // MARK: - Property
    
    // 뿌려줄 데이터
    let tagList: [String] = [
        "김연경은이태리로간다",
        "Then",
        "SnapKit",
        "RxSwift",
        "Viper",
        "Swift",
        "UIKit",
        "Foundation",
        "ReactorKit"
    ]
    
    private var results: [SearchResult] = []
    
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
        
        searchResultUpdate()
        
        
        
        
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
        searchController.searchBar.searchTextField.backgroundColor = UIColor.clear
        searchController.searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14)
    }
    
    func searchResultUpdate() {
        results.append(contentsOf: [
            .festival(model: MyListModel(posterImageURL: "exhibitionImg1", title: "서울국제재즈페스티벌", startDate: "2020.5.25", endDate: "2020.5.26", location: "올림픽 공원")),
            .festival(model: MyListModel(posterImageURL: "exhibitionImg1", title: "자라섬재즈페스티벌", startDate: "2021.11.7", endDate: "2021.11.7", location: "자라섬")),
                        .exhibition(model: MyListModel(
                                        posterImageURL: "exhibitionImg1",
                                        title: "재즈의 역사",
                                        startDate: "2021.3.18",
                                        endDate: "2021.10.18",
                                        location: "서울국제뮤지선"))
        ])
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
              let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        resultsController.update(with: results)

        print(query)
        // perform search
    }
    // perform search

func updateSearchResults(for searchController: UISearchController) {
}
}

extension SearchViewController: UICollectionViewDataSource {
    // cell갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    // cell 선언
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchTagCollectionViewCell", for: indexPath) as? SearchTagCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setData(title: tagList[indexPath.item])
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    // 셀 크기설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel().then {
            $0.font = .systemFont(ofSize: 14)
            $0.text = tagList[indexPath.row]
            $0.sizeToFit()
        }
        let size = label.frame.size
        
        return CGSize(width: size.width + 36, height: size.height + 30)
    }
}
