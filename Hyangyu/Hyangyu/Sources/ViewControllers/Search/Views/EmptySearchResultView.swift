//
//  SearchResultView.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/06.
//

import UIKit


class EmptySearchResultView: UIView {
    
    private var emptyLabel = UILabel().then {
        $0.text = "찾으시는 검색 결과가 존재하지 않습니다."
        $0.tintColor = .subTextGray1
        $0.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
    }
    
//    private var sections: [SearchSection] = []
//
//    private let tableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .plain)
//        tableView.backgroundColor = .systemBackground
//        tableView.estimatedSectionHeaderHeight = 50
//        tableView.rowHeight = 80
//        let searchResultsTableViewCellNib = UINib(nibName: String(describing: SearchResultsTableViewCell.self), bundle: nil)
//        tableView.register(searchResultsTableViewCellNib, forCellReuseIdentifier: String(describing: SearchResultsTableViewCell.self))
//        tableView.isHidden = true
//        return tableView
//    }()
//
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(emptyLabel)
//        tableView.delegate = self
//        tableView.dataSource = self

        emptyLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
//
//
//
    }
//
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//
//    func update(with results: [SearchResult]) {
//        let displays = results.filter({
//            switch $0 {
//            case .display: return true
//            default: return false
//            }
//        })
//
//
//        let fair = results.filter({
//            switch $0 {
//            case .fair: return true
//            default: return false
//            }
//        })
//
//
//        let festivals = results.filter({
//            switch $0 {
//            case .festival: return true
//            default: return false
//            }
//        })
//        self.sections = [
//            SearchSection(title: "전시회", results: displays),
//            SearchSection(title: "박람회", results: expos),
//            SearchSection(title: "페스티벌", results: festivals),
//        ]
//
//        tableView.reloadData()
//        tableView.isHidden = results.isEmpty
//    }
//
//    func search(term: String) {
//    }
//
//
//
//}
//
//extension SearchResultView: UITableViewDelegate {
//
//}
//
//extension SearchResultView: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sections[section].results.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let result = sections[indexPath.section].results[indexPath.row]
//        switch  result {
//        case .exhibition(let exhibition):
//            guard let cell = tableView.dequeueReusableCell(
//                withIdentifier: SearchResultsTableViewCell.identifier,
//                for: indexPath
//            ) as? SearchResultsTableViewCell else {
//                return UITableViewCell()
//            }
//            let viewModel = SearchResultsTableViewCellViewModel(
//                title: exhibition.title,
//                imageURL: exhibition.posterImageURL ?? "",
//                startDate: exhibition.startDate,
//                endDate: exhibition.endDate,
//                location: exhibition.location
//            )
//            cell.configure(with: viewModel)
//            return cell
//        case .expo(let expo):
//            guard let cell = tableView.dequeueReusableCell(
//                withIdentifier: SearchResultsTableViewCell.identifier,
//                for: indexPath
//            ) as? SearchResultsTableViewCell else {
//                return UITableViewCell()
//            }
//            let viewModel = SearchResultsTableViewCellViewModel(
//                title: expo.title,
//                imageURL: expo.posterImageURL ?? "",               startDate: expo.startDate,
//                endDate: expo.endDate,
//                location: expo.location
//            )
//            cell.configure(with: viewModel)
//            return cell
//        case .festival(let festival):
//            guard let cell = tableView.dequeueReusableCell(
//                withIdentifier: SearchResultsTableViewCell.identifier,
//                for: indexPath
//            ) as? SearchResultsTableViewCell  else {
//                return UITableViewCell()
//            }
//            let viewModel = SearchResultsTableViewCellViewModel(
//                title: festival.title,
//                imageURL: festival.posterImageURL ?? "",
//                startDate: festival.startDate,
//                endDate: festival.endDate,
//                location: festival.location
//            )
//            cell.configure(with: viewModel)
//            return cell
//        }
//
//        func numberOfSections(in tableView: UITableView) -> Int {
//            return sections.count
//        }
//
//
//    }
//}
}
