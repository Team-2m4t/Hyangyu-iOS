//
//  SearchResultViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/24.
//

import UIKit

struct SearchSection {
    let title: String
    let results: [SearchResult]
}

//protocol SearchResultsViewControllerDelegate: AnyObject {
//    func didTapResult(_ result: SearchResult)
//}

class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    weak var delegate : SearchResultsViewContollerDelegate?
    
    private var sections: [SearchSection] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .systemBackground
        tableView.estimatedSectionHeaderHeight = 50
        tableView.rowHeight = 100
        let searchResultsTableViewCellNib = UINib(nibName: String(describing: SearchResultsTableViewCell.self), bundle: nil)
        tableView.register(searchResultsTableViewCellNib, forCellReuseIdentifier: String(describing: SearchResultsTableViewCell.self))
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
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
                imageURL: exhibition.posterImageURL ?? ""
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
                imageURL: expo.posterImageURL ?? ""
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
                imageURL: festival.posterImageURL ?? ""
            )
            cell.configure(with: viewModel)
            return cell
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let result = sections[indexPath.section].results[indexPath.row]
//        delegate?.didTapResult(result)
//        
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        let titleLabel = UILabel().then{
            $0.textColor = .textBlack
            $0.font = UIFont(name: FontType.appleSDGothicNeoSemiBold.rawValue, size: 15)
            $0.text = sections[section].title
        }
        let countLabel = UILabel().then{
            $0.textColor = .textBlack
            $0.font = UIFont(name: FontType.appleSDGothicNeoSemiBold.rawValue, size: 15)
            $0.text = "(\(sections[section].results.count))"
        }
        titleLabel.frame = CGRect(x: 20, y: 0, width: headerView.frame.width, height: headerView.frame.height)
        countLabel.frame = CGRect(x: 200, y: 0, width: 50, height: 50)
              headerView.addSubview(titleLabel)
        headerView.addSubview(countLabel)
              
              return headerView
        
        
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
}

