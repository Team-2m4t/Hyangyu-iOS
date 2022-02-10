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

protocol SearchResultsViewConrollerDelegate: AnyObject {
    func didTapResult(_ result: SearchResult)
}

class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var searchResults: [SearchResult] = []
    
    private var emptyResearchView = EmptySearchResultView()
    
        weak var delegate : SearchResultsViewConrollerDelegate?
    
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
        view.addSubview(emptyResearchView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        emptyResearchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        emptyResearchView.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    func update(with results: [SearchResult]) {
        searchResults = results
        let displays = results.filter({
            switch $0 {
            case .display: return true
            default: return false
            }
        })
        
        
        let fairs = results.filter({
            switch $0 {
            case .fair: return true
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
            SearchSection(title: "전시회", results: displays),
            SearchSection(title: "박람회", results: fairs),
            SearchSection(title: "페스티벌", results: festivals),
        ]
        
        tableView.reloadData()
        tableView.isHidden = results.isEmpty
        emptyResearchView.isHidden = !results.isEmpty
        
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
        case .display(let display):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultsTableViewCell.identifier,
                for: indexPath
            ) as? SearchResultsTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: display)
            return cell
        case .fair(let fair):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultsTableViewCell.identifier,
                for: indexPath
            ) as? SearchResultsTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: fair)
            return cell
        case .festival(let festival):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchResultsTableViewCell.identifier,
                for: indexPath
            ) as? SearchResultsTableViewCell  else {
                return UITableViewCell()
            }
            cell.configure(with: festival)
            return cell
        }
    }
    
    
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
        let moreButton = UIButton().then {
            $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
            $0.tintColor = .black
        }
        titleLabel.frame = CGRect(x: 20, y: 0, width: headerView.frame.width, height: headerView.frame.height)
        countLabel.frame = CGRect(x: headerView.frame.width - 60, y: 0, width: 50, height: 50)
        moreButton.frame = CGRect(x: headerView.frame.width - 30, y: 0, width: 10, height: 50)
        headerView.addSubview(titleLabel)
        headerView.addSubview(countLabel)
        headerView.addSubview(moreButton)
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = sections[indexPath.section].results[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didTapResult(result)
    }
}

