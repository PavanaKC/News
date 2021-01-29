//
//  APIConstants.swift
//  News
//
//  Created by Pavana, Kc (623-Extern) on 29/01/21.
//

import Foundation

let apiKey = "0d1a4df850f848fa81fe4fabe37a77d1"
let newsListUrl = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=\(apiKey)"
let likesUrl = "https://cn-news-info-api.herokuapp.com/likes/<ARTICLEID>"
let commentUrl = "https://cn-news-info-api.herokuapp.com/comments/<ARTICLEID>"

enum ResponseKey: String {
    case articles = "articles"
    case title = "title"
    case author = "author"
    case description = "description"
    case imageUrl = "urlToImage"
    case articleUrl = "url"
}
