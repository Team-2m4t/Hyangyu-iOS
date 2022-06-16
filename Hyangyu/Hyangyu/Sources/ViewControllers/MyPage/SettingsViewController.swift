//
//  SettingsViewController.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/18.
//

import UIKit

final class SettingsViewController: UIViewController {
        
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
        
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
    }
    
    private func configureModels() {
        sections.append(Section(title: "공지", options: [Option(title: "공지", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.infoTapped()
            }
        }), Option(title: "문의사항", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.contanctTapped()
            }
        })]))
        sections.append(Section(title: "설정", options: [Option(title: "계정 설정", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.notificationTapped()
            }
        }), Option(title: "푸시 알림 설정", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.notificationTapped()
            }
        })]))
        sections.append(Section(title: "로그아웃", options: [Option(title: "로그아웃", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.signOutTapped()
            }
        }), Option(title: "회원 탈퇴", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.withDrawalTapped()
            }
        })]))
    }
    
    // MARK: - handlers
    
    private func signOut(completion: (Bool) -> Void) {
        UserDefaults.standard.removeObject(forKey: "jwtToken")
        completion(true)
    }
    
    private func signOutTapped() {
        let alert = UIAlertController(title: "로그아웃",
                                      message: "정말 로그아웃 하시겠어요?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "로그아웃", style: .destructive, handler: { _ in
            self.signOut { [weak self] signedOut in
                if signedOut {
                    DispatchQueue.main.async {
                        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
                        let loginViewController = loginStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
                        let navVC = UINavigationController(rootViewController: loginViewController)
                        navVC.modalPresentationStyle = .fullScreen
                        self?.present(navVC, animated: true, completion: nil)
                    }
                }
            }
        }))
        present(alert, animated: true)
    }
    
    private func infoTapped() { }
    
    private func contanctTapped() { }
    
    private func notificationTapped() { }
    
    private func withDrawalTapped() { }
    
}

// MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
    
    
}

// MARK: - UITableDataSource
extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = sections[indexPath.section].options[indexPath.row]
        model.handler()
    }
}
