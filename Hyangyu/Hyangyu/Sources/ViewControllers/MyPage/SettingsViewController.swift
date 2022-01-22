//
//  SettingsViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/18.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let appVersionCell = UITableViewCell().then{
        $0.textLabel?.text = "버전정보"
        $0.detailTextLabel?.text = "1.0.1"
    }
    
    private let switchCell = UITableViewCell().then {
        $0.textLabel?.text = "푸시 알람 받기"
    }
    
    
    private var sections = [Section]()

    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        initNavigationBar()
        
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
    }
    
    private func configureModels() {
        sections.append(Section(title: "공지", options: [Option(title: "공지"), Option(title: "문의사항")]))
        sections.append(Section(title: "설정", options: [Option(title: "계정 설정"), Option(title: "푸시 알림 설정")]))
        sections.append(Section(title: "로그아웃", options: [Option(title: "로그아웃"), Option(title: "회원 탈퇴")]))
    }
    
    private func signOutTapped() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func viewProfile() {

    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Call handler for cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }


}
