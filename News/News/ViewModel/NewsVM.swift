//
//  NewsVM.swift
//  News
//
//  Created by PavanaKC on 29/01/21.
//

import Foundation
import CoreData

final class NewsVM: BaseVM {
    var newsList = [News]()
     
    //Get News Info
    func getNews(completion: @escaping (Bool) -> Void) {
        webservice.getRequest(URLString: URLConstants.newsListUrl.rawValue + "\(apiKey)", headers: [:]) { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let response):
                        
                self.saveNewsData(newsJsonData: response, completion: { [weak self] in
                    guard let `self` = self else { return }
                    DispatchQueue.main.async {
                        self.readNewsData()
                        completion(true)
                    }
                })
            case .failure(_):
                completion(false)
            }
        }
    }
    
    //MARK: Private methods
    
    //Save to CoreData
    private func saveNewsData(newsJsonData: AnyObject, completion: @escaping () -> Void) {
        newsList.removeAll()
        
        moc.performAndWait {
            if  let jsonData = newsJsonData as? [String: Any], let newsArray = jsonData[ResponseKey.articles.rawValue] as? [[String: Any]] {
                for eachData in newsArray {
                    
                    let title = eachData[ResponseKey.title.rawValue] as? String
                    let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "title == %@", title ?? "")
                    
                    var results: [NSManagedObject]
                    do {
                        results = try moc.fetch(fetchRequest)
                        let news = results.first as? News ?? News(context: moc)
                        news.title = title
                        news.author = eachData[ResponseKey.author.rawValue] as? String
                        news.explanation = eachData[ResponseKey.description.rawValue] as? String
                        news.imageUrl = eachData[ResponseKey.imageUrl.rawValue] as? String
                        news.articleUrl = eachData[ResponseKey.articleUrl.rawValue] as? String
                        newsList.append(news)
                    }
                    catch {
                        print("error executing fetch request: \(error)")
                    }
                }
            }
            coreData.saveContext()
            completion()
        }
    }
    
    //Read from CoreData
    func readNewsData() {
        let request: NSFetchRequest<News> = News.fetchRequest()
        
        do {
            newsList = try moc.fetch(request)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
