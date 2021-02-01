//
//  NewsTableCell.swift
//  News
//
//  Created by PavanaKC on 29/01/21.
//

import UIKit

final class NewsTableCell: UITableViewCell {
    
    @IBOutlet private weak var headLinesLabel: UILabel!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var descriptionlabel: UILabel!
    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.red.cgColor
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 4
    }
    
    override func prepareForReuse() {
         super.prepareForReuse()
        newsImage.image = nil
     }
    
    func populateCell(news: News, image: UIImage?) {
        headLinesLabel.text = news.title
        authorNameLabel.text = "Author: " + (news.author ?? "_")
        descriptionlabel.text = news.explanation
        newsImage.image = image ?? UIImage(named: "placeholder")
    }
}
