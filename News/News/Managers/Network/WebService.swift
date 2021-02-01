//
//  WebService.swift
//  News
//
//  Created by PavanaKC on 29/01/21.
//

import Foundation

typealias ApiCompletionBlock<A> = (Swift.Result<AnyObject, Error>) -> Void

final class WebService {
    
    // MARK: - Constants
    let defaultSession = URLSession(configuration: .default)
    
    //Function to handle GET Api Call
    func getRequest(URLString: String, headers: [String: String]?,
                    completion:@escaping ApiCompletionBlock<Any>) {
                
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
                completion(.failure(error! as NSError))
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Response From Server: \(json)")
                    completion(.success(json as AnyObject))
                } catch {
                    completion(.failure(error as NSError))
                }
            }
        }.resume()
    }
    
    func downloadImageFromUrl(imageUrl :String, completion: @escaping ApiCompletionBlock<Any>) {
       URLSession.shared.dataTask( with: NSURL(string:imageUrl)! as URL, completionHandler: {
          (data, response, error) -> Void in
          DispatchQueue.main.async {
             if let data = data {
                completion(.success(data as AnyObject))
             } else if error != nil {
                completion(.failure(error! as NSError))
             }
          }
       }).resume()
    }
}
