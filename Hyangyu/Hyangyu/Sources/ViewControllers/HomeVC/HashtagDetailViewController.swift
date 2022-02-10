//
//  HashtagDetailViewController.swift
//  Hyangyu
//
//  Created by 길태연 on 2022/01/19.
//

import UIKit

class HashtagDetailViewController: UIViewController {

    @IBOutlet weak var hashDetailTableView: UITableView!
    @IBOutlet weak var hashLabel: UILabel!
    var hashName: String?
    var hashNumber: Int?
    
    private var hashList: [HashtagDetailDataModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setHashList()
        hashDetailTableView.delegate = self
        hashDetailTableView.dataSource = self
        hashLabel.text = hashName
        hashDetailTableView.separatorStyle = .none
    }
    func setHashList() {
        if hashName == "삶" { // api 연결 후 자세하게
            hashList.append(contentsOf: [
                HashtagDetailDataModel(coverName: "ha2", title: "라이프 사진전 : 더 라스터 프린트", subtitle: "세종문화회관 미술관", data: "2021.05.11~2021.08.21"),
            HashtagDetailDataModel(coverName: "ha1", title: "알렉스 프레거, 빅 웨스트", subtitle: "롯데뮤지엄", data: "2022.02.28 ~2022.06.06"),
            HashtagDetailDataModel(coverName: "e15", title: "어둠속의대화", subtitle: "어둠속 대화 북촌점", data: "2022.02.01~2022.04.01")
            ])} else {
                hashList.append(contentsOf: [
                    HashtagDetailDataModel(coverName: "f4", title: "When We Were Young", subtitle: "라스베이거스 페스티벌 그라운드", data: "2022.10.22~2021.10.29"),
                HashtagDetailDataModel(coverName: "f6", title: "PARKLIFE", subtitle: "Manchester's Heaton Park", data: "2022.06.08~2021.06.09"),
                HashtagDetailDataModel(coverName: "e15", title: "어둠속의대화", subtitle: "어둠속 대화 북촌점", data: "22022.02.01~2022.04.01")
                ])
                
            }
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension HashtagDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
}
extension HashtagDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hashList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let hashCell = tableView.dequeueReusableCell(withIdentifier: HashtagDetailTableViewCell.identifier, for: indexPath) as? HashtagDetailTableViewCell else { return UITableViewCell() }
        hashCell.setData(imageName: hashList[indexPath.row].coverName, title: hashList[indexPath.row].title, subtitle: hashList[indexPath.row].subtitle, data: hashList[indexPath.row].data)
        return hashCell
    }
}
