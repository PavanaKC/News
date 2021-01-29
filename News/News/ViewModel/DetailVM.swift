//
//  DetailVM.swift
//  News
//
//  Created by PavanaKC (623-Extern) on 29/01/21.
//

import Foundation

class DetailVM: BaseVM {
    
    func getArticleInfo(url: String, articleID: String, completion: @escaping ((Int?) -> Void)) {
        webservice.getRequest(URLString: newsListUrl, headers: [:]) { [weak self] (data, error) in
            guard let jsonData = data, let newsArray = jsonData[ResponseKey.articles.rawValue] as? [[String: Any]]
            else {
                completion(0)
                return
            }
            
            self?.saveNewsData(newsData: newsArray, completion: {
                DispatchQueue.main.async {
                    completion(0)
                }
            })
        }
    }
}
