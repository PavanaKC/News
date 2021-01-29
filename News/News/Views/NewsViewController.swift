//
//  NewsViewController.swift
//  News
//
//  Created by PavanaKC on 29/01/21.
//

import UIKit

class NewsViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet private weak var newsListTableView: UITableView!

    //MARK: private variable
    private let newsVM = NewsVM()
    private var newsInfo: [News]?
    private let tableFooterHeight: CGFloat = 50
    private let tableRowHeight: CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchNewsList()
    }

    //MARK: Private Functions
    private func setupTableView() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: tableFooterHeight))
        footerView.backgroundColor = .clear
        newsListTableView.tableFooterView = footerView
        
        newsListTableView.estimatedRowHeight = tableRowHeight
    }
    
    private func fetchNewsList() {
        newsVM.getNews { [weak self] in
            print("data fetched")
            self?.newsInfo = self?.newsVM.readNewsData()
            self?.newsListTableView.reloadData()
        }
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableCell") as? NewsTableCell
        else { return UITableViewCell() }
        
        guard let data = newsInfo?[indexPath.row] else { return UITableViewCell() }
        cell.headLinesLabel.text = data.title
        cell.authorNameLabel.text = "Author: " + (data.author ?? "_")
        cell.descriptionlabel.text = data.explanation
        
        let spinner = UIActivityIndicatorView()
        spinner.startAnimating()
        spinner.style = .large
        spinner.color = .black
        cell.accessoryView = spinner
        
        newsVM.downloadImage(from: data.imageUrl ?? "") { data in
            
            cell.accessoryView = nil
            
            if let imageData = data {
                cell.newsImage.image = UIImage(data: imageData)
            } else {
                cell.newsImage.image = UIImage(named: "placeholder")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = mainStoryboard.instantiateViewController(identifier: "DetailViewController") as DetailViewController
        if let news = newsInfo?[indexPath.row] {
            detailVC.currentNews = news
        }
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true, completion: nil)
    }
}
