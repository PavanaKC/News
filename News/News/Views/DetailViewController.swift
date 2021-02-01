//
//  DetailViewController.swift
//  News
//
//  Created by PavanaKC on 29/01/21.
//

import UIKit

final class DetailViewController: BaseViewController {

    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet private weak var commentsButton: UIButton!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var detailsTextView: UITextView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var currentNews = News()
    private let detailVM = DetailVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialiseUI()
    }
    
    //MARK: Private methods
    private func initialiseUI() {
        commentsButton.setTitle("\(currentNews.commentsCount)", for: .normal)
        likeButton.setTitle("\(currentNews.likesCount)", for: .normal)
        
        let text1 = (currentNews.title ?? "") + "\n\n" + "Author: "
        let text2 = (currentNews.author ?? "") + "\n\n" + (currentNews.explanation ?? "")
        var attributedText: NSMutableAttributedString
        attributedText = NSMutableAttributedString(string: text1 + text2)

        attributedText.setAttributes([.font: UIFont.systemFont(ofSize: 20, weight: .bold),
                                      .foregroundColor: UIColor.black], range: NSRange(location: 0, length: currentNews.title?.count ?? 0))
        attributedText.setAttributes([.font: UIFont.systemFont(ofSize: 20, weight: .semibold),
                                      .foregroundColor: UIColor.gray], range: NSRange(location: (currentNews.title?.count ?? 0) + 2, length: "Author: ".count + (currentNews.author?.count ?? 0)))
        detailsTextView.attributedText = attributedText
        
        fetchData()
    }
    
    private func fetchData() {
        activityIndicator.isHidden = false
        detailVM.downloadImage(from: currentNews.imageUrl ?? "") { [weak self] data in
            guard let `self` = self else { return }
            self.activityIndicator.isHidden = true
            if let imageData = data {
                self.newsImage.image = UIImage(data: imageData)
            } else {
                self.showToastLabel(message: "Error while fetching news Information. Try again after sometime")
            }
        }
        
        let articleID = currentNews.articleUrl?.replacingOccurrences(of: "/", with: "-")
        
        activityIndicator.isHidden = false
        detailVM.getLikesInfo(articleID: articleID ?? "", currentNews: currentNews, completion: { [weak self] isSuccess in
            guard let `self` = self else { return }
            
            if isSuccess {
                self.activityIndicator.isHidden = true
                self.likeButton.setTitle(" \(self.currentNews.likesCount)", for: .normal)
            } else {
                self.showToastLabel(message: "Error while fetching news Information. Try again after sometime")
            }
        })
        
        activityIndicator.isHidden = false
        detailVM.getCommentsInfo(articleID: articleID ?? "", currentNews: currentNews, completion: { [weak self] isSuccess in
            guard let `self` = self else { return }
            
            if isSuccess {
                self.activityIndicator.isHidden = true
                self.commentsButton.setTitle(" \(self.currentNews.commentsCount)", for: .normal)
            } else {
                
            }
        })
    }
    
    //MARK: IBAction methods
    @IBAction private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
}
