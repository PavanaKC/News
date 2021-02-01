//
//  DetailVM.swift
//  News
//
//  Created by PavanaKC (623-Extern) on 29/01/21.
//

import Foundation
import CoreData

final class DetailVM: BaseVM {
    
    func getLikesInfo(articleID: String, currentNews: News, completion: @escaping (Bool) -> Void) {
        webservice.getRequest(URLString: URLConstants.likesUrl.rawValue + articleID, headers: [:]) { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let response):
                let count = response[ResponseKey.likes.rawValue] as? Int
                self.updateCoreData(news: currentNews, count: count ?? 0, key: ResponseKey.likesCount.rawValue, completion: {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                })
                
            case .failure(_):
                completion(false)
            }
        }
    }
    
    func getCommentsInfo(articleID: String, currentNews: News, completion: @escaping (Bool) -> Void) {
        webservice.getRequest(URLString: URLConstants.commentUrl.rawValue + articleID, headers: [:]) { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let response):
                let count = response[ResponseKey.comments.rawValue] as? Int
                self.updateCoreData(news: currentNews, count: count ?? 0, key: ResponseKey.commentsCount.rawValue, completion: {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                })
                
            case .failure(_):
                completion(false)
            }
        }
    }
    
    //MARK: Private methods
    private func updateCoreData(news: News, count: Int, key: String, completion: @escaping () -> Void) {
        moc.performAndWait {
            news.setValue(count, forKey: key)
            coreData.saveContext()
            completion()
        }
    }
}
