//
//  SearchResultsTableViewCell.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/24.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {
    
    static let identifier = "SearchResultsTableViewCell"
    
    // MARK: - @IBOutlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureUI() {
        self.posterImageView.layer.cornerRadius = 10
        self.posterImageView.layer.masksToBounds = true
    }
    
    func configure(with viewModel: SearchResultsTableViewCellViewModel){
        posterImageView.image = UIImage(named: viewModel.imageURL ?? "")
        titleLabel.text = viewModel.title
        startDateLabel.text = viewModel.startDate
        endDateLabel.text = viewModel.endDate
        locationLabel.text = viewModel.location
    }

}
