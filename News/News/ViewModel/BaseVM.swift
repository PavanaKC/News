//
//  BaseVM.swift
//  News
//
//  Created by PavanaKC (623-Extern) on 29/01/21.
//

import Foundation

class BaseVM {
    var webservice = WebService()
    let moc = coreData.persistentContainer.viewContext

    //Download image
    func downloadImage(from url: String, completion: @escaping ((Data?) -> Void)) {
        print("Download Started")
        
        webservice.downloadImageFromUrl(imageUrl: url) { result in
            
            switch result {
            case .success(let response):
                let imageData = response as? Data
                DispatchQueue.main.async {
                    completion(imageData)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
}
