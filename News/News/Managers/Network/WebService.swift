//
//  WebService.swift
//  News
//
//  Created by PavanaKC on 29/01/21.
//

import Foundation

class WebService {
    
    // MARK: - Constants
    let defaultSession = URLSession(configuration: .default)
    
    //Function to handle GET Api Call
    func getRequest(URLString: String, headers: [String: String]?,
                    completion: @escaping (([String: Any]?, NSError?) -> Void)) {
                
        guard let serviceUrl = URL(string: URLString) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")

        defaultSession.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            if error != nil {
                print(error.debugDescription)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print("Response From Server: \(json)")
                    completion(json, nil)
                } catch {
                    completion(nil, error as NSError)
                }
            }
        }.resume()
    }
    
    func downloadImageFromUrl(imageUrl :String, completion: @escaping ((Data?) -> Void)) {
       URLSession.shared.dataTask( with: NSURL(string:imageUrl)! as URL, completionHandler: {
          (data, response, error) -> Void in
          DispatchQueue.main.async {
             if let data = data {
                completion(data)
             }
          }
       }).resume()
    }
}
