//
//  DetailViewController.swift
//  News
//
//  Created by PavanaKC on 29/01/21.
//

import UIKit

class DetailViewController: UIViewController {

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
            self?.activityIndicator.isHidden = true
            if let imageData = data {
                self?.newsImage.image = UIImage(data: imageData)
            }
        }
        
        let articleID = currentNews.articleUrl?.replacingCharacters(in: "/", with: "-")
        
        activityIndicator.isHidden = false
        detailVM.getArticleInfo(url: likesUrl, articleID: articleID, completion: { [weak self] count in
            self?.activityIndicator.isHidden = true
            self?.likeButton.setTitle("\(count ?? 0)", for: .normal)
        })
        
        activityIndicator.isHidden = false
        detailVM.getArticleInfo(url: commentUrl, articleID: articleID, completion: { [weak self] count in
            self?.activityIndicator.isHidden = true
            self?.commentsButton.setTitle("\(count ?? 0)", for: .normal)
        })
    }
    
    //MARK: IBAction methods
    @IBAction private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
}
