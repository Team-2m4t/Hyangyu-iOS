//
//  DetailPageViewController.swift
//  Hyangyu
//
//  Created by 홍희수 on 2022/01/26.
//

import UIKit


class DetailPageViewController: UIViewController {
    
    // MARK: - @IBOutlets
    
    @IBOutlet weak var mainPosterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var holidayLabel: UILabel!
    @IBOutlet weak var weekdayOpenLabel: UILabel!
    @IBOutlet weak var weekdayCloseLabel: UILabel!
    @IBOutlet weak var weekendOpenLabel: UILabel!
    @IBOutlet weak var weekendCloseLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var siteLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    // MARK: - Properties
    
    private var event: [Event] = []
    
    let moreReviewStoryboard : UIStoryboard = UIStoryboard(name: "MoreReviewPage", bundle: nil)
    
    let writeReviewStoryboard : UIStoryboard = UIStoryboard(name: "WriteReviewPage", bundle: nil)
    
    // MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.initWithBackButton()
        configureUI()
    }
    
    // MARK: - Functions
    
    func configure(with event: Event) {
        self.event.append(event)
    }
    
    private func configureUI() {
        if !mainPosterImageView.updateServerImage(event[0].photo1) {
            mainPosterImageView?.image = UIImage(named: "exhibitionImg1")
        }
        titleLabel?.text = event[0].title
        startDateLabel?.text = event[0].startDate
        endDateLabel?.text = event[0].endDate
        locationLabel?.text = event[0].location
        holidayLabel?.text = event[0].holiday
        weekdayOpenLabel?.text = event[0].weekdayOpen
        weekdayCloseLabel?.text = event[0].weekdayClose
        weekendOpenLabel?.text = event[0].weekendOpen
        weekendCloseLabel?.text = event[0].weekendClose
        priceLabel?.text = "\(event[0].price)"
        siteLabel?.text = event[0].site
        
        setButton()
        
    }
  
    // 토스트 메세지
    private func showToast(message: String) {
        // 토스트 위치
        let toastLabel = UILabel(frame: CGRect(x: 30,
                                               y: self.view.frame.size.height - 95,
                                               width: self.view.frame.size.width - 60,
                                               height: 40))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.text = message
        toastLabel.textAlignment = .center
        toastLabel.layer.cornerRadius = 12
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.0, delay: 0.5,
                       options: .curveEaseIn, animations: { toastLabel.alpha = 0.0 },
                       completion: {_ in toastLabel.removeFromSuperview() })
    }
    
    func setButton() {
        if event[0].saved {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    // MARK: - @IBAction
    @IBAction func likeButtonDidTap(_ sender: UIButton) {
        if event[0].saved {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            deleteMySavedDisplay(displayId: event[0].eventID) {[weak self] response in
                NotificationCenter.default.post(
                    name: NSNotification.Name("RefreshMyExhibitionCollectionView"),
                    object: nil,
                    userInfo: nil
                )
            }
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            saveMyDisplay(displayID: event[0].eventID) {[weak self] response in
                NotificationCenter.default.post(
                    name: NSNotification.Name("RefreshMyExhibitionCollectionView"),
                    object: nil,
                    userInfo: nil
                )
            }
        }
        
    }
    
    @IBAction func writeReviewButtonClicked(_ sender: Any) {
        guard let writeReviewVC = writeReviewStoryboard.instantiateViewController(identifier: "WriteReviewViewController") as? WriteReviewViewController else {return}
        
        writeReviewVC.modalPresentationStyle = .fullScreen
        writeReviewVC.modalTransitionStyle = .crossDissolve
        self.present(writeReviewVC, animated: true, completion: nil)
    }
    
    @IBAction func moreReviewButtonClicked(_ sender: Any) {
        guard let moreReviewVC = moreReviewStoryboard.instantiateViewController(identifier: "MoreReviewViewController") as? MoreReviewViewController else {return}
        
        moreReviewVC.modalPresentationStyle = .fullScreen
        moreReviewVC.modalTransitionStyle = .crossDissolve
        self.present(moreReviewVC, animated: true, completion: nil)
    }
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailPageViewController {
    
    @objc func saveMyDisplay(displayID: Int, completion: @escaping(String) -> Void) {
        SavedAPI.shared.saveMyDisplay(displayID: displayID) { [self] response in
            switch response {
            case .success(let data):
                if let data = data as? String {
                    self.showToast(message: data)
                    self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    event[0].saved = true
                    completion(data)
                }
            case .requestErr(let message):
                print("requestErr", message)
                if let message = message as? String {
                    self.showToast(message: message)
                }
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    @objc func deleteMySavedDisplay(displayId: Int, completion: @escaping(String) -> Void) {
        SavedAPI.shared.deleteMySavedDisplay(displayID: displayId) { [self] response in
            switch response {
            case .success(let data):
                if let data = data as? String {
                    self.showToast(message: data)
                    self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                    event[0].saved = false
                    completion(data)
                }
            case .requestErr(let message):
                print("requestErr", message)
                if let message = message as? String {
                    self.showToast(message: message)
                }
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
