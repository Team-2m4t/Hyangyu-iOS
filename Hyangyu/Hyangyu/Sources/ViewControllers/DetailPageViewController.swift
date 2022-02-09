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
    
    // MARK: - Properties
    
    private var event: [Event] = []
    
    let moreReviewStoryboard : UIStoryboard = UIStoryboard(name: "MoreReviewPage", bundle: nil)
    
    let writeReviewStoryboard : UIStoryboard = UIStoryboard(name: "WriteReviewPage", bundle: nil)
    
    // MARK: - Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    // MARK: - Functions
    
    func configure(with event: Event) {
        print(event)
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
        
    }
    //
    
    // MARK: - @IBAction
    
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
