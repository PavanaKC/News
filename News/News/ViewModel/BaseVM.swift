//
//  BaseVM.swift
//  News
//
//  Created by PavanaKC (623-Extern) on 29/01/21.
//

import Foundation

class BaseVM {
    var webservice = WebService()

    //Download image
    func downloadImage(from url: String, completion: @escaping ((Data?) -> Void)) {
        print("Download Started")
        
        webservice.downloadImageFromUrl(imageUrl: url) { imageData in
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
}
