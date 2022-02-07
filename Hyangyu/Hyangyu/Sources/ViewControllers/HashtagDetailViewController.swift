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
            HashtagDetailDataModel(coverName: "e7", title: "라이프 사진전 : 더 라스터 프린트", subtitle: "세종문화회관 미술관", data: "2021.05.11~2021.08.21"),
        HashtagDetailDataModel(coverName: "e5", title: "알렉스 프레거, 빅 웨스트", subtitle: "롯데뮤지엄", data: "2021.05.11~2021.08.21"),
        HashtagDetailDataModel(coverName: "e4", title: "어둠속의대화", subtitle: "세종문화회관 미술관", data: "2021.05.11~2021.08.21")
        ])} else {
            hashList.append(contentsOf: [
                HashtagDetailDataModel(coverName: "e9", title: "라이프 사진전 : 더 라스터 프린트", subtitle: "세종문화회관 미술관", data: "2021.05.11~2021.08.21"),
            HashtagDetailDataModel(coverName: "e10", title: "알렉스 프레거, 빅 웨스트", subtitle: "롯데뮤지엄", data: "2021.05.11~2021.08.21"),
            HashtagDetailDataModel(coverName: "e8", title: "어둠속의대화", subtitle: "세종문화회관 미술관", data: "2021.05.11~2021.08.21")
            ])
            
        }
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
