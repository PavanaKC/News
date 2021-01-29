//
//  NewsVM.swift
//  News
//
//  Created by PavanaKC on 29/01/21.
//

import Foundation
import CoreData

class NewsVM: BaseVM {
    var news = [News]()
    private let moc = coreData.persistentContainer.viewContext
     
    //Get News Info
    func getNews(completion: @escaping () -> Void) {
        webservice.getRequest(URLString: newsListUrl, headers: [:]) { [weak self] (data, error) in
            guard let jsonData = data, let newsArray = jsonData[ResponseKey.articles.rawValue] as? [[String: Any]]
            else {
                completion()
                return
            }
            
            self?.saveNewsData(newsData: newsArray, completion: {
                DispatchQueue.main.async {
                    completion()
                }
            })
        }
    }
    
    //Read from CoreData
    func readNewsData() -> [News]? {
        let request: NSFetchRequest<News> = News.fetchRequest()
        
        do {
            news = try moc.fetch(request)
            return news
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    //MARK: Private methods
    
    //Save to CoreData
    private func saveNewsData(newsData: [[String: Any]], completion: @escaping () -> Void) {
        
        for eachData in newsData {
            let news = News(context: moc)
            news.title = eachData[ResponseKey.title.rawValue] as? String
            news.author = eachData[ResponseKey.author.rawValue] as? String
            news.explanation = eachData[ResponseKey.description.rawValue] as? String
            news.imageUrl = eachData[ResponseKey.imageUrl.rawValue] as? String
            coreData.saveContext()
        }
        completion()
    }
}
