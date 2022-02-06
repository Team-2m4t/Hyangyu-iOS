//
//  SearchResultView.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/06.
//

import UIKit


class SearchResultView: UIView {
    
    private var sections: [SearchSection] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .systemBackground
        tableView.estimatedSectionHeaderHeight = 50
        tableView.rowHeight = 80
        let searchResultsTableViewCellNib = UINib(nibName: String(describing: SearchResultsTableViewCell.self), bundle: nil)
        tableView.register(searchResultsTableViewCellNib, forCellReuseIdentifier: String(describing: SearchResultsTableViewCell.self))
        tableView.isHidden = true
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    
        
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with results: [SearchResult]) {
        let exhibitions = results.filter({
            switch $0 {
            case .exhibition: return true
            default: return false
            }
        })
        
        
        let expos = results.filter({
            switch $0 {
            case .expo: return true
            default: return false
            }
        })
        
        
        let festivals = results.filter({
            switch $0 {
            case .festival: return true
            default: return false
            }
        })
        self.sections = [
            SearchSection(title: "전시회", results: exhibitions),
            SearchSection(title: "박람회", results: expos),
            SearchSection(title: "페스티벌", results: festivals),
        ]
        
        tableView.reloadData()
        tableView.isHidden = results.isEmpty
    }
    
    func search(term: String) {
    }
    
    

}

extension SearchResultView: UITableViewDelegate {
    
}

extension SearchResultView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = sections[indexPath.section].results[indexPath.row]
        switch  result {
        case .exhibition(let exhibition):
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchResultsTableViewCell.identifier,
                    for: indexPath
            ) as? SearchResultsTableViewCell else {
                return UITableViewCell()
            }
            let viewModel = SearchResultsTableViewCellViewModel(
                title: exhibition.title,
                imageURL: exhibition.posterImageURL ?? "",
                startDate: exhibition.startDate,
                endDate: exhibition.endDate,
                location: exhibition.location
            )
            cell.configure(with: viewModel)
            return cell
        case .expo(let expo):
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchResultsTableViewCell.identifier,
                    for: indexPath
            ) as? SearchResultsTableViewCell else {
                return UITableViewCell()
            }
            let viewModel = SearchResultsTableViewCellViewModel(
                title: expo.title,
                imageURL: expo.posterImageURL ?? "",               startDate: expo.startDate,
                endDate: expo.endDate,
                location: expo.location
            )
            cell.configure(with: viewModel)
            return cell
        case .festival(let festival):
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchResultsTableViewCell.identifier,
                    for: indexPath
            ) as? SearchResultsTableViewCell  else {
                return UITableViewCell()
            }
            let viewModel = SearchResultsTableViewCellViewModel(
                title: festival.title,
                imageURL: festival.posterImageURL ?? "",
                startDate: festival.startDate,
                endDate: festival.endDate,
                location: festival.location
            )
            cell.configure(with: viewModel)
            return cell
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    
    }
}
