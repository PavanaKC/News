//
//  NewsTableCell.swift
//  News
//
//  Created by PavanaKC on 29/01/21.
//

import UIKit

class NewsTableCell: UITableViewCell {
    
    @IBOutlet weak var headLinesLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
         super.prepareForReuse()
        newsImage.image = nil
     }
}
